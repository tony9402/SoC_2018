#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdlib.h>
#include <memory.h>
#include <math.h>
#include "amazon2_sdk.h"
#include "graphic_api.h"
#include "Color.h"
#include "uart_api.h"
#include "robot_protocol.h"

#define AMAZON2_GRAPHIC_VERSION		"v0.5"

/*#ifdef height 60
#undef height 
#define height 120
#endif
#ifdef width 90
#undef width
#define width 180
#endif*/

#define red 0
#define orange 0
#define yellow 1
#define green 2
#define blue 3
#define black 4 
#define yellowandblack 5
#define orangeandblack 6
#define greenandblack 7

U8 stage[] = {yellowandblack, red, black, blue, blue, green, orangeandblack, blue, yellowandblack, black, yellowandblack, };
U8 stage_round = 0;
U16 input[21600] = {0};
U16 Colorcnt[5] = {0};
U32 Colorpos[5] = {0};
U16 Linecnt_x = 0;
U16 Linecnt_y = 0;
U32 LineSum_x = 0;
U32 LineSum_y = 0;
short Linemax_i, Linemax_j, Linemin_i, Linemin_j;
short Linemin_i_j, Linemax_i_j, Linemin_ih_j, Linemax_ih_j;

BYTE opening(U16 *input);

#include <termios.h>
static struct termios inittio, newtio;

void init_console(void)
{
    tcgetattr(0, &inittio);
    newtio = inittio;
    newtio.c_lflag &= ~ICANON;
    newtio.c_lflag &= ~ECHO;
    newtio.c_lflag &= ~ISIG;
    newtio.c_cc[VMIN] = 1;
    newtio.c_cc[VTIME] = 0;

    cfsetispeed(&newtio, B115200);

    tcsetattr(0, TCSANOW, &newtio);
}

void GoLeft()
{
	Send_Command(1);
}

void GoRight()
{
	Send_Command(2);
}

void GoStraight()
{
	Send_Command(3);
}

int main(int argc, char **argv)
{
	short i, j;
	float x;
	float dx;
	int ret;
	int cal, cal2;
	BYTE motion;
	init_console();
	HSV hsv;
	ret = uart_open();
	if (ret < 0) return EXIT_FAILURE;

	uart_config(UART1, 9600, 8, UART_PARNONE, 1);
	if (open_graphic() < 0) {
		return -1;	
	}
	direct_camera_display_off();
	clear_screen();
	DelayLoop(100000);
	while(1)
	{
		read_fpga_video_data(input);
		
		Linecnt_x = LineSum_x = 0;
		Linecnt_y = LineSum_y = 0;
		
		opening(input);

		draw_fpga_video_data_full(input);
		flip();
		DelayLoop(40000);
	}
	uart_close();
	close_graphic();
	return 0;
}

void opening(U16 *input)
{
	short i,j;
	U32 where, count, pos_sum;
	count = pos_sum = where = 0;
	U16* erosion_arr = (U16*)malloc(43200);
	memcpy(erosion_arr,input,21600 * 2);
	for(i=0;i<height;i++)
	{
		for(j=0;j<width;j++)
		{
			if(input[pos(i,j)] == 0x001F)
			{
				input[pos(i,j)] = 0x001F;
			}
			else if(input[pos(i,j)] == 0x07e0)
			{
				input[pos(i,j)] = 0x07e0;
			}
			else
			{
				input[pos(i,j)] = 0xFFFF;
			}
			if(i>=1&&erosion_arr[pos(i-1,j)] == 0xFFFF){input[pos(i,j)] = 0xFFFF;continue;}
			if(i<height-1&&erosion_arr[pos(i+1,j)] == 0xFFFF){input[pos(i,j)] = 0xFFFF;continue;}
			if(j>=1&&erosion_arr[pos(i,j-1)] == 0xFFFF){input[pos(i,j)] = 0xFFFF;continue;}
			if(j<width-1&&erosion_arr[pos(i,j+1)] == 0xFFFF){input[pos(i,j)] = 0xFFFF;continue;}
			if(i>=1&&j>=1&&erosion_arr[pos(i-1,j-1)] == 0xFFFF){input[pos(i,j)] = 0xFFFF;continue;}
			if(i<height-1&&j>=1&&erosion_arr[pos(i+1,j-1)] == 0xFFFF){input[pos(i,j)] = 0xFFFF;continue;}
			if(j>=1&&i<height-1&&erosion_arr[pos(i-1,j+1)] == 0xFFFF){input[pos(i,j)] = 0xFFFF;continue;}
			if(j<width-1&&i<height-1&&erosion_arr[pos(i+1,j+1)] == 0xFFFF){input[pos(i,j)] = 0xFFFF;continue;}
			
		}
	}

	memcpy(erosion_arr,input,21600 * 2);
	for(i=0;i<height;i++)
	{
		for(j=0;j<width;j++)
		{
			if(input[pos(i,j)] == 0x001F)
			{
				input[pos(i,j)] = 0x001F;
			}
			else if(input[pos(i,j)] == 0x07e0)
			{
				input[pos(i,j)] = 0x07e0;
			}
			else
			{
				input[pos(i,j)] = 0xFFFF;
			}
			if(i>=1&&erosion_arr[pos(i-1,j)] != 0xFFFF){input[pos(i,j)] = erosion_arr[pos(i-1,j)];}
			if(i<height-1&&erosion_arr[pos(i+1,j)] != 0xFFFF){input[pos(i,j)] = erosion_arr[pos(i+1,j)];}
			if(j>=1&&erosion_arr[pos(i,j-1)] != 0xFFFF){input[pos(i,j)] = erosion_arr[pos(i,j-1)];}
			if(j<width-1&&erosion_arr[pos(i,j+1)] != 0xFFFF){input[pos(i,j)] = erosion_arr[pos(i,j+1)];}
			if(i>=1&&j>=1&&erosion_arr[pos(i-1,j-1)] != 0xFFFF){input[pos(i,j)] = erosion_arr[pos(i-1,j-1)];}
			if(i<height-1&&j>=1&&erosion_arr[pos(i+1,j-1)] != 0xFFFF){input[pos(i,j)] = erosion_arr[pos(i+1,j-1)];}
			if(j>=1&&i<height-1&&erosion_arr[pos(i-1,j+1)] != 0xFFFF){input[pos(i,j)] = erosion_arr[pos(i-1,j+1)];}
			if(j<width-1&&i<height-1&&erosion_arr[pos(i+1,j+1)] != 0xFFFF){input[pos(i,j)] = erosion_arr[pos(i+1,j+1)];}
			if(input[pos(i,j)] == 0x07e0)
			{
				if(20<=width&&width<=160){
					count++;
					pos_sum+=j;
				}
			}
		}
	}

	free(erosion_arr);
	where = pos_sum / count;
	if(80<=where&&where <= 100)
	{
		Send_Command(3);
	}
	else if(20<=where && where < 80)
	{
		Send_Command(2);
	}
	else if(100<where&&where<=160)
	{
		Send_Command(1);
	}
	/*if(abs(left - right) <= 20 && left >= 40 && right >= 40)
	{
		return 90;
	}
	else if(left > right)
	{
		return 135;
	}
	else
	{
		return 45;	
	}*/

}
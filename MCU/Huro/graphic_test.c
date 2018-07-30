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
short BlueIndex[120][180];
short BlueIndex2[90];
short BlueIndex3[90];
BYTE opening(U16 *input);

//struct POS
//{
//	U16 X;
//	U16 Y;
//};
#include <termios.h>
static struct termios inittio, newtio;
void BeforeStart(U16* output, U16* input);
void StartBarigate(U16* output, U16* input);
void EndBarigate(U16* output, U16* input);
void downRedStair(U16* output, U16* input);
void upRedStair(U16* output, U16* input);
void hurdle(U16* output, U16* input);
void Gate(U16* output, U16* input);
void GreenBridge(U16* output, U16* input);
void downRedStair(U16* output, U16* input);
void Greening(U16* output, U16* input);
void DownGreen(U16* output, U16* input);
void mine(U16* output, U16* input);
void upTrap(U16* output, U16* input);
void downTrap(U16* output, U16* input);
short StopCnt = 0;
short StarCount = 0;
void walk();
void walkslowly();
void upstair();
void downstair();
void ex();
void tumbling();
void SeeLeft();
void SeeStraight();
void SeeFront();
void goLeft();
void goRight();


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
	int StartCount=0;
	U16* input = (U16*)malloc(2 * 90 * 60);
	U16* output = (U16*)malloc(2 * 180 * 120);
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
	while(1)
	{
		read_fpga_video_data(input);
		if (StopCnt == 0) BeforeStart(output, input);
		else if(StopCnt == 1)
		{
			StartBarigate(output, input);
		}
		else if (StopCnt == 2)
		{
			upRedStair(output, input);
		}
		else if (StopCnt == 3)
		{
			downRedStair(output, input);
		}
		draw_fpga_video_data_full(input);
		flip();
		DelayLoop(5000);
	}
	uart_close();
	close_graphic();
	return 0;
}


void BeforeStart(U16* output, U16* input)//StopCnt==0
{
	int i, j;
	short YellowCnt = 0;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if (input[pos(i, j)] == 0xFFE0) YellowCnt++;
		}
	}
	if (YellowCnt > 1000) StopCnt++;
}

void StartBarigate(U16* output, U16* input)//StopCnt ==1
{
	int i, j;
	short YellowCnt = 0, BlackCnt = 0;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if ( input[pos(i, j)] ==0xFFE0) YellowCnt++;
			}
	}
	if (YellowCnt < 100)
	{
		walk();
		StopCnt++;
	}
	YellowCnt= 0;
}

void upRedStair(U16* output, U16* input)//StopCnt==2
{
	int i, j;
	U16 RedCnt = 0;
	unsigned char buf[1] = { 0,  };
	short Cnt=0,Cnt2=0;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{

			if ((input[pos(i, j)] == 0xF800)) RedCnt++;
		}
	}


	if (RedCnt > 5000)
	{

		walkslowly();

		if (Cnt == 0)
		{
			upstair();
			Cnt++;
			StopCnt++;
		}
	}

	else
	{
		if(Cnt2==0)
		{
			walkslowly();
			Cnt2++;
		}
	}
}
void downRedStair(U16* output, U16* input)
{
	int i, j;
	short RedCnt = 0;
	short Cnt = 0;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if ((input[pos(i, j)] == 0xF800)) RedCnt++;
		}
	}
	if (RedCnt < 50)
	{
		downstair();
		StopCnt++;
	}
	else
	{
			walk();
			Cnt++;
	}
	RedCnt = 0;

}
void mine(U16* output, U16* input)
{
	//U16 temp = 180;
	//int temp_i,i,j;
	//for (i = 0; i < 50; i++)
	//{
	//	if (POS[i].X < temp) temp = POS[i].X;
	//	temp_i = i;
	//}
	//if ((50 < POS[i].X) && (90 > PSO[i])) goLeft();
	//else if ((89 < POS[i].X) && (130 > PSO[i])) goRight();
	//else walk();
}
void hurdle(U16* output, U16* input)
{
	int i, j;
	short BlueCnt=0;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if ((input[pos(i, j)] == 0x001F)) BlueCnt++;
		}
	}
	if (BlueCnt > 100)
	{
		walkslowly();
		tumbling();
		walk();
		SeeLeft();
	}
	StopCnt++;
}

void Gate(U16* output, U16* input)
{
	int i, j,temp_i1,temp_i2;
	short temp = 0, temp2 = 0;
	for (i = 0; i < 90; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if ((input[pos(i, j)] == 0x001F))
			{
				BlueIndex[i][j]++;
				if (j < 90) BlueIndex2[j];
				else BlueIndex3[j];
			}
		}
	}
	for (i = 0; i < 90; i++)
	{
		if (BlueIndex2[i] > temp)
		{
			temp = BlueIndex2[i];
			temp_i1 = i;
		}
		if (BlueIndex3[i + 90] > temp2)
		{
			temp2 = BlueIndex3[i+90];
			temp_i2 = i+90;
		}
	}
	if ((temp_i1 < 40) || (temp_i2 < 130)) goRight();
	else goLeft();
	if ((40 < temp_i1)&&(temp_i1 < 50) && (130 <temp_i2)&&( temp_i2 < 140))
	{
		walk();
		StopCnt++;
	}


}
void GreenBridge(U16* output, U16* input)
{
	int i, j;
	short GreenCnt = 0;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			//hsv = RGB565toHSV888(input[pos(i, j)]);
			//if ((IsGREEN(hsv))) GreenCnt++;
		}
	}
	if (GreenCnt > 100) {
		printf("일정 거리 이상 걷기");
		printf("다리 나왔다 올라가자");
		StopCnt++;
	}
}
void Greening(U16* output, U16* input)
{
	int i, j;
	short divGreen[2] = { 0 };
	for (i = 0; i < 120; i++)
	{
		for (j = 91; j < 180; j++)
		{
			/*	hsv = RGB565toHSV888(input[pos(i, j)]);
			if ((IsGREEN(hsv))) divGreen[0]++;
			*/
		}
	}

	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 90; j++)
		{
			/*		hsv = RGB565toHSV888(input[pos(i, j)]);
			if ((IsGREEN(hsv))) divGreen[1]++;
			*/
		}
	}
	if (divGreen[0] < divGreen[1]) printf("왼쪽으로 걷기");
	else printf("오른쪽으로 걷기");
	if ((divGreen[0] - divGreen[1] < 30) && (divGreen[0] - divGreen[1] > -30)) printf("중심 맟춰짐,n보 걷기\n");
	if (divGreen[0] + divGreen[1] < 10) StopCnt++;
	divGreen[0] = divGreen[1] = 0;

}
void DownGreen(U16* output, U16* input)
{
	int i, j;
	short BlackCnt = 0;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			/*		hsv = RGB565toHSV888(input[pos(i, j)]);
			if ((IsGREEN(hsv))) BlackCnt++;
			*/
		}
	}
	if (BlackCnt < 10) printf("계단 내려가");
	BlackCnt = 0;
}
void upTrap(U16* output, U16* input)
{
	int i, j;
	int YellowCnt;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if ((input[pos(i, j)] == 0xFFE0)) YellowCnt++;
		}
	}
	if (YellowCnt > 1000) upstair();


}
void downTrap(U16* output, U16* input)
{

}
void walk()
{
	Send_Command(1);
	unsigned char buf[1] = { 0, };
	while (1)
	{
		uart_read(UART1, buf, 1);
		if (buf[0] == 38)break;
	}
}
void walkslowly()
{
	Send_Command(4);
	unsigned char buf[1] = { 0, };
	while (1)
	{
		uart_read(UART1, buf, 1);
		if (buf[0] == 38)break;
	}
}

void upstair()
{
	Send_Command(2);
	unsigned char buf[1] = { 0, };
	while (1)
	{
		uart_read(UART1, buf, 1);
		if (buf[0] == 38)break;
	}
}

void downstair()
{
	Send_Command(3);
	unsigned char buf[1] = { 0, };
	while (1)
	{
		uart_read(UART1, buf, 1);
		if (buf[0] == 38)break;
	}
}
void ex()
{
	Send_Command(7);
	unsigned char buf[1] = { 0, };
	while (1)
	{
		uart_read(UART1, buf, 1);
		if (buf[0] == 38)break;
	}
}
void tumbling()
{
	Send_Command(8);
	unsigned char buf[1] = { 0, };
	while (1)
	{
		uart_read(UART1, buf, 1);
		if (buf[0] == 38)break;
	}
}
void SeeLeft()
{
	{
		Send_Command(9);
		unsigned char buf[1] = { 0, };
		while (1)
		{
			uart_read(UART1, buf, 1);
			if (buf[0] == 38)break;
		}
	}
}
void SeeRight()
{
	{
		Send_Command(10);
		unsigned char buf[1] = { 0, };
		while (1)
		{
			uart_read(UART1, buf, 1);
			if (buf[0] == 38)break;
		}
	}
}
void SeeFront()
{
	{
		Send_Command(11);
		unsigned char buf[1] = { 0, };
		while (1)
		{
			uart_read(UART1, buf, 1);
			if (buf[0] == 38)break;
		}
	}
}
void goLeft()
{
	{
		Send_Command(12);
		unsigned char buf[1] = { 0, };
		while (1)
		{
			uart_read(UART1, buf, 1);
			if (buf[0] == 38)break;
		}
	}
}
void goRight()
{
	{
		Send_Command(13);
		unsigned char buf[1] = { 0, };
		while (1)
		{
			uart_read(UART1, buf, 1);
			if (buf[0] == 38)break;
		}
	}
}
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
#include "uart_api.h"
#include "robot_protocol.h"
#include "img_processing.h"
#include "robot_motion.h"
#include "init.h"

int main()
{
	int SoundCnt=0;
	int StopCnt =0;
    short i, j;
    int ret;
    init_console();
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
		if(StopCnt == 0)
		{
			if (SoundCnt == 0)
			{
				ex();
				SoundCnt++;
			}
			BeforeStart(&StopCnt);
		}
		else if(StopCnt == 1)
		{
			if (SoundCnt == 1)
			{
				ex();
				SoundCnt++;
			}
			StartBarigate(&StopCnt);
		}
		else if(StopCnt == 2)
		{
			if (SoundCnt == 2)
			{
				ex();
				SoundCnt++;
			}
			upRedStair(&StopCnt);
		}
		else if(StopCnt == 3)
		{
			if (SoundCnt == 3)
			{
				ex();
				SoundCnt++;
			}
			downRedStair(&StopCnt);
		}
		else if(StopCnt == 4)
		{
			if (SoundCnt == 4)
			{
				ex();
				SoundCnt++;
			}
			Find_Black_circle(&StopCnt);
		}
		else if (StopCnt == 5)
		{
			if (SoundCnt == 5)
			{
				ex();
				SoundCnt++;
			}
			hurdle(&StopCnt);
		}
		else if (StopCnt == 6)
		{
			if (SoundCnt == 6)
			{
				ex();
				SoundCnt++;
			}
			Gate(&StopCnt);
		}
		else if (StopCnt == 7)
		{
			if (SoundCnt == 7)
			{
				ex();
				SoundCnt++;
			}
			GreenBridge(&StopCnt);
		}
		else if (StopCnt == 8)
		{
			if (SoundCnt == 8)
			{
				ex();
				SoundCnt++;
			}
			Greening(&StopCnt);
		}
		else if (StopCnt == 9)
		{
			if (SoundCnt == 9)
			{
				ex();
				SoundCnt++;
			}
			DownGreen(&StopCnt);
		}
		DelayLoop(1000);
	}
	
    uart_close();
	close_graphic();
    return 0;
}

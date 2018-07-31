#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdlib.h>
#include <memory.h>
#include <math.h>

int StopCnt = 0;

#include "amazon2_sdk.h"
#include "graphic_api.h"
#include "uart_api.h"
#include "robot_protocol.h"
#include "img_processing.h"
#include "robot_motion.h"
#include "init.h"

int main()
{
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
			BeforeStart(&StopCnt);
		}
		else if(StopCnt == 1)
		{
			StartBarigate(&StopCnt);
		}
		else if(StopCnt == 2)
		{
			upRedStair(&StopCnt);
		}
		else if(StopCnt == 3)
		{
			downRedStair(&StopCnt);
		}
		else if(StopCnt == 4)
		{
			hurdle(&StopCnt);
		}
		DelayLoop(1000);
	}
	
    uart_close();
	close_graphic();
    return 0;
}

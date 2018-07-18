#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <math.h>
#include "amazon2_sdk.h"
#include "graphic_api.h"
#include "Color.h"

#define AMAZON2_GRAPHIC_VERSION		"v0.5"

int main(int argc, char **argv)
{
	short i, j;
	if (open_graphic() < 0) {
		return -1;
	}
	if(direct_camera_display_stat() > 0)
		direct_camera_display_off();
	
	clear_screen();
	U16* input = (U16*)malloc(2 * 90 * 60);
	U16* output = (U16*)malloc(2 * 180 * 120);
	HSV hsv;
	while(1)
	{
		read_fpga_video_data(input);

		for(i=0;i<height;i++)
		{
			for(j=0;j<width;j++)
			{
				hsv = RGB565toHSV888(input[pos(i,j)]);
				if(!(IsGREEN(hsv)))
					input[pos(i,j)] = 0xffff;
			}
		}


		for(i=0;i<_height;i+=2)
        {
            for(j=0;j<_width;j+=2)
            {
                output[pos(i,j)] = output[pos(i,j+1)] = output[pos(i+1,j)] = output[pos(i+1,j+1)] = input[pos(i/2,j/2)];
            }
        }
		//draw_fpga_video_data_full(output);
		draw_fpga_video_data_full(input);
		flip();
	}


	free(input);
	free(output);
	close_graphic();
	return 0;
}


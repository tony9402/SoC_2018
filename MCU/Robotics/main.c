#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <math.h>

#include "amazon2_sdk.h"
#include "graphic_api.h"
#include "uart_api.h"
#include "robot_protocol.h"
#include "Robotics.h"
#include "robotmotion.h"

#define AMAZON2_GRAPHIC_VERSION		"v0.5"
#define SOURCE_VESION               "v0.1"
#define MADE_DATE                   "2018-07-22"

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

int main(void)
{
    U16 *input = (U16*)malloc(43200);
    short i, j;
    int ret;
    if(open_graphic() < 0)return -1;
    direct_camera_display_off();
    clear_screen();
    init_console();
    ret = uart_open();
    if(ret < 0) return EXIT_FAILURE;

    while(1)
    {
        read_fpga_video_data(input);



        draw_fpga_video_data_full(input);
        flip();
    }

    free(input);
    close_graphic();
    uart_close();
    return 0;
}
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
void Attack()
{
	Send_Command(0x25, 0xDA);
	return;
}

void TurnLeft()
{
	Send_Command(0x1B, 0xE4);
	return;
}

void TurnRight()
{
	Send_Command(0x1C, 0xE3);
	return;
}

void GoStraight()
{
	Send_Command(0x18, 0xE7);
	return;
}
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

U16 input[21600] = {0};

int main(void)
{
    short i, j;
    int x, y;
    int r,L_B, L_D, R_B, R_D, g, b, h, s, v;
    short cntBp, cntDp;
    short cnt[3][2] = {0};
    x = y = r = g = b = h = s = v= L_B= L_D= R_B= R_D= cntBp = cntDp = 0;

    int ret;
    if(open_graphic() < 0)return -1;
    direct_camera_display_off();
    clear_screen();
    init_console();
    ret = uart_open();
	uart_config(UART1, 57600, 8, UART_PARNONE, 1);
    if(ret < 0) return EXIT_FAILURE;
    Send_Command(0x01,0xFE);
    while(1)
    {
		
		cnt[0][0] = cnt[0][1] = cnt[1][0] = cnt[1][1] = cnt[2][0] = cnt[2][1] = 0;
		clear_screen();
		read_fpga_video_data(input);
		for (r = 0; r < 4; r++) {
			for (g = 0; g < 6; g++) {
				cntBp = cntDp = 0;
				for (i = 30 * r; i < 30 * r + 30; i++) {
					for (j = 30 * g; j < 30 * g + 30; j++) {
						if ((input[pos(i, j)] == 0x001F)) {
							cntBp += 1;
						}
						else if ((input[pos(i, j)] == 0x0000)) {
							cntDp += 1;
						}
					}
				}
				if (cntBp + cntDp <= 300) {
					for (i = 30 * r; i < 30 * r + 30; i++) {
						for (j = 30 * g; j < 30 * g + 30; j++) {
							input[pos(i, j)] = 0xffff;
						}
					}
				}
				else if (cntBp > 150) {
					for (i = 30 * r; i < 30 * r + 30; i++) {
						for (j = 30 * g; j < 30 * g + 30; j++) {
							input[pos(i, j)] = 0x001f;
						}
					}
				}
			}
		}
		for (i = 0; i < 120; i++) {
			for (j = 0; j < 180; j++) {
				if (j < 50) {
					if (input[pos(i, j)] == 0x0000) {
						cnt[2][0] += 1;
					}
					if ((input[pos(i, j)] == 0x001F)) {
						cnt[2][1] += 1;
					}
				}
				else if (j < 130) {
					if (input[pos(i, j)] == 0x0000) {
						cnt[1][0] += 1;
					}
					if ((input[pos(i, j)] == 0x001F)) {
						cnt[1][1] += 1;
					}
				}
				else if (j < 180) {
					if (input[pos(i, j)] == 0x0000) {
						cnt[0][0] += 1;
					}
					if ((input[pos(i, j)] == 0x001F)) {
						cnt[0][1] += 1;
					}
				}
			}
		}
		if ((MAX3(cnt[0][0], cnt[1][0], cnt[2][0]) < 700) && (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) < 500)) {
			if (L_B == 1) {
				TurnLeft();
			}
			else if (R_B == 1) {
				TurnRight();
			}
			else if (L_D == 1) {
				TurnLeft();
			}
			else if (R_D == 1) {
				TurnRight();
			}
			else {
				TurnRight();
			}
			printf("nothing in there\n");
		}

		if (MAX3(cnt[0][0], cnt[1][0], cnt[2][0]) == cnt[0][0]) {
			L_B = L_D = R_B = R_D = 0;
			if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[0][1]) {
				if (cnt[0][0] > cnt[0][1]) {
					printf("enemy detected in LEFT!TURN LEFT!\n");
                   TurnLeft();
				   L_D = 1;
				}
				else {
					printf("blue detected in LEFT!TURN LEFT!\n");
					TurnLeft();
					L_B = 1;
				}
			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[1][1]) {
				if (cnt[0][0] > cnt[1][1]) {
					printf("enemy detected in LEFT!TURN LEFT!\n");
                   TurnLeft();
				   L_D = 1;
				}
				else {
					printf("blue detected in CENTER!GO STRAIGHT!\n");
                    GoStraight();
				}

			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[2][1]) {
				if (cnt[0][0] > cnt[2][1]) {
					printf("enemy detected in LEFT!TURN LEFT!\n");
                   TurnLeft();
				   L_D = 1;
				}
				else {
					printf("blue detected in RIGHT!TURN RIGHT!\n");
					TurnRight();
					R_B = 1;
				}
			}
		}
		else if (MAX3(cnt[0][0], cnt[1][0], cnt[2][0]) == cnt[1][0]) {
			L_B = L_D = R_B = R_D = 0;
			if (cnt[1][2] >= 300) {
				printf("enemy in face");
				Attack();
			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[0][1]) {	
				if (cnt[1][0] > cnt[0][1]) {
					printf("enemy detected in CENTER!GoStraight!\n");
                   Attack();
				}
				else {
					printf("blue detected in LEFT!TURN LEFT!\n");
                   TurnLeft();
				   L_B = 0;
				}
			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[1][1]) {
				if (cnt[1][0] > cnt[1][1]) {
					printf("enemy detected in CENTER!GoStraight!\n");
                   Attack();
				}
				else {
					printf("blue detected in CENTER!GO STRAIGHT!\n");
                    GoStraight();
				}

			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[2][1]) {
				if (cnt[1][0] > cnt[2][1]) {
					printf("enemy detected in CENTER!GoStraight!\n");
                   Attack();
				}
				else {
					printf("blue detected in RIGHT!TURN RIGHT!\n");
                   TurnRight();
				   R_B = 0;
				}
			}
		}
		else if (MAX3(cnt[0][0], cnt[1][0], cnt[2][0]) == cnt[2][0]) {
			L_B = L_D = R_B = R_D = 0;
			if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[0][1]) {
				if (cnt[2][0] > cnt[0][1]) {
					printf("enemy detected in RIGHT!TURN RIGHT!\n");
                   TurnRight();
				   R_D = 0;
				}
				else {
					printf("blue detected in LEFT!TURN LEFT!\n");
                   TurnLeft();
				   L_B = 0;
				}
			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[1][1]) {
				if (cnt[2][0] > cnt[1][1]) {
					printf("enemy detected in RIGHT!TURN RIGHT!\n");
                   TurnRight();
				   R_D = 0;
				}
				else {
					printf("blue detected in CENTER!GO STRAIGHT!\n");
					GoStraight();
				}

			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[2][1]) {
				if (cnt[2][0] > cnt[2][1]) {
					printf("enemy detected in RIGHT!TURN RIGHT!\n");
                   TurnRight();
				   R_D = 0;
				}
				else {
					printf("blue detected in RIGHT!TURN RIGHT!\n");
                   TurnRight();
				   R_B = 0;
				}
			}
		}
        draw_fpga_video_data_full(input);
        flip();
    }
    close_graphic();
    uart_close();
    return 0;
}
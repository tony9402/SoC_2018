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
#define red(x) (x)>>3
#define green(x) (x)>>2
#define blue(x) (x)>>3
#define RED(x) (x&0xF800)>>11
#define GREEN(x) (x&0x07e0)>>5
#define BLUE(x) (x)&0x001F
#define GRAY(x) (RED(x)+BLUE(x)+GREEN(x))/3
#define color(r,g,b) ((((r)>>3)&0x001f)<<0xb)|((((g)>>2)&0x003f)<<0x5)|((((b)>>3)&0x001f))
void show_help(void)
{
printf("================================================================\n");
printf("Graphic API Example (Ver : %s)\n", AMAZON2_GRAPHIC_VERSION);
printf("================================================================\n");
printf("h : show this message\n");
printf("0 : flip \n");
printf("a : direct camera display on\n");
printf("d : direct camera display off\n");
printf("1 : clear screen \n");
printf("2 : draw_rectfill(10, 200, 100, 100, MAKE_COLORREF(255, 0, 0)); \n");
printf("3 : draw_rectfill(110, 200, 100, 100, MAKE_COLORREF(0, 255, 0)); \n");
printf("4 : draw_rectfill(210, 200, 100, 100, MAKE_COLORREF(0, 0, 255)); \n");
printf("5 : read fpga video data \n");
printf("6 : draw fpga video data < Original > (180 x 120)\n");
printf("7 : draw fpga buffer data \n");
printf("8 : bmp(/root/img/AMAZON2.bmp) load \n");
printf("9 : bmp(/root/img/AMAZON2.bmp) draw \n");
printf("m : Demo \n");
printf("q : exit \n");
printf("x : exit \n");
printf("z : exit \n");
printf("================================================================\n");
}

static void demo(void)
{

	U16* fpga_videodata = (U16*)malloc(180 * 120 * 2);
	int x = 0;
	int y = 0;
	int r, g, b, h, s, v;
	r = g = b = h = s = v = 0;
	short cntBp = 0, cntDp = 0;

	short i, j;
	HSV hsv;
	short cnt[3][2] = { 0 };
	printf("Demo Start\n");
	while (1)
	{
		cnt[0][0] = cnt[0][1] = cnt[1][0] = cnt[1][1] = cnt[2][0] = cnt[2][1] = 0;


		clear_screen();
		read_fpga_video_data(fpga_videodata);
		for (r = 0; r < 4; r++) {
			for (g = 0; g < 6; g++) {
				cntBp = cntDp = 0;
				for (i = 30 * r; i < 30 * r + 30; i++) {
					for (j = 30 * g; j < 30 * g + 30; j++) {
						if ((fpga_videodata[pos(i, j)] <= 0x001F) && (fpga_videodata[pos(i, j)] != 0x0000)) {
							cntBp += 1;
						}
						else if ((fpga_videodata[pos(i, j)] == 0x0000)) {
							cntDp += 1;
						}
					}
				}
				if (cntBp + cntDp <= 400) {
					for (i = 30 * r; i < 30 * r + 30; i++) {
						for (j = 30 * g; j < 30 * g + 30; j++) {
							fpga_videodata[pos(i, j)] = 0xffff;
						}
					}

				}
				else if (cntBp > 50) {
					for (i = 30 * r; i < 30 * r + 30; i++) {
						for (j = 30 * g; j < 30 * g + 30; j++) {
							fpga_videodata[pos(i, j)] = 0x001f;
						}
					}
				}
			}
		}
		for (i = 0; i < 120; i++) {
			for (j = 0; j < 180; j++) {
				if (j < 60) {
					if (fpga_videodata[pos(i, j)] == 0x0000) {
						cnt[0][0] += 1;
					}
					if ((fpga_videodata[pos(i, j)] <= 0x001F) && (fpga_videodata[pos(i, j)] != 0x0000)) {
						cnt[0][1] += 1;
					}
				}
				else if (j < 120) {
					if (fpga_videodata[pos(i, j)] == 0x0000) {
						cnt[1][0] += 1;
					}
					if ((fpga_videodata[pos(i, j)] <= 0x001F) && (fpga_videodata[pos(i, j)] != 0x0000)) {
						cnt[1][1] += 1;
					}
				}
				else if (j < 180) {
					if (fpga_videodata[pos(i, j)] == 0x0000) {
						cnt[2][0] += 1;
					}
					if ((fpga_videodata[pos(i, j)] <= 0x001F) && (fpga_videodata[pos(i, j)] != 0x0000)) {
						cnt[2][1] += 1;
					}
				}
			}
		}

		draw_fpga_video_data_full(fpga_videodata);
		flip();
		printf("L_D=%d C_D=%d R_D=%d\n", cnt[0][0], cnt[1][0], cnt[2][0]);
		printf("L_B=%d C_B=%d R_B=%d\n", cnt[0][1], cnt[1][1], cnt[2][1]);
		if ((MAX3(cnt[0][0], cnt[1][0], cnt[2][0]) < 1000) && (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) < 500)) {
			printf("nothing in there\n");
			printf("max_D %d\n", (MAX3(cnt[0][0], cnt[1][0], cnt[2][0])));
			printf("max_b %d\n", (MAX3(cnt[0][1], cnt[1][1], cnt[2][1])));
		}
		else if (MAX3(cnt[0][0], cnt[1][0], cnt[2][0]) == cnt[0][0]) {
			if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[0][1]) {
				if (cnt[0][0] > cnt[0][1]) {
					printf("enemy detected in LEFT!TURN LEFT!\n");
				}
				else {
					printf("blue detected in LEFT!TURN LEFT!\n");
				}
			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[1][1]) {
				if (cnt[0][0] > cnt[1][1]) {
					printf("enemy detected in LEFT!TURN LEFT!\n");
				}
				else {
					printf("blue detected in CENTER!GO STRAIGHT!\n");
				}

			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[2][1]) {
				if (cnt[0][0] > cnt[2][1]) {
					printf("enemy detected in LEFT!TURN LEFT!\n");
				}
				else {
					printf("blue detected in RIGHT!TURN RIGHT!\n");
				}
			}
		}
		else if (MAX3(cnt[0][0], cnt[1][0], cnt[2][0]) == cnt[1][0]) {
			if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[0][1]) {
				if (cnt[1][0] > cnt[0][1]) {
					printf("enemy detected in CENTER!TURN ATTACK!\n");
				}
				else {
					printf("blue detected in LEFT!TURN LEFT!\n");
				}
			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[1][1]) {
				if (cnt[1][0] > cnt[1][1]) {
					printf("enemy detected in CENTER!ATTACK!\n");
				}
				else {
					printf("blue detected in CENTER!GO STRAIGHT!\n");
				}

			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[2][1]) {
				if (cnt[1][0] > cnt[2][1]) {
					printf("enemy detected in CENTER!ATTACK!\n");
				}
				else {
					printf("blue detected in RIGHT!TURN RIGHT!\n");
				}
			}
		}
		else if (MAX3(cnt[0][0], cnt[1][0], cnt[2][0]) == cnt[2][0]) {
			if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[0][1]) {
				if (cnt[2][0] > cnt[0][1]) {
					printf("enemy detected in RIGHT!TURN RIGHT!\n");
				}
				else {
					printf("blue detected in LEFT!TURN LEFT!\n");
				}
			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[1][1]) {
				if (cnt[2][0] > cnt[1][1]) {
					printf("enemy detected in RIGHT!TURN RIGHT!\n");
				}
				else {
					printf("blue detected in CENTER!GO STRAIGHT!\n");
				}

			}
			else if (MAX3(cnt[0][1], cnt[1][1], cnt[2][1]) == cnt[2][1]) {
				if (cnt[2][0] > cnt[2][1]) {
					printf("enemy detected in RIGHT!TURN RIGHT!\n");
				}
				else {
					printf("blue detected in RIGHT!TURN RIGHT!\n");
				}
			}
		}
		/*if (1)
			break;*/
	}
	free(fpga_videodata);
	printf("Demo End\n");
}

int main(int argc, char **argv)
{

	show_help();
	BOOL b_loop = TRUE;
	if (open_graphic() < 0) {
		return -1;
	}

	SURFACE* bmpsurf = 0;
	U16* fpga_videodata = (U16*)malloc(180 * 120 * 2);

	while (b_loop)
	{
		int ch = getchar();
		switch (ch)
		{
		case 'q':
		case 'Q':
		case 'x':
		case 'X':
		case 'z':
		case 'Z':
			b_loop = FALSE;
			break;
		case 'a':
		case 'A':
			printf("direct camera display on\n");
			direct_camera_display_on();
			break;
		case 'd':
		case 'D':
			printf("direct camera display off\n");
			direct_camera_display_off();
			break;
		case '0':
			if(direct_camera_display_stat() > 0) {
				printf("direct camera display on\n");
				printf("please direct camera diplay off\n");
				break;
			}
			printf("flip\n");
			flip();
			break;
		case '1':
			if(direct_camera_display_stat() > 0) {
				printf("direct camera display on\n");
				printf("please direct camera diplay off\n");
				break;
			}
			printf("clear_screen\n");
			clear_screen();
			break;
		case '2':
			if(direct_camera_display_stat() > 0) {
				printf("direct camera display on\n");
				printf("please direct camera diplay off\n");
				break;
			}
			printf("draw_rectfill(10, 200, 100, 100, MAKE_COLORREF(255, 0, 0));\n");
			draw_rectfill(10, 200, 100, 100, MAKE_COLORREF(255, 0, 0));
			break;
		case '3':
			if(direct_camera_display_stat() > 0) {
				printf("direct camera display on\n");
				printf("please direct camera diplay off\n");
				break;
			}
			printf("draw_rectfill(110, 200, 100, 100, MAKE_COLORREF(0, 255, 0));\n");
			draw_rectfill(110, 200, 100, 100, MAKE_COLORREF(0, 255, 0));
			break;
		case '4':
			if(direct_camera_display_stat() > 0) {
				printf("direct camera display on\n");
				printf("please direct camera diplay off\n");
				break;
			}
			printf("draw_rectfill(210, 200, 100, 100, MAKE_COLORREF(0, 0, 255));\n");
			draw_rectfill(210, 200, 100, 100, MAKE_COLORREF(0, 0, 255));
			break;
		case '5':
			printf("read fpga video data\n");
			read_fpga_video_data(fpga_videodata);
			break;
		case '6':
			if(direct_camera_display_stat() > 0) {
				printf("direct camera display on\n");
				printf("please direct camera diplay off\n");
				break;
			}
			printf("draw fpga video data\n");
			draw_fpga_video_data(fpga_videodata,10,10);
			break;
		case '7':
			if(direct_camera_display_stat() > 0) {
				printf("direct camera display on\n");
				printf("please direct camera diplay off\n");
				break;
			}
			printf("draw fpga video\n");
			/*
			printf("Full < Expension(x2.66), Rotate(90) > (320 x 480)\n");
			draw_img_from_buffer(fpga_videodata, 320, 0, 0, 0, 2.67, 90);
			*/

			printf(" Double < Expension(x1.77), Rotate(0) > (320 x 480) - Default\n");
			draw_img_from_buffer(fpga_videodata, 0, 18, 0, 0, 1.77, 0);
			draw_img_from_buffer(fpga_videodata, 0, 250, 0, 0, 1.77, 0);
			break;
		case '8':
			if (bmpsurf != 0)
			{
				printf("image wad already loaded\n ");

			}
			else
			{
				if(direct_camera_display_stat() > 0) {
					printf("direct camera display on\n");
					printf("please direct camera diplay off\n");
					break;
				}
				printf("bmp(/root/img/AMAZON2.bmp) load\n");
				bmpsurf = loadbmp("/root/img/AMAZON2.bmp");
			}
			break;
		case '9':
			if (bmpsurf == 0)
			{
				printf("bmp is not loaded yet\n");
			}
			else
			{
				if(direct_camera_display_stat() > 0) {
					printf("direct camera display on\n");
					printf("please direct camera diplay off\n");
					break;
				}
				printf("bmp(/root/img/AMAZON2.bmp) draw\n");
				draw_surface(bmpsurf, 10, 300);
			}
			break;
		case 'm':
		case 'M':
			if(direct_camera_display_stat() > 0) {
				printf("direct camera display on\n");
				printf("please direct camera diplay off\n");
				break;
			}
			demo();
			break;
		case 'h':
		case 'H':
			show_help();
		default:
			break;
		}
	}
	free(fpga_videodata);
	if (bmpsurf != 0)
		release_surface(bmpsurf);
	close_graphic();
	return 0;
}


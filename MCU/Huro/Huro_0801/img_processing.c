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
#include "robot_protocol.h"
#include "img_processing.h"
#include "robot_motion.h"

bool MatchLineWithBlack(U16 *input)
{
	ColorInfo black;
	black.x = black.y = black.count = 0;
	U16 result_y = 0;
	U16 result_x = 0;
	int score = 0;
	short i, j;
	
	read_fpga_video_data(input);

	//LookBlackLine();//목돌려

	for(i=0;i<height*2/3;i++)
	{
		for(j=0;j<width/2;j++)
		{
			if(input[pos(i,j)] != 0x0000)
				input[pos(i,j)] = 0xFFFF;
			else
				input[pos(i,j)] = 0x07e0;
			
			if(input[pos(i,j)] == 0x07e0)
			{
				black.x += j;
				black.y += i;
				black.count++;
			}
		}	
	}

	result_y = black.y / black.count;
	result_x = black.x / black.count;
	if(result_y < 10)
	{
		draw_fpga_video_data_full(input);
		flip();
		GoRight();
		return false;
	}

	for(j=0;j<result_x;j++)
	{
		for(i=0;i<height*2/3;i++)
		{
			if(input[pos(i,j)]==0x07e0)
			{
				if(result_y > i - 10)
				{
					score++;
				}
				else if(result_y < i+10)
				{
					score--;
				}
			}
		}
	}

	printf("score : %d\n", score);

	if(score > 15)
	{
		//TurnRight();
		draw_fpga_video_data_full(input);
		flip();
		return false;
	}
	else if(score < -15)
	{
		//TurnLeft();
		draw_fpga_video_data_full(input);
		flip();
		return false;
	}
	else{
		PlayMusic(); //Test_message
		draw_fpga_video_data_full(input);
		flip();
		return true;
	}

	draw_fpga_video_data_full(input);
	flip();
	return false;
}

/*bool Yellow_Gate(U16 *input)
{
	ColorInfo 
}*/

bool Red_Bridge()
{
	short i, j;
	bool min_check, max_check;
	U16 buf[1] = {0};
	U16 *input = (U16*)malloc(2 * 180 * 120);
	
	U16 min_j, max_j;
	min_check = max_check = false;
	U16 *RedColor = (U16*)malloc(2 * 90);
	U32 RedSum = 0;
	U32 RedCount = 0;
	U16 Red_j;
	read_fpga_video_data(input);
	for(i=0;i<height;i++)
	{
		for(j=width-1;j>=width/2;j--)
		{
			if(input[pos(i,j)] == 0xF800)
			{
				RedColor[j]++;
			}
		}
	}

	for(j=width-1;j>=width/2;j--)
	{
		if(RedColor[j] > 12)
		{
			if(min_check == false)
			{
				min_check = true;
				min_j = j;
			}
			if(min_check == true)
			{
				RedSum += RedColor[j] * j;
				RedCount += RedColor[j];
			}
		}
		else
		{
			if(min_check == true)
			{
				max_check = true;
				max_j = j - 1;
			}
		}
	}

	Red_j = RedSum / RedCount;

	for(i=0;i<height;i++)
	{
		input[pos(i,Red_j)] = 0x07e0;
	}
	printf("%d %d %d %d\n",Red_j,max_j, min_j, abs((int)((max_j - min_j) / 2) - Red_j));
	if(Red_j < 50)
	{	
		draw_fpga_video_data_full(input);
		flip();
		free(input);
		free(RedColor);
		return false;
	}
	if(abs((max_j - min_j) / 2 - Red_j)<20)
	{
		PlayMusic();
		draw_fpga_video_data_full(input);
		flip();
		free(input);
		free(RedColor);
		return true;
	}
	else if((max_j - min_j) / 2 - RedSum > 0)
	{
		TurnLeft10();
	}
	else
	{
		TurnRight10();
	}
	draw_fpga_video_data_full(input);
	flip();
	free(input);
	free(RedColor);
	while(1)
	{
		uart_read(1,buf,1);
		if(buf[0] == 38)break;
	}
	return false;
}



U16 visited[21600];
U16 area[8100];
xy position[8100];

bool Find_Black_circle(int *StopCnt)
{
	LookDown();
	short i, j;
	U16 *input = (U16*)malloc(43200);
	DelayLoop(1000000);
	read_fpga_video_data(input);
	memset(visited, 0, 43200);
	memset(area, 0, 16200);
	memset(position, 0, 16200);
	U32 circle = 0;
	queue Q;
	Q.size = 0;
	Q.pos = (xy*)malloc(sizeof(xy) * 16200);
	U16 front, back;
	U32 roomsize = 0;
	front = back = 0;
	U16 qx, qy;
	U32 sum_x, sum_y;
	for(i=0;i<height;i++)
	{
		for(j=0;j<width;j++)
		{
			//if(input[pos(i,j)] != 0)input[pos(i,j)] =0xFFFF;
			roomsize = 0;
			sum_x = 0;
			sum_y = 0;
			if(input[pos(i,j)] == 0x0000 && visited[pos(i,j)] != 1)
			{
				circle++;
				Q.pos[back%8100].x = j;
				Q.pos[back%8100].y = i;
				back = (back%8100 == 8099) ? (back+1)%8100 : back+1;
				Q.size++;
				visited[pos(i,j)] = 1;
				while(Q.size!=0)
				{
					roomsize++;
					qx = Q.pos[front].x;
					qy = Q.pos[front].y;
					sum_x += qx;
					sum_y += qy;
					front = (front+1)%8100;
					Q.size--;
					//input[pos(qy,qx)] = 0xFFFF;
					if(qx - 1>=0&&input[pos(qy,qx-1)] == 0x0000&&visited[pos(qy,qx-1)]==0)
					{
						visited[pos(qy,qx-1)] = 1;
						Q.pos[back%8100].x = qx-1;
						Q.pos[back%8100].y = qy;
						back = (back+1)%8100;
						Q.size++;
					}
					if(qy - 1>=0&&input[pos(qy-1,qx)]==0x0000&&visited[pos(qy-1,qx)]==0)
					{
						visited[pos(qy-1,qx)] = 1;
						Q.pos[back%8100].x = qx;
						Q.pos[back%8100].y = qy - 1;
						back = (back+1)%8100;
						Q.size++;
					}
					if(qx + 1 < width&&input[pos(qy,qx+1)]==0x0000&&visited[pos(qy,qx+1)]==0)
					{
						visited[pos(qy,qx+1)] = 1;
						Q.pos[back%8100].x = qx+1;
						Q.pos[back%8100].y = qy;
						back = (back+1)%8100;
						Q.size++;
					}
					if(qy + 1 < height&&input[pos(qy+1,qx)]==0x0000&&visited[pos(qy+1,qx)]==0)
					{
						visited[pos(qy+1,qx)] = 1;
						Q.pos[back%8100].x = qx;
						Q.pos[back%8100].y = qy+1;
						back = (back+1)%8100;
						Q.size++;
					}
				}
				position[circle-1].x = sum_x / roomsize;
				position[circle-1].y = sum_y / roomsize;
				if(roomsize < 10 || roomsize > 900) // 40
				{
					circle--;
				}
				else if (position[circle - 1].y < 70 || position[circle-1].y > 90) {
					circle--;
				}
				else
				{
					area[circle]=roomsize;
				}
			}
		}
	}
	U16 cnt_circle;
	U16 cx, cy; 
	for(cnt_circle=0;cnt_circle<circle;cnt_circle++)
	{
		cx = position[cnt_circle].x;
		cy = position[cnt_circle].y;
		if(!(30<=cx&&cx<=150&&cy<=100))continue;
		//printf("area : %d\n",area[cnt_circle]);
		for(i=-20;i<=20;i++)
		{
			if(cx + i >= 0 || cx + i < width)
			input[pos(cy,cx+i)] = 0x07e0;
		}
		for(i=-20;i<=20;i++)
		{
			if(cy+i>=0||cy+i<height)
			input[pos(cy+i,cx)] = 0x07e0;
		}
	}
//	printf("Count : %d\n",circle);
//	printf("===============================================================\n");
	mine(StopCnt, circle);
	draw_fpga_video_data_full(input);
	flip();

	free(Q.pos);
	free(input);
	return false;
}

U32 Find_Color(U16 Color, range Range)//색,동적할당,변수(몇개받을건지),넒이
{
	short i, j;
	U16 *input = (U16*)malloc(43200);
	read_fpga_video_data(input);
	memset(visited, 0, 43200);
	memset(area, 0, 16200);
	memset(position, 0, 16200);
	U32 circle = 0;
	queue Q;
	Q.size = 0;
	Q.pos = (xy*)malloc(sizeof(xy) * 16200);
	U16 front, back;
	U32 roomsize = 0;
	front = back = 0;
	U16 qx, qy;
	U32 sum_x, sum_y;
	for (i = 0; i < height; i++)
	{
		for (j = 0; j < width; j++)
		{
			roomsize = 0;
			sum_x = 0;
			sum_y = 0;
			if (input[pos(i, j)] == Color && visited[pos(i, j)] != 1)
			{
				circle++;
				Q.pos[back % 8100].x = j;
				Q.pos[back % 8100].y = i;
				back = (back + 1) % 8100;
				Q.size++;
				visited[pos(i, j)] = 1;
				while (Q.size != 0)
				{
					roomsize++;
					qx = Q.pos[front].x;
					qy = Q.pos[front].y;
					sum_x += qx;
					sum_y += qy;
					front = (front + 1) % 8100;
					Q.size--;
					if (qx - 1 >= 0 && input[pos(qy, qx - 1)] == Color && visited[pos(qy, qx - 1)] == 0)
					{
						visited[pos(qy, qx - 1)] = 1;
						Q.pos[back % 8100].x = qx - 1;
						Q.pos[back % 8100].y = qy;
						back = (back + 1) % 8100;
						Q.size++;
					}
					if (qy - 1 >= 0 && input[pos(qy - 1, qx)] == Color && visited[pos(qy - 1, qx)] == 0)
					{
						visited[pos(qy - 1, qx)] = 1;
						Q.pos[back % 8100].x = qx;
						Q.pos[back % 8100].y = qy - 1;
						back = (back + 1) % 8100;
						Q.size++;
					}
					if (qx + 1 < width&&input[pos(qy, qx + 1)] == Color && visited[pos(qy, qx + 1)] == 0)
					{
						visited[pos(qy, qx + 1)] = 1;
						Q.pos[back % 8100].x = qx + 1;
						Q.pos[back % 8100].y = qy;
						back = (back + 1) % 8100;
						Q.size++;
					}
					if (qy + 1 < height&&input[pos(qy + 1, qx)] == Color && visited[pos(qy + 1, qx)] == 0)
					{
						visited[pos(qy + 1, qx)] = 1;
						Q.pos[back % 8100].x = qx;
						Q.pos[back % 8100].y = qy + 1;
						back = (back + 1) % 8100;
						Q.size++;
					}
				}
				position[circle - 1].x = sum_x / roomsize;
				position[circle - 1].y = sum_y / roomsize;
				if (roomsize < Range.min_area || roomsize > Range.max_area)
				{
					circle--;
				}
				else {
					area[circle] = roomsize;
					position[circle - 1].area = roomsize;
				}
			}
		}
	}
	U16 cnt_circle;
	U16 cx, cy;
	for (cnt_circle = 0; cnt_circle < circle; cnt_circle++)
	{
		cx = position[cnt_circle].x;
		cy = position[cnt_circle].y;
		if (!(30 <= cx && cx <= 150 && cy <= 100))continue;
		for (i = -20; i <= 20; i++)
		{
			if (cx + i >= 0 || cx + i < width)
				input[pos(cy, cx + i)] = 0x07e0;
		}
		for (i = -20; i <= 20; i++)
		{
			if (cy + i >= 0 || cy + i < height)
				input[pos(cy + i, cx)] = 0x07e0;
		}
	}

	draw_fpga_video_data_full(input);
	flip();

	free(Q.pos);
	free(input);
	return circle;
}
void BeforeStart(int *StopCnt)
{
	U16* input = (U16*)malloc(2*180*120);
	read_fpga_video_data(input);
	short i, j;	
	short YellowCnt = 0;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if (input[pos(i, j)] == 0xFFE0) YellowCnt++;
		}
	}
	if (YellowCnt > 700) (*StopCnt)++;//1st try:1000,2nd try:700 
	draw_fpga_video_data_full(input);
	flip();
	free(input);
}

void StartBarigate(int *StopCnt)
{
	short i, j;
	short YellowCnt = 0, BlackCnt = 0;
	U16 *input = (U16*)malloc(2*180*120);
	read_fpga_video_data(input);
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if (input[pos(i, j)] ==0xFFE0) YellowCnt++;
		}
	}
	if (YellowCnt < 300)
	{
		walkFront();
		walkFront();
		walkFront();
		(*StopCnt)++;
	}
	YellowCnt= 0;
	draw_fpga_video_data_full(input);
	flip();
	free(input);
}

void upRedStair(int *StopCnt)
{
	U16 *input = (U16*)malloc(2*180*120);
	read_fpga_video_data(input);
	short i, j;
	U16 RedCnt = 0;
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
			walkslowly();
			walkslowly();
			upstair();
			Cnt++;
			(*StopCnt)++;
		}
	}
	else
	{
		if(Cnt2==0)
		{
			walkFront();
			Cnt2++;
		}
	}
	draw_fpga_video_data_full(input);
	flip();
	free(input);
}

void downRedStair(int *StopCnt)
{
	LookDown();
	U16 *input = (U16*)malloc(2*180*120);
	read_fpga_video_data(input);
	short i, j;
	short RedCnt = 0;
	short Cnt = 0;
	for (i = 70; i < 120; i++)//1st try:0 2nd try:70
	{
		for (j = 0; j < 180; j++)
		{
			if ((input[pos(i, j)] == 0xF800)) RedCnt++;
		}
	}
	if (RedCnt < 25)//1st try:50 2nd try:20 3rd try:35 4th try:28 5th try:25
	{
		downstair();
		(*StopCnt)++;
	}
	else
	{
		walk_Down();
		Cnt++;
	}
	RedCnt = 0;
	draw_fpga_video_data_full(input);
	flip();
	free(input);
}
//U16 area[8100];
//xy position[8100];
int NOT_BLUE=0;
void mine(int *StopCnt, U32 circle)
{
	if (NOT_BLUE < 20) NOT_BLUE++;
	U16 *input = (U16*)malloc(2 * 180 * 120);
//	walk_Down();
	LookDown(); //Test_Look_Down
	read_fpga_video_data(input);
	U32 temp_i,i,j;
	U16 temp=120;
	short BlueCnt = 0;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if ((input[pos(i, j)] == 0x001F)) BlueCnt++;
		}
	}
	free(input);
	for (i = 0; i < circle; i++)
	{
		if (position[i].y < temp)
		{
		
			temp = position[i].y;
				temp_i = i;
		}
		
	}
	if (BlueCnt > 500)
	{
		if (NOT_BLUE > 19)
		{
			(*StopCnt)++;
		}
	}
	else
	{
		if ((10 < position[temp_i].x) && (90 > position[temp_i].x))// 1st:20,90 2nd:10,90
		{
			GoLeft();
		}
		else if ((89 < position[temp_i].x) && (170 > position[temp_i].x))// 1st: 89,160 2nd: 80,170 
		{
			GoRight();
		}
		else
		{
			walk_Down(); 
			DelayLoop(1000000);
		}
	}
}
void hurdle(int *StopCnt)
{
	U16 *input = (U16*)malloc(2*180*120);

	LookDown();
	read_fpga_video_data(input);
	short i, j;
	short BlueCnt = 0;
	for (i = 70; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if ((input[pos(i, j)] == 0x001F)) BlueCnt++;
		}
	}

	draw_fpga_video_data_full(input);
	flip();

	free(input);
	if (BlueCnt < 55)// 1st:50 2nd:55
	{
		walk_Down();
		tumbling();
		(*StopCnt)++;
	}
	else
	{
		walk_Down();
	}
}

U16 BlueIndex[120][180];
U16 BlueIndex2[90];
U16 BlueIndex3[90];
xy Gate_pos[8100];
short TURN_COUNT = 0;

void Gate(int *StopCnt)
{
	short i, j, temp_i1, temp_i2;
	short temp = 0, temp2 = 0;

	U16 *input = (U16*)malloc(2 * 180 * 120);
	read_fpga_video_data(input);
	
	if (TURN_COUNT == 0) {
		SeeFront();
		Turn_Left90();
		TURN_COUNT++;
	}

	U32 Count = 0;
	range Range;
	Range.max_area = 1000;
	Range.min_area = 30;

	Find_Color(0x001F, Range);

	for (i = 0; i < Count; i++)
	{
		if (temp < Gate_pos[i].area)
		{
			temp = Gate_pos[i].area;
			temp_i1 = i;
		}
		if((Gate_pos[i].area<temp)&&(temp2<Gate_pos[i].area))
		{
			temp2 = Gate_pos[i].area;
			temp_i2 = i;

		}
	}
	if (((Gate_pos[temp_i1].x+ Gate_pos[temp_i1].x)/2)<130) GoRight90();
	else GoLeft90();
	if ((((Gate_pos[temp_i1].x + Gate_pos[temp_i1].x) / 2)>40) && ((Gate_pos[temp_i1].x + Gate_pos[temp_i1].x) / 2)<80)   /*(40 < temp_i1)&&(temp_i1 < 50) && (130 <temp_i2)&&( temp_i2 < 140)*/
	{
		walkFront();
		(*StopCnt)++;
	}

	draw_fpga_video_data_full(input);
	flip();
	free(input);

}

void GreenBridge(int *StopCnt)
{
	U16 *input = (U16*)malloc(2 * 180 * 120);

	read_fpga_video_data(input);
	short i, j;
	short GreenCnt = 0;
	
	for (i = 70; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if ((input[pos(i, j)] == 0x07E0)) GreenCnt++;
		}
	}
	if (GreenCnt > 100) 
	{
		//추가해야함
		//멈추면 성공
		(*StopCnt)++;
	}
	else walkFront();//walkSlowly()로 수정해야함 예시용
	draw_fpga_video_data_full(input);
	flip();
}

void Greening(int *StopCnt)
{
	U16 *input = (U16*)malloc(2 * 180 * 120);
	read_fpga_video_data(input);

	short i, j;
	short divGreen[2] = { 0 };

	if (divGreen[0] < divGreen[1]) printf("왼쪽으로 걷기");
	else printf("오른쪽으로 걷기");
	if ((divGreen[0] - divGreen[1] < 30) && (divGreen[0] - divGreen[1] > -30)) printf("중심 맟춰짐,n보 걷기\n");
	if (divGreen[0] + divGreen[1] < 10) (*StopCnt)++;
	divGreen[0] = divGreen[1] = 0;
}

void DownGreen(int *StopCnt)
{
	short i, j;
	short BlackCnt = 0;
	if (BlackCnt < 10) printf("계단 내려가");
	BlackCnt = 0;
}

void upTrap(int *StopCnt)
{
	U16 *input = (U16*)malloc(2*180*120);
	read_fpga_video_data(input);
	short i, j;
	int YellowCnt;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if ((input[pos(i, j)] == 0xFFE0)) YellowCnt++;
		}
	}
	if (YellowCnt > 1000) upstair();
	draw_fpga_video_data_full(input);
	flip();
	free(input);
}
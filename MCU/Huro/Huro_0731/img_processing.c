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

bool Find_Black_circle()
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
				if(roomsize < 40 || roomsize > 900)
				{
					circle--;
				}else{
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
		printf("area : %d\n",area[cnt_circle]);
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
	printf("Count : %d\n",circle);
	printf("===============================================================\n");
	draw_fpga_video_data_full(input);
	flip();

	free(Q.pos);
	free(input);
	return false;
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
	U16 *input = (U16*)malloc(2*180*120);
	read_fpga_video_data(input);
	short i, j;
	short RedCnt = 0;
	short Cnt = 0;
	for (i = 0; i < 120; i++)
	{
		for (j = 0; j < 180; j++)
		{
			if ((input[pos(i, j)] == 0xF800)) RedCnt++;
		}
	}
	if (RedCnt < 10)//1st try:50 2nd try:20
	{
		downstair();
		(*StopCnt)++;
	}
	else
	{
		walkFront();
		Cnt++;
	}
	RedCnt = 0;
	draw_fpga_video_data_full(input);
	flip();
	free(input);
}

void hurdle(int *StopCnt)
{
	U16 *input = (U16*)malloc(2*180*120);
	read_fpga_video_data(input);
	short i, j;
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
		walkFront();
		walkFront();
		walkFront();
		walkFront();
		walkFront();
		tumbling();
		walkFront();
		SeeLeft();
	}
	(*StopCnt)++;
	draw_fpga_video_data_full(input);
	flip();
	free(input);
}

U16 BlueIndex[120][180];
U16 BlueIndex2[90];
U16 BlueIndex3[90];

void Gate(int *StopCnt)
{
	U16 *input = (U16*)malloc(2*180*120);
	read_fpga_video_data(input);
	short i, j, temp_i1, temp_i2;
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
	if ((temp_i1 < 40) || (temp_i2 < 130)) GoRight();
	else GoLeft();
	if ((40 < temp_i1)&&(temp_i1 < 50) && (130 <temp_i2)&&( temp_i2 < 140))
	{
		//walk();
		(*StopCnt)++;
	}
	draw_fpga_video_data_full(input);
	flip();
	free(input);
}

void GreenBridge(int *StopCnt)
{
	short i, j;
	short GreenCnt = 0;
	
	if (GreenCnt > 100) {
		printf("일정 거리 이상 걷기");
		printf("다리 나왔다 올라가자");
		(*StopCnt)++;
	}
}

void Greening(int *StopCnt)
{
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
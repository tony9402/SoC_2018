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
		ex(); //Test_message
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
		ex();
		draw_fpga_video_data_full(input);
		flip();
		free(input);
		free(RedColor);
		return true;
	}
	else if((max_j - min_j) / 2 - RedSum > 0)
	{
		//TurnLeft10();
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
				if(roomsize < 3 || roomsize > 1000) // 40 2rd 10 3rd 3 
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
		if(!(30<=cx&&cx<=150&&cy<=70))continue;
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

U32 Find_Color_RANGE(U16 Color, range Range, Pos_range pos_range)//색,동적할당,변수(몇개받을건지),넒이
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
	for (i = pos_range.First_y; i < pos_range.Second_y; i++)
	{
		for (j = pos_range.First_x; j < pos_range.Second_x; j++)
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
		walkslowly();
		walkslowly();
		walkslowly();
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
			GO_TO_RED_STAIR_MID();
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
	//	if (NOT_BLUE < 20) NOT_BLUE++;
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
	//	if (NOT_BLUE > 19)
	//	{
			(*StopCnt)++;
	//	}
	}
	else
	{
		if ((30 < position[temp_i].x) && (position[temp_i].x < 90))// 1st:20,90 2nd:10,90, 3st 30, 90
		{
			GoLeft();
		}
		else if ((89 < position[temp_i].x) && (position[temp_i].x < 150))// 1st: 89,160 2nd: 80,170 , 3st 89 150
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
   range GateRange;
   GateRange.max_area = 600;
   GateRange.min_area = 10;
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

   Find_Color(0x001F,GateRange);
   
   for (i = 0; i < Count; i++)
   {
      if (temp < position[i].area)
      {
         if (position[i].x < 90)
         {
            temp = position[i].area;
            temp_i1 = i;
         }
      }
      if(position[i].area>temp2)
      {
         if (position[i].x > 89)
         {
            temp2 = position[i].area;
            temp_i2 = i;
         }
      }
   }
   if (((position[temp_i1].x+ position[temp_i1].x)/2)<130) GoRight90();
   else GoLeft90();
   if ((((position[temp_i1].x + position[temp_i1].x) / 2)>40) && (((position[temp_i1].x + position[temp_i1].x) / 2)<80))   /*(40 < temp_i1)&&(temp_i1 < 50) && (130 <temp_i2)&&( temp_i2 < 140)*/
   {
		SeeFront();
		Delay1s();
		walkFront();
		(*StopCnt)++;
   }

   draw_fpga_video_data_full(input);
   flip();
   free(input);

}

void GreenBridge(int *StopCnt)
{
   see65();
   U16 *input = (U16*)malloc(2 * 180 * 120);
   U16 *erosion = (U16*)malloc(2*180*120);
   memcpy(erosion, input, 2*180*120);
   read_fpga_video_data(input);
   short i, j;
   short GreenCnt = 0;
   
	for(i=1;i<height-1;i++)
	{
		for(j=1;j<width-1;j++)
		{
			if(input[pos(i,j)]==0x07e0){
				if((i>=1)&&erosion[pos(i-1,j)]==0xFFFF)
				{
					input[pos(i,j)]=0xFFFF;
				}
				else if((j>=1)&&erosion[pos(i,j-1)]==0xFFFF)
				{
					input[pos(i,j)]=0xFFFF;
				}
				else if((i<height-1)&&erosion[pos(i+1,j)]==0xFFFF)
				{
					input[pos(i,j)]=0xFFFF;
				}
				else if((j<width-1)&&erosion[pos(i,j+1)]==0xFFFF)
				{
					input[pos(i,j)]=0xFFFF;
				}
			}
		}
	}

	free(erosion);

   for (i = 0; i < height; i++)
   {
      for (j = 0; j < width; j++)
      {
		  if(j<20 || j> 160)if(input[pos(i,j)]==0x07e0)input[pos(i,j)]=0xFFFF;
          if ((input[pos(i, j)] == 0x07E0)) GreenCnt++;
      }
   }

   if (GreenCnt > 3000) //3200->3000
   {
		ex();
		walkslowly();
		walkslowly();
		walkslowly();

		range Range = {400, 5000};
		U32 Green_Count;
		U32 Green_j_cnt = 0, Green_j = 0;

		while(1){
			LookDown60();
			Green_j_cnt = Green_j = 0;
			Green_Count = Find_Color(0x07E0, Range);
			for(i=0;i<Green_Count;i++)
			{
				Green_j_cnt += position[i].x;
			}

			Green_j = Green_j_cnt / Green_Count;
			if(Green_j < 85)GoRight60();
			else if(Green_j > 95)GoLeft60();
			else break;
   		}
		up_2cm();
		(*StopCnt)++;
   }
   else walkslowly ();//walkSlowly()로 수정해야함 예시용
   free(input);
   draw_fpga_video_data_full(input);
   flip();
}

void Greening(int *StopCnt)
{
	U16 *input = (U16*)malloc(2 * 180 * 120);
	short divGreen[2] = { 0 };
	LookDown();
	short i, j;
	U32 Green_j_cnt = 0, Green_j = 0;
	U32 Green_Count;
	range Range = {400, 15000};
	Pos_range pos_range = {20, height / 2, width - 20, height};
	
	while(1){
		read_fpga_video_data(input);
		Green_Count = Find_Color_RANGE(0x07E0, Range, pos_range);
		
		for(i=0;i<Green_Count;i++)
		{
			Green_j_cnt += position[i].x;
		}

		Green_j = (Green_Count == 0 ? 0 : Green_j_cnt / Green_Count);

		for (i = 60; i < 120; i++)
		{
			for (j = 10; j < 90; j++)
			{
				if ((input[pos(i, j)] == 0x07E0)) divGreen[0]++;
			}
		}

		for (i = 60; i < 120; i++)
		{
			for (j = 90; j < 170; j++)
			{
				if ((input[pos(i, j)] == 0x07E0)) divGreen[1]++;
			}
		}
		//if (divGreen[0] < divGreen[1]) GoLeft();
		//else GoRight();
		if(Green_j < 87)GoRight();
		else if(Green_j > 93)GoLeft();
		else walk_Down();

		if ((divGreen[0] + divGreen[1]) < 100)
		{
			ex();
			(*StopCnt)++;
			draw_fpga_video_data_full(input);
			flip();
			break;
		}

		divGreen[0] = divGreen[1] = 0;
		draw_fpga_video_data_full(input);
		flip();
	}
	free(input);
}

void DownGreen(int *StopCnt)
{
   U16 *input = (U16*)malloc(2 * 180 * 120);
   read_fpga_video_data(input);

   short i, j;
   short BlackCnt = 0;
   for (i = 70; i < 120; i++)
   {
      for (j = 0; j < 180; j++)
      {
         if ((input[pos(i, j)] == 0x0000)) BlackCnt++;
      }
   }
   if (BlackCnt < 50)//20->50
   {
      ex();
      down_2cm();
      (*StopCnt)++;
   }
   else walk_Down();
   BlackCnt = 0;
   free(input);
   draw_fpga_video_data_full(input);
   flip();
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

void GO_TO_RED_STAIR_MID()
{
	short i, j;
	U16 *input = (U16*)malloc(2*180*120);
	U32 Red_Count = 0;
	U32 Red_Sum_j = 0;
	U16 Red_j = 0;
	range Range = {400, 19000};
	
	while(1){
		//LookDown();
		Red_Count = Find_Color(0xF800, Range);
		Red_Sum_j = 0;
		LookDown60();
		//DelayLoop(1000000);
		if(Red_Count == 1)
		{
			if(position[0].x < 84)
			{
				GoRight();
			}
			else if(position[0].x > 96)
			{
				GoLeft();
			}
			else
			{
				free(input);
				return;
			}
		}else
		{
			for(i=0;i<Red_Count;i++)
			{
				Red_Sum_j+=position[i].x;
			}
			Red_j = Red_Sum_j / Red_Count;
			if(Red_j < 85)
			{
				GoRight();
			}
			else if(Red_j > 95)
			{
				GoLeft();
			}
			else
			{
				free(input);
				return;
			}
		}
	}

	free(input);
	return;
}

void Go_To_MID()
{
	short i;
	U16 *input = (U16*)malloc(2*180*120);
	LookRight();
	LookDown60();

	U32 Black_Count = 0;
	U32 Max_area, Max_i;
	range Range = { 200, 2000};
	while(1){
		read_fpga_video_data(input);
		Black_Count = Find_Color(0x0000, Range);

		Max_area = position[0].area;
		Max_i = i;
		for(i=0;i<Black_Count;i++)
		{
			if(Max_area < position[i].area)
			{
				Max_area = position[i].area;
				Max_i = i;	
			}
		}

		draw_fpga_video_data_full(input);
		flip();
	}
	return;
}
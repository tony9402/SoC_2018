#ifndef __IMG_PROCESSING_H
#define __IMG_PROCESSING_H

#ifndef Change_Image_Scale
    #define width 180
    #define height 120
#endif

#ifdef bool
    #undef bool
    #define bool int
#endif

#ifdef true
    #undef true
    #define true 1
#endif

#ifdef false
    #undef false
    #define false 0
#endif 

#define bool int
#define false 0
#define true 1

#define MAX3(x,y,z)   (((x)>(y))?((x)>(z))?(x):(z):((y)>(z))?(y):(z))
#define MIN3(x,y,z)   (((x)>(y))?((y)>(z))?(z):(y):((x)>(z))?(z):(x))
#define max2(x,y)      ((x)>(y)?(x):(y))
#define min2(x,y)      ((x)>(y)?(y):(x))
#define pos(y,x)     ((y)*180+(x))
#define abs(x)       ((x)<0?-(x):(x))

typedef struct{
	U32 x;
	U32 y;
	U16 count;
}ColorInfo;

typedef struct{
    U16 x;
    U16 y;
	U32 area;
}xy;

typedef struct{
    U32 size;
    xy *pos;
}queue;

typedef struct {
	U16 min_area;
	U16 max_area;
}range;

typedef struct{
    U16 First_x;
    U16 First_y;
    U16 Second_x;
    U16 Second_y;
}Pos_range;

bool MatchLineWithBlack(U16 *input);
bool Red_Bridge();
bool Find_Black_circle(int *StopCnt);
U32 Find_Color(U16 Color, range Range);
U32 Find_Color_RANGE(U16 Color, range Range, Pos_range pos_range);
void BeforeStart(int *StopCnt);
void StartBarigate(int *StopCnt);
void upRedStair(int *StopCnt);
void downRedStair(int *StopCnt);
void hurdle(int *StopCnt);
void mine(int *StopCnt, U32 circle);
void Gate(int *StopCnt);
void GreenBridge(int *StopCnt);
void Greening(int *StopCnt);
void DownGreen(int *StopCnt);
void upTrap(int *StopCnt);
void GO_TO_RED_STAIR_MID();

#endif

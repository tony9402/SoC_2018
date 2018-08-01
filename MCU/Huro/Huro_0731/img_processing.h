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
}xy;

typedef struct{
    U32 size;
    xy *pos;
}queue;

bool MatchLineWithBlack(U16 *input);
bool Red_Bridge();
bool Find_Black_circle();

void BeforeStart(int *StopCnt);
void StartBarigate(int *StopCnt);
void upRedStair(int *StopCnt);
void downRedStair(int *StopCnt);
void hurdle(int *StopCnt);
void Gate(int *StopCnt);
void GreenBridge(int *StopCnt);
void Greening(int *StopCnt);
void DownGreen(int *StopCnt);
void upTrap(int *StopCnt);

#endif
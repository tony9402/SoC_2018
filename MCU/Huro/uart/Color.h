#ifndef __COLOR_H
#define __COLOR_H

#include<memory.h>
#include<stdlib.h>

#define MAX3(x,y,z)   (((x)>(y))?((x)>(z))?(x):(z):((y)>(z))?(y):(z))
#define MIN3(x,y,z)   (((x)>(y))?((y)>(z))?(z):(y):((x)>(z))?(z):(x))
#define max2(x,y)      ((x)>(y)?(x):(y))
#define min2(x,y)      ((x)>(y)?(y):(x))
#define exred(x)      (((x)&0xf800)>>11)
#define exgreen(x)    (((x)&0x07e0)>>5)
#define exblue(x)     (((x)&0x001f)>>0)
#define makered8(x)   ((x)<<3|(x)>>2)
#define makegreen8(x) ((x)<<2|(x)>>4)
#define makeblue8(x)  ((x)<<3|(x)>>2)
/*#define _height       120
#define _width        180*/
#define height        120
#define width         180
#define pos(y,x)     ((y)*180+(x))
#define abs(x)       ((x)<0?-(x):(x))
#define distance_red_green(x) (abs((exred(x))-(exgreen(x)>>1)))
#define distance_green_blue(x) (abs((exblue(x))-(exgreen(x)>>1)))
#define distance_blue_red(x) (abs((exred(x))-(exblue(x))))

typedef unsigned char BYTE;
typedef unsigned short WORD;
typedef unsigned int DWORD;

typedef struct{
    BYTE H : 8;
    BYTE S : 8;
    BYTE V : 8;
}HSV;

typedef struct{
    BYTE red : 8;
    BYTE green : 8;
    BYTE blue : 8;
}__RGB565;

int IsRED(HSV hsv);
int IsGREEN(HSV hsv);
int IsBLUE(HSV hsv);
int IsYELLOW(HSV hsv);
int IsORANGE(HSV hsv);
void erosion(U16 *input);
HSV RGB565toHSV888(U16 RGB);

int IsGRAY(HSV hsv)
{
    return (160<=hsv.V&&hsv.V<=220)&&(hsv.S<=10);
}

int IsBLACK(U16 rgb)
{
    //return (abs(R-B)<=2 && abs(G/2-B) <= 3 && abs(G/2-R) <= 3 && R<8&&G<15&&B<8);
}

int IsRED(HSV hsv)
{
    return ((220<=hsv.H)||(hsv.H<=11))&&(55<=hsv.S);
}

int IsGREEN(HSV hsv)
{
    return ((55<=(hsv.H))&&((hsv.H)<=110))&&(30<=hsv.S);
}

int IsBLUE(HSV hsv)
{
    return ((140<=(hsv.H))&&((hsv.H)<=225))&&(45<=hsv.S)&&(80<=hsv.V);
}

int IsYELLOW(HSV hsv)
{
    return ((30<=(hsv.H))&&((hsv.H)<=45))&&(55<=hsv.S);
}

int IsORANGE(HSV hsv)
{
    return ((12<=(hsv.H))&&((hsv.H)<=20))&&(55<=hsv.S);
}

U16 Save[height * width];

void erosion(U16 *input)
{
    memcpy(Save,input,height * width * 2);
    short i, j;
    for(i=0;i<height;i++)
    {
        for(j=0;j<width;j++)
        {
            if(i == 0 || i == height - 1 || j == 0 || j == width - 1){input[pos(i,j)]=0xFFFF;}
            else{
                if(Save[pos(i-1,j)]==0xFFFF||Save[pos(i,j-1)]==0xFFFF||Save[pos(i+1,j)]==0xFFFF||Save[pos(i,j+1)]==0xFFFF
                   ||Save[pos(i-1,j-1)]==0xFFFF||Save[pos(i-1,j+1)]==0xFFFF||Save[pos(i+1,j-1)]==0xFFFF||Save[pos(i+1,j+1)]==0xFFFF)
                {
                    input[pos(i,j)]=0xFFFF;
                }
            }
        }
        if(i<=height/2)
        {
            input[pos(i,j)]=0x07e0;
        }
    }
    return;
}

HSV RGB565toHSV888(U16 RGB)
{
    __RGB565 rgb = {(exred(RGB)<<3)|(exred(RGB)>>2), (exgreen(RGB)<<2)|(exgreen(RGB)>>4), (exblue(RGB)<<3)|(exblue(RGB)>>2)};
    HSV out;

    BYTE _max_, _min_;
    _max_ = MAX3(rgb.red, rgb.green, rgb.blue);
    _min_ = MIN3(rgb.red, rgb.green, rgb.blue);

    out.V = _max_;
    if(!out.V)
    {
        out.H = 0;
        out.S = 0;
        return out;
    }

    out.S = 255 * (long)(_max_ - _min_) / out.V;
    if(!out.S)
    {
        out.H = 0;
        return out;
    }

    if(_max_ == rgb.red)
    {
        out.H = 0 + 43 * (rgb.green - rgb.blue) / (_max_ - _min_);
    }
    else if(_max_ == rgb.green)
    {
        out.H = 85 + 43 * (rgb.blue - rgb.red) / (_max_ - _min_);
    }
    else
    {
        out.H = 171 + 43 * (rgb.red - rgb.green) / (_max_ - _min_);
    }
    return out;
}

#endif

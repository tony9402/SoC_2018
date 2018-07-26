#ifndef __COLOR_H
#define __COLOR_H

#define MAX3(x,y,z)  (((x)>(y))?((x)>(z))?(x):(z):((y)>(z))?(y):(z))
#define MIN3(x,y,z)  (((x)>(y))?((y)>(z))?(z):(y):((x)>(z))?(z):(x))
#define exred(x)     ((x)&0xf800)>>11
#define exgreen(x)   ((x)&0x07e0)>>5
#define exblue(x)    ((x)&0x001f)>>0
#define _height      120
#define _width       180
#define height       60
#define width        90
#define pos(y,x)     ((y)*_width+(x))
#define abs(x)       (((x)<0)?(-(x)):(x))
// #define IsRED(hsv)     ((220<=(hsv.H))||((hsv.H<=11))&&(150<=hsv.S)
// #define IsGREEN(hsv)   ((55<=(hsv.H))&&((hsv.H)<=110))&&(150<=hsv.S)
// #define IsBLUE(hsv)    ((120<=(hsv.H))&&((hsv.H)<=175))&&(150<=hsv.S)
// #define IsYELLOW(hsv)  ((30<=(hsv.H))&&((hsv.H)<=45))&&(150<=hsv.S)
// #define IsORANGE(hsv)  ((12<=(hsv.H))&&((hsv.H)<=20))&&(150<=hsv.S)

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

int IsRED(HSV hsv)
{
	return ((220 <= hsv.H) || (hsv.H <= 11)) && (55 <= hsv.S);
}

int IsGREEN(HSV hsv)
{
	return ((55 <= (hsv.H)) && ((hsv.H) <= 110)) && (55 <= hsv.S);
}

int IsBLUE(HSV hsv)
{
	return ((120 <= (hsv.H)) && ((hsv.H) <= 175));
}

int IsYELLOW(HSV hsv)
{
	return ((30 <= (hsv.H)) && ((hsv.H) <= 45)) && (55 <= hsv.S);
}

int IsORANGE(HSV hsv)
{
	return ((12 <= (hsv.H)) && ((hsv.H) <= 20)) && (55 <= hsv.S);
}
int lsGRAY(HSV hsv) 
{
	return (hsv.V <= 100) && (55 <= hsv.S);
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

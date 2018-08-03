#ifndef __ROBOT_MOTION_H
#define __ROBOT_MOTION_H

#define GO_LEFT       2       //LOOK_DOWN
#define GO_RIGHT      3       //LOOK_DOWN
#define GO_FORWARD    4       //LOOK_FORWARD
#define SEEFRONT      5       //   
#define TURN_LEFT_90  6       //
#define GO_LEFT90     7
#define GO_RIGHT90    8

#define DELAY         10      //
#define TURN_RIGHT_10 11

#define LOOK_DOWN     13      //
#define WALK_FRONT    14      //
#define WALK_SLOWLY   15      //
#define WALK_Down     16      //
#define UP_STAIR      17      //
#define DOWN_STAIR    18      //
#define LOOK_DOWN_60  19      //


#define GO_LEFT60     20      //
#define GO_RIGHT60    21      //
#define LOOK_FORWARD  22      
#define TUMBLING      23      //
#define DOWN2CM       24      //
#define EX            25      //
#define SEE65         26      //
#define UP2CM         27      //

#define TURN_LEFT_60      
#define TURN_RIGHT_60 
#define DUMBLING_BLUE 9
#define DUMBLING_YELLOW 10
#define DUMBLING_RED 11
#define LOOK_RIGHT 12
#define LOOK_LEFT
//#define LOOK_DOWN 21
#define LOOK_RIGHT 22
#define SEELEFT 24

void PlayMusic();
void GoLeft();
void GoRight();
void GoStraight();
void TurnLeft60();
void TurnRight60();
void TurnRight10();
void LookRight();
void LookDown();
void LookDown60();
void wait_for_stop();
void walkFront();
void walkslowly();
void walk_Down();
void upstair();
void downstair();
void ex();
void tumbling();
void SeeLeft();
void SeeRight();
void SeeFront();
void Turn_Left90();
void GoLeft90();
void GoRight90();
void see65();
void up_2cm();
void down_2cm();
void LookForward();

#endif
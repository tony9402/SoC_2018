#ifndef __ROBOT_MOTION_H
#define __ROBOT_MOTION_H

#define Play_Music 3
#define GO_LEFT 
#define GO_RIGHT
#define GO_FORWARD
#define TURN_LEFT_60 2
#define TURN_RIGHT_60 1
#define TURN_LEFT_10 6
#define TURN_RIGHT_10 5
#define DUMBLING_BLUE
#define DUMBLING_YELLOW
#define DUMBLING_RED
#define LOOK_RIGHT 4
#define LOOK_DOWN
#define WALK_FRONT 1
#define WALK_SLOWLY 4
#define UP_STAIR 2
#define DOWN_STAIR 3
#define EX 7
#define LOOK_LEFT
#define LOOK_DOWN
#define LOOK_RIGHT
#define TUMBLING 8
#define SEELEFT 10

void PlayMusic();
void GoLeft();
void GoRight();
void GoStraight();
void TurnLeft60();
void TurnRight60();
void TurnLeft10();
void TurnRight10();
void LookRight();
void wait_for_stop();
void walkFront();
void walkslowly();
void upstair();
void downstair();
void ex();
void tumbling();
void SeeLeft();
void SeeRight();
void SeeFront();

#endif
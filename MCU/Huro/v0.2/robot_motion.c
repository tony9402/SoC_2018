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
#include "uart_api.h"
#include "robot_motion.h"

void GoLeft()
{
	Send_Command(GO_LEFT);
	wait_for_stop();
}

void GoRight()
{
	Send_Command(GO_RIGHT);
	wait_for_stop();
}

void GoStraight()
{
	Send_Command(GO_FORWARD);
	wait_for_stop();
}

void PlayMusic()
{
	Send_Command(Play_Music);
	wait_for_stop();
}

void TurnLeft60()
{
	Send_Command(TURN_LEFT_60);
	wait_for_stop();
}

void TurnRight60()
{
	Send_Command(TURN_RIGHT_60);
	wait_for_stop();
}

void TurnLeft10()
{
	Send_Command(TURN_LEFT_10);
	wait_for_stop();
}

void TurnRight10()
{
	Send_Command(TURN_RIGHT_10);
	wait_for_stop();
}

void LookRight()
{
    Send_Command(LOOK_RIGHT);
	wait_for_stop();
}

void LookLeft()
{
	Send_Command(LOOK_LEFT);
	wait_for_stop();
}
void LookDown()
{
	Send_Command(LOOK_DOWN);
	wait_for_stop();
}

void LookDown60()
{
	Send_Command(LOOK_DOWN_60);
	wait_for_stop();
}

void walkFront()
{
	Send_Command(WALK_FRONT);
	wait_for_stop();
}

void walkslowly()
{
	Send_Command(WALK_SLOWLY);
	wait_for_stop();
}
void walk_Down()
{
	Send_Command(WALK_Down);
	wait_for_stop();

}

void upstair()
{
	Send_Command(UP_STAIR);
	wait_for_stop();
}

void downstair()
{
	Send_Command(DOWN_STAIR);
	wait_for_stop();
}

void ex()
{
	Send_Command(EX);
	wait_for_stop();
}

void tumbling()
{
	Send_Command(TUMBLING);
	wait_for_stop();
}
void SeeFront()
{
	Send_Command(SEEFRONT);
	wait_for_stop();

}

void SeeLeft()
{
	Send_Command(SEELEFT);
	wait_for_stop();
}
//void SeeRight();
//void SeeFront();

void Turn_Left90()
{
	Send_Command(TURN_LEFT_90);
	wait_for_stop();
}

void GoLeft90()
{
	Send_Command(GO_LEFT90);
	wait_for_stop();

}
void GoRight90()
{
	Send_Command(GO_RIGHT90);
	wait_for_stop();

}

void see65()
{
   Send_Command(SEE65);
   wait_for_stop();
}

void up_2cm()
{
   Send_Command(UP2CM);
   wait_for_stop();
}

void wait_for_stop()
{
	unsigned char buf[1] = { 0, };
	while (1)
	{
		uart_read(UART1, buf, 1);
		if (buf[0] == 38)break;
	}
}




'******** ��Ż������ �⺻�� ���α׷� ********

DIM I AS BYTE
DIM J AS BYTE
DIM �ڼ� AS BYTE
DIM Action_mode AS BYTE
DIM A AS BYTE
DIM A_old AS BYTE
DIM B AS BYTE
DIM C AS BYTE
DIM ����ӵ� AS BYTE
DIM �¿�ӵ� AS BYTE
DIM �¿�ӵ�2 AS BYTE
DIM ������� AS BYTE
DIM �������� AS BYTE
DIM ����üũ AS BYTE
DIM ����ONOFF AS BYTE
DIM ���̷�ONOFF AS BYTE
DIM ����յ� AS INTEGER
DIM �����¿� AS INTEGER
DIM DELAY_TIME AS BYTE
DIM DELAY_TIME2 AS BYTE
DIM TEMP AS BYTE
DIM ������������ AS BYTE
DIM ����Ȯ��Ƚ�� AS BYTE
DIM �Ѿ���Ȯ�� AS BYTE

DIM �ݺ�Ƚ�� AS BYTE
DIM ���⼾���������� AS BYTE
DIM ȫ�����������ÿ��� AS BYTE
DIM ������ AS BYTE

DIM info_index AS BYTE

DIM S6 AS BYTE
DIM S7 AS BYTE
DIM S8 AS BYTE

DIM S11 AS BYTE
DIM S12 AS BYTE
DIM S13 AS BYTE
DIM S14 AS BYTE


'**** ���⼾����Ʈ ����

CONST �յڱ���AD��Ʈ = 2
CONST �¿����AD��Ʈ = 3

'*****  2012�� ���� ���� ****
'CONST ����Ȯ�νð� = 10  'ms
'CONST min = 100			'�ڷγѾ�������
'CONST max = 160			'�����γѾ�������
'CONST COUNT_MAX = 30
'

'**** 2012�� ��� ���� *****
CONST ����Ȯ�νð� = 5  'ms
CONST min = 61			'�ڷγѾ�������
CONST max = 107			'�����γѾ�������
CONST COUNT_MAX = 20

'*******************

CONST �������� = 103	'��6V����

PTP SETON 				'�����׷캰 ���������� ����
PTP ALLON				'��ü���� ������ ���� ����

DIR G6A,1,0,0,1,0,0		'����0~5��
DIR G6B,1,1,1,1,1,1		'����6~11��
DIR G6C,0,0,0,0,0,0		'����12~17��
DIR G6D,0,1,1,0,1,0		'����18~23��


'***** �ʱ⼱�� *********************************
����ONOFF = 0
������� = 0
����üũ = 0
����Ȯ��Ƚ�� = 0
�Ѿ���Ȯ�� = 0
���⼾���������� = 1
ȫ�����������ÿ��� = 0
������������ = 0
'****Action_mode(�ʱ�׼Ǹ��)******************
Action_mode = 0	'D(CODE 27):�����
'Action_mode = 1	'F(CODE 32):����Ʈ���
'Action_mode = 2	'G(CODE 23):���Ӹ��
'Action_mode = 3	'B(CODE 20):�౸���
'Action_mode = 4	'E(CODE 18):��ֹ����ָ��
'Action_mode = 5	'C(CODE 17):ī�޶���
'Action_mode = 6	'A(CODE 15):ȫ�����



'****�ʱ���ġ *****************************
OUT 52,0	'�� LED �ѱ�

GOSUB MOTOR_ON



SPEED 5
GOSUB �����ʱ��ڼ�
GOSUB �⺻�ڼ�

PRINT "VOLUME 150 !"


GOSUB SOUND_MODE_SELECT


GOTO MAIN
'************************************************
'************************************************

MOTOR_FAST_ON:
    GOSUB MOTOR_GET

    MOTOR G6B
    MOTOR G6C
    MOTOR G6A
    MOTOR G6D

    ����ONOFF = 0
    RETURN

    '************************************************
    '************************************************
MOTOR_ON:

    GOSUB MOTOR_GET

    MOTOR G6B
    DELAY 50
    MOTOR G6C
    DELAY 50
    MOTOR G6A
    DELAY 50
    MOTOR G6D

    ����ONOFF = 0
    GOSUB ������			
    RETURN

    '************************************************
    '����Ʈ�������ͻ�뼳��
MOTOR_OFF:

    MOTOROFF G6B
    MOTOROFF G6C
    MOTOROFF G6A
    MOTOROFF G6D
    ����ONOFF = 1	
    GOSUB MOTOR_GET	
    GOSUB ������	
    RETURN
    '************************************************
    '��ġ���ǵ��
MOTOR_GET:
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,1
    GETMOTORSET G6C,1,1,1,0,0,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN

    '************************************************
All_motor_Reset:

    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    MOTORMODE G6B,1,1,1, , ,1
    MOTORMODE G6C,1,1,1

    RETURN
    '************************************************
All_motor_mode2:

    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    MOTORMODE G6B,2,2,2, , ,2
    MOTORMODE G6C,2,2,2

    RETURN
    '************************************************
All_motor_mode3:

    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    MOTORMODE G6B,3,3,3, , ,3
    MOTORMODE G6C,3,3,3

    RETURN
    '************************************************
Leg_motor_mode1:
    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    RETURN
    '************************************************
Leg_motor_mode2:
    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    RETURN

    '************************************************
Leg_motor_mode3:
    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    RETURN
    '************************************************
Leg_motor_mode4:
    MOTORMODE G6A,3,2,2,1,3
    MOTORMODE G6D,3,2,2,1,3
    RETURN
    '************************************************
Leg_motor_mode5:
    MOTORMODE G6A,3,2,2,1,2
    MOTORMODE G6D,3,2,2,1,2
    RETURN
    '************************************************
    '************************************************
Arm_motor_mode1:
    MOTORMODE G6B,1,1,1
    MOTORMODE G6C,1,1,1
    RETURN
    '************************************************
Arm_motor_mode2:
    MOTORMODE G6B,2,2,2
    MOTORMODE G6C,2,2,2
    RETURN
    '************************************************
Arm_motor_mode3:
    MOTORMODE G6B,3,3,3
    MOTORMODE G6C,3,3,3
    RETURN

    '************************************************
    '*******�⺻�ڼ�����*****************************
    '************************************************
�����ʱ��ڼ�:
    MOVE G6A,95,  76, 145,  93, 105, 100
    MOVE G6D,95,  76, 145,  93, 105, 100
    MOVE G6B,100,  45,  90, 100, 100, 100
    MOVE G6C,100,  45,  90, 100, 100, 100
    WAIT
    �ڼ� = 0
    RETURN
    '************************************************
����ȭ�ڼ�:
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    �ڼ� = 0

    RETURN
    '************************************************
�⺻�ڼ�:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    �ڼ� = 0
    ������������ = 0
    RETURN
    '************************************************	
�����ڼ�:
    MOVE G6A,100, 56, 182, 76, 100, 100
    MOVE G6D,100, 56, 182, 76, 100, 100
    MOVE G6B,100, 20, 90, 100, 100, 100
    MOVE G6C,100, 20, 90, 100, 100, 100
    WAIT
    �ڼ� = 2
    RETURN
    '************************************************
�����ڼ�:

    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT
    �ڼ� = 1

    RETURN

    '************************************************
RX_EXIT:
    'GOSUB SOUND_STOP
    ERX 4800, A, MAIN

    GOTO RX_EXIT
    '************************************************
GOSUB_RX_EXIT:

    ERX 4800, A, GOSUB_RX_EXIT2

    GOTO GOSUB_RX_EXIT

GOSUB_RX_EXIT2:
    RETURN
    '************************************************
    '******* ��������� *************************
    '************************************************
MR_SOUND_OPEN:
    PRINT "OPEN MRSOUND.MRS !"
    RETURN
    '************************************************
SOUND_ȫ��1:
    PRINT "SOUND 48!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_ȫ��2:
    PRINT "SOUND 49!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_ȫ��3:
    PRINT "SOUND 50!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_ȫ��4:
    PRINT "SOUND 51!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_ȫ��5:
    PRINT "SOUND 52!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_ȫ��6:
    PRINT "SOUND 53!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_ȫ��7:
    PRINT "SOUND 54!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_ȫ��8:
    PRINT "SOUND 55!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_ȫ��9:
    PRINT "SOUND 56!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
    '************************************************
SOUND_����ü����: '
    PRINT "SOUND 47!"
    RETURN
SOUND_���մ���: '
    PRINT "SOUND 46!"
    RETURN
SOUND_�ȳ��ϼ���: '
    PRINT "SOUND 12!"
    RETURN
SOUND_�ȳ��ϼ���̴Ϸκ��������ߵȸ�Ż�������Դϴ�: '
    PRINT "SOUND 0!"
    RETURN
    '************************************************
MRSOUND_OPEN:
    PRINT "OPEN MRSOUND.mrs !"
    RETURN
    '************************************************
SOUND_MODE_SELECT:
    GOSUB MR_SOUND_OPEN

    IF Action_mode = 0 THEN			
        GOSUB  SOUND_�����
    ELSEIF Action_mode = 1 THEN		
        GOSUB SOUND_�������
    ELSEIF Action_mode = 2 THEN		
        GOSUB SOUND_���Ӹ��
    ELSEIF Action_mode = 3 THEN		
        GOSUB SOUND_�౸���
    ELSEIF Action_mode = 4 THEN		
        GOSUB SOUND_��ֹ����ָ��
    ELSEIF Action_mode = 5 THEN		
        GOSUB SOUND_ī�޶���
    ELSEIF Action_mode = 6 THEN		
        GOSUB SOUND_ȫ�����
    ENDIF

    RETURN
    '************************************************
SOUND_�����:
    PRINT "SOUND 1!"
    RETURN
SOUND_�������:
    PRINT "SOUND 2!"
    RETURN
SOUND_���Ӹ��:
    PRINT "SOUND 3!"
    RETURN
SOUND_�౸���:
    PRINT "SOUND 4!"
    RETURN
SOUND_��ֹ����ָ��:
    PRINT "SOUND 5!"
    RETURN
SOUND_ȫ�����:
    PRINT "SOUND 6!"
    RETURN
SOUND_ī�޶���:
    PRINT "SOUND 7!"
    RETURN
SOUND_û��÷�:
    PRINT "SOUND 26!"
    RETURN
SOUND_û�⳻��:
    PRINT "SOUND 27!"
    RETURN
SOUND_���÷�:
    PRINT "SOUND 28!"
    RETURN
SOUND_��⳻��:
    PRINT "SOUND 29!"
    RETURN


SOUND_BGM1:
    PRINT "AUTO 31!"
    RETURN
SOUND_BGM2:
    PRINT "AUTO 32!"
    RETURN
SOUND_BGM3:
    PRINT "AUTO 33!"
    RETURN
SOUND_BGM4:
    PRINT "AUTO 34!"
    RETURN
SOUND_BGM5:
    PRINT "AUTO 35!"
    RETURN
SOUND_BGM6:
    PRINT "AUTO 36!"
    RETURN
SOUND_BGM7:
    PRINT "AUTO 37!"
    RETURN
SOUND_BGM8:
    PRINT "AUTO 38!"
    RETURN
SOUND_BGM9:
    PRINT "AUTO 39!"
    RETURN
SOUND_BGM10:
    PRINT "AUTO 40!"
    RETURN
SOUND_BGM11:
    PRINT "AUTO 41!"
    RETURN
SOUND_MUSIC42:
    PRINT "SOUND 42!"
    RETURN

SOUND_ALL_OFF_MSG:
    PRINT "SOUND 20!"
    DELAY 1500
    GOSUB SOUND_VOLUME_0
    RETURN

SOUND_ALL_ON_MSG:
    PRINT "VOLUME 150 !"
    PRINT "SOUND 21!"

    RETURN

SOUND_ON_OK_MSG:
    PRINT "SOUND 22!"
    RETURN

SOUND_����:
    PRINT "SOUND 23!"
    RETURN
SOUND_����:
    PRINT "SOUND 24 !"
    RETURN
SOUND_��:
    PRINT "SOUND 25 !"
    RETURN
SOUND_Walk_Move:
    PRINT "SOUND 45 !"
    RETURN
SOUND_Walk_Ready:
    PRINT "PLAYNUM 43 !"
    RETURN
SOUND_walk:
    PRINT "SOUND 43 !"
    RETURN
SOUND_REPLAY:
    PRINT "!"
    RETURN


SOUND_VOLUME_0:
    PRINT "VOLUME 0 !"
    RETURN

SOUND_STOP:
    PRINT "STOP !"
    RETURN

SOUND_UP:
    PRINT "UP 10 !"
    RETURN

SOUND_DOWN:
    PRINT "DOWN 10 !"
    RETURN


    '************************************************
    '******* �ǿ��� �Ҹ� ���� ***********************
    '************************************************


������:
    TEMPO 220
    MUSIC "O23EAB7EA>3#C"
    RETURN
    '************************************************
������:
    TEMPO 220
    MUSIC "O38GD<BGD<BG"
    RETURN
    '************************************************
�������̸�Ʈ��:
    TEMPO 220
    MUSIC "O28B>4D8C4E<8B>4D<8B>4G<8E>4C"
    RETURN
    '************************************************
������:
    TEMPO 210
    MUSIC "O23C5G3#F5G3A5G"
    RETURN
    '************************************************
����Ʈ��:
    TEMPO 210
    MUSIC "O15A>C<A>3D"
    RETURN
    '************************************************
�����:
    TEMPO 180
    MUSIC "O13A"
    DELAY 300

    RETURN
    '************************************************
������:
    TEMPO 180
    MUSIC "A"
    DELAY 300

    RETURN
    '************************************************
���̷���:
    TEMPO 180
    MUSIC "O22FC"
    DELAY 10
    RETURN
    '************************************************

�౸������:
    TEMPO 180
    MUSIC "O28A#GABA"
    RETURN
    '************************************************

��ֹ�������:
    TEMPO 200
    MUSIC "O37C<C#BCA"
    RETURN
    '************************************************
    '************************************************
    '*******************************************
DANCE_STOP:

    ERX 4800,A ,DANCE_GOGO
    IF A = 26  THEN
        ������ = 1
    ENDIF

DANCE_GOGO:

    RETURN
    '************************************************
    '******************************************
STOP_MAIN:
    PRINT "STOP !"
    GOSUB All_motor_mode3

    HIGHSPEED SETOFF
    SPEED 6
    MOVE G6B,, 50, 100
    MOVE G6C,, 50, 100
    WAIT
    SPEED 6
    GOSUB �⺻�ڼ�
    ������ = 0


    GOTO RX_EXIT
    '*******************************************
�ڷ��Ͼ��:

    IF ����ONOFF = 1 THEN
        GOSUB MOTOR_ON
    ENDIF
    HIGHSPEED SETOFF
    GOSUB All_motor_Reset

    SPEED 15
    GOSUB �⺻�ڼ�

    MOVE G6A,90, 130, 120,  80, 110, 100
    MOVE G6D,90, 130, 120,  80, 110, 100
    MOVE G6B,150, 160,  10, 100, 100, 100
    MOVE G6C,150, 160,  10, 100, 100, 100
    WAIT

    MOVE G6B,170, 140,  10, 100, 100, 100
    MOVE G6C,170, 140,  10, 100, 100, 100
    WAIT

    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT
    SPEED 10
    MOVE G6A, 80, 155,  85, 150, 150, 100
    MOVE G6D, 80, 155,  85, 150, 150, 100
    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT



    MOVE G6A, 75, 162,  55, 162, 155, 100
    MOVE G6D, 75, 162,  59, 162, 155, 100
    MOVE G6B,188,  10, 100, 100, 100, 100
    MOVE G6C,188,  10, 100, 100, 100, 100
    WAIT

    SPEED 10
    MOVE G6A, 60, 162,  30, 162, 145, 100
    MOVE G6D, 60, 162,  30, 162, 145, 100
    MOVE G6B,170,  10, 100, 100, 100, 100
    MOVE G6C,170,  10, 100, 100, 100, 100
    WAIT
    GOSUB Leg_motor_mode3	
    MOVE G6A, 60, 150,  28, 155, 140, 100
    MOVE G6D, 60, 150,  28, 155, 140, 100
    MOVE G6B,150,  60,  90, 100, 100, 100
    MOVE G6C,150,  60,  90, 100, 100, 100
    WAIT

    MOVE G6A,100, 150,  28, 140, 100, 100
    MOVE G6D,100, 150,  28, 140, 100, 100
    MOVE G6B,130,  50,  85, 100, 100, 100
    MOVE G6C,130,  50,  85, 100, 100, 100
    WAIT
    DELAY 100

    MOVE G6A,100, 150,  33, 140, 100, 100
    MOVE G6D,100, 150,  33, 140, 100, 100
    WAIT
    SPEED 10
    GOSUB �⺻�ڼ�

    �Ѿ���Ȯ�� = 1
    RETURN

    '**********************************************
�������Ͼ��:

    HIGHSPEED SETOFF
    PTP SETON 				
    PTP ALLON

    GOSUB All_motor_Reset


    SPEED 15
    MOVE G6A,100, 15,  70, 140, 100,
    MOVE G6D,100, 15,  70, 140, 100,
    MOVE G6B,20,  140,  15
    MOVE G6C,20,  140,  15
    WAIT

    SPEED 12
    MOVE G6A,100, 136,  35, 80, 100,
    MOVE G6D,100, 136,  35, 80, 100,
    MOVE G6B,20,  30,  80
    MOVE G6C,20,  30,  80
    WAIT

    SPEED 12
    MOVE G6A,100, 165,  70, 30, 100,
    MOVE G6D,100, 165,  70, 30, 100,
    MOVE G6B,30,  20,  95
    MOVE G6C,30,  20,  95
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 10
    MOVE G6A,100, 165,  45, 90, 100,
    MOVE G6D,100, 165,  45, 90, 100,
    MOVE G6B,130,  50,  60
    MOVE G6C,130,  50,  60
    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�
    �Ѿ���Ȯ�� = 1
    RETURN

    '******************************************
    '************************************************
    '****** ���� ����********************************
    '************************************************

��������50:
    GOSUB SOUND_Walk_Ready
    ����ӵ� = 10'5
    �¿�ӵ� = 5'8'3
    �¿�ӵ�2 = 4'5'2
    �Ѿ���Ȯ�� = 0
    GOSUB Leg_motor_mode3

    IF ������� = 0 THEN
        ������� = 1

        SPEED 4
        '�����ʱ���
        MOVE G6A, 88,  71, 152,  91, 110
        MOVE G6D,108,  76, 146,  93,  94
        MOVE G6B,100,35
        MOVE G6C,100,35
        WAIT

        SPEED 10'����ӵ�
        '�޹ߵ��
        MOVE G6A, 90, 100, 115, 105, 114
        MOVE G6D,113,  78, 146,  93,  94
        MOVE G6B,90
        MOVE G6C,110
        WAIT


        GOTO ��������50_1	
    ELSE
        ������� = 0

        SPEED 4
        '���ʱ���
        MOVE G6D,  88,  71, 152,  91, 110
        MOVE G6A, 108,  76, 146,  93,  94
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        SPEED 10'����ӵ�
        '�����ߵ��
        MOVE G6D, 90, 100, 115, 105, 114
        MOVE G6A,113,  78, 146,  93,  94
        MOVE G6C,90
        MOVE G6B,110
        WAIT


        GOTO ��������50_2	

    ENDIF


    '*******************************


��������50_1:

    SPEED ����ӵ�
    '�޹߻�������
    MOVE G6A, 85,  44, 163, 113, 114
    MOVE G6D,110,  77, 146,  93,  94
    WAIT

    GOSUB SOUND_REPLAY

    SPEED �¿�ӵ�
    'GOSUB Leg_motor_mode3
    '�޹��߽��̵�
    MOVE G6A,110,  76, 144, 100,  93
    MOVE G6D,85, 93, 155,  71, 112
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF


    SPEED ����ӵ�
    'GOSUB Leg_motor_mode2
    '�����ߵ��10
    MOVE G6A,111,  77, 146,  93, 94
    MOVE G6D,90, 100, 105, 110, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    ERX 4800,A, ��������50_2
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        'GOSUB Leg_motor_mode3
        SPEED 5

        '���ʱ���2
        MOVE G6A, 106,  76, 146,  93,  96		
        MOVE G6D,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	


        SPEED 3
        GOSUB �⺻�ڼ�
        GOSUB Leg_motor_mode1
        ' GOSUB ���̷�OFF
        GOTO RX_EXIT
    ENDIF
    '**********


��������50_2:


    SPEED ����ӵ�
    '�����߻�������
    MOVE G6D,85,  44, 163, 113, 114
    MOVE G6A,110,  77, 146,  93,  94
    WAIT

    GOSUB SOUND_REPLAY

    SPEED �¿�ӵ�
    'GOSUB Leg_motor_mode3
    '�������߽��̵�
    MOVE G6D,110,  76, 144, 100,  93
    MOVE G6A, 85, 93, 155,  71, 112
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    SPEED ����ӵ�
    'GOSUB Leg_motor_mode2
    '�޹ߵ��10
    MOVE G6A, 90, 100, 105, 110, 114
    MOVE G6D,111,  77, 146,  93,  94
    MOVE G6B, 90
    MOVE G6C,110
    WAIT

    ERX 4800,A, ��������50_1
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        'GOSUB Leg_motor_mode3
        SPEED 5

        '�����ʱ���2
        MOVE G6D, 106,  76, 146,  93,  96		
        MOVE G6A,  88,  71, 152,  91, 106
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        SPEED 3
        GOSUB �⺻�ڼ�
        GOSUB Leg_motor_mode1
        ' GOSUB ���̷�OFF
        GOTO RX_EXIT
    ENDIF


    GOTO ��������50_1
    '************************************************
    '************************************************
    '************************************************
��������50:
    GOSUB SOUND_Walk_Ready
    ����ӵ� = 12'6
    �¿�ӵ� = 6'3
    �¿�ӵ�2 = 4'2
    �Ѿ���Ȯ�� = 0
    GOSUB Leg_motor_mode3



    IF ������� = 0 THEN
        ������� = 1

        SPEED 4
        '�����ʱ���
        MOVE G6A, 88,  71, 152,  91, 110
        MOVE G6D,108,  76, 146,  93,  94
        MOVE G6B,100,35
        MOVE G6C,100,35
        WAIT

        SPEED 10'����ӵ�
        '�޹ߵ��
        MOVE G6A, 90, 95, 115, 105, 114
        MOVE G6D,113,  78, 146,  93,  94
        MOVE G6B,90
        MOVE G6C,110
        WAIT

        GOTO ��������50_1	
    ELSE
        ������� = 0

        SPEED 4
        '���ʱ���
        MOVE G6D,  88,  71, 152,  91, 110
        MOVE G6A, 108,  76, 146,  93,  94
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        SPEED 10'����ӵ�
        '�����ߵ��
        MOVE G6D, 90, 95, 115, 105, 114
        MOVE G6A,113,  78, 146,  93,  94
        MOVE G6C,90
        MOVE G6B,110
        WAIT

        GOTO ��������50_2

    ENDIF


��������50_1:
    SPEED ����ӵ�
    GOSUB Leg_motor_mode2
    '�������߽��̵�
    MOVE G6D,110,  76, 144, 100,  93
    MOVE G6A, 90, 93, 155,  71, 112
    WAIT
    GOSUB SOUND_REPLAY

    SPEED �¿�ӵ�2
    GOSUB Leg_motor_mode3
    '�����߻�������
    MOVE G6D,90,  46, 163, 110, 114
    MOVE G6A,110,  77, 147,  90,  94
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    SPEED ����ӵ�
    '�����ߵ��10
    MOVE G6A,112,  77, 147,  93, 94
    MOVE G6D,90, 100, 105, 110, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    ERX 4800,A, ��������50_2
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        '���ʱ���2
        MOVE G6A, 106,  76, 146,  93,  96		
        MOVE G6D,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	

        SPEED 3
        GOSUB �⺻�ڼ�
        'GOSUB Leg_motor_mode1
        ' GOSUB ���̷�OFF
        GOTO RX_EXIT
    ENDIF
    '**********

��������50_2:
    SPEED ����ӵ�
    GOSUB Leg_motor_mode2
    '�޹��߽��̵�
    MOVE G6A,110,  76, 144, 100,  93
    MOVE G6D,90, 93, 155,  71, 112
    WAIT
    GOSUB SOUND_REPLAY

    SPEED �¿�ӵ�2
    GOSUB Leg_motor_mode3
    '�޹߻�������
    MOVE G6A, 90,  46, 163, 110, 114
    MOVE G6D,110,  77, 147,  90,  94
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    SPEED ����ӵ�
    '�޹ߵ��10
    MOVE G6A, 90, 100, 105, 110, 114
    MOVE G6D,112,  76, 147,  93,  94
    MOVE G6B, 90
    MOVE G6C,110
    WAIT

    ERX 4800,A, ��������50_1
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        '���ʱ���2
        MOVE G6D, 106,  76, 146,  93,  96		
        MOVE G6A,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	

        SPEED 3
        GOSUB �⺻�ڼ�
        'GOSUB Leg_motor_mode1
        ' GOSUB ���̷�OFF
        GOTO RX_EXIT
    ENDIF  	

    GOTO ��������50_1
    '**********************************************
    '******************************************
�����޸���50:
    �Ѿ���Ȯ�� = 0
    GOSUB SOUND_Walk_Ready
    SPEED 12
    HIGHSPEED SETON
    GOSUB Leg_motor_mode4

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  78, 145,  93, 98
        WAIT

        GOTO �����޸���50_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  78, 145,  93, 98
        WAIT

        GOTO �����޸���50_4
    ENDIF


    '**********************

�����޸���50_1:
    MOVE G6A,95,  95, 100, 120, 104
    MOVE G6D,104,  78, 146,  91,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT


�����޸���50_2:
    MOVE G6A,95,  75, 122, 120, 104
    MOVE G6D,104,  80, 146,  89,  100
    WAIT

    GOSUB SOUND_REPLAY

�����޸���50_3:
    MOVE G6A,103,  70, 145, 103,  100
    MOVE G6D, 95, 88, 160,  68, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, �����޸���50_4
    IF A <> A_old THEN  GOTO �����޸���50_����

    '*********************************

�����޸���50_4:
    MOVE G6D,95,  95, 100, 120, 104
    MOVE G6A,104,  78, 146,  91,  102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT


�����޸���50_5:
    MOVE G6D,95,  75, 122, 120, 104
    MOVE G6A,104,  80, 146,  89,  100
    WAIT

    GOSUB SOUND_REPLAY

�����޸���50_6:
    MOVE G6D,103,  70, 145, 103,  100
    MOVE G6A, 95, 88, 160,  68, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, �����޸���50_1
    IF A <> A_old THEN  GOTO �����޸���50_����


    GOTO �����޸���50_1


�����޸���50_����:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB ����ȭ�ڼ�
    SPEED 5
    GOSUB �⺻�ڼ�

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************

    '******************************************
�����޸���40:
    �Ѿ���Ȯ�� = 0
    SPEED 10
    GOSUB SOUND_Walk_Ready
    HIGHSPEED SETON
    GOSUB Leg_motor_mode5

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,88,  73, 145,  96, 102
        MOVE G6D,104,  73, 145,  96, 100
        WAIT

        GOTO �����޸���40_1
    ELSE
        ������� = 0
        MOVE G6D,88,  73, 145,  96, 102
        MOVE G6A,104,  73, 145,  96, 100
        WAIT


        GOTO �����޸���40_4
    ENDIF


    '**********************

�����޸���40_1:
    'SPEED 10
    MOVE G6A,92,  92, 100, 115, 104
    MOVE G6D,103,  74, 145,  96,  100
    MOVE G6B, 120
    MOVE G6C,80
    'WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

�����޸���40_2:
    'SPEED 10
    MOVE G6A,95,  100, 122, 95, 104
    MOVE G6D,103,  70, 145,  102,  100
    'WAIT

�����޸���40_3:
    'SPEED 10
    MOVE G6A,103,  90, 145, 80, 100
    MOVE G6D,92,  64, 145,  108,  102
    'WAIT
    GOSUB SOUND_REPLAY



    ERX 4800,A, �����޸���40_4
    IF A <> A_old THEN  GOTO �����޸���40_����
    '*********************************

�����޸���40_4:
    'SPEED 10
    MOVE G6D,92,  92, 100, 115, 104
    MOVE G6A,103,  74, 145,  96,  100
    MOVE G6C, 120
    MOVE G6B,80
    'WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

�����޸���40_5:

    MOVE G6D,95,  100, 122, 95, 104
    MOVE G6A,103,  70, 145,  102,  100


�����޸���40_6:

    MOVE G6D,103,  90, 145, 80, 100
    MOVE G6A,92,  64, 145,  108,  102
    ' WAIT
    GOSUB SOUND_REPLAY

    ERX 4800,A, �����޸���40_1
    IF A <> A_old THEN  GOTO �����޸���40_����

    GOTO  �����޸���40_1 	

�����޸���40_����:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB ����ȭ�ڼ�
    SPEED 5
    GOSUB �⺻�ڼ�

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************

    '******************************************
����ȭ����:
    HIGHSPEED SETOFF
    SPEED 10
    GOSUB ����ȭ�ڼ�
    SPEED 15
    GOSUB �⺻�ڼ�
    GOSUB Leg_motor_mode1
    RETURN

    '******************************************
    '**********************************************

    '******************************************
������������:
    �Ѿ���Ȯ�� = 0
    GOSUB SOUND_Walk_Ready
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_4
    ENDIF


    '**********************

������������_1:
    MOVE G6A,95,  95, 120, 100, 104
    MOVE G6D,104,  77, 146,  91,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT


������������_2:
    MOVE G6A,95,  85, 130, 103, 104
    MOVE G6D,104,  79, 146,  89,  100
    WAIT

������������_3:
    MOVE G6A,103,   85, 130, 103,  100
    MOVE G6D, 95,  79, 146,  89, 102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, ������������_4
    IF A <> A_old THEN  GOTO ������������_����

    '*********************************

������������_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 146,  91,  102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT


������������_5:
    MOVE G6D,95,  85, 130, 103, 104
    MOVE G6A,104,  79, 146,  89,  100
    WAIT

������������_6:
    MOVE G6D,103,   85, 130, 103,  100
    MOVE G6A, 95,  79, 146,  89, 102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, ������������_1
    IF A <> A_old THEN  GOTO ������������_����


    GOTO ������������_1


������������_����:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB ����ȭ�ڼ�
    SPEED 10
    GOSUB �⺻�ڼ�

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '******************************************
������������:
    �Ѿ���Ȯ�� = 0
    GOSUB SOUND_Walk_Ready
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_4
    ENDIF


    '**********************

������������_1:
    MOVE G6D,104,  77, 146,  91,  102
    MOVE G6A,95,  95, 120, 100, 104
    MOVE G6B,115
    MOVE G6C,85
    WAIT


������������_2:
    MOVE G6A,95,  90, 135, 90, 104
    MOVE G6D,104,  77, 146,  91,  100
    WAIT

������������_3:
    MOVE G6A, 103,  79, 146,  89, 100
    MOVE G6D,95,   65, 146, 103,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, ������������_4
    IF A <> A_old THEN  GOTO ������������_����

    '*********************************

������������_4:
    MOVE G6A,104,  77, 146,  91,  102
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6C,115
    MOVE G6B,85
    WAIT


������������_5:
    MOVE G6A,104,  77, 146,  91,  100
    MOVE G6D,95,  90, 135, 90, 104
    WAIT

������������_6:
    MOVE G6D, 103,  79, 146,  89, 100
    MOVE G6A,95,   65, 146, 103,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, ������������_1
    IF A <> A_old THEN  GOTO ������������_����


    GOTO ������������_1


������������_����:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB ����ȭ�ڼ�
    SPEED 10
    GOSUB �⺻�ڼ�

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '**********************************************

�����޸���30: '������ ª��
    �Ѿ���Ȯ�� = 0
    GOSUB SOUND_Walk_Ready
    SPEED 12
    HIGHSPEED SETON

    IF ������� = 0 THEN
        MOVE G6A,100,  80, 119, 118, 103
        MOVE G6D,102,  75, 149,  93,  100
        MOVE G6B, 80,  30,  80
        MOVE G6C,120,  30,  80

        ������� = 1
        GOTO �����޸���30_2
    ELSE
        MOVE G6D,100,  80, 119, 118, 103
        MOVE G6A,102,  75, 149,  93,  100
        MOVE G6C, 80,  30,  80
        MOVE G6B,120,  30,  80

        ������� = 0
        GOTO �����޸���30_4

    ENDIF



    '********************************************
�����޸���30_1:

    '�޹ߵ��10:
    MOVE G6A,100,  80, 119, 118, 103
    MOVE G6D,102,  75, 147,  93,  100
    MOVE G6B, 80,  30,  80
    MOVE G6C,120,  30,  80
    GOSUB SOUND_REPLAY

    ERX 4800, A, �����޸���30_2
    GOSUB �⺻�ڼ�
    HIGHSPEED SETOFF
    GOTO RX_EXIT

�����޸���30_2:

    '�޹��߽��̵�1:
    MOVE G6A,102,  74, 140, 106,  100
    MOVE G6D, 95, 105, 124,  93, 103
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

�����޸���30_3:
    '�����ߵ��10:
    MOVE G6D,100,  80, 119, 118, 103
    MOVE G6A,102,  75, 147,  93,  100
    MOVE G6C, 80,  30,  80
    MOVE G6B,120,  30,  80
    GOSUB SOUND_REPLAY



    ERX 4800, A, �����޸���30_4
    GOSUB �⺻�ڼ�
    HIGHSPEED SETOFF
    GOTO RX_EXIT

�����޸���30_4:
    '�������߽��̵�1:
    MOVE G6D,102,  74, 140, 106,  100
    MOVE G6A, 95, 105, 124,  93, 103
    MOVE G6C,100,  30,  80
    MOVE G6B,100,  30,  80

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    '************************************************


    GOTO �����޸���30_1


    GOTO RX_EXIT

    '*********************************************
    '******************************************
����޸���:
    �Ѿ���Ȯ�� = 0
    GOSUB SOUND_Walk_Ready
    SPEED 15
    GOSUB All_motor_mode3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  85, 101
        MOVE G6D,101,  77, 145,  85, 98
        WAIT

        GOTO ����޸���_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  85, 101
        MOVE G6A,101,  77, 145,  85, 98
        WAIT

        GOTO ����޸���_4
    ENDIF


    '**********************

����޸���_1:
    MOVE G6A,95,  95, 120, 95, 104
    MOVE G6D,104,  77, 145,  87,  102
    WAIT
    DELAY 5

����޸���_2:
    MOVE G6D,104,  79, 145,  82,  100
    MOVE G6A,95,  85, 130, 95, 104
    WAIT
    DELAY 5
����޸���_3:
    MOVE G6A,103,   85, 130, 95,  100
    MOVE G6D, 97,  79, 145,  82, 102
    WAIT
    DELAY 5
    GOSUB SOUND_REPLAY
    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, ����޸���_4
    IF A <> A_old THEN  GOTO ����޸���_����

    '*********************************

����޸���_4:
    MOVE G6D,95,  95, 120, 95, 104
    MOVE G6A,104,  77, 145,  87,  102
    WAIT


����޸���_5:
    MOVE G6D,95,  85, 130, 95, 104
    MOVE G6A,104,  79, 145,  82,  100
    WAIT

����޸���_6:
    MOVE G6D,103,   85, 130, 95,  100
    MOVE G6A, 97,  79, 145,  82, 102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, ����޸���_1
    IF A <> A_old THEN  GOTO ����޸���_����


    GOTO ����޸���_1


����޸���_����:
    HIGHSPEED SETOFF
    SPEED 15
    MOVE G6A,98,  76, 145,  85, 101, 100
    MOVE G6D,98,  76, 145,  85, 101, 100
    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '******************************************
������������:
    �Ѿ���Ȯ�� = 0
    GOSUB SOUND_Walk_Ready
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  85, 101
        MOVE G6D,101,  77, 145,  85, 98
        WAIT

        GOTO ������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  85, 101
        MOVE G6A,101,  77, 145,  85, 98
        WAIT

        GOTO ������������_4
    ENDIF


    '**********************

������������_1:
    MOVE G6D,104,  77, 146,  83,  102
    MOVE G6A,95,  95, 120, 92, 104
    WAIT


������������_2:
    MOVE G6A,95,  90, 135, 82, 104
    MOVE G6D,104,  77, 146,  83,  100
    WAIT

������������_3:
    MOVE G6A, 103,  79, 146,  81, 100
    MOVE G6D,95,   65, 146, 95,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, ������������_4
    IF A <> A_old THEN  GOTO ������������_����

    '*********************************

������������_4:
    MOVE G6D,95,  95, 120, 92, 104
    MOVE G6A,104,  77, 146,  83,  102
    WAIT


������������_5:
    MOVE G6A,104,  77, 146,  83,  100
    MOVE G6D,95,  90, 135, 82, 104
    WAIT

������������_6:
    MOVE G6D, 103,  79, 146,  81, 100
    MOVE G6A,95,   65, 146, 95,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, ������������_1
    IF A <> A_old THEN  GOTO ������������_����


    GOTO ������������_1


������������_����:
    HIGHSPEED SETOFF
    SPEED 15
    MOVE G6A,98,  76, 145,  85, 101, 100
    MOVE G6D,98,  76, 145,  85, 101, 100
    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    DELAY 400


    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '*********************************************	
�����ɾƺ���:
    GOSUB All_motor_mode3
    SPEED 9

�����ɾƺ���_1:

    MOVE G6A,114, 143,  28, 142,  96, 100
    MOVE G6D, 87, 135,  28, 155, 110, 100
    WAIT


    MOVE G6D,98, 126,  28, 160, 102, 100
    MOVE G6A,98, 160,  28, 125, 102, 100
    WAIT

    ERX 4800, A, �����ɾƺ���_2
    SPEED 6
    IF  ������������ = 0 THEN
        GOSUB �����ڼ�
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        �ڼ� = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT

�����ɾƺ���_2:
    MOVE G6D,113, 143,  28, 142,  96, 100
    MOVE G6A, 87, 135,  28, 155, 110, 100
    WAIT

    MOVE G6A,98, 126,  28, 160, 102, 100
    MOVE G6D,98, 160,  28, 125, 102, 100
    WAIT

    ERX 4800, A, �����ɾƺ���_1
    SPEED 6
    IF  ������������ = 0 THEN
        GOSUB �����ڼ�
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        �ڼ� = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT


    GOTO �����ɾƺ���_1
    '*****************************
�����ɾƺ���:
    GOSUB All_motor_mode3
    SPEED 8

�����ɾƺ���_1:

    MOVE G6D,113, 140,  28, 142,  96, 100
    MOVE G6A, 87, 140,  28, 140, 110, 100
    WAIT

    MOVE G6A,98, 155,  28, 125, 102, 100
    MOVE G6D,98, 121,  28, 160, 102, 100
    WAIT

    ERX 4800, A, �����ɾƺ���_2
    SPEED 6
    IF  ������������ = 0 THEN
        GOSUB �����ڼ�
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        �ڼ� = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT

�����ɾƺ���_2:
    MOVE G6A,113, 140,  28, 142,  96, 100
    MOVE G6D, 87, 140,  28, 140, 110, 100
    WAIT


    MOVE G6D,98, 155,  28, 125, 102, 100
    MOVE G6A,98, 121,  28, 160, 102, 100
    WAIT

    ERX 4800, A, �����ɾƺ���_1
    SPEED 6
    IF  ������������ = 0 THEN
        GOSUB �����ڼ�
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        �ڼ� = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT


    GOTO �����ɾƺ���_1
    '*****************************		

�ɾƿ����ʿ�����:
    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6A,110, 145,  28, 140, 100, 100
    MOVE G6D, 86, 145,  28, 140, 105, 100
    WAIT

    SPEED 5
    MOVE G6A, 90, 145,  28, 140, 110, 100
    MOVE G6D, 90, 145,  28, 140, 110, 100
    WAIT

    SPEED 6 	
    MOVE G6A, 80, 135,  45, 135, 105, 100
    MOVE G6D,108, 145,  28, 140, 100, 100
    WAIT

    SPEED 4 		
    MOVE G6A, 90, 145,  28, 140, 100, 100
    MOVE G6D,106, 145,  28, 140, 100, 100
    WAIT

    SPEED 3
    IF  ������������ = 0 THEN
        GOSUB �����ڼ�
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        �ڼ� = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT
    '*****************************	
�ɾƿ��ʿ�����:
    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6D,110, 145,  28, 140, 100, 100
    MOVE G6A, 86, 145,  28, 140, 105, 100
    WAIT

    SPEED 5
    MOVE G6D, 90, 145,  28, 140, 110, 100
    MOVE G6A, 90, 145,  28, 140, 110, 100
    WAIT

    SPEED 6 	
    MOVE G6D, 80, 135,  45, 135, 105, 100
    MOVE G6A,108, 145,  28, 140, 100, 100
    WAIT

    SPEED 4 		
    MOVE G6D, 90, 145,  28, 140, 100, 100
    MOVE G6A,106, 145,  28, 140, 100, 100
    WAIT

    SPEED 3
    IF  ������������ = 0 THEN
        GOSUB �����ڼ�
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        �ڼ� = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT
    '**********************************************
    '************************************************
�ȳ�������:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6B,188,  15,  80
    MOVE G6C,188,  15,  80
    WAIT


    GOSUB All_motor_Reset
    ������������ = 3
    RETURN
    '************************************************
    '************************************************
�ȳ�����:
    GOSUB All_motor_mode3
    SPEED 3
    MOVE G6A,100,  73, 145,  85, 100
    MOVE G6D,100,  73, 145,  85, 100
    MOVE G6B,165,  30,  80
    MOVE G6C,165,  30,  80
    WAIT


    DELAY 2000
    '**** ��°������� ************
    MOVE G6B,165,  15,  80
    MOVE G6C,165,  15,  80
    WAIT

    GOSUB All_motor_Reset
    ������������ = 2
    RETURN
    '************************************************
    '**********************************************

�ȳ�������������50:
    �Ѿ���Ȯ�� = 0
    ����ӵ� = 10
    �¿�ӵ� = 3
    �¿�ӵ�2 = 4

    GOSUB Leg_motor_mode3
    SPEED 3
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    IF ������� = 0 THEN
        ������� = 1

        SPEED 3
        '�����ʱ���
        MOVE G6A, 88,  68, 152,  83, 110
        MOVE G6D,108,  73, 146,  85,  94
        WAIT

        SPEED 10'����ӵ�
        '�޹ߵ��
        MOVE G6A, 90, 97, 115, 98, 114
        MOVE G6D,112,  75, 146,  85,  94
        WAIT


        GOTO �ȳ�������������50_1	
    ELSE
        ������� = 0

        SPEED 3
        '���ʱ���
        MOVE G6D,  88,  68, 152,  83, 110
        MOVE G6A, 108,  73, 146,  85,  94
        WAIT

        SPEED 10'����ӵ�
        '�����ߵ��
        MOVE G6D, 90, 97, 115, 98, 114
        MOVE G6A,112,  75, 146,  85,  94
        WAIT


        GOTO �ȳ�������������50_2	

    ENDIF


    '*******************************


�ȳ�������������50_1:

    SPEED ����ӵ�
    '�޹߻�������
    MOVE G6A, 90,  41, 163, 105, 114
    MOVE G6D,110,  74, 146,  85,  94
    WAIT

    SPEED �¿�ӵ�
    GOSUB Leg_motor_mode3
    '�޹��߽��̵�
    MOVE G6A,110,  73, 144, 92,  93
    MOVE G6D,90, 90, 155,  63, 112
    WAIT


    SPEED ����ӵ�
    GOSUB Leg_motor_mode2
    '�����ߵ��10
    MOVE G6A,111,  74, 146,  85, 94
    MOVE G6D,90, 97, 105, 102, 114
    WAIT
    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF
    ERX 4800,A, �ȳ�������������50_2
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        '���ʱ���2
        MOVE G6A, 106,  73, 146,  85,  96		
        MOVE G6D,  88,  68, 152,  82, 106
        WAIT	


        SPEED 3
        MOVE G6A,100,  73, 145,  85, 100, 100
        MOVE G6D,100,  73, 145,  85, 100, 100
        WAIT
        GOSUB Leg_motor_mode1
        ' GOSUB ���̷�OFF
        GOTO RX_EXIT
    ENDIF
    '**********


�ȳ�������������50_2:


    SPEED ����ӵ�
    '�����߻�������
    MOVE G6D,90,  41, 163, 105, 114
    MOVE G6A,110,  74, 146,  85,  94
    WAIT

    SPEED �¿�ӵ�
    GOSUB Leg_motor_mode3
    '�������߽��̵�
    MOVE G6D,110,  73, 144, 92,  93
    MOVE G6A, 90, 90, 155,  63, 112
    WAIT

    SPEED ����ӵ�
    GOSUB Leg_motor_mode2
    '�޹ߵ��10
    MOVE G6A, 90, 97, 105, 102, 114
    MOVE G6D,111,  74, 146,  85,  94
    WAIT
    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO MAIN
    ENDIF
    ERX 4800,A, �ȳ�������������50_1
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        '�����ʱ���2
        MOVE G6D, 106,  73, 146,  85,  96		
        MOVE G6A,  88,  68, 152,  82, 106
        WAIT

        SPEED 3
        MOVE G6A,100,  73, 145,  85, 100, 100
        MOVE G6D,100,  73, 145,  85, 100, 100
        WAIT
        GOSUB Leg_motor_mode1
        ' GOSUB ���̷�OFF
        GOTO RX_EXIT
    ENDIF


    GOTO �ȳ�������������50_1
    '************************************************
    '******************************************
���ڸ�����:
    �Ѿ���Ȯ�� = 0
    GOSUB Arm_motor_mode3
    'GOSUB Leg_motor_mode3
    MOTORMODE G6A,2,3,3,3,2
    MOTORMODE G6D,2,3,3,3,2

    MOVE G6B,,35
    MOVE G6C,,35
    WAIT

���ڸ�����_1:

    SPEED 4
    MOVE G6A,105,  76, 146,  93, 98, 100
    MOVE G6D,85,  73, 151,  90, 108, 100
    WAIT

    SPEED 12
    MOVE G6A,113,  76, 146,  93, 96, 100
    MOVE G6D,90,  100, 95,  120, 115, 100
    MOVE G6B,120
    MOVE G6C,80
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        RETURN
    ENDIF

    SPEED 10
    MOVE G6A,109,  76, 146,  93, 97, 100
    MOVE G6D,90,  76, 148,  92, 110, 100
    WAIT



    SPEED 4	
    MOVE G6A,98,  76, 146,  93, 100, 100
    MOVE G6D,98,  76, 146,  93, 100, 100	
    WAIT

    ERX 4800,A, ���ڸ�����_2
    IF A <> A_old THEN
        SPEED 5
        GOSUB �⺻�ڼ�
        GOSUB Leg_motor_mode1
        RETURN
    ENDIF

���ڸ�����_2:
    '***********************************
    SPEED 4
    MOVE G6D,105,  76, 146,  93, 98, 100
    MOVE G6A,85,  73, 151,  90, 108, 100
    WAIT	

    SPEED 12
    MOVE G6D,113,  76, 146,  93, 96, 100
    MOVE G6A,90,  100, 95,  120, 115, 100
    MOVE G6C,120
    MOVE G6B,80
    WAIT	



    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        RETURN
    ENDIF

    SPEED 10
    MOVE G6D,109,  76, 146,  93, 97, 100
    MOVE G6A,90,  76, 148,  92, 110, 100
    WAIT	

    SPEED 4		
    MOVE G6D,98,  76, 146,  93, 100, 100
    MOVE G6A,98,  76, 146,  93, 100, 100	
    WAIT	

    ERX 4800,A, ���ڸ�����_1
    IF A <> A_old THEN
        SPEED 5
        GOSUB �⺻�ڼ�
        GOSUB Leg_motor_mode1
        RETURN
    ENDIF

    GOTO ���ڸ�����_1


    RETURN
    '**********************************************	
    '**********************************************	
    '**********************************************	
    '************************************************
�����ʿ�����20:

    GOSUB SOUND_Walk_Move
    SPEED 12
    MOVE G6D, 93,  90, 120, 105, 104, 100
    MOVE G6A,103,  76, 145,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  77, 145, 93, 100, 100
    MOVE G6A,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 15
    MOVE G6D,98,  76, 145,  93, 100, 100
    MOVE G6A,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 8

    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    '**********************************************

���ʿ�����20:

    GOSUB SOUND_Walk_Move
    SPEED 12
    MOVE G6A, 93,  90, 120, 105, 104, 100
    MOVE G6D,103,  76, 145,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6A, 102,  77, 145, 93, 100, 100
    MOVE G6D,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 15
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6D,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 8

    GOSUB �⺻�ڼ�
    GOTO RX_EXIT

    '**********************************************

�����ʿ�����70:
    GOSUB SOUND_Walk_Move
    SPEED 10
    MOVE G6D, 90,  90, 120, 105, 110, 100
    MOVE G6A,100,  76, 146,  93, 107, 100
    MOVE G6B,100,  40
    MOVE G6C,100,  40
    WAIT

    SPEED 12
    MOVE G6D, 102,  76, 147, 93, 100, 100
    MOVE G6A,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 10
    MOVE G6D,98,  76, 146,  93, 100, 100
    MOVE G6A,98,  76, 146,  93, 100, 100
    WAIT

    SPEED 15
    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    '*************

���ʿ�����70:
    GOSUB SOUND_Walk_Move

    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100	
    MOVE G6D,100,  76, 146,  93, 107, 100	
    MOVE G6B,100,  40
    MOVE G6C,100,  40
    WAIT

    SPEED 12
    MOVE G6A, 102,  76, 147, 93, 100, 100
    MOVE G6D,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 10
    MOVE G6A,98,  76, 146,  93, 100, 100
    MOVE G6D,98,  76, 146,  93, 100, 100
    WAIT

    SPEED 15	
    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    '************************************************

��������ʿ�����20:


    SPEED 12
    MOVE G6D, 93,  90, 120, 97, 104, 100
    MOVE G6A,103,  76, 145,  85, 104, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  77, 145, 85, 100, 100
    MOVE G6A,90,  80, 140,  87, 107, 100
    WAIT

    SPEED 15
    MOVE G6D,98,  76, 145,  85, 100, 100
    MOVE G6A,98,  76, 145,  85, 100, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOTO RX_EXIT
    '**********************************************

������ʿ�����20:


    SPEED 12
    MOVE G6A, 93,  90, 120, 97, 104, 100
    MOVE G6D,103,  76, 145,  85, 104, 100
    WAIT

    SPEED 12
    MOVE G6A, 102,  77, 145, 85, 100, 100
    MOVE G6D,90,  80, 140,  87, 107, 100
    WAIT

    SPEED 15
    MOVE G6A,98,  76, 145,  85, 100, 100
    MOVE G6D,98,  76, 145,  85, 100, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT

    '**********************************************

��������ʿ�����70:
    GOSUB SOUND_Walk_Move
    SPEED 10
    MOVE G6D, 90,  90, 120, 92, 110, 100
    MOVE G6A,100,  76, 146,  85, 107, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  76, 147, 85, 100, 100
    MOVE G6A,83,  76, 140,  92, 115, 100
    WAIT

    SPEED 10
    MOVE G6D,98,  76, 146,  85, 100, 100
    MOVE G6A,98,  76, 146,  85, 100, 100
    WAIT

    SPEED 15
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOTO RX_EXIT
    '*************

������ʿ�����70:
    GOSUB SOUND_Walk_Move

    SPEED 10
    MOVE G6A, 90,  90, 120, 97, 110, 100	
    MOVE G6D,100,  76, 146,  85, 107, 100	
    WAIT

    SPEED 12
    MOVE G6A, 102,  76, 147, 85, 100, 100
    MOVE G6D,83,  76, 140,  92, 115, 100
    WAIT

    SPEED 10
    MOVE G6A,98,  76, 146,  85, 100, 100
    MOVE G6D,98,  76, 146,  85, 100, 100
    WAIT

    SPEED 15	
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOTO RX_EXIT
    '************************************************
õõ�����ʿ�����50:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    SPEED 3
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT


    SPEED 5
    MOVE G6D,110,  92, 124,  97,  93,  100
    MOVE G6A, 76,  72, 160,  82, 128,  100
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,
    WAIT

    SPEED 5
    MOVE G6A,94,  76, 145,  93, 106, 100
    MOVE G6D,94,  76, 145,  93, 106, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT	
    '***********************
    SPEED 5
    MOVE G6A,110,  92, 124,  97,  93,  100
    MOVE G6D, 76,  72, 160,  82, 120,  100
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,
    WAIT

    SPEED 6
    MOVE G6D, 85,  80, 140, 95, 110, 100
    MOVE G6A,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 4
    MOVE G6D, 88,  71, 152,  91, 110, '60
    MOVE G6A,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 2
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset	
    RETURN

    '**********************************************
    '************************************************
õõ�������ʿ�����50:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    SPEED 3
    MOVE G6D, 88,  71, 152,  91, 110, '60
    MOVE G6A,108,  76, 146,  93,  92, '60
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT

    SPEED 5
    MOVE G6D, 85,  80, 140, 95, 114, 100
    MOVE G6A,112,  76, 146,  93, 98, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT


    SPEED 5
    MOVE G6A,110,  92, 124,  97,  93,  100
    MOVE G6D, 76,  72, 160,  82, 128,  100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT

    SPEED 5
    MOVE G6D,94,  76, 145,  93, 106, 100
    MOVE G6A,94,  76, 145,  93, 106, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT	
    '***********************
    SPEED 5
    MOVE G6D,110,  92, 124,  97,  93,  100
    MOVE G6A, 76,  72, 160,  82, 120,  100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT

    SPEED 6
    MOVE G6A, 85,  80, 140, 95, 110, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT

    SPEED 2
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset	
    RETURN

    '**********************************************

    '**********************************************
������10:
    GOSUB SOUND_Walk_Move
    SPEED 5
    MOVE G6A,97,  86, 145,  83, 103, 100
    MOVE G6D,97,  66, 145,  103, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  86, 145,  83, 101, 100
    MOVE G6D,94,  66, 145,  103, 101, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB �⺻�ڼ�
    GOTO RX_EXIT
    '**********************************************
��������10:
    GOSUB SOUND_Walk_Move
    SPEED 5
    MOVE G6A,97,  66, 145,  103, 103, 100
    MOVE G6D,97,  86, 145,  83, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  66, 145,  103, 101, 100
    MOVE G6D,94,  86, 145,  83, 101, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    '**********************************************
    '**********************************************
������20:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB �⺻�ڼ�
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
��������20:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B,90
    MOVE G6C,110
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB �⺻�ڼ�
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
������45:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  106, 145,  63, 105, 100
    MOVE G6D,95,  46, 145,  123, 105, 100
    MOVE G6B,115
    MOVE G6C,85
    WAIT

    SPEED 10
    MOVE G6A,93,  106, 145,  63, 105, 100
    MOVE G6D,93,  46, 145,  123, 105, 100
    WAIT

    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '**********************************************
��������45:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  46, 145,  123, 105, 100
    MOVE G6D,95,  106, 145,  63, 105, 100
    MOVE G6C,115
    MOVE G6B,85
    WAIT

    SPEED 10
    MOVE G6A,93,  46, 145,  123, 105, 100
    MOVE G6D,93,  106, 145,  63, 105, 100
    WAIT

    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
������60:
    GOSUB SOUND_Walk_Move
    SPEED 15
    MOVE G6A,95,  116, 145,  53, 105, 100
    MOVE G6D,95,  36, 145,  133, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  116, 145,  53, 105, 100
    MOVE G6D,90,  36, 145,  133, 105, 100
    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�
    GOTO RX_EXIT

    '**********************************************
��������60:
    GOSUB SOUND_Walk_Move
    SPEED 15
    MOVE G6A,95,  36, 145,  133, 105, 100
    MOVE G6D,95,  116, 145,  53, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  36, 145,  133, 105, 100
    MOVE G6D,90,  116, 145,  53, 105, 100

    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�
    GOTO RX_EXIT

    '************************************************
    '**********************************************
���������10:
    GOSUB SOUND_Walk_Move
    SPEED 5
    MOVE G6A,97,  86, 145,  75, 103, 100
    MOVE G6D,97,  66, 145,  95, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  86, 145,  75, 101, 100
    MOVE G6D,94,  66, 145,  95, 101, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT
    '**********************************************
�����������10:
    GOSUB SOUND_Walk_Move
    SPEED 5
    MOVE G6A,97,  66, 145,  95, 103, 100
    MOVE G6D,97,  86, 145,  75, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  66, 145,  95, 101, 100
    MOVE G6D,94,  86, 145,  75, 101, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT
    '**********************************************
    '**********************************************
���������20:

    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  96, 145,  65, 105, 100
    MOVE G6D,95,  56, 145,  105, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  65, 105, 100
    MOVE G6D,93,  56, 145,  105, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
�����������20:

    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  56, 145,  105, 105, 100
    MOVE G6D,95,  96, 145,  65, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  105, 105, 100
    MOVE G6D,93,  96, 145,  65, 105, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
���������45:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  106, 145,  55, 105, 100
    MOVE G6D,95,  46, 145,  115, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,93,  106, 145,  55, 105, 100
    MOVE G6D,93,  46, 145,  115, 105, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '**********************************************
�����������45:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  46, 145,  115, 105, 100
    MOVE G6D,95,  106, 145,  55, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,93,  46, 145,  115, 105, 100
    MOVE G6D,93,  106, 145,  55, 105, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
���������60:
    GOSUB SOUND_Walk_Move
    SPEED 15
    MOVE G6A,95,  116, 145,  45, 105, 100
    MOVE G6D,95,  36, 145,  125, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  116, 145,  45, 105, 100
    MOVE G6D,90,  36, 145,  125, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT

    '**********************************************
�����������60:
    GOSUB SOUND_Walk_Move
    SPEED 15
    MOVE G6A,95,  36, 145,  125, 105, 100
    MOVE G6D,95,  116, 145,  45, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  36, 145,  125, 105, 100
    MOVE G6D,90,  116, 145,  45, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT

    '************************************************
    '*******��Ÿ��� ����****************************
    '************************************************

�λ�1:
    GOSUB SOUND_�ȳ��ϼ���̴Ϸκ��������ߵȸ�Ż�������Դϴ�
    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6A,100,  70, 125, 150, 100
    MOVE G6D,100,  70, 125, 150, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    DELAY 1000
    SPEED 6
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    '************************************************
�λ�2:
    GOSUB All_motor_mode3
    SPEED 4
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6B,110,  30,  80
    MOVE G6C,90,  30,  80
    WAIT

    SPEED 8
    MOVE G6D, 90, 95, 115, 105, 112
    MOVE G6A,113,  76, 146,  93,  94
    MOVE G6B,130,  30,  80
    MOVE G6C,75,  30,  80
    WAIT

    SPEED 8
    MOVE G6A,112,  86, 120, 120,  94
    MOVE G6D,90, 100, 155,  71, 112
    MOVE G6B,140,  30,  80
    MOVE G6C,70,  30,  80
    WAIT


    SPEED 10
    MOVE G6A,108,  85, 110, 140,  94
    MOVE G6D,85, 97, 145,  91, 112
    MOVE G6B,150,  20,  40
    MOVE G6C,60,  30,  80
    WAIT

    DELAY 1000
    '*******************
    GOSUB leg_motor_mode2
    SPEED 6
    MOVE G6D, 90, 95, 115, 105, 110
    MOVE G6A,114,  76, 146,  93,  96
    MOVE G6B,130,  30,  80
    MOVE G6C,75,  30,  80
    WAIT

    SPEED 8
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6B,110,  30,  80
    MOVE G6C,90,  30,  80
    WAIT

    SPEED 3
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    '************************************************


�λ�3:
    GOSUB All_motor_mode3

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  70,  80
    MOVE G6B,160,  35,  80
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    '�λ�
    SPEED 8
    MOVE G6A,100,  55, 145,  145, 100, 100
    MOVE G6D,100,  55, 145,  145, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    DELAY 1000
    '�Ͼ��
    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  70,  80
    MOVE G6B,160,  40,  80
    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�



    RETURN
    '************************************************


ȯȣ��:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode2
    SPEED 15
    MOVE G6A,100,  80, 145,  75, 100
    MOVE G6D,100,  80, 145,  75, 100
    MOVE G6B,100,  180,  120
    MOVE G6C,100,  180,  120
    WAIT	

    SPEED 10
    FOR i = 1 TO 2

        MOVE G6B,100,  145,  100
        MOVE G6C,100,  145,  100
        WAIT

        MOVE G6B,100,  180,  130
        MOVE G6C,100,  180,  130
        WAIT	
    NEXT i
    DELAY 200
    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
�¸��������1:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode2
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  180,  120
    MOVE G6C,100,  180,  120
    WAIT	

    SPEED 10
    FOR i = 1 TO 3

        MOVE G6B,100,  145,  100
        MOVE G6C,100,  145,  100
        WAIT

        MOVE G6B,100,  180,  130
        MOVE G6C,100,  180,  130
        WAIT	
    NEXT i
    DELAY 200
    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
�¸��������2:
    SPEED 10
    GOSUB �⺻�ڼ�
    GOSUB All_motor_mode3

    SPEED 8

    MOVE G6A, 100, 163,  75,  15, 100
    MOVE G6D, 100, 163,  75,  15, 100
    MOVE G6B,185, 100, 90
    MOVE G6C,185, 100, 90
    WAIT

    SPEED 2

    MOVE G6A, 100, 165,  70,  10, 100, 100
    MOVE G6D, 100, 165,  70,  10, 100, 100
    MOVE G6B,185, 100, 90
    MOVE G6C,185, 100, 90
    WAIT

    DELAY 400
    SPEED 15
    FOR I = 1 TO 5

        MOVE G6B,185, 20, 50
        MOVE G6C,185, 20, 50
        WAIT

        MOVE G6B,185, 70, 80
        MOVE G6C,185, 70, 80
        WAIT

    NEXT I

    MOVE G6B,100, 70, 80
    MOVE G6C,100, 70, 80
    WAIT

    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A, 100, 145,  70,  80, 100, 100
    MOVE G6D, 100, 145,  70,  80, 100, 100
    MOVE G6B,100, 40, 90
    MOVE G6C,100, 40, 90
    WAIT

    SPEED 8
    MOVE G6A,100, 121,  80, 110, 101, 100
    MOVE G6D,100, 121,  80, 110, 101, 100
    MOVE G6B,100,  40,  80, , ,
    MOVE G6C,100,  40,  80, , ,
    WAIT

    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
    ''************************************************
�¸��������3:
    GOSUB All_motor_mode3
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  180,  120
    WAIT	

    SPEED 10
    FOR i = 1 TO 4

        MOVE G6C,100,  145,  100
        WAIT

        MOVE G6C,100,  180,  130
        WAIT	
    NEXT i
    DELAY 200
    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset

    RETURN
    ''************************************************

�й�׼�1:
    GOSUB Leg_motor_mode3

    SPEED 10
    MOVE G6A,100, 140,  37, 140, 100, 100
    MOVE G6D,100, 140,  37, 140, 100, 100
    WAIT

    SPEED 3
    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    SPEED 8
    MOVE G6B,140
    MOVE G6C,140
    WAIT
    SPEED 4
    MOVE G6A,70, 163,  28, 160, 135
    MOVE G6D,70, 163,  28, 160, 135
    MOVE G6B,160,  15,  90
    MOVE G6C,185,  20,  85
    WAIT

    DELAY 400
    SPEED 10
    FOR i = 1 TO 8
        MOVE G6C,165,  20,  85
        WAIT
        MOVE G6C,188,  20,  85
        WAIT  	
    NEXT i
    DELAY 500

    GOSUB Leg_motor_mode3

    SPEED 10	
    MOVE G6A,  70, 165,  28, 162, 135
    MOVE G6D,  70, 165,  28, 162, 135
    MOVE G6B,  155, 15, 90
    MOVE G6C,  155, 15, 90
    WAIT

    SPEED 6	
    MOVE G6A,  70, 145,  28, 142, 130
    MOVE G6D,  70, 145,  28, 142, 130
    MOVE G6B,  155, 15, 90
    MOVE G6C,  155, 15, 90
    WAIT

    SPEED 10	
    MOVE G6A,  100, 145,  27, 142, 100
    MOVE G6D,  100, 145,  27, 142, 100
    MOVE G6B,  140, 15, 90
    MOVE G6C,  140, 15, 90
    WAIT

    SPEED 6
    MOVE G6A,  100, 138,  28, 155, 100
    MOVE G6D,  100, 138,  28, 155, 100
    MOVE G6B, 113,  30, 80
    MOVE G6C, 113,  30, 80
    WAIT

    GOSUB Leg_motor_mode2
    SPEED 8
    GOSUB �⺻�ڼ�

    RETURN

    ''************************************************
�й�׼�2:
    GOSUB Arm_motor_mode3
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  185,  170
    WAIT	

    SPEED 4
    FOR i = 1 TO 8
        MOVE G6C,100,  170,  185
        WAIT

        MOVE G6C,100,  185,  170
        WAIT	
    NEXT i
    DELAY 200
    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset

    RETURN
    ''************************************************
    ''************************************************
�Ⱦ��ֱ�:
    GOSUB All_motor_mode3

    SPEED 12
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 146,  93,  92
    MOVE G6B,100,  60,  80
    MOVE G6C,160,  50,  80
    WAIT

    SPEED 15
    MOVE G6A, 85,  76, 145, 94, 110
    MOVE G6D,108,  81, 135,  98, 98
    MOVE G6B,100,  60,  80
    MOVE G6C,160,  50,  80
    WAIT

    SPEED 6
    MOVE G6A, 90,  92, 115, 109, 125, 100
    MOVE G6D,103,  76, 141,  98,  82, 100
    MOVE G6B,160,  50,  80
    MOVE G6C,188,  50,  80
    WAIT	

    SPEED 5
    FOR i = 1 TO 6

        MOVE G6B,160,  50,  50
        MOVE G6C,188,  50,  50
        WAIT

        MOVE G6B,160,  55,  80
        MOVE G6C,188,  55,  80
        WAIT
    NEXT i


    SPEED 10
    MOVE G6A, 85,  76, 145, 94, 110
    MOVE G6D,108,  81, 135,  98, 98
    MOVE G6B,100,  40,  80
    MOVE G6C,160,  60,  80
    WAIT

    SPEED 10
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 146,  93,  92
    MOVE G6B,100,  40,  80
    MOVE G6C,140,  60,  90
    WAIT

    SPEED 6
    MOVE G6A, 95,  75, 146,  93, 105
    MOVE G6D,109,  76, 146,  93,  92
    WAIT

    SPEED 3
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN


    ''************************************************
������:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6B, 150,  35, 70,
    MOVE G6C, 150,  35, 70,
    MOVE G6A,100,  63, 135, 140, 100,
    MOVE G6D,100,  63, 135, 140, 100,
    WAIT

    FOR I = 1 TO 4
        SPEED 7
        MOVE G6B, 155,  40, 90,
        MOVE G6C, 155,  40, 90,
        WAIT

        SPEED 5
        MOVE G6A,100,  58, 135, 155, 100,
        MOVE G6D,100,  58, 135, 155, 100,
        WAIT

        SPEED 7
        MOVE G6B, 155,  20, 70,
        MOVE G6C, 155,  20, 70,
        WAIT

        SPEED 5
        MOVE G6A,100,  48, 160, 135, 100,
        MOVE G6D,100,  48, 160, 135, 100,
        WAIT
    NEXT I


    SPEED 6
    MOVE G6A,100,  65, 135, 140, 100,
    MOVE G6D,100,  65, 135, 140, 100,
    MOVE G6B, 155,  40, 80,
    MOVE G6C, 155,  40, 80,
    WAIT

    SPEED 6
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset 	
    RETURN
    '************************************************







    '************************************************
    '************************************************
����:

    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A,100, 155,  28, 140, 100, 100
    MOVE G6D,100, 155,  28, 140, 100, 100
    MOVE G6B,180,  40,  85
    MOVE G6C,180,  40,  85
    WAIT

    SPEED 5	
    MOVE G6A, 100, 155,  53, 160, 100, 100
    MOVE G6D, 100, 155,  53, 160, 100, 100
    MOVE G6B,190,  30, 80
    MOVE G6C,190,  30, 80
    WAIT	

    GOSUB All_motor_mode2

    DELAY 300

    SPEED 8
    PTP SETOFF
    PTP ALLOFF
    HIGHSPEED SETON

    GOSUB GOSUB_RX_EXIT

    'GOTO ���������_LOOP

����_LOOP:


    MOVE G6A, 100, 160,  55, 160, 100
    MOVE G6D, 100, 145,  75, 160, 100
    MOVE G6B, 175,  25,  70
    MOVE G6C, 190,  50,  40
    WAIT
    ERX 4800, A, ����_1
    IF A = 8 THEN GOTO ����_1
    IF A = 9 THEN GOTO �����������_LOOP
    IF A = 7 THEN GOTO ���������_LOOP

    GOTO �����Ͼ��

����_1:
    MOVE G6A, 100, 150,  70, 160, 100
    MOVE G6D, 100, 140, 120, 120, 100
    MOVE G6B, 160,  25,  70
    MOVE G6C, 190,  25,  70
    WAIT

    MOVE G6D, 100, 160,  55, 160, 100
    MOVE G6A, 100, 145,  75, 160, 100
    MOVE G6C, 175,  25,  70
    MOVE G6B, 190,  50,  40
    WAIT

    ERX 4800, A, ����_2
    IF A = 8 THEN GOTO ����_2
    IF A = 9 THEN GOTO �����������_LOOP
    IF A = 7 THEN GOTO ���������_LOOP

    GOTO �����Ͼ��

����_2:
    MOVE G6D, 100, 140,  80, 160, 100
    MOVE G6A, 100, 140, 120, 120, 100
    MOVE G6C, 160,  25,  70
    MOVE G6B, 190,  25,  70
    WAIT

    GOTO ����_LOOP


    '**********************************
���������:

    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A,100, 155,  28, 140, 100, 100
    MOVE G6D,100, 155,  28, 140, 100, 100
    MOVE G6B,180,  40,  85
    MOVE G6C,180,  40,  85
    WAIT

    SPEED 5	
    MOVE G6A, 100, 155,  53, 160, 100, 100
    MOVE G6D, 100, 155,  53, 160, 100, 100
    MOVE G6B,190,  30, 80
    MOVE G6C,190,  30, 80
    WAIT	

    GOSUB All_motor_mode2

    SPEED 10
    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6C,175,  20, 80
    MOVE G6B,175,  20, 80
    WAIT

    SPEED 8
    PTP SETOFF
    PTP ALLOFF
    HIGHSPEED SETON

���������_LOOP:

    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6B,175,  70, 20
    MOVE G6C,175,  10, 75
    WAIT	


    ERX 4800, A, ���������_1
    IF A = 8 THEN GOTO ����_LOOP
    IF A = 9 THEN GOTO �����������_LOOP
    IF A = 7 THEN GOTO ���������_1
    GOTO �����Ͼ��

���������_1:
    MOVE G6A, 100, 155,  110, 100, 110
    MOVE G6D, 100, 155,  110, 100, 110
    MOVE G6B,175,  80, 30
    MOVE G6C,175,  30, 95
    WAIT		


    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6B,175,  15, 75
    MOVE G6C,175,  60, 20
    WAIT		

    ERX 4800, A, ���������_2
    IF A = 8 THEN GOTO ����_LOOP
    IF A = 9 THEN GOTO �����������_LOOP
    IF A = 7 THEN GOTO ���������_2
    GOTO �����Ͼ��

���������_2:
    MOVE G6A, 100, 155,  110, 100, 110
    MOVE G6D, 100, 155,  110, 100, 110
    MOVE G6B,175,  10, 75
    MOVE G6C,175,  10, 75
    WAIT	

    GOTO ���������_LOOP



    '**********************************

    '**********************************
�����������:

    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A,100, 155,  28, 140, 100, 100
    MOVE G6D,100, 155,  28, 140, 100, 100
    MOVE G6B,180,  40,  85
    MOVE G6C,180,  40,  85
    WAIT

    SPEED 5	
    MOVE G6A, 100, 155,  53, 160, 100, 100
    MOVE G6D, 100, 155,  53, 160, 100, 100
    MOVE G6B,190,  30, 80
    MOVE G6C,190,  30, 80
    WAIT	

    GOSUB All_motor_mode2

    SPEED 10
    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6C,175,  20, 80
    MOVE G6B,175,  20, 80
    WAIT

    SPEED 8
    PTP SETOFF
    PTP ALLOFF
    HIGHSPEED SETON

�����������_LOOP:

    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6C,175,  70, 20
    MOVE G6B,175,  10, 75
    WAIT	


    ERX 4800, A, �����������_1
    IF A = 8 THEN GOTO ����_LOOP
    IF A = 9 THEN GOTO �����������_1
    IF A = 7 THEN GOTO ���������_LOOP
    GOTO �����Ͼ��

�����������_1:
    MOVE G6A, 100, 155,  110, 100, 110
    MOVE G6D, 100, 155,  110, 100, 110
    MOVE G6C,175,  80, 30
    MOVE G6B,175,  30, 95
    WAIT		


    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6C,175,  15, 75
    MOVE G6B,175,  60, 20
    WAIT		

    ERX 4800, A, �����������_2
    IF A = 8 THEN GOTO ����_LOOP
    IF A = 9 THEN GOTO �����������_2
    IF A = 7 THEN GOTO ���������_LOOP
    GOTO �����Ͼ��

�����������_2:
    MOVE G6A, 100, 155,  110, 100, 110
    MOVE G6D, 100, 155,  110, 100, 110
    MOVE G6C,175,  10, 75
    MOVE G6B,175,  10, 75
    WAIT	

    GOTO �����������_LOOP



    '**********************************

    GOTO RX_EXIT
    '**********************************	
�����Ͼ��:
    PTP SETON		
    PTP ALLON
    SPEED 15
    HIGHSPEED SETOFF

    SPEED 10
    MOVE G6A, 80, 155,  85, 150, 150, 100
    MOVE G6D, 80, 155,  85, 150, 150, 100
    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT

    MOVE G6A, 75, 162,  55, 162, 155, 100
    MOVE G6D, 75, 162,  59, 162, 155, 100
    MOVE G6B,188,  10, 100, 100, 100, 100
    MOVE G6C,188,  10, 100, 100, 100, 100
    WAIT

    SPEED 10
    MOVE G6A, 60, 162,  30, 162, 145, 100
    MOVE G6D, 60, 162,  30, 162, 145, 100
    MOVE G6B,170,  10, 100, 100, 100, 100
    MOVE G6C,170,  10, 100, 100, 100, 100
    WAIT
    GOSUB Leg_motor_mode3	
    MOVE G6A, 60, 150,  28, 155, 140, 100
    MOVE G6D, 60, 150,  28, 155, 140, 100
    MOVE G6B,150,  60,  90, 100, 100, 100
    MOVE G6C,150,  60,  90, 100, 100, 100
    WAIT

    MOVE G6A,100, 150,  28, 140, 100, 100
    MOVE G6D,100, 150,  28, 140, 100, 100
    MOVE G6B,130,  50,  85, 100, 100, 100
    MOVE G6C,130,  50,  85, 100, 100, 100
    WAIT
    DELAY 100

    MOVE G6A,100, 150,  33, 140, 100, 100
    MOVE G6D,100, 150,  33, 140, 100, 100
    WAIT
    SPEED 10

    GOSUB �⺻�ڼ�

    GOTO RX_EXIT

    '******************************************************
�����δ���:

    SPEED 15
    MOVE G6A,100, 155,  27, 140, 100, 100
    MOVE G6D,100, 155,  27, 140, 100, 100
    MOVE G6B,130,  30,  85
    MOVE G6C,130,  30,  85
    WAIT

    SPEED 10	
    MOVE G6A, 100, 165,  55, 165, 100, 100
    MOVE G6D, 100, 165,  55, 165, 100, 100
    MOVE G6B,185,  10, 100
    MOVE G6C,185,  10, 100
    WAIT

    SPEED 15
    MOVE G6A,100, 160, 110, 140, 100, 100
    MOVE G6D,100, 160, 110, 140, 100, 100
    MOVE G6B,140,  70,  20
    MOVE G6C,140,  70,  20
    WAIT

    SPEED 15
    MOVE G6A,100,  56, 110,  26, 100, 100
    MOVE G6D,100,  71, 177, 162, 100, 100
    MOVE G6B,170,  40,  70
    MOVE G6C,170,  40,  70
    WAIT

    SPEED 15
    MOVE G6A,100,  60, 110,  15, 100, 100
    MOVE G6D,100,  70, 120, 30, 100, 100
    MOVE G6B,170,  40,  70
    MOVE G6C,170,  40,  70
    WAIT

    SPEED 15
    MOVE G6A,100,  60, 110,  15, 100, 100
    MOVE G6D,100,  60, 110,  15, 100, 100
    MOVE G6B,190,  40,  70
    MOVE G6C,190,  40,  70
    WAIT
    DELAY 50

    SPEED 15
    MOVE G6A,100, 110, 70,  65, 100, 100
    MOVE G6D,100, 110, 70,  65, 100, 100
    MOVE G6B,190, 160, 115
    MOVE G6C,190, 160, 115
    WAIT

    SPEED 10
    MOVE G6A,100, 170,  70,  15, 100, 100
    MOVE G6D,100, 170,  70,  15, 100, 100
    MOVE G6B,190, 155, 120
    MOVE G6C,190, 155, 120
    WAIT

    SPEED 10
    MOVE G6A,100, 170,  30,  110, 100, 100
    MOVE G6D,100, 170,  30,  110, 100, 100
    MOVE G6B,190,  40,  60
    MOVE G6C,190,  40,  60
    WAIT

    SPEED 13
    GOSUB �����ڼ�

    SPEED 10
    GOSUB �⺻�ڼ�

    RETURN

    '**********************************************
    '**********************************************
�ڷδ���:

    SPEED 15
    MOVE G6A,100, 170,  71,  23, 100, 100
    MOVE G6D,100, 170,  71,  23, 100, 100
    MOVE G6B, 80,  50,  70
    MOVE G6C, 80,  50,  70
    WAIT	

    MOVE G6A,100, 133,  49,  23, 100, 100
    MOVE G6D,100, 133,  49,  23, 100, 100
    MOVE G6B, 45, 116,  15
    MOVE G6C, 45, 116,  15
    WAIT

    SPEED 15
    MOVE G6A,100, 133,  49,  23, 100, 100
    MOVE G6D,100,  70, 180, 160, 100, 100
    MOVE G6B, 45,  50,  70
    MOVE G6C, 45,  50,  70
    WAIT


    SPEED 15
    MOVE G6A,100, 133, 180, 160, 100, 100
    MOVE G6D,100,  133, 180, 160, 100, 100
    MOVE G6B, 10,  50,  70
    MOVE G6C, 10,  50,  70
    WAIT

    HIGHSPEED SETON

    MOVE G6A,100, 95, 180, 160, 100, 100
    MOVE G6D,100, 95, 180, 160, 100, 100
    MOVE G6B,160,  50,  70
    MOVE G6C,160,  50,  70
    WAIT

    HIGHSPEED SETOFF '

    MOVE G6A,90, 130, 120,  80, 110, 100
    MOVE G6D,90, 130, 120,  80, 110, 100
    MOVE G6B,150, 160,  10, 100, 100, 100
    MOVE G6C,150, 160,  10, 100, 100, 100
    WAIT

    MOVE G6B,170, 140,  10, 100, 100, 100
    MOVE G6C,170, 140,  10, 100, 100, 100
    WAIT

    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT
    SPEED 10
    MOVE G6A, 80, 155,  85, 150, 150, 100
    MOVE G6D, 80, 155,  85, 150, 150, 100
    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT



    MOVE G6A, 75, 162,  55, 162, 155, 100
    MOVE G6D, 75, 162,  59, 162, 155, 100
    MOVE G6B,188,  10, 100, 100, 100, 100
    MOVE G6C,188,  10, 100, 100, 100, 100
    WAIT

    SPEED 10
    MOVE G6A, 60, 162,  30, 162, 145, 100
    MOVE G6D, 60, 162,  30, 162, 145, 100
    MOVE G6B,170,  10, 100, 100, 100, 100
    MOVE G6C,170,  10, 100, 100, 100, 100
    WAIT
    GOSUB Leg_motor_mode3	
    MOVE G6A, 60, 150,  28, 155, 140, 100
    MOVE G6D, 60, 150,  28, 155, 140, 100
    MOVE G6B,150,  60,  90, 100, 100, 100
    MOVE G6C,150,  60,  90, 100, 100, 100
    WAIT

    MOVE G6A,100, 150,  28, 140, 100, 100
    MOVE G6D,100, 150,  28, 140, 100, 100
    MOVE G6B,130,  50,  85, 100, 100, 100
    MOVE G6C,130,  50,  85, 100, 100, 100
    WAIT
    DELAY 100

    MOVE G6A,100, 150,  33, 140, 100, 100
    MOVE G6D,100, 150,  33, 140, 100, 100
    WAIT
    SPEED 10
    GOSUB �⺻�ڼ�
    RETURN
    '************************************************
�����δ���:

    SPEED 10
    MOVE G6A,100, 155,  25, 140, 100,
    MOVE G6D,100, 155,  25, 140, 100,
    MOVE G6B,130,  50,  85
    MOVE G6C,130,  50,  85
    WAIT

    SPEED 3
    MOVE G6A, 100, 165,  50, 160, 100,
    MOVE G6D, 100, 165,  50, 160, 100,
    MOVE G6B,185,  10, 100
    MOVE G6C,185,  10, 100
    WAIT

    SPEED 10
    MOVE G6A,100, 130, 120,  80, 100,
    MOVE G6D,100, 130, 120,  80, 100,
    MOVE G6B,125, 160,  10
    MOVE G6C,125, 160,  10
    WAIT	

    SPEED 12
    GOSUB �⺻�ڼ�

    RETURN
    '**********************************************
    '******************************************
�ڷδ���:

    SPEED 10
    MOVE G6A,100, 165,  40, 100, 100,
    MOVE G6D,100, 165,  40, 100, 100,
    MOVE G6B,110,  70,  50
    MOVE G6C,110,  70,  50
    WAIT

    SPEED 10
    MOVE G6A,100, 165,  70, 15, 100,
    MOVE G6D,100, 165,  70, 15, 100,
    MOVE G6B,30,  20,  95
    MOVE G6C,30,  20,  95
    WAIT

    SPEED 15
    MOVE G6A,100, 126,  60, 50, 100,
    MOVE G6D,100, 126,  60, 50, 100,
    MOVE G6B,20,  30,  90
    MOVE G6C,20,  30,  90
    WAIT

    SPEED 10
    MOVE G6A,100, 10,  83, 140, 100,
    MOVE G6D,100, 10,  83, 140, 100,
    MOVE G6B,20,  130,  15
    MOVE G6C,20,  130,  15
    WAIT

    SPEED 10
    MOVE G6A,100, 10,  100, 115, 100,
    MOVE G6D,100, 10,  100, 115, 100,
    MOVE G6B,100,  130,  15
    MOVE G6C,100,  130,  15
    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�

    RETURN
    '******************************************


    '**********************************************
    '**********************************************
���ʴ���:
    GOSUB Leg_motor_mode1
    SPEED 15
    GOSUB �⺻�ڼ�


    SPEED 15
    MOVE G6D,100, 125,  62, 132, 100, 100
    MOVE G6A,100, 125,  62, 132, 100, 100
    MOVE G6B,105, 150, 140
    MOVE G6C,105, 150, 140
    WAIT

    SPEED 7
    MOVE G6D,83 , 108,  85, 125, 105, 100
    MOVE G6A,108, 125,  62, 132, 110, 100
    MOVE G6B,105, 155, 145
    MOVE G6C,105, 155, 145
    WAIT


    SPEED 10
    MOVE G6D,89,  125,  62, 130, 110, 100
    MOVE G6A,110, 125,  62, 130, 122, 100
    WAIT
    SPEED 8
    MOVE G6D, 89, 125,  62, 130, 150, 100
    MOVE G6A,106, 125,  62, 130, 150, 100
    MOVE G6B,105, 160, 190
    MOVE G6C,105, 168, 190
    WAIT

    SPEED 6
    MOVE G6D,120, 125,  62, 130, 170, 100
    MOVE G6A,104, 125,  62, 130, 170, 100
    WAIT

    SPEED 12
    MOVE G6D,120, 125,  62, 130, 183, 100
    MOVE G6A,110, 125,  62, 130, 185, 100
    WAIT

    DELAY 400

    SPEED 14
    MOVE G6D,120, 125,  62, 130, 168, 100
    MOVE G6A,120, 125  62, 130, 185, 100
    MOVE G6B,105, 120, 145
    MOVE G6C,105, 120, 145
    WAIT

    SPEED 12
    MOVE G6D,105, 125,  62, 130, 183, 100
    MOVE G6A, 86, 112,  73, 127, 100, 100
    MOVE G6B,105, 120, 135
    MOVE G6C,105, 120, 135
    WAIT

    SPEED 8
    MOVE G6D,107, 125,  62, 132, 113, 100
    MOVE G6A, 82, 110,  90, 120,  100, 100
    MOVE G6B,105, 50, 80
    MOVE G6C,105, 50, 80
    WAIT

    SPEED 6
    MOVE G6A,97, 125,  62, 132, 102, 100
    MOVE G6D,97, 125,  62, 132, 102, 100
    MOVE G6B,100, 50, 80
    MOVE G6C,100, 50, 80
    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�
    RETURN
    '**********************************************
    '**********************************************
�����ʴ���:
    GOSUB Leg_motor_mode1
    SPEED 15
    GOSUB �⺻�ڼ�


    SPEED 15
    MOVE G6A,100, 125,  62, 132, 100, 100
    MOVE G6D,100, 125,  62, 132, 100, 100
    MOVE G6B,105, 150, 140
    MOVE G6C,105, 150, 140
    WAIT

    SPEED 7
    MOVE G6A,83 , 108,  85, 125, 105, 100
    MOVE G6D,108, 125,  62, 132, 110, 100
    MOVE G6B,105, 155, 145
    MOVE G6C,105, 155, 145
    WAIT


    SPEED 10
    MOVE G6A,89,  125,  62, 130, 110, 100
    MOVE G6D,110, 125,  62, 130, 122, 100
    WAIT
    SPEED 8
    MOVE G6A, 89, 125,  62, 130, 150, 100
    MOVE G6D,106, 125,  62, 130, 150, 100
    MOVE G6B,105, 160, 190
    MOVE G6C,105, 168, 190
    WAIT

    SPEED 6
    MOVE G6A,120, 125,  62, 130, 170, 100
    MOVE G6D,104, 125,  62, 130, 170, 100
    WAIT

    SPEED 12
    MOVE G6A,120, 125,  62, 130, 183, 100
    MOVE G6D,110, 125,  62, 130, 185, 100
    WAIT

    DELAY 400

    SPEED 14
    MOVE G6A,120, 125,  60, 130, 168, 100
    MOVE G6D,120, 125  60, 130, 185, 100
    MOVE G6B,105, 120, 145
    MOVE G6C,105, 120, 145
    WAIT

    SPEED 12
    MOVE G6A,105, 125,  62, 130, 183, 100
    MOVE G6D, 86, 112,  73, 127, 100, 100
    MOVE G6B,105, 120, 135
    MOVE G6C,105, 120, 135
    WAIT

    SPEED 8
    MOVE G6A,107, 125,  62, 132, 113, 100
    MOVE G6D, 82, 110,  90, 120,  100, 100
    MOVE G6B,105, 50, 80
    MOVE G6C,105, 50, 80
    WAIT

    SPEED 6
    MOVE G6A,97, 125,  62, 132, 102, 100
    MOVE G6D,97, 125,  62, 132, 102, 100
    MOVE G6B,100, 50, 80
    MOVE G6C,100, 50, 80
    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�
    RETURN
    '**********************************************
    '**********************************************
�޹߷ξɰ��Ͼ��:

    GOSUB Leg_motor_mode2

    SPEED 8
    MOVE G6A,112,  77, 146,  93,  92' 60	
    MOVE G6D, 80,  71, 152,  91, 112', 60
    MOVE G6C,100,  100,  100, , , ,
    MOVE G6B,100,  100,  100, , , ,	
    WAIT


    SPEED 8
    MOVE G6A,113,  77, 146,  93,  92, 100	
    MOVE G6D,80,  150,  27, 143, 114, 100
    MOVE G6C,100,  100,  100, , , ,
    MOVE G6B,100,  100,  100, , , ,	
    WAIT

    DELAY 500


    SPEED 8
    MOVE G6A,113, 152,  27, 140, 92, 100
    MOVE G6D,85, 154,  27, 143, 114, 100,
    MOVE G6C,100,  100,  100
    MOVE G6B,100,  100,  100
    WAIT

    GOSUB Leg_motor_mode1
    DELAY 1000

    SPEED 3
    MOVE G6A,115, 152,  35, 140, 92, 100
    WAIT

    SPEED 8
    MOVE G6A,113,  77, 146,  93, 92, 100
    WAIT

    GOSUB Leg_motor_mode2
    DELAY 500

    MOVE G6A,112,  77, 146,  93,  92, 100		
    MOVE G6D, 80, 88, 125, 100, 115, 100
    MOVE G6B,100,  100,  100, , , ,
    MOVE G6C,100,  100,  100, , , ,
    WAIT


    SPEED 4
    GOSUB �⺻�ڼ�
    GOSUB Leg_motor_mode1

    RETURN
    '******************************************	
�����߷ξɰ��Ͼ��:

    GOSUB Leg_motor_mode2

    SPEED 8
    MOVE G6D,112,  77, 146,  93,  92, '60	
    MOVE G6A, 80,  71, 152,  91, 112,' 60
    MOVE G6C,100,  100,  100, , , ,
    MOVE G6B,100,  100,  100, , , ,	
    WAIT


    SPEED 8
    MOVE G6D,113,  77, 146,  93,  92, 100	
    MOVE G6A,80,  150,  27, 140, 114, 100
    MOVE G6C,100,  100,  100, , , ,
    MOVE G6B,100,  100,  100, , , ,	
    WAIT

    DELAY 500

    SPEED 8
    MOVE G6D,113, 152,  27, 140, 92, 100
    MOVE G6A,85, 154,  27, 140, 114, 100,
    MOVE G6C,100,  100,  100
    MOVE G6B,100,  100,  100
    WAIT

    GOSUB Leg_motor_mode1
    DELAY 1000

    SPEED 3
    MOVE G6D,115, 152,  35, 140, 92, 100
    WAIT

    SPEED 8
    MOVE G6D,113,  77, 146,  93, 92, 100
    WAIT

    GOSUB Leg_motor_mode2
    DELAY 500


    MOVE G6D,112,  77, 146,  93,  92, 100		
    MOVE G6A, 80, 88, 125, 100, 115, 100
    MOVE G6B,100,  100,  100, , , ,
    MOVE G6C,100,  100,  100, , , ,
    WAIT


    SPEED 4
    GOSUB �⺻�ڼ�
    GOSUB Leg_motor_mode1

    RETURN
    '**********************************************
    '********************************************	
������������:
    GOSUB �����δ���
    GOSUB Arm_motor_mode1
    GOSUB Leg_motor_mode3

    SPEED 10
    MOVE G6B, 115,  45,  70,  ,  ,  ,
    MOVE G6C,115,  45,  70,  ,  ,  ,
    WAIT

    MOVE G6A,100, 125,  65,  10, 100
    MOVE G6D,100, 125,  65,  10, 100
    MOVE G6B, 130,  45,  70,  ,  ,  ,
    MOVE G6C,130,  45,  70,  ,  ,  ,
    WAIT

    SPEED 6
    MOVE G6A,100,  89, 129,  57, 100,
    MOVE G6D, 100,  89, 129,  57, 100
    MOVE G6B, 180,  45,  70,  ,  ,  ,
    MOVE G6C, 180,  45,  70,  ,  ,  ,
    WAIT

    MOVE G6A,100,  64, 169,  60, 100,
    MOVE G6D, 100,  64, 169,  60, 100
    MOVE G6B, 190,  45,  70,  ,  ,  ,
    MOVE G6C, 190,  45,  70,  ,  ,  ,
    WAIT
    DELAY 500

    SPEED 12

    FOR i = 1 TO 4

        MOVE G6A,100, 141,  30, 120, 100
        MOVE G6D, 100,  64, 169,  60, 100
        WAIT

        MOVE G6D,100, 141,  30, 120, 100
        MOVE G6A, 100,  64, 169,  60, 100
        WAIT

    NEXT i

    MOVE G6A,100,  64, 169,  60, 100,
    MOVE G6D, 100,  64, 169,  60, 100
    MOVE G6B, 190,  45,  70,  ,  ,  ,
    MOVE G6C, 190,  45,  70,  ,  ,  ,
    WAIT

    DELAY 300

    SPEED 4
    FOR i = 1 TO 3


        MOVE G6A,70,  64, 169,  60, 130,
        MOVE G6D, 70,  64, 169,  60, 130
        WAIT

        MOVE G6A,100,  64, 169,  60, 100,
        MOVE G6D, 100,  64, 169,  60, 100
        WAIT
    NEXT i

    DELAY 300	
    SPEED 10
    MOVE G6A,100,  89, 129,  65, 100,
    MOVE G6D,100,  89, 129,  65, 100
    MOVE G6B, 180,  45,  70,  ,  ,  ,
    MOVE G6C, 180,  45,  70,  ,  ,  ,
    WAIT

    SPEED 10
    MOVE G6A,100, 125,  65,  10, 100,
    MOVE G6D, 100, 125,  65,  10, 100
    MOVE G6B, 160,  45,  70,  ,  ,  ,
    MOVE G6C, 160,  45,  70,  ,  ,  ,
    WAIT

    SPEED 10
    MOVE G6A,100, 125,  65,  10, 100,
    MOVE G6D, 100, 125,  65,  10, 100
    MOVE G6B, 110,  45,  70,  ,  ,  ,
    MOVE G6C, 110,  45,  70,  ,  ,  ,
    WAIT
    SPEED 10
    GOSUB �⺻�ڼ�

    GOSUB �ڷ��Ͼ��

    RETURN
    '**********************************************	
�����:

    DIM w1 AS BYTE
    GOSUB Leg_motor_mode2
    GOSUB Arm_motor_mode3

    SPEED 3
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    WAIT


    SPEED 5
    MOVE G6A, 80,  74, 146, 94, 116, 100
    MOVE G6D,108,  81, 137,  98, 98, 100
    MOVE G6B,100,  70,  90
    MOVE G6C,100,  70,  90	
    WAIT

    SPEED 5
    MOVE G6A,94,  76, 145,  93, 106, 100
    MOVE G6D,94,  76, 145,  93, 106, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT	



    SPEED 4
    MOVE G6A,94,  94, 145,  45, 106
    MOVE G6D,94,  94, 145,  45, 106
    WAIT	

    HIGHSPEED SETON


    FOR I= 1 TO 3
        SPEED 6
        FOR w1= 0 TO 2

            MOVE G6B,100,  150,  140,
            MOVE G6C,100,  100,  190,
            MOVE G6A, 95,  94, 145,  45, 107,
            MOVE G6D, 89,  94, 145,  45, 113,
            WAIT

            MOVE G6C,100,  150,  140,
            MOVE G6B,100,  100,  190,
            MOVE G6D, 95,  94, 145,  45, 107,
            MOVE G6A, 89,  94, 145,  45, 113,
            WAIT

        NEXT w1

        SPEED 12
        MOVE G6C,100,  100,  190,
        MOVE G6B,100,  75,  100,
        MOVE G6A, 95,  94, 145,  45, 107,
        MOVE G6D, 89,  94, 145,  45, 113,
        WAIT

        SPEED 12
        MOVE G6C,100,  150,  140,
        MOVE G6B,100,  100,  100,
        MOVE G6D, 95,  94, 145,  45, 107,
        MOVE G6A, 89,  94, 145,  45, 113,
        WAIT

        DELAY 200
        SPEED 6
        FOR w1= 0 TO 2


            MOVE G6B,100,  150,  140,
            MOVE G6C,100,  100,  190,
            MOVE G6A, 95,  94, 145,  45, 107,
            MOVE G6D, 89,  94, 145,  45, 113,
            WAIT

            MOVE G6C,100,  150,  140,
            MOVE G6B,100,  100,  190,
            MOVE G6D, 95,  94, 145,  45, 107,
            MOVE G6A, 89,  94, 145,  45, 113,
            WAIT

        NEXT w1

        SPEED 15
        MOVE G6B,100,  100,  190,
        MOVE G6C,100,  75,  100,
        MOVE G6D, 89,  94, 145,  45, 113,
        MOVE G6A, 95,  94, 145,  45, 107,
        WAIT

        SPEED 12
        MOVE G6B,100,  150,  140,
        MOVE G6C,100,  100,  100,
        MOVE G6D, 95,  94, 145,  45, 107,
        MOVE G6A, 89,  94, 145,  45, 113,
        WAIT

        DELAY 100
    NEXT I
    HIGHSPEED SETOFF

    GOSUB Arm_motor_mode3	
    GOSUB Leg_motor_mode1
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 98, 100
    MOVE G6D,100,  76, 145,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT
    SPEED 5
    DELAY 50
    GOSUB �⺻�ڼ�


    RETURN

    '************************************************

    '******************************************	


���:

    GOSUB All_motor_mode3

    SPEED 12
    MOVE G6A, 88,  71, 152,  91, 110, 100
    MOVE G6D,112,  76, 146,  93,  92, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT


    SPEED 10
    MOVE G6A, 90,  98, 105,  115, 115, 100
    MOVE G6D,114,  74, 145,  98,  93, 100
    MOVE G6B,100,  150,  150
    MOVE G6C,100,  150,  150
    WAIT

    SPEED 6
    MOVE G6A, 90, 121,  36, 105, 115,  100
    MOVE G6D,114,  60, 146, 138,  93,  100
    WAIT

    SPEED 6
    GOSUB Leg_motor_mode2
    MOVE G6A, 90,  98, 105,  64, 115,  100
    MOVE G6D,114,  42, 170, 160,  93,  100
    MOVE G6B,100, 160, 180
    MOVE G6C,100, 160, 180
    WAIT

    SPEED 10
    MOVE G6A, 90, 117,  41, 113, 115,  60
    MOVE G6D,114,  33, 176, 160,  93,  60
    MOVE G6B,100, 160, 180
    MOVE G6C,100, 160, 180
    WAIT


    FOR i = 0 TO 2
        SPEED 7
        MOVE G6A, 90, 117,  41, 113, 115,  100
        MOVE G6D,114,  33, 176, 160,  93,  100
        MOVE G6B,100, 180, 130, , ,  70
        MOVE G6C,100, 180, 130, , ,
        WAIT
        SPEED 15
        MOVE G6A, 90,  63, 165,  47, 115,  100
        MOVE G6D,114,  43, 176, 160,  93,  100
        MOVE G6B,100,  70,  50, , ,
        MOVE G6C,100,  70,  50, , ,
        WAIT
    NEXT i

    FOR i = 0 TO 3
        SPEED 6
        MOVE G6A, 90,  74, 176,  32, 115,  100
        MOVE G6D,114,  39, 176, 160,  93,  100
        MOVE G6B,170, 169, 117, , , 130
        MOVE G6C,170, 169, 117, , ,
        WAIT

        SPEED 15
        HIGHSPEED SETON
        MOVE G6A, 90,  36, 154,  32, 115,  100
        MOVE G6D,114,  39, 176, 160,  93,  100
        MOVE G6B,170,  40,  70, , ,
        MOVE G6C,170,  40,  70, , ,
        WAIT
        DELAY 100
        HIGHSPEED SETOFF
    NEXT i
    '****************

    SPEED 1
    HIGHSPEED SETON
    FOR i = 1 TO 15
        SPEED i
        MOVE G6B,170,  80,  80
        MOVE G6C,170,  80,  80
        WAIT

        MOVE G6B,170,  120,  120
        MOVE G6C,170,  120,  120
        WAIT
    NEXT i
    DELAY 100
    HIGHSPEED SETOFF
    DELAY 500
    '****************
    SPEED 6
    MOVE G6A, 90,  98, 105,  64, 115,  100
    MOVE G6D,114,  39, 170, 160,  93,  100
    MOVE G6B,100, 160, 180
    MOVE G6C,100, 160, 180
    WAIT


    MOVE G6A, 90, 121,  36, 105, 115,  100
    MOVE G6D,114,  60, 146, 138,  93,  100
    MOVE G6B,100,  150,  150
    MOVE G6C,100,  150,  150
    WAIT

    SPEED 4
    MOVE G6A, 85,  98, 105,  115, 115, 100
    MOVE G6D,115,  74, 145,  98,  93, 100
    WAIT

    SPEED 8
    MOVE G6A, 85,  71, 152,  91, 110, 100
    MOVE G6D,108,  76, 146,  93,  92, 100
    MOVE G6B,100,  70,  80
    MOVE G6C,100,  70,  80
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  35,  80
    MOVE G6C,100,  35,  80
    WAIT

    SPEED 2
    GOSUB �⺻�ڼ�	
    GOSUB All_motor_Reset
    RETURN
    '******************************************
    '******************************************
����:

    GOSUB All_motor_mode3

    SPEED 12
    MOVE G6D, 88,  71, 152,  91, 110, 100
    MOVE G6A,112,  76, 146,  93,  92, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT


    SPEED 10
    MOVE G6D, 90,  98, 105,  115, 115, 100
    MOVE G6A,114,  74, 145,  98,  93, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT

    SPEED 6
    MOVE G6D, 90, 121,  36, 105, 115,  100
    MOVE G6A,114,  60, 146, 138,  93,  100
    MOVE G6B,130,  100,  100
    MOVE G6C,130,  100,  100
    WAIT

    SPEED 6
    GOSUB Leg_motor_mode2
    MOVE G6D, 90,  98, 145,  54, 115,  100
    MOVE G6A,114,  45, 170, 160,  93,  100
    MOVE G6B,170, 100, 100
    MOVE G6C,170, 100, 100
    WAIT

    GOSUB Leg_motor_mode4
    '****************
    FOR I = 0 TO 3
        SPEED 6
        MOVE G6D, 90,  98, 145,  54, 115,  100
        MOVE G6A,114,  45, 170, 160,  93,  100
        MOVE G6B,170, 150, 140
        MOVE G6C,170, 50, 70
        WAIT

        SPEED 6
        MOVE G6D, 90,  98, 145,  54, 115,  100
        MOVE G6A,114,  45, 170, 160,  93,  100
        MOVE G6C,170, 150, 140
        MOVE G6B,170, 50, 70
        WAIT

    NEXT I
    DELAY 300

    SPEED 10
    MOVE G6D, 90,  98, 145,  54, 115,  100
    MOVE G6A,114,  45, 170, 160,  93,  100
    MOVE G6B,170, 100, 100
    MOVE G6C,170, 100, 100
    WAIT

    '****************
    SPEED 5
    MOVE G6D, 90,  98, 105,  64, 115,  100
    MOVE G6A,114,  45, 170, 160,  93,  100
    MOVE G6B,170, 100, 100
    MOVE G6C,170, 100, 100
    WAIT
    GOSUB Leg_motor_mode2

    SPEED 5
    MOVE G6D, 90, 121,  36, 105, 115,  100
    MOVE G6A,113,  64, 146, 138,  93,  100
    MOVE G6B,140,  100,  100
    MOVE G6C,140,  100,  100
    WAIT

    SPEED 4
    MOVE G6D, 85,  98, 105,  115, 115, 100
    MOVE G6A,113,  74, 145,  98,  93, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT

    SPEED 8
    MOVE G6D, 85,  71, 152,  91, 110, 100
    MOVE G6A,108,  76, 146,  93,  92, 100
    MOVE G6B,100,  70,  80
    MOVE G6C,100,  70,  80
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  35,  80
    MOVE G6C,100,  35,  80
    WAIT

    SPEED 2
    GOSUB �⺻�ڼ�	
    GOSUB All_motor_Reset
    RETURN
    '******************************************
    '************************************************
�յڱ�������:
    '  IF ���⼾���������� = 0 THEN
    '        RETURN
    '    ENDIF
    FOR i = 0 TO COUNT_MAX
        A = AD(�յڱ���AD��Ʈ)	'���� �յ�
        IF A > 250 OR A < 5 THEN RETURN
        IF A > MIN AND A < MAX THEN RETURN
        DELAY ����Ȯ�νð�
    NEXT i

    IF A < MIN THEN GOSUB �����
    IF A > MAX THEN GOSUB �����

    GOSUB GOSUB_RX_EXIT

    RETURN
    '**************************************************
�����:
    A = AD(�յڱ���AD��Ʈ)
    'IF A < MIN THEN GOSUB �������Ͼ��
    IF A < MIN THEN  GOSUB �ڷ��Ͼ��
    RETURN

�����:
    A = AD(�յڱ���AD��Ʈ)
    'IF A > MAX THEN GOSUB �ڷ��Ͼ��
    IF A > MAX THEN GOSUB �������Ͼ��
    RETURN
    '**************************************************
�¿��������:
    '  IF ���⼾���������� = 0 THEN
    '        RETURN
    '    ENDIF
    FOR i = 0 TO COUNT_MAX
        B = AD(�¿����AD��Ʈ)	'���� �¿�
        IF B > 250 OR B < 5 THEN RETURN
        IF B > MIN AND B < MAX THEN RETURN
        DELAY ����Ȯ�νð�
    NEXT i

    IF B < MIN OR B > MAX THEN
        SPEED 8
        MOVE G6B,140,  40,  80
        MOVE G6C,140,  40,  80
        WAIT
        GOSUB �⺻�ڼ�	
        RETURN

    ENDIF
    RETURN
    '**************************************************
    '**************************************************
�����߰�����:
    GOSUB Leg_motor_mode3
    SPEED 4

    MOVE G6A,110,  77, 145,  93,  92, 100	
    MOVE G6D, 85,  71, 152,  91, 114, 100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT

    SPEED 10
    MOVE G6A,113,  75, 145,  100,  95	
    MOVE G6D, 83,  85, 122,  105, 114
    WAIT

    GOSUB Leg_motor_mode2
    HIGHSPEED SETON

    SPEED 15
    MOVE G6A,113,  73, 145,  85,  95	
    MOVE G6D, 83,  20, 172,  155, 114
    MOVE G6C,50
    MOVE G6B,150
    WAIT


    DELAY 400
    HIGHSPEED SETOFF


    SPEED 10
    MOVE G6A,113,  72, 145,  97,  95
    MOVE G6D, 83,  58, 122,  130, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT	

    SPEED 8
    MOVE G6A,113,  77, 145,  95,  95	
    MOVE G6D, 80,  80, 142,  95, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT	

    SPEED 8
    MOVE G6A,110,  77, 145,  93,  93, 100	
    MOVE G6D, 80,  71, 152,  91, 114, 100
    WAIT


    SPEED 3
    GOSUB �⺻�ڼ�	
    GOSUB Leg_motor_mode1
    DELAY 400

    RETURN


    '******************************************
�޹߰�����:

    GOSUB Leg_motor_mode3
    SPEED 4

    MOVE G6D,110,  77, 145,  93,  92, 100	
    MOVE G6A, 85,  71, 152,  91, 114, 100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT

    SPEED 10
    MOVE G6D,113,  75, 145,  100,  95	
    MOVE G6A, 83,  85, 122,  105, 114
    WAIT

    GOSUB Leg_motor_mode2
    HIGHSPEED SETON

    SPEED 15
    MOVE G6D,113,  73, 145,  85,  95	
    MOVE G6A, 83,  20, 172,  155, 114
    MOVE G6B,50
    MOVE G6C,150
    WAIT


    DELAY 400
    HIGHSPEED SETOFF


    SPEED 10
    MOVE G6D,112,  72, 145,  97,  95
    MOVE G6A, 83,  58, 122,  130, 114
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,	
    WAIT	

    SPEED 8
    MOVE G6D,113,  77, 145,  95,  95	
    MOVE G6A, 80,  80, 142,  95, 114
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,
    WAIT	

    SPEED 8
    MOVE G6D,110,  77, 145,  93,  93, 100	
    MOVE G6A, 80,  71, 152,  91, 114, 100
    WAIT


    SPEED 3
    GOSUB �⺻�ڼ�	
    GOSUB Leg_motor_mode1
    DELAY 400

    RETURN

    '******************************************
    '**************************************
LED_ON_OFF2:

    OUT 52,1
    DELAY 150

    OUT 52,0
    DELAY 150
    RETURN
    '**************************************
LED_ON_OFF:

    OUT 52,1
    DELAY 150
    OUT 52,0
    DELAY 150

    OUT 52,1
    DELAY 150
    OUT 52,0
    DELAY 150
    RETURN
    '**************************************
    '**************************************
���۹��2:

    GOSUB All_motor_mode3

    GOSUB LED_ON_OFF2

    '�����ʱ���2:
    SPEED 3
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80, 100, 100, 100
    MOVE G6C,100,  40,  80, 100, 100, 100
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  90, 100, 100, 100
    MOVE G6C,100,  40,  90, 100, 100, 100
    WAIT


    SPEED 5
    MOVE G6A, 80,  74, 146, 94, 116, 100
    MOVE G6D,108,  81, 137,  98, 98, 100
    MOVE G6B,100,  70,  90, 100, 100, 100
    MOVE G6C,100,  70,  90, 100, 100, 100 	
    WAIT

    SPEED 4
    MOVE G6A,98,  76, 145,  93, 103, 100
    MOVE G6D,98,  76, 145,  93, 103, 100
    MOVE G6B,100,  100,  100, 100, 100, 100
    MOVE G6C,100,  100,  100, 100, 100, 100
    WAIT	


    GOSUB LED_ON_OFF2
    '**** �뷡�����ڼ�******
    SPEED 3
    MOVE G6A,98,  76, 145,  93, 103, 100
    MOVE G6D,98,  76, 145,  93, 103, 100
    WAIT

    '**********************************
    FOR i = 0 TO 3
        SPEED 4
        MOVE G6A,108,  92, 119,  106, 99
        MOVE G6D,86,  76, 145,  94, 107
        WAIT

        SPEED 4
        MOVE G6A,102,  78, 139,  98, 84
        MOVE G6D,92,  90, 115,  110, 122
        WAIT

        SPEED 4
        MOVE G6D,108,  92, 119,  106, 99
        MOVE G6A,86,  76, 145,  94, 107
        WAIT

        SPEED 4
        MOVE G6D,102,  78, 139,  98, 84
        MOVE G6A,92,  90, 115,  110, 122
        WAIT

    NEXT i

    SPEED 3
    MOVE G6A,108,  92, 119,  106, 99
    MOVE G6D,86,  76, 145,  94, 107
    MOVE G6B,, , , , ,80
    WAIT

    GOSUB Leg_motor_mode1
    SPEED 4
    MOVE G6A,98,  76, 145,  93, 98, 100
    MOVE G6D,98,  76, 145,  93, 98, 100
    MOVE G6B,100,  100,  100, 100, 100, 100
    MOVE G6C,100,  100,  100, 100, 100, 100
    WAIT



    SPEED 6
    GOSUB �⺻�ڼ�

    GOSUB All_motor_Reset


    RETURN
    '******************************************
�¿�ڵ���:

    GOSUB All_motor_Reset

    SPEED 8
    MOVE G6A,88,  76, 145,  93, 110
    MOVE G6D,88,  76, 145,  93, 110
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    WAIT

    DELAY 500
    HIGHSPEED SETON

    SPEED 8	
    MOVE G6B,100,  100,  120
    MOVE G6C,100,  50,  90
    WAIT

    SPEED 15
    MOVE G6B,100,  150,  180
    MOVE G6C,100,  60,  100
    WAIT
    DELAY 400

    HIGHSPEED SETOFF
    GOSUB Arm_motor_mode3
    SPEED 6
    MOVE G6B,100,  150,  150
    MOVE G6C,100,  150,  150
    WAIT

    HIGHSPEED SETON
    GOSUB Arm_motor_mode1
    SPEED 8
    MOVE G6C,100,  150,  100
    MOVE G6B,100,  100,  100
    WAIT
    DELAY 300

    SPEED 15
    MOVE G6C,100,  150,  150
    MOVE G6B,100,  50,  100
    WAIT
    DELAY 300
    HIGHSPEED SETOFF

    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode4

    FOR I = 2 TO 5
        TEMP = I * 3
        SPEED TEMP
        MOVE G6A,  99,  96, 111, 107,  82,
        MOVE G6D,  72,  89, 120, 103, 142,
        MOVE G6B, 170,  70,  50,  ,  ,
        MOVE G6C,  100, 140, 150,  ,  ,
        WAIT

        MOVE G6D,  99,  96, 111, 107,  82,
        MOVE G6A,  72,  89, 120, 103, 142,
        MOVE G6C, 170,  70,  50,  ,  ,
        MOVE G6B,  100, 140, 150,  ,  ,
        WAIT
    NEXT I

    HIGHSPEED SETON
    FOR I = 2 TO 4
        TEMP = I * 3
        SPEED TEMP
        MOVE G6A,  99,  96, 111, 107,  82,
        MOVE G6D,  72,  89, 120, 103, 142,
        MOVE G6B, 170,  70,  50,  ,  ,
        MOVE G6C,  100, 140, 150,  ,  ,
        WAIT

        MOVE G6D,  99,  96, 111, 107,  82,
        MOVE G6A,  72,  89, 120, 103, 142,
        MOVE G6C, 170,  70,  50,  ,  ,
        MOVE G6B,  100, 140, 150,  ,  ,
        WAIT
    NEXT I

    HIGHSPEED SETOFF

    DELAY 300
    GOSUB Leg_motor_mode1
    SPEED 15
    MOVE G6A,98,  76, 145,  93, 98, 100
    MOVE G6D,98,  76, 145,  93, 98, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    GOSUB �⺻�ڼ�


    RETURN
    '**********************************************
    '******************************************
�Ƹ�����:

    GOSUB All_motor_Reset

    HIGHSPEED SETON
    SPEED 8
    MOVE G6A,88,  76, 145,  93, 110
    MOVE G6D,88,  76, 145,  93, 110
    MOVE G6B,100,  100, 100
    MOVE G6C,100,  100,  100
    WAIT

    DELAY 300



    HIGHSPEED SETOFF

    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode4

    FOR I = 1 TO 8
        SPEED 10
        MOVE G6A,  99,  96, 111, 107,  82,
        MOVE G6D,  72,  89, 120, 103, 142,
        MOVE G6B,100,  170, 150
        MOVE G6C,100,  70,  70
        WAIT

        SPEED 10
        MOVE G6A,  87,  92, 115, 105,  112,
        MOVE G6D,  87,  92, 115, 105, 112,
        MOVE G6B,100,  80, 180
        MOVE G6C,100,  120,  20
        WAIT

        '***************************
        SPEED 10
        MOVE G6D,  99,  96, 111, 107,  82,
        MOVE G6A,  72,  89, 120, 103, 142,
        MOVE G6C,100,  170, 150
        MOVE G6B,100,  70,  70
        WAIT

        SPEED 10
        MOVE G6A,  87,  92, 115, 105,  112,
        MOVE G6D,  87,  92, 115, 105, 112,
        MOVE G6C,100,  80, 180
        MOVE G6B,100,  120,  20
        WAIT
    NEXT I

    SPEED 15
    MOVE G6A,  87,  92, 115, 105,  112,
    MOVE G6D,  87,  92, 115, 105, 112,
    MOVE G6C,100,  80, 90
    MOVE G6B,100,  80,  90
    WAIT

    DELAY 300
    GOSUB Leg_motor_mode1
    SPEED 15
    MOVE G6A,98,  76, 145,  93, 98, 100
    MOVE G6D,98,  76, 145,  93, 98, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    GOSUB �⺻�ڼ�


    RETURN
    '**********************************************
�������ϸ��Ͼ��:
    GOSUB All_motor_mode3

    SPEED 10
    MOVE G6A,100, 140,  37, 140, 100, 100
    MOVE G6D,100, 140,  37, 140, 100, 100
    WAIT

    SPEED 3
    GOSUB �����ڼ�

    HIGHSPEED SETON
    FOR i = 1 TO 2
        SPEED 6
        MOVE G6B,100,  150,  115
        MOVE G6C,100,  150,  115
        WAIT   	

        SPEED 8
        MOVE G6B,100,  40,  80
        MOVE G6C,100,  40,  80
        WAIT
    NEXT i
    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6B,100,  150,  115
    MOVE G6C,100,  150,  115
    WAIT

    SPEED 6
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    MOVE G6A,100, 133,  50, 132, 100, 100
    MOVE G6D,100, 133,  50, 132, 100, 100
    WAIT

    SPEED 10
    MOVE G6B,100,  150,  115
    MOVE G6C,100,  150,  115
    WAIT


    SPEED 6
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    MOVE G6A,100, 120,  80, 112, 100, 100
    MOVE G6D,100, 120,  80, 112, 100, 100
    WAIT

    SPEED 10
    MOVE G6B,100,  150,  115
    MOVE G6C,100,  150,  115
    WAIT

    SPEED 6
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    MOVE G6A,100, 88,  125, 100, 100, 100
    MOVE G6D,100, 88,  125, 100, 100, 100
    WAIT

    SPEED 10
    MOVE G6B,100,  150,  115
    MOVE G6C,100,  150,  115
    WAIT

    SPEED 6
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    MOVE G6A,100, 76,  145, 93, 100, 100
    MOVE G6D,100, 76,  145, 93, 100, 100
    WAIT

    FOR i = 1 TO 3
        SPEED 10
        MOVE G6B,100,  150,  115
        MOVE G6C,100,  150,  115
        WAIT

        SPEED 10
        MOVE G6B,100,  40,  80
        MOVE G6C,100,  40,  80
        WAIT
    NEXT i

    HIGHSPEED SETOFF
    SPEED 5
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset       	
    RETURN


    '**********************************************

���۴�:

    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80, 100, 100, 100
    MOVE G6C,160,  30,  80, 100, 100, 100
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,110,  76, 145,  93, 98, 100
    MOVE G6B,100,  40,  90, , , 55
    MOVE G6C,185,  15,  15	
    WAIT


    SPEED 4
    MOVE G6A, 80,  74, 145, 94, 116, 100
    MOVE G6D,108,  81, 135,  98, 98, 100
    MOVE G6B,100,  40,  90, , , 55
    MOVE G6C,185,  15,  15	
    WAIT

    SPEED 6
    MOVE G6A,98,  76, 145,  93, 103, 100
    MOVE G6D,98,  76, 145,  93, 103, 100
    MOVE G6B,100,  40,  90, , , 100
    MOVE G6C,185,  30,  10	
    WAIT	

    '**** �뷡�����ڼ�******
    SPEED 5
    MOVE G6A,98,  79, 145,  83, 103, 100
    MOVE G6D,98,  79, 145,  83, 103, 100
    MOVE G6B,100, 50, 90, , , 100
    MOVE G6C,185,  30,  10	
    WAIT
    '**** �뷡�����ڼ�******

    SPEED 4
    FOR I = 0 TO 1

        MOVE G6B,100,  80,  90, , , 80
        MOVE G6C,180,  30,  10	
        WAIT	

        MOVE G6B,100,  60,  90, , , 120
        MOVE G6C,185,  35,  10	
        WAIT	

    NEXT I


    SPEED 4
    MOVE G6A,95, 100, 145,  53, 105, 100
    MOVE G6D,95,  60, 145,  93, 105, 100
    MOVE G6B,100, 40, 90, , , 145
    WAIT

    SPEED 5
    FOR I = 0 TO 1

        MOVE G6B,100,  120,  120, , , 80
        MOVE G6C,180,  30,  10	
        WAIT	

        MOVE G6B,100,  80,  90, , , 120
        MOVE G6C,185,  35,  10	
        WAIT	

    NEXT I

    SPEED 4
    MOVE G6A,98,  79, 145,  83, 103, 100
    MOVE G6D,98,  79, 145,  83, 103, 100
    MOVE G6B,100, 40, 90, , ,100
    WAIT


    SPEED 4
    MOVE G6D,95, 100, 145,  53, 105, 100
    MOVE G6A,95,  60, 145,  93, 105, 100
    MOVE G6B,, , , , , 55
    WAIT


    SPEED 4
    FOR I = 0 TO 1

        MOVE G6B,120, 60, 90, , ,80
        WAIT
        MOVE G6B,80, 40, 90, , , 120
        WAIT

    NEXT I

    SPEED 4
    MOVE G6A,98,  79, 145,  83, 103, 100
    MOVE G6D,98,  79, 145,  83, 103, 100
    MOVE G6B,100, 50, 70, , , 100
    MOVE G6C,185,  40,  10	
    WAIT

    '******************************************

    '***�¿����ǽ���1*****
    SPEED 3
    MOVE G6A,108,  95, 119,  96, 99
    MOVE G6D,86,  82, 145,  83, 107
    MOVE G6B,80, 50, 80, , , 70
    MOVE G6C,185,  20,  10	
    WAIT

    SPEED 4
    MOVE G6A,112,  83, 139,  86, 84
    MOVE G6D,80,  80, 145,  83, 122
    MOVE G6B,100, 120, 110, , , 60
    MOVE G6C,175,  40,  10	
    WAIT


    SPEED 3
    MOVE G6D,108,  95, 119,  96, 99
    MOVE G6A,86,  82, 145,  83, 107
    MOVE G6B,100, 130, 120, , , 70
    MOVE G6C,185,  40,  10	
    WAIT

    SPEED 4
    MOVE G6D,112,  82, 139,  86, 84
    MOVE G6A,80,  79, 145,  83, 122
    MOVE G6B,120, 50, 70, , , 100
    MOVE G6C,185,  30,  10	
    WAIT


    '***�¿����ǽ���2-1*****
    SPEED 4
    MOVE G6A,108,  78, 119,  136, 99
    MOVE G6D,86,  65, 145,  123, 107
    MOVE G6B,120, 40, 80, , , 110
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6A,112,  83, 139,  86, 84
    MOVE G6D,80,  80, 145,  83, 122
    MOVE G6B,120, 20, 80, , , 120
    MOVE G6C,175,  40,  10	
    WAIT

    SPEED 4
    MOVE G6A,108,  78, 119,  136, 99
    MOVE G6D,86,  65, 145,  123, 107
    MOVE G6B,120, 40, 80, , , 90
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6A,112,  83, 139,  86, 84
    MOVE G6D,80,  80, 145,  83, 122
    MOVE G6B,120, 20, 80, , , 70
    MOVE G6C,190,  20,  10	
    WAIT

    '***�¿����ǽ���2*****
    SPEED 4
    MOVE G6A,108,  95, 119,  96, 99
    MOVE G6D,86,  82, 145,  83, 107
    MOVE G6B,100, 40, 90, , , 80
    MOVE G6C,185,  20,  10	
    WAIT

    SPEED 4
    MOVE G6A,112,  83, 139,  86, 84
    MOVE G6D,80,  80, 145,  83, 122
    MOVE G6B,100, 80, 95, , , 70
    MOVE G6C,175,  40,  10	
    WAIT

    SPEED 3
    MOVE G6D,108,  95, 119,  96, 99
    MOVE G6A,86,  82, 145,  83, 107
    MOVE G6B,70, 130, 120, , , 110
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6D,108,  86, 139,  76, 90
    MOVE G6A,85,  83, 145,  73, 122
    MOVE G6B,150, 40, 70, , , 120
    MOVE G6C,190,  30,  10	
    WAIT


    SPEED 5
    FOR I = 0 TO 2
        MOVE G6B,150, 40, 70, , , 110
        MOVE G6C,190,  20,  10	
        WAIT
        MOVE G6B,150, 40, 70, , , 90
        MOVE G6C,185,  30,  10	
        WAIT
    NEXT I

    '***�¿����ǽ���3*****
    SPEED 4
    MOVE G6A,108,  78, 119,  136, 99
    MOVE G6D,86,  65, 145,  123, 107
    MOVE G6B,120, 40, 80, , , 110
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6A,112,  83, 139,  86, 84
    MOVE G6D,80,  80, 145,  83, 122
    MOVE G6B,190, 20, 80, , , 120
    MOVE G6C,175,  40,  10	
    WAIT

    SPEED 4
    MOVE G6D,105,  102, 119,  76, 99
    MOVE G6A,87,  89, 145,  63, 107
    MOVE G6B,80, 150, 120, , , 50
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6D,100,  82, 139,  91, 84
    MOVE G6A,95,  104, 105,  102, 122
    MOVE G6B,150, 100, 90, , , 60
    MOVE G6C,185,  20,  10	
    WAIT

    SPEED 4
    FOR I = 0 TO 2
        MOVE G6B,150, 100, 90, , ,70
        MOVE G6C,190,  20,  10	
        WAIT
        MOVE G6B,190, 100, 90, , ,90
        MOVE G6C,185,  30,  10	
        WAIT
    NEXT I

    '************
    SPEED 3
    MOVE G6D,100,  72, 139,  101, 84
    MOVE G6A,95,  114, 105,  92, 122
    MOVE G6B,150, 100, 90, , , 120
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6A,100,  72, 139,  101, 84
    MOVE G6D,95,  114, 105,  92, 122
    MOVE G6B,150, 100, 90, , , 60
    MOVE G6C,185,  30,  10	
    WAIT
    '****************
    SPEED 3
    MOVE G6D,100,  72, 139,  101, 84
    MOVE G6A,95,  114, 105,  92, 122
    MOVE G6B,150, 70, 80, , , 90
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6A,100,  72, 139,  101, 84
    MOVE G6D,95,  114, 105,  92, 122
    MOVE G6B,120, 130, 120, , , 60
    MOVE G6C,185,  30,  10	
    WAIT
    '************
    SPEED 3
    MOVE G6A,98,  87, 145,  63, 103, 100
    MOVE G6D,98,  87, 145,  63, 103, 100
    MOVE G6B,60, 180, 110, , , 100
    MOVE G6C,190,  30,  10	
    WAIT
    GOSUB LED_ON_OFF2
    SPEED 5
    FOR I = 0 TO 3
        MOVE G6B,, , , , , 95
        MOVE G6C,190,  40,  10	
        WAIT
        MOVE G6B,, , , , , 105
        MOVE G6C,190,  30,  10	
        WAIT    	

    NEXT I	

    '*************************

    DELAY 1000

    SPEED 8
    MOVE G6A,98,  87, 145,  63, 103, 100
    MOVE G6D,98,  87, 145,  63, 103, 100
    MOVE G6B,120,  80,  80
    MOVE G6C,120,  80,  80
    WAIT

    GOSUB Leg_motor_mode1
    SPEED 7
    MOVE G6A,102,  76, 145,  93, 98, 100
    MOVE G6D,102,  76, 145,  93, 98, 100
    WAIT

    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset



    RETURN

    '************************************************

�ͻͼ۴�:

    GOSUB All_motor_mode3


    '**** �뷡�����ڼ��ΰ���******

    SPEED 12
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 146,  93,  92
    MOVE G6B,130,  60,  90
    MOVE G6C,160,  30,  80
    WAIT

    SPEED 12
    MOVE G6A, 85,  80, 140, 95, 114
    MOVE G6D,110,  76, 145,  93, 98
    MOVE G6B,150,  80,  90
    MOVE G6C,185,  15,  15	
    WAIT


    SPEED 12
    MOVE G6A, 80,  74, 145, 94, 116
    MOVE G6D,108,  81, 135,  98, 98
    MOVE G6B,180,  90, 90
    MOVE G6C,185,  15,  15	
    WAIT

    SPEED 6
    MOVE G6A,100,  96, 105,  113, 110
    MOVE G6D,85,  76, 145,  93, 105
    MOVE G6B,180,  90, 90
    MOVE G6C,185,  15,  15	
    WAIT	

    DELAY 300

    FOR i = 1 TO 2

        SPEED 4
        MOVE G6D,100,  96, 105,  113, 110
        MOVE G6A,85,  76, 145,  93, 105
        MOVE G6B,180,  90, 90
        MOVE G6C,185,  15,  15	
        WAIT	


        SPEED 4
        MOVE G6A,100,  96, 105,  113, 110
        MOVE G6D,85,  76, 145,  93, 105
        MOVE G6B,180,  90, 90
        MOVE G6C,185,  15,  15	
        WAIT

    NEXT i

    DELAY 300

    SPEED 8
    MOVE G6D,100,  96, 105,  113, 110
    MOVE G6A,85,  76, 145,  93, 105
    MOVE G6C,180,  90, 90
    MOVE G6B,185,  15,  15	
    WAIT	

    FOR i = 1 TO 2

        SPEED 4
        MOVE G6A,100,  96, 105,  113, 110
        MOVE G6D,85,  76, 145,  93, 105
        MOVE G6C,180,  90, 90
        MOVE G6B,185,  15,  15	
        WAIT

        SPEED 4
        MOVE G6D,100,  96, 105,  113, 110
        MOVE G6A,85,  76, 145,  93, 105
        MOVE G6C,180,  90, 90
        MOVE G6B,185,  15,  15	
        WAIT	

    NEXT i

    DELAY 300

    SPEED 10
    MOVE G6D,95,  80, 130,  110, 105
    MOVE G6A,95,  80, 130,  110, 105
    MOVE G6C,100,  70, 80
    MOVE G6B,100,  70,  80	
    WAIT		

    GOSUB Leg_motor_mode1
    SPEED 7
    MOVE G6A,102,  76, 145,  93, 98, 100
    MOVE G6D,102,  76, 145,  93, 98, 100
    WAIT

    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset

    RETURN
    '************************************************
�����׼�:
    GOSUB All_motor_mode3

    SPEED 10
    MOVE G6B,100,  40,  80
    MOVE G6C,180,  30,  80
    WAIT


    SPEED 15
    FOR i = 1 TO 3
        MOVE G6B,80,  40,  90
        MOVE G6C,185,  15,  80	
        WAIT

        MOVE G6B,80,  40,  90
        MOVE G6C,185,  15,  20	
        WAIT
    NEXT i

    SPEED 10
    MOVE G6B,80,  40,  90
    MOVE G6C,185,  25,  90	
    WAIT
    DELAY 400

    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset

    RETURN

    '************************************************

    '************************************************
    '************************************************
    '************************************************
    '************************************************

�ȵ��ۺ���:
    GOSUB Arm_motor_mode3
    SPEED 10
    MOVE G6C,100,  70,  100
    WAIT

    MOTOROFF G6C	'������ ���� Ǯ��
    SPEED 15

    TEMPO 230
    MUSIC "cde"	

    DELAY 1000

�ȵ��ۺ���_1:

    '������ ������ġ�� �б�
    S12 = MOTORIN(12)
    S13 = MOTORIN(13)
    S14 = MOTORIN(14)

    '������ ���Ͱ� �����ϱ�
    SERVO 6,S12
    SERVO 7,S13
    SERVO 8,S14

    ''ERX ������ �����ܵ������� ��ȯ
    ERX 4800,A,�ȵ��ۺ���_1
    IF A = 26 THEN
        TEMPO 230
        MUSIC "cdefgab"

        GOSUB MOTOR_ON
        SPEED 5
        GOSUB �⺻�ڼ�

        GOTO RX_EXIT
    ENDIF	


    GOTO �ȵ��ۺ���_1
    '******************************************
��Ʈ�������ϱ�:
    SPEED 10
    GOSUB �⺻�ڼ�
    GOSUB All_motor_mode3

    SPEED 8

    MOVE G6A, 100, 163,  75,  15, 100, 100
    MOVE G6D, 100, 163,  75,  15, 100, 100
    MOVE G6B,185, 120, 130, 100, 100, 100
    MOVE G6C,185, 120, 130, 100, 100, 100
    WAIT

    SPEED 2

    MOVE G6A, 100, 168,  70,  10, 100, 100
    MOVE G6D, 100, 168,  70,  10, 100, 100
    MOVE G6B,185, 120, 130
    MOVE G6C,185, 120, 130
    WAIT

    DELAY 1000
    SPEED 10
    FOR I = 1 TO 5

        MOVE G6B,185, 20, 50
        MOVE G6C,185, 20, 50
        WAIT

        MOVE G6B,185, 70, 80
        MOVE G6C,185, 70, 80
        WAIT

    NEXT I

    MOVE G6B,100, 70, 80
    MOVE G6C,100, 70, 80
    WAIT

    SPEED 10
    FOR I = 1 TO 5

        MOVE G6B,100, 90, 90
        MOVE G6C,100, 90, 90
        WAIT

        MOVE G6B,100, 40, 70
        MOVE G6C,100, 40, 70
        WAIT

    NEXT I

    DELAY 500
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A, 100, 145,  70,  80, 100, 100
    MOVE G6D, 100, 145,  70,  80, 100, 100
    MOVE G6B,100, 40, 90, 100, 100, 100
    MOVE G6C,100, 40, 90, 100, 100, 100
    WAIT

    SPEED 8
    MOVE G6A,100, 121,  80, 110, 101, 100
    MOVE G6D,100, 121,  80, 110, 101, 100
    MOVE G6B,100,  40,  80, , ,
    MOVE G6C,100,  40,  80, , ,
    WAIT

    SPEED 8
    GOSUB �⺻�ڼ�
    RETURN
    '******************************************
���Ӵ�1: '
    ������ = 0
    GOSUB SOUND_BGM10
    GOSUB ȯȣ��

    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN

    DELAY 500

    GOSUB �����߷ξɰ��Ͼ��

    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN

    DELAY 500

    GOSUB �޹߷ξɰ��Ͼ��

    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN

    DELAY 500

    GOSUB ���۹��2
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN

    DELAY 500

    GOSUB �����
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN

    DELAY 500

    GOSUB �λ�3
    GOSUB SOUND_STOP
    GOTO RX_EXIT


    '******************************************
���Ӵ�2: '80 sec
    ������ = 0
    GOSUB SOUND_BGM7
    GOSUB ��Ʈ�������ϱ�

    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB ������

    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB �ͻͼ۴�

    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN

    DELAY 500

    GOSUB �������ϸ��Ͼ��
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN

    DELAY 500

    GOSUB ���
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN

    DELAY 500

    GOSUB �¿�ڵ���
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB �λ�2
    GOSUB SOUND_STOP
    GOTO RX_EXIT
    '******************************************
���մ�1: ' sec
    ������ = 0
    GOSUB SOUND_���մ���

    GOSUB �λ�3	

    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN

    GOSUB �й�׼�2
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB ���۹��2
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB �����
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 500

    '*********************
    GOSUB ������
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB ����
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB �ͻͼ۴�
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB �����߷ξɰ��Ͼ��
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB �Ƹ�����
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB �������ϸ��Ͼ��
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB ��Ʈ�������ϱ�
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB ���
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB �¿�ڵ���
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 300


    GOSUB ������������
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB �λ�2


    GOTO RX_EXIT
    '******************************************
���մ�2:
    ������ = 0
    GOSUB SOUND_MUSIC42

    GOSUB ���۴�
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB �Ⱦ��ֱ�
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB ���۹��2
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB �й�׼�1
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB �Ƹ�����
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB ���
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB �ֻ�������
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    DELAY 500
    GOSUB �λ�3


    GOTO RX_EXIT
    '******************************************
���մ�3: '
    GOSUB SOUND_BGM5
    GOSUB ���۴�
    GOSUB SOUND_STOP

    GOTO RX_EXIT
    '******************************************
���������:
    GOSUB All_motor_mode3
    SPEED 8
    MOVE G6A,100,  76, 145,  90, 100, 100
    MOVE G6D,100,  76, 145,  90, 100, 100
    MOVE G6B,190,  30,  80
    MOVE G6C,190,  30,  80
    WAIT

    SPEED 8
    MOVE G6A,100, 143,  28, 135, 190, 100
    MOVE G6D,100, 143,  28, 135, 190, 100
    MOVE G6B,190,  30,  80
    MOVE G6C,190,  30,  80
    WAIT


    DELAY 1000
    SPEED 8
    MOVE G6A,100, 143,  28, 90, 190, 100
    MOVE G6D,100, 143,  28, 90, 190, 100
    MOVE G6B,180,  30,  80
    MOVE G6C,180,  30,  80
    WAIT

    SPEED 8
    MOVE G6B,170,  20,  40
    MOVE G6C,170,  20,  40
    WAIT
    DELAY 500


    SPEED 8
    MOVE G6A,100, 143,  28, 135, 190, 100
    MOVE G6D,100, 143,  28, 135, 190, 100
    MOVE G6B,190,  20,  40
    MOVE G6C,190,  20,  40
    WAIT

    SPEED 6
    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  90, 100, 100
    MOVE G6D,100,  76, 145,  90, 100, 100
    WAIT


    RETURN

    '************************************************
��������:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6A,100,  33, 188,  155, 100
    MOVE G6D,100,  33, 188,  155, 100
    MOVE G6B,185,  35,  80
    MOVE G6C,185,  35,  80
    WAIT

    '**** ��°������� ************
    MOVE G6B,185,  15,  60
    MOVE G6C,185,  15,  60
    WAIT

    SPEED 4
    MOVE G6A,100,  33, 170,  155, 100
    MOVE G6D,100,  33, 170,  155, 100
    WAIT

    SPEED 5
    MOVE G6A,100,  60, 150,  115, 100
    MOVE G6D,100,  60, 150,  115, 100
    WAIT

    SPEED 6
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOSUB All_motor_Reset
    ������������ = 1
    RETURN
    '************************************************
    '************************************************
���ǳ���:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6A,100,  35, 170,  155, 100
    MOVE G6D,100,  35, 170,  155, 100
    WAIT

    DELAY 300

    MOVE G6B,185,  40,  80
    MOVE G6C,185,  40,  80
    WAIT

    SPEED 5
    MOVE G6A,100,  65, 150,  105, 100
    MOVE G6D,100,  65, 150,  105, 100
    MOVE G6B,140,  40,  80
    MOVE G6C,140,  40,  80
    WAIT


    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB All_motor_Reset
    ������������ = 0
    RETURN
    '************************************************
    '******************************************
��������ġ:
    HIGHSPEED SETON
    SPEED 7
    MOVE G6A, 92, 100, 110, 100, 107
    MOVE G6D, 92, 100, 110, 100, 107
    MOVE G6B,185, 130,  15
    MOVE G6C,185, 130,  15
    WAIT

    SPEED 10
    MOVE G6B,185, 50,  15
    MOVE G6C,185, 50,  15
    WAIT

    SPEED 13
    FOR I = 0 TO 1
        MOVE G6B,185,  10, 80
        MOVE G6C,185, 80,  10
        WAIT
        DELAY 200
        MOVE G6B,185, 80,  10
        MOVE G6C,185,  10, 80
        WAIT
        DELAY 200

    NEXT I

    MOVE G6A, 92, 100, 113, 100, 107
    MOVE G6D, 92, 100, 113, 100, 107
    MOVE G6B,185, 130,  10
    MOVE G6C,185, 130,  10
    WAIT

    HIGHSPEED SETOFF
    SPEED 12
    MOVE G6A, 102, 100, 113, 100, 98
    MOVE G6D, 102, 100, 113, 100, 98
    MOVE G6B,100,  80,  60
    MOVE G6C,100,  80,  60
    WAIT

    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    ''**********************************************

    '******************************************
����ø������:
    HIGHSPEED SETON
    SPEED 7
    MOVE G6A,98,  70, 146,  103, 100
    MOVE G6D,98,  70, 146,  103, 100
    MOVE G6B,133, 30,  80
    MOVE G6C,133, 30,  80
    WAIT

    SPEED 10
    MOVE G6B,133, 15,  70
    MOVE G6C,133, 15,  70
    WAIT

    SPEED 13
    MOVE G6A,98,  77, 146,  73, 100
    MOVE G6D,98,  77, 146,  73, 100
    MOVE G6B,185, 15,  70
    MOVE G6C,185, 15,  70
    WAIT

    HIGHSPEED SETOFF
    DELAY 1000

    SPEED 12
    MOVE G6A,98,  70, 146,  103, 100
    MOVE G6D,98,  70, 146,  103, 100
    MOVE G6B,133, 30,  80
    MOVE G6C,133, 30,  80
    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    ''**********************************************
    '******************************************
�޸�ø������:
    HIGHSPEED SETON
    SPEED 7
    MOVE G6A,98,  79, 146,  83, 100
    MOVE G6D,98,  79, 146,  83, 100
    MOVE G6B,80, 30,  80
    MOVE G6C,80, 30,  80
    WAIT

    SPEED 10
    MOVE G6B,80, 20,  70
    MOVE G6C,80, 20,  70
    WAIT

    SPEED 13
    MOVE G6A,98,  68, 146,  118, 100
    MOVE G6D,98,  68, 146,  118, 100
    MOVE G6B,15, 10,  70
    MOVE G6C,15, 10,  70
    WAIT

    HIGHSPEED SETOFF
    DELAY 1000

    SPEED 12
    MOVE G6A,98,  68, 146,  103, 100
    MOVE G6D,98,  68, 146,  103, 100
    MOVE G6B,80, 30,  80
    MOVE G6C,80, 30,  80
    WAIT

    SPEED 8
    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    ''**********************************************
�޼��������:
    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,185,  80,  20
    MOVE G6C,50,  40,  80
    WAIT

    SPEED 10
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,185,  80,  20
    MOVE G6C,50,  40,  80
    WAIT
    GOSUB All_motor_Reset
    SPEED 12
    HIGHSPEED SETON

    MOVE G6A,95,  84, 105, 126,  105,
    MOVE G6D, 86, 110, 136,  69, 114,
    MOVE G6B, 189,  30,  80
    MOVE G6C,  50,  40,  80
    WAIT

    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 12
    MOVE G6A,93,  80, 130, 110,  105,
    MOVE G6D, 93, 80, 130,  110, 105,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT

    SPEED 6
    MOVE G6A,101,  80, 130, 110,  98,
    MOVE G6D, 101, 80, 130,  110, 98,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�
    GOTO RX_EXIT
    ''**********************************************
�������������:
    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A,108,  76, 146,  93,  92
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6B,50,  40,  80
    MOVE G6C,185,  80,  20
    WAIT

    SPEED 10
    MOVE G6A,112,  76, 146,  93, 98
    MOVE G6D, 85,  80, 140, 95, 114
    MOVE G6B,50,  40,  80
    MOVE G6C,185,  80,  20
    WAIT
    GOSUB All_motor_Reset
    SPEED 12
    HIGHSPEED SETON

    MOVE G6A, 86, 110, 136,  69, 114,
    MOVE G6D,95,  84, 105, 126,  105,
    MOVE G6B,  50,  40,  80
    MOVE G6C, 189,  30,  80
    WAIT

    DELAY 1000
    HIGHSPEED SETOFF
    SPEED 12
    MOVE G6A, 93, 80, 130,  110, 105,
    MOVE G6D,93,  80, 130, 110,  105,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT

    SPEED 6
    MOVE G6A, 101, 80, 130,  110, 98,
    MOVE G6D,101,  80, 130, 110,  98,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT
    SPEED 10
    GOSUB �⺻�ڼ�
    GOTO RX_EXIT
    ''**********************************************
���ʿ�����:
    HIGHSPEED SETON
    GOSUB Leg_motor_mode3
    SPEED 8
    MOVE G6D,108,  76, 146,  93,  92
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6C,100,  60,  90, , ,
    MOVE G6B,100,  170,  15, , ,
    WAIT

    GOSUB All_motor_Reset

    SPEED 8
    MOVE G6D,110,  76, 146,  93,  92
    MOVE G6A, 88,  85, 130,  100, 110
    MOVE G6C,100,  60,  90, , ,
    MOVE G6B,100,  170,  45, , ,
    WAIT

    SPEED 13
    MOVE G6D, 63, 76,  160, 85, 130	
    MOVE G6A, 88, 125,  70, 120, 115
    MOVE G6C,100,  70,  100
    MOVE G6B,100, 125, 108
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF
    SPEED 15

    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�
    GOTO RX_EXIT
    ''**********************************************
�����ʿ�����:
    HIGHSPEED SETON
    GOSUB Leg_motor_mode3
    SPEED 8
    MOVE G6A,108,  76, 146,  93,  92
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6B,100,  60,  90, , ,
    MOVE G6C,100,  170,  15, , ,
    WAIT

    GOSUB All_motor_Reset

    SPEED 8
    MOVE G6A,110,  76, 146,  93,  92
    MOVE G6D, 88,  85, 130,  100, 110
    MOVE G6B,100,  60,  90, , ,
    MOVE G6C,100,  170,  45, , ,
    WAIT

    SPEED 13
    MOVE G6A, 63, 76,  160, 85, 130	
    MOVE G6D, 88, 125,  70, 120, 115
    MOVE G6B,100,  70,  100
    MOVE G6C,100, 125, 108
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF
    SPEED 15

    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�
    GOTO RX_EXIT
    ''**********************************************
    '**********************************************
���ʿ��ڰ���:

    HIGHSPEED SETON
    SPEED 12
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6B,15,  40,  80
    MOVE G6C,115,  40,  80
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 15
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT

    SPEED 12
    GOSUB �⺻�ڼ�

    GOTO RX_EXIT

    '**********************************************
�����ʿ��ڰ���:


    HIGHSPEED SETON
    SPEED 12
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B,115,  40,  80
    MOVE G6C,15,  40,  80
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 15
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    WAIT

    SPEED 12
    GOSUB �⺻�ڼ�
    GOTO RX_EXIT


    '************************************************
    '************************************************
����:
    GOSUB SOUND_����
    GOSUB Leg_motor_mode2
    SPEED 12
    MOVE G6A,100,  96, 145,  73, 100, 100
    MOVE G6D,100,  56, 145,  113, 100, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    DELAY 1000

    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB All_motor_Reset
    RETURN

    '************************************************
����:
    GOSUB SOUND_����
    GOSUB Leg_motor_mode2
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  60,  50
    MOVE G6C,100,  60,  50
    WAIT

    DELAY 1000

    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB All_motor_Reset

    RETURN

    '************************************************
��:
    GOSUB SOUND_��
    GOSUB Leg_motor_mode2
    SPEED 12
    MOVE G6A,91,  76, 145,  93, 108
    MOVE G6D,91,  76, 145,  93, 108
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    WAIT

    DELAY 1000

    SPEED 5
    MOVE G6A,101,  76, 145,  93, 98
    MOVE G6D,101,  76, 145,  93, 98
    WAIT

    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB All_motor_Reset
    RETURN


    '************************************************
����������:
    B = RND
    B = B MOD 3

    IF B = 0 THEN
        GOSUB ������_����
    ELSEIF B = 1 THEN
        GOSUB ������_������
    ELSEIF B = 2 THEN
        GOSUB ������_����
    ENDIF
    RETURN
    '***************************************
������_����:
    HIGHSPEED SETON
    SPEED 10
    MOVE G6B, , , , , , 150
    WAIT
    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 15
    GOSUB �⺻�ڼ�
    RETURN
    '***************************************
������_������:
    HIGHSPEED SETON
    SPEED 10
    MOVE G6B, , , , , , 50
    WAIT
    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 15 	
    GOSUB �⺻�ڼ�
    RETURN
    '***************************************
������_����:
    HIGHSPEED SETON
    SPEED 10
    MOVE G6B, , , , , , 110
    WAIT
    MOVE G6B, , , , , , 90
    WAIT	
    MOVE G6B, , , , , , 100
    WAIT	
    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 15 	
    GOSUB �⺻�ڼ�
    RETURN
    '***************************************

û�����ڼ�:
    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6A,100,  76, 145,  88, 100
    MOVE G6D,100,  76, 145,  88, 100
    MOVE G6B,135,  35,  80
    MOVE G6C,135,  35,  80
    WAIT

    RETURN
    '************************************************

û��޼տ÷�:
    GOSUB SOUND_û��÷�
    SPEED 15
    MOVE G6B,165
    WAIT
    MOVE G6B,135
    WAIT
    RETURN
    '************************************************
û��޼ճ���:
    GOSUB SOUND_û�⳻��
    SPEED 15
    MOVE G6B,105
    WAIT
    MOVE G6B,135
    WAIT
    RETURN
    '************************************************
�������տ÷�:
    GOSUB SOUND_���÷�
    SPEED 15
    MOVE G6C,165
    WAIT
    MOVE G6C,135
    WAIT
    RETURN
    '************************************************
�������ճ���:
    GOSUB SOUND_��⳻��
    SPEED 15
    MOVE G6C,105
    WAIT
    MOVE G6C,135
    WAIT

    RETURN
    '************************************************
�ֻ�������:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6A,100,  30, 188,  155, 100
    MOVE G6D,100,  30, 188,  155, 100
    MOVE G6B,185,  30,  80
    MOVE G6C,185,  30,  80
    WAIT

    MOVE G6B,185,  15,  65
    MOVE G6C,185,  15,  65
    WAIT

    SPEED 4
    MOVE G6A,100,  30, 170,  155, 100
    MOVE G6D,100,  30, 170,  155, 100
    WAIT

    SPEED 5
    MOVE G6A,100,  60, 150,  115, 100
    MOVE G6D,100,  60, 150,  115, 100
    WAIT

    SPEED 6
    MOVE G6A,100,  74, 145,  85, 100
    MOVE G6D,100,  74, 145,  85, 100
    WAIT


    TEMP = RND
    TEMP = TEMP MOD 3

    IF TEMP = 0 THEN

        SPEED 4
        MOVE G6B,135,  13,  50
        MOVE G6C,188,  13,  50
        WAIT

        SPEED 15
        MOVE G6C,188,  60,  50
        MOVE G6B,165,  13,  50
        WAIT

    ELSEIF TEMP = 1 THEN

        SPEED 4
        MOVE G6C,135,  13,  50
        MOVE G6B,188,  13,  50
        WAIT

        SPEED 15
        MOVE G6B,188,  60,  50
        MOVE G6C,165,  13,  50
        WAIT

    ELSE

        SPEED 15
        MOVE G6B,188,  50,  65
        MOVE G6C,188,  50,  65
        WAIT

    ENDIF


    DELAY 1000

    SPEED 10
    MOVE G6B,140,  70,  80
    MOVE G6C,140,  70,  80
    WAIT


    SPEED 4
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB All_motor_Reset
    RETURN
    '************************************************
    '************************************************
�Ŵ��������:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6A,100,  30, 188,  155, 100
    MOVE G6D,100,  30, 188,  155, 100
    MOVE G6B,185,  30,  80
    MOVE G6C,185,  30,  80
    WAIT

    MOVE G6B,185,  15,  60
    MOVE G6C,185,  15,  60
    WAIT

    SPEED 4
    MOVE G6A,100,  30, 170,  155, 100
    MOVE G6D,100,  30, 170,  155, 100
    WAIT

    SPEED 5
    MOVE G6A,100,  60, 150,  115, 100
    MOVE G6D,100,  60, 150,  115, 100
    WAIT

    SPEED 6
    MOVE G6A,100,  74, 145,  85, 100
    MOVE G6D,100,  74, 145,  85, 100
    WAIT

    DELAY 500

    SPEED 10
    MOVE G6B,188,  50,  65
    MOVE G6C,188,  50,  65
    WAIT

    DELAY 1000

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT

    GOSUB All_motor_Reset
    RETURN
    '************************************************

    '************************************************
    '********************************************
    '********************************************

�º��������:
    SPEED 10

    '*************
    MOVE G6A,90,  78, 155,  103, 100, 100
    MOVE G6D,90,  66, 140,  83, 100, 100
    WAIT

    DELAY 20	
    SPEED 15
    MOVE G6A,100,  76, 146,  93, 100, 100
    MOVE G6D,100,  76, 146,  93, 100, 100
    WAIT

    DELAY 200	
    '*************
    GOTO RX_EXIT

    '************************************************
    '************************************************

�º����������:
    SPEED 10

    '*************
    MOVE G6D,90,  78, 155,  103, 100, 100
    MOVE G6A,90,  66, 140,  83, 100, 100
    WAIT

    DELAY 20	
    SPEED 15
    MOVE G6D,100,  76, 146,  93, 100, 100
    MOVE G6A,100,  76, 146,  93, 100, 100
    WAIT

    DELAY 200	
    '*************
    GOTO RX_EXIT
    '************************************************
    '************************************************
��ܿ޹߿�����3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 146,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6A, 90, 100, 110, 100, 114
    MOVE G6D,113,  78, 146,  93,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 15
    MOVE G6A, 90, 140, 35, 130, 114
    MOVE G6D,113,  73, 155,  90,  94
    WAIT


    SPEED 12
    MOVE G6A,  80, 40, 115, 160, 114,
    MOVE G6D,113,  70, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 7
    MOVE G6A, 105, 70, 100, 160, 100,
    MOVE G6D,80,  90, 165,  70, 100
    MOVE G6B,160,50
    MOVE G6C,160,40
    WAIT

    SPEED 6
    MOVE G6A, 113, 90, 80, 160,95,
    MOVE G6D,70,  95, 165,  65, 105
    MOVE G6B,180,50
    MOVE G6C,180,30
    WAIT

    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 8
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,75,  90, 165,  70, 105
    WAIT

    SPEED 12
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,90,  120, 40,  140, 108
    WAIT

    SPEED 10
    MOVE G6A, 114, 90, 110, 130,95,
    MOVE G6D,90,  95, 90,  145, 108
    MOVE G6B,140,50
    MOVE G6C,140,30
    WAIT

    SPEED 10
    MOVE G6A, 110, 90, 110, 130,95,
    MOVE G6D,80,  85, 110,  135, 108
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 5
    MOVE G6D, 98, 90, 110, 125,99,
    MOVE G6A,98,  90, 110,  125, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 6
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    '****************************************

��ܿ����߿�����3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6A,108,  76, 146,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6D, 90, 100, 110, 100, 114
    MOVE G6A,113,  78, 146,  93,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 15
    MOVE G6D, 90, 140, 35, 130, 114
    MOVE G6A,113,  73, 155,  90,  94
    WAIT


    SPEED 12
    MOVE G6D,  80, 40, 115, 160, 114,
    MOVE G6A,113,  70, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 7
    MOVE G6D, 105, 70, 100, 160, 100,
    MOVE G6A,80,  90, 165,  70, 100
    MOVE G6C,160,50
    MOVE G6B,160,40
    WAIT

    SPEED 6
    MOVE G6D, 113, 90, 80, 160,95,
    MOVE G6A,70,  95, 165,  65, 105
    MOVE G6C,180,50
    MOVE G6B,180,30
    WAIT

    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 8
    MOVE G6D, 114, 90, 100, 150,95,
    MOVE G6A,75,  90, 165,  70, 105
    WAIT

    SPEED 12
    MOVE G6D, 114, 90, 100, 150,95,
    MOVE G6A,90,  120, 40,  140, 108
    WAIT

    SPEED 10
    MOVE G6D, 114, 90, 110, 130,95,
    MOVE G6A,90,  95, 90,  145, 108
    MOVE G6C,140,50
    MOVE G6B,140,30
    WAIT

    SPEED 10
    MOVE G6D, 110, 90, 110, 130,95,
    MOVE G6A,80,  85, 110,  135, 108
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 5
    MOVE G6D, 98, 90, 110, 125,99,
    MOVE G6A,98,  90, 110,  125, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 6
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    '********************************************	

    '************************************************
��ܿ޹߳�����3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 145,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6A, 90, 100, 115, 105, 114
    MOVE G6D,113,  76, 145,  93,  94
    WAIT

    GOSUB Leg_motor_mode2


    SPEED 12
    MOVE G6A,  80, 30, 155, 150, 114,
    MOVE G6D,113,  65, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6A,  80, 30, 175, 150, 114,
    MOVE G6D,113,  115, 65,  140,  94
    MOVE G6B,70,50
    MOVE G6C,70,40
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6A,90, 20, 150, 150, 110
    MOVE G6D,110,  155, 35,  120,94
    MOVE G6B,100,50
    MOVE G6C,140,40
    WAIT

    '****************************

    SPEED 8
    MOVE G6A,100, 30, 150, 150, 100
    MOVE G6D,100,  155, 70,  100,100
    MOVE G6B,140,50
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6A,114, 70, 130, 150, 94
    MOVE G6D,80,  125, 140,  85,114
    MOVE G6B,170,50
    MOVE G6C,100,40
    WAIT

    GOSUB Leg_motor_mode2	
    SPEED 10
    MOVE G6A,114, 70, 130, 150, 94
    MOVE G6D,80,  125, 50,  150,114
    WAIT

    SPEED 9
    MOVE G6A,114, 75, 130, 120, 94
    MOVE G6D,80,  85, 90,  150,114
    WAIT

    SPEED 8
    MOVE G6A,112, 80, 130, 110, 94
    MOVE G6D,80,  75,130,  115,114
    MOVE G6B,130,50
    MOVE G6C,100,40
    WAIT

    SPEED 6
    MOVE G6D, 98, 80, 130, 105,99,
    MOVE G6A,98,  80, 130,  105, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 4
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    '****************************************
    '************************************************
��ܿ����߳�����3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6A,108,  76, 145,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6D, 90, 100, 115, 105, 114
    MOVE G6A,113,  76, 145,  93,  94
    WAIT

    GOSUB Leg_motor_mode2


    SPEED 12
    MOVE G6D,  80, 30, 155, 150, 114,
    MOVE G6A,113,  65, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6D,  80, 30, 175, 150, 114,
    MOVE G6A,113,  115, 65,  140,  94
    MOVE G6B,70,50
    MOVE G6C,70,40
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6D,90, 20, 150, 150, 110
    MOVE G6A,110,  155, 35,  120,94
    MOVE G6C,100,50
    MOVE G6B,140,40
    WAIT

    '****************************

    SPEED 8
    MOVE G6D,100, 30, 150, 150, 100
    MOVE G6A,100,  155, 70,  100,100
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT

    SPEED 10
    MOVE G6D,114, 70, 130, 150, 94
    MOVE G6A,80,  125, 140,  85,114
    MOVE G6C,170,50
    MOVE G6B,100,40
    WAIT

    GOSUB Leg_motor_mode2	
    SPEED 10
    MOVE G6D,114, 70, 130, 150, 94
    MOVE G6A,80,  125, 50,  150,114
    WAIT

    SPEED 9
    MOVE G6D,114, 75, 130, 120, 94
    MOVE G6A,80,  85, 90,  150,114
    WAIT

    SPEED 8
    MOVE G6D,112, 80, 130, 110, 94
    MOVE G6A,80,  75,130,  115,114
    MOVE G6C,130,50
    MOVE G6B,100,40
    WAIT

    SPEED 6
    MOVE G6D, 98, 80, 130, 105,99,
    MOVE G6A,98,  80, 130,  105, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 4
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    '************************************************
    '************************************************

    '************************************************
�޼տ����οø���:

    SPEED 15
    MOVE G6B,,100
    WAIT

    GOSUB �⺻�ڼ�
    RETURN
    '**********************************************
�����տ����οø���:
    SPEED 15
    MOVE G6C,,100
    WAIT

    GOSUB �⺻�ڼ�
    RETURN
    '**********************************************
Ű�ۿ��ʸ���:

    HIGHSPEED SETON
    SPEED 7
    MOVE G6D,65, 85,  120, 110, 90, 100
    MOVE G6A,110, 143,  28, 142, 130, 100
    MOVE G6B,185,  100,  80
    MOVE G6C,185,  100,  80
    WAIT

    DELAY 2000
    HIGHSPEED SETOFF
    SPEED 10
    GOSUB �����ڼ�
    SPEED 8
    GOSUB �⺻�ڼ�


    RETURN
    '**********************************************
Ű�ۿ����ʸ���:

    HIGHSPEED SETON
    SPEED 7
    MOVE G6A,65, 85,  120, 110, 90, 100
    MOVE G6D,110, 143,  28, 142, 130, 100
    MOVE G6B,185,  100,  80
    MOVE G6C,185,  100,  80
    WAIT

    DELAY 2000
    HIGHSPEED SETOFF
    SPEED 10
    GOSUB �����ڼ�
    SPEED 8
    GOSUB �⺻�ڼ�

    RETURN
    '**********************************************
Ű�����鸷��:

    HIGHSPEED SETON
    SPEED 7
    MOVE G6A,80, 143,  28, 142, 118, 100
    MOVE G6D,80, 143,  28, 142, 118, 100
    MOVE G6B,100,  60,  80, 100, 100, 100
    MOVE G6C,100,  60,  80, 100, 100, 100
    WAIT

    DELAY 2000
    HIGHSPEED SETOFF
    SPEED 8
    GOSUB �⺻�ڼ�

    RETURN
    '**********************************************

    '**********************************************

�����������:
    GOSUB All_motor_mode3
    SPEED 7
    MOVE G6A,100,  76, 145,  95, 100
    MOVE G6D,100,  76, 145,  95, 100
    MOVE G6B,100,  185,  110
    MOVE G6C,100,  185,  110
    WAIT

    GOSUB GOSUB_RX_EXIT
�����������_1:
    ERX 4800, A, �����������_1
    '**** ��°������� ************
    SPEED 4
    MOVE G6B,,  ,  135
    MOVE G6C,,  ,  135
    WAIT

    DELAY 500
    GOSUB GOSUB_RX_EXIT	

�����������_2:
    ERX 4800, A, �����������_2
    IF A = 26 THEN
        SPEED 10
        GOSUB �⺻�ڼ�
        GOSUB All_motor_Reset	
        GOTO RX_EXIT
    ELSEIF A = 4 THEN
        GOTO ���������_3
    ELSEIF A = 5 THEN
        GOTO ���������_3
    ELSEIF A = 6 THEN
        GOTO �����������_3
    ENDIF
�����������_3:
    GOSUB Leg_motor_mode2
    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    WAIT

    SPEED 8
    MOVE G6A,95,  46, 145,  123, 105, 100
    MOVE G6D,95,  106, 145,  63, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,93,  46, 145,  123, 105, 100
    MOVE G6D,93,  106, 145,  63, 105, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    WAIT


    SPEED 6
    MOVE G6A,100,  96, 125,  85, 100
    MOVE G6D,100,  96, 125,  85, 100
    MOVE G6B,135,  ,
    MOVE G6C,135,  ,
    WAIT

    GOSUB All_motor_Reset
    HIGHSPEED SETON

    SPEED 12
    MOVE G6A,100,  66, 145,  115, 100
    MOVE G6D,100,  66, 145,  115, 100
    MOVE G6B,75,  , 125
    MOVE G6C,75,  , 125
    WAIT	

    DELAY 800
    HIGHSPEED SETOFF

    GOSUB All_motor_mode3
    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset

    RETURN
    RETURN
    '**********************************************
���������:
    GOSUB All_motor_mode3
    SPEED 7
    MOVE G6A,100,  76, 145,  95, 100
    MOVE G6D,100,  76, 145,  95, 100
    MOVE G6B,100,  185,  110
    MOVE G6C,100,  185,  110
    WAIT

    GOSUB GOSUB_RX_EXIT
���������_1:
    ERX 4800, A, ���������_1
    '**** ��°������� ************
    SPEED 4
    MOVE G6B,,  ,  135
    MOVE G6C,,  ,  135
    WAIT

    DELAY 500
    GOSUB GOSUB_RX_EXIT	

���������_2:
    ERX 4800, A, ���������_2
    IF A = 26 THEN
        SPEED 10
        GOSUB �⺻�ڼ�
        GOSUB All_motor_Reset	
        GOTO RX_EXIT
    ELSEIF A = 4 THEN
        GOTO ���������_3
    ELSEIF A = 5 THEN
        GOTO ���������_3
    ELSEIF A = 6 THEN
        GOTO �����������_3
    ENDIF
���������_3:
    GOSUB Leg_motor_mode2
    SPEED 6
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6A,100,  76, 145,  93, 100
    WAIT

    SPEED 8
    MOVE G6D,95,  46, 145,  123, 105, 100
    MOVE G6A,95,  106, 145,  63, 105, 100
    WAIT

    SPEED 10
    MOVE G6D,93,  46, 145,  123, 105, 100
    MOVE G6A,93,  106, 145,  63, 105, 100
    WAIT

    SPEED 8
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6A,100,  76, 145,  93, 100
    WAIT


    SPEED 6
    MOVE G6A,100,  96, 125,  85, 100
    MOVE G6D,100,  96, 125,  85, 100
    MOVE G6B,135,  ,
    MOVE G6C,135,  ,
    WAIT	
    GOSUB All_motor_Reset
    HIGHSPEED SETON

    SPEED 12
    MOVE G6A,100,  66, 145,  115, 100
    MOVE G6D,100,  66, 145,  115, 100
    MOVE G6B,75,  , 125
    MOVE G6C,75,  , 125
    WAIT	

    DELAY 800
    HIGHSPEED SETOFF

    GOSUB All_motor_mode3
    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset

    RETURN
    RETURN
    '**********************************************
���������:
    GOSUB All_motor_mode3
    SPEED 7
    MOVE G6A,100,  76, 145,  95, 100
    MOVE G6D,100,  76, 145,  95, 100
    MOVE G6B,100,  185,  110
    MOVE G6C,100,  185,  110
    WAIT

    GOSUB GOSUB_RX_EXIT
���������_1:
    ERX 4800, A, ���������_1
    '**** ��°������� ************
    SPEED 4
    MOVE G6B,,  ,  135
    MOVE G6C,,  ,  135
    WAIT

    DELAY 500
    GOSUB GOSUB_RX_EXIT	

���������_2:
    ERX 4800, A, ���������_2
    IF A = 26 THEN
        SPEED 10
        GOSUB �⺻�ڼ�
        GOSUB All_motor_Reset	
        GOTO RX_EXIT
    ELSEIF A = 4 THEN
        GOTO ���������_3
    ELSEIF A = 5 THEN
        GOTO ���������_3
    ELSEIF A = 6 THEN
        GOTO �����������_3
    ENDIF
���������_3:
    SPEED 5
    MOVE G6A,100,  96, 125,  85, 100
    MOVE G6D,100,  96, 125,  85, 100
    MOVE G6B,135,  ,
    MOVE G6C,135,  ,
    WAIT

    GOSUB All_motor_Reset
    HIGHSPEED SETON

    SPEED 12
    MOVE G6A,100,  66, 145,  115, 100
    MOVE G6D,100,  66, 145,  115, 100
    MOVE G6B,75,  , 125
    MOVE G6C,75,  , 125
    WAIT	

    DELAY 800
    HIGHSPEED SETOFF

    GOSUB All_motor_mode3
    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset

    RETURN
    '**********************************************
���������ν���:
    GOSUB Leg_motor_mode3
    SPEED 4
    '���ʱ���
    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6C, 100,40
    MOVE G6B, 100,40
    WAIT

    GOSUB Leg_motor_mode1
    HIGHSPEED SETON
    SPEED 8
    '�����ߵ��
    MOVE G6D, 80, 95, 115, 105, 140
    MOVE G6A,113,  78, 146,  93,  94
    MOVE G6C, 100,60
    MOVE G6B, 100,60
    WAIT

    DELAY 100
    HIGHSPEED SETOFF
    GOSUB Leg_motor_mode3
    SPEED 8
    '���ʱ���2
    MOVE G6A, 106,  76, 146,  93,  96		
    MOVE G6D,  88,  71, 152,  91, 106
    MOVE G6B, 100,35
    MOVE G6C, 100,35
    WAIT	

    GOSUB Leg_motor_mode3
    SPEED 3
    GOSUB �⺻�ڼ�
    GOSUB Leg_motor_mode1


    RETURN
    '**********************************************
�������ν���:
    GOSUB Leg_motor_mode3
    SPEED 4
    '���ʱ���
    MOVE G6A,  88,  71, 152,  91, 110
    MOVE G6D, 108,  76, 146,  93,  94
    MOVE G6B, 100,40
    MOVE G6C, 100,40
    WAIT

    GOSUB Leg_motor_mode1
    HIGHSPEED SETON

    SPEED 8
    MOVE G6A, 80, 95, 115, 105, 140
    MOVE G6D,113,  78, 146,  93,  94
    MOVE G6B, 100,60
    MOVE G6C, 100,60
    WAIT

    DELAY 100
    HIGHSPEED SETOFF
    GOSUB Leg_motor_mode3

    SPEED 8
    MOVE G6D, 106,  76, 146,  93,  96		
    MOVE G6A,  88,  71, 152,  91, 106
    MOVE G6B, 100,35
    MOVE G6C, 100,35
    WAIT	

    GOSUB Leg_motor_mode3
    SPEED 3
    GOSUB �⺻�ڼ�
    GOSUB Leg_motor_mode1

    RETURN

    '**********************************************
�ڷν���:
    IF ������� = 0 THEN
        '������
        GOSUB Leg_motor_mode2
        SPEED 4

        MOVE G6A,110,  77, 145,  93,  92, 100	
        MOVE G6D, 85,  71, 152,  91, 114, 100
        MOVE G6C,100,  40,  80, , , ,
        MOVE G6B,100,  40,  80, , , ,	
        WAIT

        SPEED 10
        MOVE G6A,114,  78, 147,  85,  95	
        MOVE G6D, 83,  85, 122,  100, 114
        WAIT


        HIGHSPEED SETON

        SPEED 15
        MOVE G6A,114,  75, 147,  110,  95	
        MOVE G6D, 83,  110, 122,  75, 114
        MOVE G6B,80
        MOVE G6C,120
        WAIT


        DELAY 100
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3

        SPEED 10
        MOVE G6A,114,  74, 147,  97,  95
        MOVE G6D, 83,  85, 122,  105, 114
        MOVE G6C,100,  40,  80, , , ,
        MOVE G6B,100,  40,  80, , , ,	
        WAIT	

        SPEED 8
        MOVE G6A,113,  76, 147,  95,  95	
        MOVE G6D, 80,  76, 142,  95, 114
        MOVE G6C,100,  40,  80, , , ,
        MOVE G6B,100,  40,  80, , , ,
        WAIT	

        SPEED 8
        MOVE G6A,110,  77, 147,  93,  93, 100	
        MOVE G6D, 80,  71, 154,  91, 114, 100
        WAIT


        SPEED 3
        GOSUB �⺻�ڼ�	
        GOSUB Leg_motor_mode1
        ������� = 1
    ELSE
        '�޹�
        GOSUB Leg_motor_mode2
        SPEED 4

        MOVE G6D,110,  77, 145,  93,  92, 100	
        MOVE G6A, 85,  71, 152,  91, 114, 100
        MOVE G6B,100,  40,  80, , , ,
        MOVE G6C,100,  40,  80, , , ,	
        WAIT

        SPEED 10
        MOVE G6D,114,  78, 147,  85,  95	
        MOVE G6A, 83,  85, 122,  100, 114
        WAIT


        HIGHSPEED SETON

        SPEED 15
        MOVE G6D,114,  75, 147,  110,  95	
        MOVE G6A, 83,  110, 122,  75, 114
        MOVE G6C,80
        MOVE G6B,120
        WAIT


        DELAY 100
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3

        SPEED 10
        MOVE G6D,114,  74, 147,  97,  95
        MOVE G6A, 83,  85, 122,  105, 114
        MOVE G6B,100,  40,  80, , , ,
        MOVE G6C,100,  40,  80, , , ,	
        WAIT	

        SPEED 8
        MOVE G6D,113,  76, 147,  95,  95	
        MOVE G6A, 80,  76, 142,  95, 114
        MOVE G6B,100,  40,  80, , , ,
        MOVE G6C,100,  40,  80, , , ,
        WAIT	

        SPEED 8
        MOVE G6D,110,  77, 147,  93,  93, 100	
        MOVE G6A, 80,  71, 154,  91, 114, 100
        WAIT


        SPEED 3
        GOSUB �⺻�ڼ�	
        GOSUB Leg_motor_mode1
        ������� = 0
    ENDIF




    RETURN

    '************************************************
RND_MOTION:

    GOSUB All_motor_mode3

RND_MOTION_LOOP:
    'FOR J = 1 TO �ݺ�Ƚ��
    ȫ�����������ÿ��� = 0



    SPEED 3
    TEMP = RND
    TEMP = TEMP MOD 80

    S11= 60 + TEMP
    SERVO 11,S11

    '***********
    TEMP = RND
    TEMP = TEMP MOD 30

    SPEED 1

    S6= 90 + TEMP
    TEMP = TEMP MOD 2
    IF TEMP = 0 THEN
        SERVO 6,S6
    ENDIF

    '***********	
    TEMP = RND
    TEMP = TEMP MOD 30

    S12= 90 + TEMP

    TEMP = TEMP MOD 2
    IF TEMP = 0 THEN
        SERVO 12,S12
    ENDIF


    '*********************************	
    FOR I = 1 TO 150
        DELAY 15' 195
        ERX 4800,A ,RND_MOTION_1
        IF A = 26 THEN	' ��
            GOSUB SOUND_STOP
            OUT 52,0
            SPEED 5
            GOSUB �⺻�ڼ�
            GOSUB All_motor_Reset
            GOSUB ������
            RETURN
        ELSEIF A = 21 THEN ' ��: ����
            SPEED 6
            MOVE G6B,160,  25,  70, , ,100
            MOVE G6C,160,  25,  70
            WAIT
            SPEED 8
            MOVE G6B,160,  25,  80, , ,100
            MOVE G6C,160,  25,  80
            WAIT		
            I = 1
            ȫ�����������ÿ��� = 1

        ELSEIF A = 15 THEN  ' A: ���ʾ�
            SPEED 6
            MOVE G6B,160,  70,  70, , ,70
            MOVE G6C,160,  25,  70
            WAIT
            SPEED 8
            MOVE G6B,160,  50,  90, , ,55
            MOVE G6C,160,  15,  40
            WAIT
            I = 1
            ȫ�����������ÿ��� = 1

        ELSEIF A = 30 THEN  ' ��: ������
            SPEED 6
            MOVE G6C,175,  70,  70
            MOVE G6B,160,  25,  70, , ,140
            WAIT
            SPEED 10
            MOVE G6C,175,  90,  95
            MOVE G6B,175,  15,  20, , ,170
            WAIT
            I = 1
            ȫ�����������ÿ��� = 1

        ELSEIF A = 28 THEN 	' ��: ����
            SPEED 6
            MOVE G6B,175,  70,  70, , ,60
            MOVE G6C,160,  25,  70
            WAIT
            SPEED 10
            MOVE G6B,175,  90,  95
            MOVE G6C,175,  15,  20, , ,30
            WAIT
            I = 1
            ȫ�����������ÿ��� = 1

        ELSEIF A = 20 THEN   ' B: �����ʾ�
            SPEED 6
            MOVE G6C,160,  70,  70
            MOVE G6B,160,  25,  70, , ,130
            WAIT
            SPEED 8
            MOVE G6C,160,  50,  90
            MOVE G6B,160,  15,  40, , ,145
            WAIT
            I = 1
            ȫ�����������ÿ��� = 1

        ELSEIF A = 1 THEN
            GOSUB SOUND_ȫ��1
        ELSEIF A = 2 THEN
            GOSUB SOUND_ȫ��2
        ELSEIF A = 3 THEN
            GOSUB SOUND_ȫ��3
        ELSEIF A = 4 THEN
            GOSUB SOUND_ȫ��4
        ELSEIF A = 5 THEN
            GOSUB SOUND_ȫ��5
        ELSEIF A = 6 THEN
            GOSUB SOUND_ȫ��6
        ELSEIF A = 7 THEN
            GOSUB SOUND_ȫ��7
        ELSEIF A = 8 THEN
            GOSUB SOUND_ȫ��8
        ELSEIF A = 9 THEN
            GOSUB SOUND_ȫ��9
        ENDIF

        GOSUB GOSUB_RX_EXIT


RND_MOTION_1:
        IF I < 10 THEN
            OUT 52,1
        ELSEIF I > 10 THEN
            OUT 52,0
        ENDIF
    NEXT I
    '***********

    IF ȫ�����������ÿ��� = 1 THEN
        SPEED 6
        MOVE G6B,130,  40,  80, , ,100
        MOVE G6C,130,  40,  80
        WAIT

        MOVE G6B,100,  30,  80, , ,100
        MOVE G6C,100,  30,  80
        WAIT
    ENDIF


    GOTO RND_MOTION_LOOP
    '***********************************
    SPEED 3
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    GOSUB ������

    RETURN

    '************************************************

    '**********************************************
����ü������:
    ������ = 0

    GOSUB SOUND_����ü����
    GOSUB ����ü��_1	'����

    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN

    GOSUB ����ü��_2	'�ٸ��

    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    GOSUB ����ü��_3	'�ȿ
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    GOSUB ����ü��_4	'�Ӹ��
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    GOSUB ����ü��_5 	'�����
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    GOSUB ����ü��_6	'���ٸ��
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    GOSUB ����ü��_7	'���
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    GOSUB ����ü��_8 	'����
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    GOSUB ����ü��_9	'�¸��
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    GOSUB ����ü��_10   '�ܶٱ�
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    GOSUB ����ü��_11   '�ȴٸ��
    GOSUB DANCE_STOP
    IF ������ = 1 THEN GOTO STOP_MAIN
    GOSUB ����ü��_12	'������



    GOTO RX_EXIT
    '**********************************************
    '**********************************************

����ü��_1: '����
    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    SPEED 3
    FOR i = 1 TO 4'7

        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6C,110,  30,  80
        MOVE G6B,110,  30,  80
        WAIT

        MOVE G6D,100,  85, 125,  105, 100, 100
        MOVE G6A,100,  85, 125,  105, 100, 100
        MOVE G6C,90,  30,  80
        MOVE G6B,90,  30,  80
        WAIT


    NEXT i

    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6C,110,  30,  80
    MOVE G6B,110,  30,  80
    WAIT

    SPEED 4
    FOR i = 1 TO 4

        MOVE G6C,120,  30,  80
        MOVE G6B,80,  30,  80
        WAIT

        MOVE G6C,80,  30,  80
        MOVE G6B,120,  30,  80
        WAIT

    NEXT i

    MOVE G6C,100,  30,  80
    MOVE G6B,100,  30,  80
    WAIT

    RETURN
    '**********************************************

����ü��_2: '�ٸ��
    GOSUB All_motor_mode3

    FOR i = 1 TO 4
        SPEED 7
        MOVE G6D,100,  74, 145,  90, 100, 100
        MOVE G6A,100,  74, 145,  90, 100, 100
        MOVE G6C,180,  30,  80
        MOVE G6B,180,  30,  80
        WAIT
        DELAY 100

        SPEED 11
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6C,100,  185,  100
        MOVE G6B,100,  185,  100
        WAIT
        DELAY 100

        SPEED 9
        MOVE G6A,100, 60, 178, 76, 100, 100
        MOVE G6D,100, 60, 178, 76, 100, 100
        MOVE G6C,100,  100,  100
        MOVE G6B,100,  100,  100
        WAIT

        DELAY 100
        SPEED 7
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,100,  30,  80, 100, 100, 100
        MOVE G6C,100,  30,  80, 100, 100, 100
        WAIT
        DELAY 100


    NEXT i


    SPEED 8
    MOVE G6B,130,  30,  80, 100, 100, 100
    MOVE G6C,130,  30,  80, 100, 100, 100
    WAIT

    SPEED 8
    MOVE G6B,130,  15,  60, 100, 100, 100
    MOVE G6C,130,  15,  60, 100, 100, 100
    WAIT

    SPEED 8
    MOVE G6B,130,  15,  60, 100, 100, 100
    MOVE G6C,130,  15,  60, 100, 100, 100
    WAIT

    FOR i = 1 TO 4
        SPEED 8
        MOVE G6A,100,  110, 60,  153, 100, 100
        MOVE G6D,100,  110, 60,  153, 100, 100
        MOVE G6B,150,  20,  80, 100, 100, 100
        MOVE G6C,150,  20,  80, 100, 100, 100
        WAIT

        SPEED 5
        MOVE G6A,100,  122, 40,  160, 100, 100
        MOVE G6D,100,  122, 40,  160, 100, 100
        MOVE G6B,150,  20,  80, 100, 100, 100
        MOVE G6C,150,  20,  80, 100, 100, 100
        WAIT


        SPEED 6
        MOVE G6A,100,  110, 60,  153, 100, 100
        MOVE G6D,100,  110, 60,  153, 100, 100
        MOVE G6B,150,  15,  60, 100, 100, 100
        MOVE G6C,150,  15,  60, 100, 100, 100
        WAIT


        SPEED 5
        MOVE G6A,100,  122, 40,  160, 100, 100
        MOVE G6D,100,  122, 40,  160, 100, 100
        MOVE G6B,150,  20,  80, 100, 100, 100
        MOVE G6C,150,  20,  80, 100, 100, 100
        WAIT
        DELAY 100

        SPEED 10
        MOVE G6A,100,  33, 170,  155, 100, 100
        MOVE G6D,100,  33, 170,  155, 100, 100
        MOVE G6B,170,  15,  60, 100, 100, 100
        MOVE G6C,170,  15,  60, 100, 100, 100
        WAIT
        DELAY 100

        SPEED 8
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,100,  40,  80, 100, 100, 100
        MOVE G6C,100,  40,  80, 100, 100, 100
        WAIT
        DELAY 100

    NEXT i



    RETURN

    '**********************************************

����ü��_3: '�ȿ

    FOR i = 1 TO 3
        SPEED 9
        MOVE G6A,100, 60, 173, 76, 100, 100
        MOVE G6D,100, 60, 173, 76, 100, 100
        MOVE G6C,185,  30,  80
        MOVE G6B,185,  30,  80
        WAIT
        DELAY 100

        SPEED 8
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6C,100,  30,  90
        MOVE G6B,100,  30,  90
        WAIT

        DELAY 100

    NEXT i

    FOR i = 1 TO 3
        SPEED 10
        MOVE G6A,100, 63, 173, 76, 100, 100
        MOVE G6D,100, 63, 173, 76, 100, 100
        MOVE G6C,60,  180,  130
        MOVE G6B,60,  180,  130
        WAIT
        DELAY 100

        SPEED 11
        MOVE G6A,100,  76, 145,  90, 100, 100
        MOVE G6D,100,  76, 145,  90, 100, 100
        MOVE G6C,130,  30,  90
        MOVE G6B,130,  30,  90
        WAIT

        DELAY 100

    NEXT i


    RETURN


    '**********************************************

����ü��_4: '�Ӹ��
    GOSUB All_motor_mode3
    SPEED 9
    MOVE G6A,100,  76, 145,  95, 100, 100
    MOVE G6D,100,  76, 145,  95, 100, 100
    MOVE G6C,70,  40,  80
    MOVE G6B,70,  40,  80
    WAIT


    SPEED 9
    MOVE G6A,100,  76, 145,  95, 100, 100
    MOVE G6D,100,  76, 145,  95, 100, 100
    MOVE G6C,70,  20,  60
    MOVE G6B,70,  20,  60
    WAIT

    SPEED 9
    MOVE G6A,94,  68, 125,  155, 105, 100
    MOVE G6D,94,  68, 125,  155, 105, 100
    MOVE G6C,70,  20,  60
    MOVE G6B,70,  20,  60
    WAIT


    FOR i = 1 TO 1



        SPEED 9
        MOVE G6A,104,  78, 110,  160, 100, 100
        MOVE G6D,84,  68, 125,  155, 115, 100
        MOVE G6C,70,  20,  60
        MOVE G6B,70,  20,  60, , , 50
        WAIT

        SPEED 7
        MOVE G6A,104,  70, 130,  146, 95, 100
        MOVE G6D,84,  58, 145,  145, 115, 100
        MOVE G6C,70,  20,  60
        MOVE G6B,70,  20,  60
        WAIT

        SPEED 9
        MOVE G6A,100,  86, 145,  75, 95, 100
        MOVE G6D,84,  81, 155,  70, 115, 100
        MOVE G6C,70,  20,  60
        MOVE G6B,70,  20,  60
        WAIT


        '***************************

        SPEED 9
        MOVE G6D,100,  86, 145,  75, 95, 100
        MOVE G6A,84,  81, 155,  70, 115, 100
        MOVE G6C,70,  20,  60
        MOVE G6B,70,  20,  60, , , 150
        WAIT

        SPEED 7
        MOVE G6D,104,  70, 130,  146, 95, 100
        MOVE G6A,84,  58, 145,  145, 115, 100
        MOVE G6C,70,  20,  60
        MOVE G6B,70,  20,  60
        WAIT

        SPEED 9
        MOVE G6D,104,  78, 110,  160, 100, 100
        MOVE G6A,84,  68, 125,  155, 115, 100
        MOVE G6C,70,  20,  60
        MOVE G6B,70,  20,  60
        WAIT

    NEXT i


    SPEED 9
    MOVE G6A,104,  78, 110,  160, 100, 100
    MOVE G6D,84,  68, 125,  155, 115, 100
    MOVE G6C,70,  20,  60
    MOVE G6B,70,  20,  60, , , 50
    WAIT

    SPEED 7
    MOVE G6A,100,  86, 145,  75, 95, 100
    MOVE G6D,84,  81, 155,  70, 115, 100
    MOVE G6C,70,  20,  60
    MOVE G6B,70,  20,  60
    WAIT

    SPEED 6
    MOVE G6D,94,  85, 145,  75, 105, 100
    MOVE G6A,94,  85, 145,  75, 105, 100
    MOVE G6C,70,  20,  60
    MOVE G6B,70,  20,  60, , , 100
    WAIT
    DELAY 100

    FOR i = 1 TO 2

        SPEED 9
        MOVE G6A,100,  86, 145,  75, 95, 100
        MOVE G6D,84,  81, 155,  70, 115, 100
        MOVE G6C,70,  20,  60,
        MOVE G6B,70,  20,  60,, , 50
        WAIT

        SPEED 8
        MOVE G6A,104,  70, 130,  146, 95, 100
        MOVE G6D,84,  58, 145,  145, 115, 100
        MOVE G6C,70,  20,  60
        MOVE G6B,70,  20,  60
        WAIT

        SPEED 8
        MOVE G6A,104,  78, 110,  160, 100, 100
        MOVE G6D,84,  68, 125,  155, 115, 100
        MOVE G6C,70,  20,  60
        MOVE G6B,70,  20,  60,
        WAIT

        SPEED 8
        MOVE G6D,104,  78, 110,  160, 100, 100
        MOVE G6A,84,  68, 125,  155, 115, 100
        MOVE G6C,70,  20,  60
        MOVE G6B,70,  20,  60, , , 150
        WAIT

        SPEED 8
        MOVE G6D,104,  70, 130,  146, 95, 100
        MOVE G6A,84,  58, 145,  145, 115, 100
        MOVE G6C,70,  20,  60
        MOVE G6B,70,  20,  60
        WAIT

        SPEED 9
        MOVE G6D,100,  86, 145,  75, 95, 100
        MOVE G6A,84,  81, 155,  70, 115, 100
        MOVE G6C,70,  20,  60
        MOVE G6B,70,  20,  60
        WAIT


        '***************************



    NEXT i

    SPEED 8
    MOVE G6A,100,  76, 145,  95, 100, 100
    MOVE G6D,100,  76, 145,  95, 100, 100
    MOVE G6C,70,  20,  60
    MOVE G6B,70,  20,  60, , , 100
    WAIT

    SPEED 7
    MOVE G6A,100,  76, 145,  95, 100, 100
    MOVE G6D,100,  76, 145,  95, 100, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT



    RETURN


    '**********************************************

����ü��_5: '�����
    GOSUB All_motor_mode3
    SPEED 8
    MOVE G6A,100,  76, 145,  95, 100, 100
    MOVE G6D,100,  76, 145,  95, 100, 100
    MOVE G6C,70,  40,  80
    MOVE G6B,70,  40,  80
    WAIT


    SPEED 7
    MOVE G6A,100,  76, 145,  95, 100, 100
    MOVE G6D,100,  76, 145,  95, 100, 100
    MOVE G6C,70,  20,  50
    MOVE G6B,70,  20,  50
    WAIT

    FOR j = 1 TO 2
        FOR i = 1 TO 2

            SPEED 4
            MOVE G6A, 100,  74, 175,  45, 100, 100
            MOVE G6D, 100,  74, 175,  45, 100, 100
            MOVE G6B,  60,  30,  30, 100, 100, 100
            MOVE G6C,  60,  30,  30, 100, 100, 100
            WAIT

            SPEED 4
            MOVE G6A, 100,  80, 145,  85, 100, 100
            MOVE G6D, 100,  80, 145,  85, 100, 100
            MOVE G6C,70,  20,  50
            MOVE G6B,70,  20,  50
            WAIT

        NEXT i

        SPEED 6
        MOVE G6A, 100,  64, 145,  135, 100, 100
        MOVE G6D, 100,  64, 145,  135, 100, 100
        MOVE G6B,  60,  30,  30, 100, 100, 100
        MOVE G6C,  60,  30,  30, 100, 100, 100
        WAIT

        FOR i = 1 TO 2

            SPEED 3
            MOVE G6A, 100,  64, 145,  135, 100, 100
            MOVE G6D, 100,  64, 145,  135, 100, 100
            MOVE G6B,  60,  30,  30, 100, 100, 100
            MOVE G6C,  60,  30,  30, 100, 100, 100
            WAIT

            SPEED 3
            MOVE G6A, 100,  74, 125,  145, 100, 100
            MOVE G6D, 100,  74, 125,  145, 100, 100
            MOVE G6C,70,  20,  50
            MOVE G6B,70,  20,  50
            WAIT

        NEXT i

    NEXT j

    SPEED 5
    MOVE G6A, 100,  64, 145,  135, 100, 100
    MOVE G6D, 100,  64, 145,  135, 100, 100
    MOVE G6B,  60,  30,  30, 100, 100, 100
    MOVE G6C,  60,  30,  30, 100, 100, 100
    WAIT

    SPEED 6
    MOVE G6A,100,  76, 145,  95, 100, 100
    MOVE G6D,100,  76, 145,  95, 100, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT



    RETURN


    '**********************************************

����ü��_6: '���ٸ��
    GOSUB All_motor_mode3

    FOR j = 1 TO 2
        FOR i = 1 TO 2

            SPEED 10
            MOVE G6D,96,  116, 67,  133, 130, 100
            MOVE G6A,85,  86, 125,  103, 85, 100
            MOVE G6C,100,  45,  90,
            MOVE G6B,100,  180,  140,, , 160
            WAIT

            SPEED 11
            MOVE G6D,96,  86, 125,  103, 110, 100
            MOVE G6A,91,  76, 145,  93, 100, 100
            MOVE G6C,100,  35,  80,
            MOVE G6B,100,  35,  80,, , 100
            WAIT
        NEXT i
        '***********************************
        FOR i = 1 TO 2

            SPEED 10
            MOVE G6A,96,  116, 67,  133, 130, 100
            MOVE G6D,85,  86, 125,  103, 85, 100
            MOVE G6B,100,  45,  90,, , 40
            MOVE G6C,100,  180,  140,
            WAIT

            SPEED 11
            MOVE G6A,96,  86, 125,  103, 110, 100
            MOVE G6D,91,  76, 145,  93, 100, 100
            MOVE G6B,100,  35,  80,, , 100
            MOVE G6C,100,  35,  80,
            WAIT
        NEXT i
    NEXT j

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80,, , 100
    MOVE G6C,100,  30,  80,
    WAIT


    RETURN
    '**********************************************
����ü��_7: '���

    GOSUB All_motor_mode3

    FOR j = 1 TO 2
        FOR i = 1 TO 2
            SPEED 5
            MOVE G6A,100,  33, 178,  155, 100
            MOVE G6D,100,  33, 178,  155, 100
            MOVE G6B,165,  15,  90
            MOVE G6C,165,  15,  90
            WAIT

            SPEED 5
            MOVE G6A,100,  76, 145,  93, 100
            MOVE G6D,100,  76, 145,  93, 100
            MOVE G6B,100,  30,  80
            MOVE G6C,100,  30,  80
            WAIT

        NEXT i


        FOR i = 1 TO 2

            SPEED 4
            MOVE G6A, 100,  74, 175,  45, 100, 100
            MOVE G6D, 100,  74, 175,  45, 100, 100
            MOVE G6B,  60,  30,  30, 100, 100, 100
            MOVE G6C,  60,  30,  30, 100, 100, 100
            WAIT

            SPEED 4
            MOVE G6A, 100,  80, 145,  85, 100, 100
            MOVE G6D, 100,  80, 145,  85, 100, 100
            MOVE G6C,70,  20,  50
            MOVE G6B,70,  20,  50
            WAIT

        NEXT i

        SPEED 10
        MOVE G6C,100,  40,  90
        MOVE G6B,100,  40,  90
        WAIT
    NEXT j


    RETURN
    '**********************************************
����ü��_8: '����
    GOSUB All_motor_mode3

    SPEED 12
    MOVE G6A,100,  70, 145,  96, 100, 100
    MOVE G6D,100,  70, 145,  96, 100, 100
    MOVE G6C,185,  30,  80
    MOVE G6B,185,  30,  80
    WAIT


    SPEED 10
    MOVE G6C,185,  11,  20
    MOVE G6B,185,  130,  120
    WAIT


    SPEED 10
    MOVE G6B,185,  11,  20
    MOVE G6C,185,  130,  120
    WAIT

    SPEED 10
    MOVE G6C,185,  11,  20
    MOVE G6B,185,  130,  120
    WAIT


    SPEED 10
    MOVE G6C,185,  30,  80
    MOVE G6B,185,  30,  80
    WAIT

    SPEED 10
    MOVE G6A,100,  70, 145,  96, 100, 100
    MOVE G6D,100,  70, 145,  96, 100, 100
    MOVE G6C,100,  30,  80
    MOVE G6B,100,  30,  80
    WAIT

    DELAY 150
    '*****************
    SPEED 12
    MOVE G6C,185,  30,  80
    MOVE G6B,185,  30,  80
    WAIT



    SPEED 10
    MOVE G6B,185,  11,  20
    MOVE G6C,185,  130,  120
    WAIT


    SPEED 10
    MOVE G6C,185,  11,  20
    MOVE G6B,185,  130,  120
    WAIT

    SPEED 10
    MOVE G6B,185,  11,  20
    MOVE G6C,185,  130,  120
    WAIT


    SPEED 10
    MOVE G6C,185,  30,  80
    MOVE G6B,185,  30,  80
    WAIT

    SPEED 10
    MOVE G6A,100,  70, 145,  96, 100, 100
    MOVE G6D,100,  70, 145,  96, 100, 100
    MOVE G6C,100,  30,  80
    MOVE G6B,100,  30,  80
    WAIT

    DELAY 150
    '*****************
    SPEED 12
    MOVE G6A,100,  70, 145,  96, 100, 100
    MOVE G6D,100,  70, 145,  96, 100, 100
    MOVE G6C,185,  30,  80
    MOVE G6B,185,  30,  80
    WAIT


    SPEED 10
    MOVE G6C,185,  11,  20
    MOVE G6B,185,  130,  120
    WAIT


    SPEED 10
    MOVE G6B,185,  11,  20
    MOVE G6C,185,  130,  120
    WAIT

    SPEED 10
    MOVE G6C,185,  11,  20
    MOVE G6B,185,  130,  120
    WAIT


    SPEED 10
    MOVE G6C,185,  30,  80
    MOVE G6B,185,  30,  80
    WAIT

    SPEED 10
    MOVE G6A,100,  70, 145,  96, 100, 100
    MOVE G6D,100,  70, 145,  96, 100, 100
    MOVE G6C,100,  30,  80
    MOVE G6B,100,  30,  80
    WAIT

    DELAY 150
    '*****************


    RETURN

    '**********************************************
����ü��_9: '�¸��
    GOSUB All_motor_mode3

    FOR i = 1 TO 5
        SPEED 12
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6C,100,  30,  80
        MOVE G6B,100,  30,  80
        WAIT

        SPEED 10
        MOVE G6A,100, 140,  37, 140, 100, 100
        MOVE G6D,100, 140,  37, 140, 100, 100
        MOVE G6B,120,  30,  80
        MOVE G6C,120,  30,  80


        SPEED 6
        MOVE G6A,100, 143,  28, 142, 100, 100
        MOVE G6D,100, 143,  28, 142, 100, 100
        WAIT


        DELAY 100

        SPEED 8
        MOVE G6A,100, 137,  37, 140, 100, 100
        MOVE G6D,100, 137,  37, 140, 100, 100
        WAIT

        SPEED 10
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,189,  70,  80
        MOVE G6C,189,  70,  80
        WAIT

        SPEED 15
        MOVE G6C,189,  40,  15
        MOVE G6B,189,  40,  15
        WAIT

        DELAY 100

        SPEED 15
        MOVE G6C,100,  40,  80
        MOVE G6B,100,  40,  80
        WAIT

    NEXT i

    RETURN

    '**********************************************
    '**********************************************
����ü��_10: '�ܶٱ�
    GOSUB All_motor_mode3

    FOR j = 1 TO 2
        FOR i = 1 TO 3
            SPEED 8
            MOVE G6A,100,  96, 108,  113, 100, 100
            MOVE G6D,100,  96, 108,  113, 100, 100
            MOVE G6C,100,  30,  80
            MOVE G6B,100,  30,  80
            WAIT

            SPEED 8
            MOVE G6A,100,  76, 145,  93, 100, 100
            MOVE G6D,100,  76, 145,  93, 100, 100
            MOVE G6C,80,  30,  80
            MOVE G6B,120,  30,  80
            WAIT

            '*************
            SPEED 8
            MOVE G6A,100,  96, 108,  113, 100, 100
            MOVE G6D,100,  96, 108,  113, 100, 100
            MOVE G6C,100,  30,  80
            MOVE G6B,100,  30,  80
            WAIT

            SPEED 8
            MOVE G6A,100,  76, 145,  93, 100, 100
            MOVE G6D,100,  76, 145,  93, 100, 100
            MOVE G6B,80,  30,  80
            MOVE G6C,120,  30,  80
            WAIT

        NEXT i


        FOR i = 1 TO 3
            SPEED 12
            MOVE G6A,100,  96, 108,  113, 100, 100
            MOVE G6D,100,  96, 108,  113, 100, 100
            MOVE G6C,100,  30,  80
            MOVE G6B,100,  30,  80
            WAIT

            SPEED 12
            MOVE G6A,100,  76, 145,  93, 100, 100
            MOVE G6D,100,  76, 145,  93, 100, 100
            MOVE G6C,80,  30,  80
            MOVE G6B,120,  30,  80
            WAIT

            '*************
            SPEED 12
            MOVE G6A,100,  96, 108,  113, 100, 100
            MOVE G6D,100,  96, 108,  113, 100, 100
            MOVE G6C,100,  30,  80
            MOVE G6B,100,  30,  80
            WAIT

            SPEED 12
            MOVE G6A,100,  76, 145,  93, 100, 100
            MOVE G6D,100,  76, 145,  93, 100, 100
            MOVE G6B,80,  30,  80
            MOVE G6C,120,  30,  80
            WAIT

        NEXT i

    NEXT j


    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    RETURN

    '**********************************************
    '**********************************************
����ü��_11: '�ȴٸ��


    FOR i = 1 TO 4
        SPEED 12
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,100,  100,  100
        MOVE G6C,100,  100,  100
        WAIT


        SPEED 10
        MOVE G6A,100, 140,  37, 140, 100, 100
        MOVE G6D,100, 140,  37, 140, 100, 100
        MOVE G6B,160,  20,  40
        MOVE G6C,160,  20,  40
        WAIT


        SPEED 10
        MOVE G6A,100, 143,  28, 142, 100, 100
        MOVE G6D,100, 143,  28, 142, 100, 100
        MOVE G6B,160,  20,  40
        MOVE G6C,160,  20,  40
        WAIT


        DELAY 100

        SPEED 8
        MOVE G6A,100, 137,  37, 140, 100, 100
        MOVE G6D,100, 137,  37, 140, 100, 100
        WAIT

        SPEED 10
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,100,  100,  100
        MOVE G6C,100,  100,  100
        WAIT

    NEXT i

    RETURN

    '**********************************************
    '**********************************************
����ü��_12: '������


    SPEED 12
    MOVE G6A,100, 60, 178, 76, 100, 100
    MOVE G6D,100, 60, 178, 76, 100, 100
    MOVE G6C,100,  185,  130
    MOVE G6B,100,  185,  130
    WAIT


    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    SPEED 10
    MOVE G6A,100, 60, 178, 76, 100, 100
    MOVE G6D,100, 60, 178, 76, 100, 100
    MOVE G6C,100,  185,  130
    MOVE G6B,100,  185,  130
    WAIT
    '******************

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    SPEED 8
    MOVE G6A,100, 60, 178, 76, 100, 100
    MOVE G6D,100, 60, 178, 76, 100, 100
    MOVE G6C,100,  185,  130
    MOVE G6B,100,  185,  130
    WAIT
    '******************
    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    SPEED 6
    MOVE G6A,100, 60, 178, 76, 100, 100
    MOVE G6D,100, 60, 178, 76, 100, 100
    MOVE G6C,100,  185,  130
    MOVE G6B,100,  185,  130
    WAIT
    '******************

    SPEED 4
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT
    '******************
    SPEED 4
    MOVE G6A,100, 60, 178, 76, 100, 100
    MOVE G6D,100, 60, 178, 76, 100, 100
    MOVE G6C,100,  185,  130
    MOVE G6B,100,  185,  130
    WAIT
    '******************

    SPEED 2
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT



    RETURN

    '**********************************************
    '**********************************************
    '**********************************************
    '**** ī�޶����� ******************************
����ڼ�:
    GOSUB All_motor_mode3

    SPEED 12
    MOVE G6A, 88,  71, 152,  91, 110, 100
    MOVE G6D,112,  76, 146,  93,  92, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT


    SPEED 10
    MOVE G6A, 90,  98, 105,  115, 115, 100
    MOVE G6D,114,  74, 145,  98,  93, 100
    MOVE G6B,100,  150,  150
    MOVE G6C,100,  150,  150
    WAIT

    SPEED 6
    MOVE G6A, 90, 121,  36, 105, 115,  100
    MOVE G6D,114,  60, 146, 138,  93,  100
    WAIT

    SPEED 6
    GOSUB Leg_motor_mode2
    MOVE G6A, 90,  98, 135,  44, 115,  100
    MOVE G6D,114,  45, 170, 160,  93,  100
    MOVE G6B,170,  120,  120 , , , 60
    MOVE G6C,170,  120,  120
    WAIT

����ڼ�_WAIT:
    ERX 4800,A,����ڼ�_WAIT
    IF A <> 26 THEN
        GOSUB ������
        GOTO ����ڼ�_WAIT
    ENDIF

    SPEED 4
    MOVE G6A, 85,  98, 105,  115, 115, 100
    MOVE G6D,115,  74, 145,  98,  93, 100
    MOVE G6B,100,  150,  150, , , 100
    MOVE G6C,100,  150,  150
    WAIT

    SPEED 8
    MOVE G6A, 85,  71, 152,  91, 110, 100
    MOVE G6D,108,  76, 146,  93,  92, 100
    MOVE G6B,100,  70,  80
    MOVE G6C,100,  70,  80
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  35,  80
    MOVE G6C,100,  35,  80
    WAIT

    SPEED 2
    GOSUB �⺻�ڼ�	
    GOSUB All_motor_Reset



    RETURN
    '**********************************************
�������ڼ�:

    SPEED 6
    MOVE G6B, 120,  40,  90
    MOVE G6C, 120,  40,  90
    WAIT

    SPEED 6
    MOVE G6A,  70,  78, 141, 95, 127, 100
    MOVE G6D,  97, 107,  93, 116, 102, 100
    MOVE G6B, 145,  66,  87, , ,  50
    MOVE G6C, 170,  15,  32, , ,
    WAIT

    GOSUB All_motor_mode3
�������ڼ�_WAIT:
    ERX 4800,A,�������ڼ�_WAIT
    IF A <> 26 THEN
        GOSUB ������
        GOTO �������ڼ�_WAIT
    ENDIF
    GOSUB All_motor_Reset
    SPEED 6
    MOVE G6B, 120,  40,  90
    MOVE G6C, 120,  40,  90
    WAIT
    SPEED 8
    GOSUB �⺻�ڼ�

    RETURN
    '**********************************************
������ڼ�:

    SPEED 8
    MOVE G6A, 63, 76,  160, 85, 130	
    MOVE G6D, 88, 125,  70, 120, 115
    MOVE G6B,100,  70,  100, , ,  150
    MOVE G6C,100, 125, 108
    WAIT

    GOSUB All_motor_mode3
������ڼ�_WAIT:
    ERX 4800,A,������ڼ�_WAIT
    IF A <> 26 THEN
        GOSUB ������
        GOTO ������ڼ�_WAIT
    ENDIF
    GOSUB All_motor_Reset
    SPEED 8
    GOSUB �⺻�ڼ�


    RETURN
    '**********************************************
�ѹߵ���ڼ�:
    GOSUB Leg_motor_mode2

    SPEED 8
    MOVE G6D,112,  77, 146,  93,  92, '60	
    MOVE G6A, 80,  71, 152,  91, 112,' 60
    MOVE G6C,100,  100,  100, , , ,
    MOVE G6B,100,  100,  100, , , ,	
    WAIT
    SPEED 8
    MOVE G6D,113,  77, 146,  93,  92, 100	
    MOVE G6A,80,  150,  27, 140, 114, 100
    MOVE G6C,100,  100,  100, , ,
    MOVE G6B,100,  100,  100, , , 100
    WAIT
    GOSUB All_motor_mode3
�ѹߵ���ڼ�_WAIT:
    ERX 4800,A,�ѹߵ���ڼ�_WAIT
    IF A <> 26 THEN
        GOSUB ������
        GOTO �ѹߵ���ڼ�_WAIT
    ENDIF

    GOSUB Leg_motor_mode2

    SPEED 8
    MOVE G6D,112,  77, 146,  93,  92, 100		
    MOVE G6A, 80, 88, 125, 100, 115, 100
    MOVE G6B,100,  100,  100, , , ,
    MOVE G6C,100,  100,  100, , , ,
    WAIT

    SPEED 4
    GOSUB �⺻�ڼ�
    GOSUB Leg_motor_mode1

    RETURN
    '**********************************************
�������ڼ�:
    GOSUB Leg_motor_mode3
    SPEED 4

    MOVE G6A,110,  77, 145,  93,  92, 100	
    MOVE G6D, 85,  71, 152,  91, 114, 100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT

    SPEED 10
    MOVE G6A,113,  75, 145,  100,  95	
    MOVE G6D, 83,  85, 122,  105, 114
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 15
    MOVE G6A,113,  73, 145,  85,  95	
    MOVE G6D, 83,  20, 172,  155, 114
    MOVE G6C,50
    MOVE G6B,150
    WAIT
�������ڼ�_WAIT:
    ERX 4800,A,�������ڼ�_WAIT
    IF A <> 26 THEN
        GOSUB ������
        GOTO �������ڼ�_WAIT
    ENDIF

    SPEED 10
    MOVE G6A,113,  72, 145,  97,  95
    MOVE G6D, 83,  58, 122,  130, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT	

    SPEED 8
    MOVE G6A,113,  77, 145,  95,  95	
    MOVE G6D, 80,  80, 142,  95, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT	

    SPEED 8
    MOVE G6A,110,  77, 145,  93,  93, 100	
    MOVE G6D, 80,  71, 152,  91, 114, 100
    WAIT


    SPEED 3
    GOSUB �⺻�ڼ�	
    GOSUB Leg_motor_mode1



    RETURN
    '**********************************************
�����ڼ�:
    SPEED 6
    MOVE G6C, 100,  40,  90
    MOVE G6B, 150,  40,  90
    WAIT
    SPEED 10
    MOVE G6C,100,  100,  100,
    MOVE G6B,190,  15,  15, , , 100
    WAIT

    GOSUB All_motor_mode3
    SPEED 8
    MOVE G6A,96,  106, 89,  123, 130, 100
    MOVE G6D,85,  76, 145,  93, 85, 100
    MOVE G6C,100,  110,  110,
    MOVE G6B,160,  15,  20, , , 160
    WAIT

�����ڼ�_WAIT:
    ERX 4800,A,�����ڼ�_WAIT
    IF A <> 26 THEN
        GOSUB ������
        GOTO �����ڼ�_WAIT
    ENDIF

    SPEED 6
    MOVE G6C, 100,  40,  90
    MOVE G6B, 150,  40,  90, , , 100
    WAIT
    GOSUB Leg_motor_mode2
    SPEED 6
    GOSUB �⺻�ڼ�	
    GOSUB Leg_motor_mode1
    RETURN
    '**********************************************
������ڼ�:
    GOSUB Leg_motor_mode2
    GOSUB Arm_motor_mode3

    SPEED 3
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80, , ,100
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    WAIT


    SPEED 5
    MOVE G6A, 80,  74, 146, 94, 116, 100
    MOVE G6D,108,  81, 137,  98, 98, 100
    MOVE G6B,100,  70,  90
    MOVE G6C,100,  70,  90	
    WAIT

    SPEED 5
    MOVE G6A,94,  76, 145,  93, 106, 100
    MOVE G6D,94,  76, 145,  93, 106, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT	

    SPEED 4
    MOVE G6C,100,  150,  140
    MOVE G6B,100,  100,  100, , ,70
    MOVE G6D, 95,  94, 145,  45, 107,
    MOVE G6A, 89,  94, 145,  45, 113,
    WAIT


������ڼ�_WAIT:
    ERX 4800,A,������ڼ�_WAIT
    IF A <> 26 THEN
        GOSUB ������
        GOTO ������ڼ�_WAIT
    ENDIF
    GOSUB Leg_motor_mode2

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 95, 100
    MOVE G6D,100,  76, 145,  93, 95, 100
    MOVE G6B,100,  30,  80, , ,100
    MOVE G6C,100,  30,  80
    WAIT
    SPEED 5
    GOSUB �⺻�ڼ�



    RETURN
    '**********************************************
�����ڼ�:

    GOSUB Leg_motor_mode3
    SPEED 4
    '���ʱ���
    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6C, 100,35
    MOVE G6B, 100,35
    WAIT

    SPEED 10'����ӵ�
    '�����ߵ��
    MOVE G6D, 90, 100, 115, 105, 114
    MOVE G6A,113,  78, 146,  93,  94
    MOVE G6C,70,35
    MOVE G6B,130,30
    WAIT

�����ڼ�_WAIT:
    ERX 4800,A,�����ڼ�_WAIT
    IF A <> 26 THEN
        GOSUB ������
        GOTO �����ڼ�_WAIT
    ENDIF

    SPEED 5

    '���ʱ���2
    MOVE G6A, 106,  76, 146,  93,  96		
    MOVE G6D,  88,  71, 152,  91, 106
    MOVE G6B, 100,35
    MOVE G6C, 100,35
    WAIT	


    SPEED 3
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN

    '******************************************
�̾����ڼ�:
    GOSUB Arm_motor_mode3
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  185,  170
    WAIT	
    SPEED 4
    MOVE G6B,100,  30,  80, , ,130
    MOVE G6C,90,  170,  185
    WAIT

�̾����ڼ�_WAIT:
    ERX 4800,A,�̾����ڼ�_WAIT
    IF A <> 26 THEN
        GOSUB ������
        GOTO �̾����ڼ�_WAIT
    ENDIF

    SPEED 8
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset

    RETURN

    '**********************************************

    '***************************************
CODE_EVENT_ALL_STOP:
    PRINT "EVENT_ALL_STOP !"
    PRINT "STOP !"
    SPEED 8
    MOVE G6B,, 40, 90, , , 100
    MOVE G6C,, 40, 90
    WAIT
    SPEED 4
    GOSUB �⺻�ڼ�
    RETURN

    '**********************************************
    '**********************************************
    '**********************************************
MF�Ұ�1��9��:
    PRINT "VOLUME 200 !"

    PRINT "OPEN INFO.MRS !"
    IF info_index = 0 THEN	'KOREA
        PRINT "SOUND 0 !"
        '                     1  2  3   4   5   6   7   8   9  10  11  12  13  14  15
        PRINT "CODE_EVENT 101 1 65 105 165 215 295 370 446 519 575 589 597 606 645 689 !"

    ELSEIF info_index = 1 THEN	'CHIN
        PRINT "SOUND 1 !"
        '                     1  2  3   4   5   6   7   8   9  10  11  12  13  14
        PRINT "CODE_EVENT 101 1 65 105 146 215 310 370 446 519 575 589 597 606 670 !"

    ELSEIF info_index = 2 THEN 'JAPAN
        PRINT "SOUND 2 !"
        '                     1  2  3   4   5   6   7   8   9  10  11  12  13  14
        PRINT "CODE_EVENT 101 1 65 120 146 170 232 336 399 442 522 596 656 !"
    ELSEIF info_index = 3 OR info_index = 4 THEN 'English

        '                     1  2  3   4   5   6   7   8   9  10  11  12  13  14
        PRINT "CODE_EVENT 101 1 65 100 123 185 228 268 371 464 584 625 !" '658 !"
        PRINT "TRS !"'"TIMER_SET !"

        IF info_index = 3 THEN
            PRINT "SOUND 3 !"
        ENDIF
        IF info_index = 4 THEN
            PRINT "SOUND 4 !"
        ENDIF
    ENDIF

MF�Ұ�1��9��_LOOP:
	GOSUB �յڱ�������
    ERX 4800,A,MF�Ұ�1��9��_LOOP

    IF A >= 100 THEN
        A_OLD  = A
        A = A - 100
        ON A GOTO MF�Ұ�1��9��_LOOP,MF�Ұ�1��9��_1,MF�Ұ�1��9��_2,MF�Ұ�1��9��_3,MF�Ұ�1��9��_4,MF�Ұ�1��9��_5,MF�Ұ�1��9��_6,MF�Ұ�1��9��_7,MF�Ұ�1��9��_8,MF�Ұ�1��9��_9,MF�Ұ�1��9��_10,MF�Ұ�1��9��_11,MF�Ұ�1��9��_12,MF�Ұ�1��9��_13,MF�Ұ�1��9��_14
        GOTO MF�Ұ�1��9��_LOOP
    ELSE
        IF A = 26  THEN
            GOSUB CODE_EVENT_ALL_STOP
            GOSUB MR_SOUND_OPEN
            RETURN
        ELSEIF A = 11  THEN
            PRINT "UP 20 !"
        ELSEIF A = 12  THEN
            PRINT "DOWN 20 !"
        ENDIF
    ENDIF
    GOTO MF�Ұ�1��9��_LOOP


    '***************************************
MF�Ұ�1��9��_1:

    GOSUB �λ�4
    GOSUB ������
    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_2:
    GOSUB �Ұ��׼�

    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_3:
    IF info_index = 0 THEN 'KOREA
        �ݺ�Ƚ�� = 6
    ELSEIF info_index = 1 THEN 'CHIN
        �ݺ�Ƚ�� = 4
    ELSEIF info_index = 2 THEN  'JAPAN
        �ݺ�Ƚ�� = 2
    ELSEIF info_index = 3 OR info_index = 4   THEN  'English
        GOSUB ����

        GOTO MF�Ұ�1��9��_LOOP
    ENDIF

    GOSUB �Ұ����ڸ�����
    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_4:

    IF info_index = 0 THEN 'KOREA
        �ݺ�Ƚ�� = 4
    ELSEIF info_index = 1 THEN 'CHIN
        �ݺ�Ƚ�� = 4
    ELSEIF info_index = 2 THEN  'JAPAN
        �ݺ�Ƚ�� = 2
    ELSEIF info_index = 3 OR info_index = 4   THEN  'English
        GOSUB �ȳ���
        DELAY 200
        GOSUB ��
        DELAY 200
        GOSUB �����ڵ�_E
        GOTO MF�Ұ�1��9��_LOOP

    ENDIF
    GOSUB �����������ڸ�
    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_5:
    IF info_index = 0 OR info_index = 1 THEN 'KOREA,'CHIN
        GOSUB �����������α׷����
    ELSEIF info_index = 2 THEN 'JAPAN
        GOSUB �Ϻ�17�����̿뵿�۴�
    ELSEIF info_index = 3 OR info_index = 4   THEN  'English
        �ݺ�Ƚ�� = 2
        'DELAY 200
        GOSUB ���ڸ�����
        GOSUB �����������ڸ�

    ENDIF
    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_6:
    IF info_index = 0 THEN 'KOREA
        GOSUB ������
        GOSUB ���׼�
        DELAY 250
        GOSUB �ø������
    ELSEIF info_index = 1 THEN 'CHIN
        GOSUB �ø������
        DELAY 250
        GOSUB ���׼�
    ELSEIF info_index = 2 THEN  'JAPAN
        GOSUB �����������κ����Դϴ�
    ELSEIF info_index = 3 OR info_index = 4   THEN  'English
        GOSUB �����������α׷����_E

    ENDIF

    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_7:
    IF info_index = 3 OR info_index = 4 THEN 'English
        GOSUB ������
        GOSUB �ø������
        DELAY 250
        GOSUB ���׼�
        GOTO MF�Ұ�1��9��_LOOP
    ENDIF
    GOSUB �����Ұ��ϴ°�ó��
    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_8:

    IF info_index = 3 OR info_index = 4 THEN 'English
        GOSUB �����Ұ��ϴ°�ó��_E
        GOSUB ��̸�����Ű��

        GOTO MF�Ұ�1��9��_LOOP
        'GOSUB �����ڵ�_C
    ENDIF
    GOSUB ������

    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_9:
    IF info_index = 3 OR info_index = 4 THEN 'English
        GOSUB ���¾����α����
        GOSUB ������

        GOTO MF�Ұ�1��9��_LOOP
    ENDIF
    GOSUB ���¾����α����
    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_10:
    IF info_index = 0 OR info_index = 1 THEN'KOREA,'CHIN
        GOSUB ����
    ELSEIF info_index = 2 THEN 'JAPAN
        GOSUB ����
        DELAY 300
        GOSUB �ȳ���
        DELAY 300
        GOSUB ��
        DELAY 300
        GOSUB �����ڵ�
    ELSEIF info_index = 3 OR info_index = 4 THEN 'English
        GOSUB ���¸��������������
    ENDIF
    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_11:
    IF info_index = 0 OR info_index = 1 THEN'KOREA,'CHIN
        GOSUB �ȳ���

    ELSEIF info_index = 3 OR info_index = 4 THEN 'English
        GOSUB ����Ȱ�����
        RETURN
    ENDIF
    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_12:
    IF info_index = 0 OR info_index = 1 THEN'KOREA,'CHIN
        GOSUB ��

    ELSEIF info_index = 2 THEN 'JAPAN
        GOSUB ����Ȱ�����
        GOSUB MR_SOUND_OPEN
        RETURN
    ENDIF
    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_13:
    IF info_index = 0 THEN 'KOREA
        GOSUB �����ڵ�
    ELSEIF info_index = 1 THEN 'CHIN
        GOSUB �����ڵ�_C
    ELSEIF info_index = 2 THEN  'JAPAN

    ENDIF

    GOTO MF�Ұ�1��9��_LOOP
    '*********
MF�Ұ�1��9��_14:
    IF info_index = 0 THEN 'KOREA
        GOSUB ����Ȱ�����
    ELSEIF info_index = 1 THEN 'CHIN
        GOSUB ����Ȱ�����_C
    ELSEIF info_index = 2 THEN  'JAPAN

    ENDIF

    GOSUB MR_SOUND_OPEN
    RETURN

    GOTO MF�Ұ�1��9��_LOOP
    '*********


    '***************************************
�λ�4:
    GOSUB All_motor_mode3

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  60,  80
    MOVE G6B,160,  35,  80
    WAIT

    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    '�λ�
    SPEED 8
    MOVE G6A,100,  55, 145,  145, 100, 100
    MOVE G6D,100,  55, 145,  145, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    DELAY 1000
    '�Ͼ��

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,140,  40,  80
    WAIT

    SPEED 12
    GOSUB �⺻�ڼ�

    RETURN
    '***************************************
������:
    GOSUB All_motor_mode3

    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,140,  30,  80
    MOVE G6C,140,  30,  80
    WAIT
    DELAY 400

    SPEED 3
    MOVE G6B,160,  90,  90, , ,60
    MOVE G6C,160,  90,  90
    WAIT

    DELAY 600
    SPEED 8
    GOSUB �⺻�ڼ�
    RETURN


    '***************************************
���׼�:
    GOSUB All_motor_mode3

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  55,  40
    MOVE G6C,100,  55,  40
    WAIT

    SPEED 6
    MOVE G6A,98, 88, 122, 105, 117
    MOVE G6D,101, 67, 162, 86, 83
    MOVE G6B,100,  60,  40
    MOVE G6C,100,  35,  50
    WAIT

    DELAY 100

    SPEED 8
    MOVE G6D,98, 88, 122, 105, 117
    MOVE G6A,101, 67, 162, 86, 83
    MOVE G6C,100,  60,  40
    MOVE G6B,100,  35,  50
    WAIT
    RETURN
    '***************************************
�Ұ��׼�:

    GOSUB ���׼�

    DELAY 800

    SPEED 8
    MOVE G6A,98, 88, 122, 105, 117
    MOVE G6D,101, 67, 162, 86, 83
    MOVE G6B,100,  80,  15, , ,150
    MOVE G6C,100,  130,  100
    WAIT

    DELAY 1000

    '***************

    SPEED 12
    GOSUB �⺻�ڼ�



    RETURN
    '*******************************************
    '******************************************
�Ұ����ڸ�����:
    �Ѿ���Ȯ�� = 0
    '    GOSUB Arm_motor_mode3
    'GOSUB Leg_motor_mode3
    MOTORMODE G6A,2,3,3,3,2
    MOTORMODE G6D,2,3,3,3,2

    MOVE G6B,,35
    MOVE G6C,,35
    WAIT
    I = 0
�Ұ����ڸ�����_1:

    SPEED 4
    MOVE G6A,105,  76, 146,  93, 98, 100
    MOVE G6D,90,  73, 151,  90, 108, 100
    WAIT

    SPEED 12
    MOVE G6A,113,  76, 146,  93, 98, 100
    MOVE G6D,85,  100, 95,  120, 112, 100
    MOVE G6B,120 , , , , ,90
    MOVE G6C,80
    WAIT

    'GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        RETURN
    ENDIF

    SPEED 10
    MOVE G6A,109,  76, 146,  93, 97, 100
    MOVE G6D,90,  76, 148,  92, 110, 100
    WAIT

    SPEED 4	
    MOVE G6A,98,  76, 146,  93, 100, 100
    MOVE G6D,98,  76, 146,  93, 100, 100	
    WAIT

    I = I + 1
    'ERX 4800,A, ���ڸ�����_2
    IF I >= �ݺ�Ƚ�� THEN
        SPEED 5
        GOSUB �⺻�ڼ�
        RETURN
    ENDIF

�Ұ����ڸ�����_2:
    '***********************************
    SPEED 4
    MOVE G6D,105,  76, 146,  93, 98, 100
    MOVE G6A,90,  73, 151,  90, 108, 100
    WAIT	

    SPEED 12
    MOVE G6D,113,  76, 146,  93, 98, 100
    MOVE G6A,85,  100, 95,  120, 112, 100
    MOVE G6C,120
    MOVE G6B,80 , , , , ,110
    WAIT	

    ' GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        RETURN
    ENDIF

    SPEED 10
    MOVE G6D,109,  76, 146,  93, 97, 100
    MOVE G6A,90,  76, 148,  92, 110, 100
    WAIT	

    SPEED 4		
    MOVE G6D,98,  76, 146,  93, 100, 100
    MOVE G6A,98,  76, 146,  93, 100, 100	
    WAIT	
    I = I + 1
    'ERX 4800,A, ���ڸ�����_1
    IF I >= �ݺ�Ƚ�� THEN
        SPEED 5
        GOSUB �⺻�ڼ�
        RETURN
    ENDIF

    GOTO �Ұ����ڸ�����_1


    RETURN
    '**********************************************	
    '************************************************
�����������ڸ�:
    MOTORMODE G6A,3,2,2,2,3
    MOTORMODE G6D,3,2,2,2,3
    MOTORMODE G6B,3,3,3, , ,3
    MOTORMODE G6C,3,3,3


    SPEED 10
    GOSUB �����������ڸ�_�ʱ��ڼ�

    HIGHSPEED SETON
    SPEED 15
    MOVE G6A,95,  110, 87,  120, 100, 100
    MOVE G6D,103,  110, 87,  120, 100, 100
    MOVE G6B,100,  35,  80, , ,100
    MOVE G6C,100,  35,  80
    WAIT


    SPEED 12
    FOR I = 1 TO �ݺ�Ƚ��
        MOVE G6D,103,  110, 89,  120, 98, 100
        MOVE G6A,95,  120, 67,  125, 105, 100
        MOVE G6C,120
        MOVE G6B,80
        WAIT

        MOVE G6D,98,  110, 88,  120, 102, 100
        MOVE G6A,101,  110, 88,  120, 102, 100
        WAIT

        MOVE G6A,103,  110, 89,  120, 98, 100
        MOVE G6D,95,  120, 67,  125, 105, 100
        MOVE G6B,120
        MOVE G6C,80
        WAIT

        MOVE G6A,98,  110, 88,  120, 102, 100
        MOVE G6D,101,  110, 88,  120, 102, 100
        WAIT

    NEXT I


    SPEED 15
    GOSUB �����������ڸ�_�ʱ��ڼ�
    DELAY 200
    HIGHSPEED SETOFF
    GOSUB Arm_motor_mode3
    SPEED 10
    GOSUB �⺻�ڼ�
    RETURN
    '************************************************
�����������ڸ�_�ʱ��ڼ�:
    MOVE G6A,100,  110, 87,  120, 100, 100
    MOVE G6D,100,  110, 87,  120, 100, 100
    MOVE G6B,100,  35,  80, , ,100
    MOVE G6C,100,  35,  80
    WAIT
    RETURN
    '************************************************
�����������α׷����:
    GOSUB �����������α׷����_1
    DELAY 1200

    GOSUB �����������α׷����_2
    DELAY 200


    SPEED 6
    FOR I = 1 TO 2
        MOVE G6A,100,  76, 145,  88, 100, 100
        MOVE G6D,100,  76, 145,  88, 100, 100
        MOVE G6C,190,  20,  80
        MOVE G6B,170,  20,  80, , ,100
        WAIT

        MOVE G6C,170,  20,  80
        MOVE G6B,190,  20,  80
        WAIT
    NEXT I

    GOSUB �����������α׷����_3

    RETURN
    '***************************************
�����������α׷����_1:
    GOSUB All_motor_mode3
    SPEED 10
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�

    SPEED 12
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  35,  20
    WAIT
    RETURN
    '***************************************
�����������α׷����_2:
    SPEED 12
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  85,  90, , ,70
    WAIT
    DELAY 200

    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,160,  85,  90
    MOVE G6B,160,  85,  90, , ,130
    WAIT

    RETURN
    '***************************************
�����������α׷����_3:
    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  50,  80, , ,130
    MOVE G6C,80,  170,  180
    WAIT
    DELAY 100

    SPEED 3
    MOVE G6B,100,  50,  80, , ,70
    MOVE G6C,80,  150,  190
    WAIT
    DELAY 100

    SPEED 10
    GOSUB �⺻�ڼ�

    RETURN
    '***************************************
�����������α׷����_E:
    GOSUB �����������α׷����_1
    DELAY 300
    GOSUB �����������α׷����_2
    GOSUB �����������α׷����_3
    RETURN
    '************************************************
�Ϻ�17�����̿뵿�۴�:
    GOSUB All_motor_mode3
    SPEED 10
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�

    SPEED 12
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  35,  20
    WAIT
    DELAY 50

    SPEED 12
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  85,  90, , ,70
    WAIT
    DELAY 50

    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,160,  85,  90
    MOVE G6B,160,  85,  90, , ,130
    WAIT
    DELAY 50


    SPEED 10
    FOR I = 1 TO 2
        MOVE G6A,100,  76, 145,  88, 100, 100
        MOVE G6D,100,  76, 145,  88, 100, 100
        MOVE G6C,190,  20,  80
        MOVE G6B,170,  20,  80, , ,100
        WAIT

        MOVE G6C,170,  20,  80
        MOVE G6B,190,  20,  80
        WAIT
    NEXT I

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  50,  80, , ,130
    MOVE G6C,80,  170,  180
    WAIT
    DELAY 50

    SPEED 8
    MOVE G6B,100,  50,  80, , ,70
    MOVE G6C,80,  150,  190
    WAIT

    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  55,  40
    MOVE G6C,100,  55,  40
    WAIT

    SPEED 6
    MOVE G6A,98, 88, 122, 105, 117
    MOVE G6D,101, 67, 162, 86, 83
    MOVE G6B,100,  60,  40
    MOVE G6C,100,  35,  50
    WAIT

    DELAY 50

    SPEED 8
    MOVE G6D,98, 88, 122, 105, 117
    MOVE G6A,101, 67, 162, 86, 83
    MOVE G6C,100,  60,  40
    MOVE G6B,100,  35,  50
    WAIT
    RETURN

    '***************************************
�����������κ����Դϴ�:
    GOSUB All_motor_mode3
    SPEED 10
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�

    SPEED 10
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�2
    DELAY 700

    SPEED 12
    MOVE G6C,40,  150,  190
    MOVE G6B,40,  150,  190, , ,100
    WAIT
    DELAY 400

    SPEED 6
    MOVE G6A,100,  76, 145,  88, 100, 100
    MOVE G6D,100,  76, 145,  88, 100, 100
    MOVE G6C,40,  170,  120
    MOVE G6B,40,  170,  120, , ,100
    WAIT

    DELAY 400

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,80,  160,  190
    MOVE G6B,80,  160,  190, , , 130
    WAIT
    DELAY 400
    MOVE G6C,80,  130,  120
    MOVE G6B,80,  160,  190, , , 130
    WAIT
    DELAY 100
    SPEED 8
    MOVE G6A,100,  76, 145,  88, 100, 100
    MOVE G6D,100,  76, 145,  88, 100, 100
    MOVE G6C,80,  130,  120
    MOVE G6B,80,  130,  120, , , 70
    WAIT

    DELAY 400
    SPEED 8
    MOVE G6C,160,  40,  25
    MOVE G6B,160,  40,  25, , ,100
    WAIT
    DELAY 200
    SPEED 4
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�2
    DELAY 200
    SPEED 6
    GOSUB �⺻�ڼ�

    RETURN



    '***************************************
    '***************************************
�ø������:
    GOSUB All_motor_mode3


    SPEED 12
    MOVE G6A,100,  54, 145,  145, 100, 100
    MOVE G6D,100,  54, 145,  145, 100, 100
    MOVE G6B,50,  40,  90, , ,110
    MOVE G6C,190,  40,  90
    WAIT
    DELAY 100

    SPEED 15
    MOVE G6C,50,  40,  90
    MOVE G6B,190,  40,  90, , ,90
    WAIT
    DELAY 100

    SPEED 10
    GOSUB �⺻�ڼ�
    RETURN

    '***************************************
�����Ұ��ϴ°�ó��:
    GOSUB All_motor_mode3
    SPEED 12
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�

    SPEED 10
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  35,  20
    WAIT
    DELAY 700

    SPEED 8
    MOVE G6C,180,  25,  80
    MOVE G6B,180,  25,  80
    WAIT
    DELAY 400

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,80,  160,  190
    MOVE G6B,80,  160,  190, , , 130
    WAIT
    DELAY 400
    MOVE G6C,80,  130,  120
    MOVE G6B,80,  160,  190, , , 130
    WAIT
    DELAY 100
    SPEED 10
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�
    SPEED 12
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  35,  20
    WAIT
    DELAY 50
    SPEED 4
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�2
    DELAY 100
    SPEED 10
    GOSUB �⺻�ڼ�

    RETURN
    '***************************************
    '***************************************
�����Ұ��ϴ°�ó��_E:
    GOSUB All_motor_mode3
    SPEED 12
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�

    SPEED 10
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  35,  20
    WAIT
    DELAY 300

    SPEED 8
    MOVE G6C,180,  25,  80
    MOVE G6B,180,  25,  80
    WAIT
    DELAY 300

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,80,  160,  190
    MOVE G6B,80,  160,  190, , , 130
    WAIT
    DELAY 200
    MOVE G6C,80,  130,  120
    MOVE G6B,80,  160,  190, , , 130
    WAIT
    DELAY 100
    SPEED 10
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�
    SPEED 12
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  35,  20
    WAIT
    DELAY 50
    SPEED 6
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�2
    DELAY 100
    SPEED 10
    GOSUB �⺻�ڼ�

    RETURN
    '***************************************
�����Ұ��ϴ°�ó��_�ʱ��ڼ�:
    MOVE G6A,100,  76, 145,  88, 100, 100
    MOVE G6D,100,  76, 145,  88, 100, 100
    MOVE G6C,160,  30,  80
    MOVE G6B,160,  30,  80
    WAIT
    RETURN

    '***************************************
�����Ұ��ϴ°�ó��_�ʱ��ڼ�2:
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,160,  90,  90, , ,60
    MOVE G6C,160,  90,  90
    WAIT
    RETURN

    '***************************************
������:
    GOSUB All_motor_mode3
    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,160,  30,  80
    MOVE G6B,100,  30,  80, , , 120
    WAIT

    SPEED 10
    MOVE G6C,170,  20,  10
    MOVE G6B,100,  30,  80
    WAIT
    DELAY 100
    SPEED 12
    MOVE G6C,130,  30,  80
    WAIT
    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  55,  40
    MOVE G6C,100,  55,  40
    WAIT

    SPEED 10

    SERVO 11,70
    GOSUB ������_�ڼ�1

    GOSUB ������_�ڼ�2

    SERVO 11,130
    GOSUB ������_�ڼ�1

    GOSUB ������_�ڼ�2


    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  160,  150
    MOVE G6B,100,  160,  150, , , 120
    WAIT

    SPEED 12
    FOR I = 1 TO 2

        SERVO 11,80
        GOSUB ������_�ڼ�3


    NEXT I

    FOR I = 1 TO 2
        SERVO 11,120
        GOSUB ������_�ڼ�3

    NEXT I
    DELAY 100
    SPEED 15
    MOVE G6D,98, 88, 122, 105, 117
    MOVE G6A,101, 67, 162, 86, 83
    MOVE G6C,80,  170,  180
    MOVE G6B,100,  120,  100, , ,150
    WAIT

    DELAY 600

    SPEED 10
    GOSUB �⺻�ڼ�

    RETURN
    '***************************************
������_�ڼ�1:
    MOVE G6A,100,  110, 87,  120, 100, 100
    MOVE G6D,100,  110, 87,  120, 100, 100
    WAIT

    RETURN
    '***************************************
������_�ڼ�2:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT

    RETURN
    '***************************************
������_�ڼ�3:
    MOVE G6C,100,  130,  130
    MOVE G6B,100,  130,  130
    WAIT

    MOVE G6C,100,  160,  150
    MOVE G6B,100,  160,  150
    WAIT

    RETURN
    '***************************************
���¾����α����:
    GOSUB All_motor_mode3
    SPEED 10
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�

    SPEED 12
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  35,  20
    WAIT
    DELAY 800

    SPEED 12
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  85,  90, , ,130
    WAIT
    DELAY 400

    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,190,  85,  90
    MOVE G6B,190,  85,  90, , ,70
    WAIT
    DELAY 400

    SPEED 4
    MOVE G6A,100,  76, 145,  90, 100, 100
    MOVE G6D,100,  76, 145,  90, 100, 100
    MOVE G6C,180,  20,  10
    MOVE G6B,190,  25,  25, , ,130
    WAIT

    RETURN

    '***************************************
��̸�����Ű��:
    GOSUB All_motor_mode3
    SPEED 10
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�

    SPEED 12
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  35,  20
    WAIT
    DELAY 300

    SPEED 12
    MOVE G6C,160,  35,  20
    MOVE G6B,160,  85,  90, , ,130
    WAIT
    DELAY 100

    SPEED 10
    MOVE G6A,100,  76, 160,  58, 100, 100
    MOVE G6D,100,  76, 160,  58, 100, 100
    MOVE G6C,190,  85,  90
    MOVE G6B,190,  85,  90, , ,70
    WAIT
    DELAY 100

    SPEED 8
    MOVE G6A,100,  76, 125,  125, 100, 100
    MOVE G6D,100,  76, 125,  125, 100, 100
    MOVE G6C,180,  20,  10
    MOVE G6B,190,  25,  25, , ,130
    WAIT

    RETURN

    '***************************************
����:
    SPEED 15
    MOVE G6D,98, 88, 122, 105, 117
    MOVE G6A,101, 67, 162, 86, 83
    MOVE G6C,60,  170,  180
    MOVE G6B,100,  60,  100, , ,150
    WAIT

    RETURN

�ȳ���:
    HIGHSPEED SETON
    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,190,  95,  95, , ,70
    MOVE G6C,180,  15,  15
    WAIT
    HIGHSPEED SETOFF
    RETURN
��:
    SPEED 15
    MOVE G6A,98, 88, 122, 105, 117
    MOVE G6D,101, 67, 162, 86, 83
    MOVE G6B,100,  85,  20, , ,100
    MOVE G6C,100,  60,  30
    WAIT

    RETURN
    '***************************************
�����ڵ�:
    SPEED 15
    GOSUB �����ڵ�_1

    DELAY 2000

    SPEED 10
    GOSUB �����ڵ�_2
    DELAY 500

    SPEED 4
    GOSUB �����ڵ�_3

    MOVE G6B,,  ,  , , ,70
    WAIT

    SPEED 12
    GOSUB �⺻�ڼ�
    RETURN
    '***************************************
�����ڵ�_1:
    MOVE G6D,98, 88, 122, 105, 117
    MOVE G6A,101, 67, 162, 86, 83
    MOVE G6B,70,  160,  190, , ,50
    MOVE G6C,70,  160,  190
    WAIT
    RETURN
    '***************************************
�����ڵ�_2:
    MOVE G6A,100,  76, 145,  90, 100, 100
    MOVE G6D,100,  76, 145,  90, 100, 100
    MOVE G6B,180,  20,  10, , ,70
    MOVE G6C,190,  20,  20
    WAIT
    RETURN
    '***************************************
�����ڵ�_3:
    MOVE G6A,100,  76, 145,  90, 100, 100
    MOVE G6D,100,  76, 145,  90, 100, 100
    MOVE G6B,190,  90,  90, , ,130
    MOVE G6C,190,  90,  90
    WAIT
    RETURN
    '***************************************
�����ڵ�_C:
    SPEED 15
    GOSUB �����ڵ�_1

    DELAY 1000

    SPEED 10
    GOSUB �����ڵ�_2
    DELAY 500

    SPEED 4
    GOSUB �����ڵ�_3

    DELAY 500
    MOVE G6B,,  ,  , , ,70
    WAIT
    DELAY 1000
    SPEED 12
    GOSUB �⺻�ڼ�
    RETURN
    '***************************************
�����ڵ�_E:
    SPEED 15
    GOSUB �����ڵ�_1

    DELAY 150

    SPEED 10
    GOSUB �����ڵ�_2
    DELAY 1500

    SPEED 5
    GOSUB �����ڵ�_3

    DELAY 100
    SPEED 8
    MOVE G6B,,  ,  , , ,70
    WAIT
    'DELAY 500
    SPEED 14
    GOSUB �⺻�ڼ�
    RETURN
    '***************************************
���¸��������������:

    GOSUB All_motor_mode3
    SPEED 10
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�

    SPEED 12
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�2
    DELAY 100

    SPEED 12
    MOVE G6C,40,  150,  190
    MOVE G6B,40,  150,  190, , ,100
    WAIT
    DELAY 100

    SPEED 6
    MOVE G6A,100,  76, 145,  88, 100, 100
    MOVE G6D,100,  76, 145,  88, 100, 100
    MOVE G6C,40,  170,  120
    MOVE G6B,40,  170,  120, , ,100
    WAIT

    DELAY 100

    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,80,  160,  190
    MOVE G6B,80,  160,  190, , , 130
    WAIT

    DELAY 100
    SPEED 10
    MOVE G6A,100,  76, 145,  88, 100, 100
    MOVE G6D,100,  76, 145,  88, 100, 100
    MOVE G6C,80,  130,  120
    MOVE G6B,80,  130,  120, , , 70
    WAIT

    DELAY 100
    SPEED 8
    MOVE G6C,160,  40,  25
    MOVE G6B,160,  40,  25, , ,100
    WAIT
    SPEED 10
    GOSUB �����Ұ��ϴ°�ó��_�ʱ��ڼ�2


    RETURN

    '***************************************

����Ȱ�����:

    GOSUB ����Ȱ�����_1

    DELAY 500

    SPEED 5
    GOSUB ����Ȱ�����_2

    DELAY 1000

    GOSUB ����Ȱ�����_3

    RETURN
    '***************************************
����Ȱ�����_1:
    GOSUB All_motor_mode3
    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,140,  30,  80
    MOVE G6B,140,  30,  80, , ,100
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,140,  30,  30
    MOVE G6B,140,  30,  30, , ,130
    WAIT
    RETURN
    '***************************************
����Ȱ�����_2:
    MOVE G6A,100,  55, 145,  145, 100, 100
    MOVE G6D,100,  55, 145,  145, 100, 100
    MOVE G6C,150,  30,  25
    MOVE G6B,150,  30,  25,
    WAIT
    RETURN
    '***************************************
����Ȱ�����_3:
    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,140,  30,  30
    MOVE G6B,140,  30,  30, , ,100
    WAIT

    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,120,  30,  80
    MOVE G6B,120,  30,  80, , ,100
    WAIT

    SPEED 6
    GOSUB �⺻�ڼ�
    RETURN
    '***************************************
    '***************************************
����Ȱ�����_C:
    GOSUB ����Ȱ�����_1

    SPEED 6
    GOSUB ����Ȱ�����_2
    DELAY 1000

    GOSUB ����Ȱ�����_3

    RETURN



    '***************************************
    '**********************************************
    '**********************************************

����ONOFF_LED:
    IF ����ONOFF = 1  THEN
        OUT 52,1
        DELAY 200
        OUT 52,0
        DELAY 200
    ENDIF
    RETURN
    '**********************************************
LOW_Voltage:

    B = AD(6)

    IF B < �������� THEN
        GOSUB �����

    ENDIF

    RETURN
    '**********************************************
    '******************************************	
MAIN: '�󺧼���


    'GOSUB LOW_Voltage
    GOSUB �յڱ�������
    GOSUB �¿��������


    GOSUB ����ONOFF_LED

    ERX 4800,A,MAIN
    A_old = A

    ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32

    GOTO MAIN	
    '*******************************************
    '		MAIN �󺧷� ����
    '*******************************************
    '*******************************************

KEY1:
    IF Action_mode  = 0 THEN '�����
        info_index = 0	'KOREA
        GOSUB MF�Ұ�1��9��
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOSUB �λ�1
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB ����
        ENDIF

    ELSEIF  Action_mode  = 3 THEN ' �౸���

        IF �ڼ� = 0 THEN
            GOSUB Ű�ۿ��ʸ���
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB ��ܿ޹߿�����3cm
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN
            GOSUB ����ڼ�
        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF �ڼ� = 0 THEN

            GOSUB SOUND_ȫ��1
            GOSUB RND_MOTION
        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY2:
    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            info_index = 1 ''CHIN
            GOSUB MF�Ұ�1��9��
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOSUB �λ�2
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN	
            GOSUB ����
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN	
            GOSUB Ű�����鸷��
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF �ڼ� = 0 THEN
            IF ������������ = 0 THEN
                GOTO ������������
            ELSE
                GOTO ����޸���
            ENDIF
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN
            GOSUB �������ڼ�
        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 AND �ڼ� = 0 THEN

            GOSUB SOUND_ȫ��2
            GOSUB RND_MOTION
        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY3:
    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN	
            info_index = 2 'JAPAN
            GOSUB MF�Ұ�1��9��
        ENDIF

    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOSUB �����׼�
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB ��
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOSUB Ű�ۿ����ʸ���
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB ��ܿ����߿�����3cm
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN
            GOSUB ������ڼ�
        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����

        IF �ڼ� = 0 THEN
            GOSUB SOUND_ȫ��3
            GOSUB RND_MOTION

        ENDIF
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY4:
    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            info_index = 3 'English
            GOSUB MF�Ұ�1��9��
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOSUB �¸��������1
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB û��޼տ÷�
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOSUB ���������
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB ��ܿ޹߳�����3cm
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN
            GOSUB �ѹߵ���ڼ�
        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB SOUND_ȫ��4
            GOSUB RND_MOTION
        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY5:
    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            'GOSUB �����	'13��
            GOSUB ���	'24��
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOSUB �¸��������2
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB ����������
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOSUB ���������
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB �ֻ�������
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN
            GOSUB �������ڼ�
        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB SOUND_ȫ��5
            GOSUB RND_MOTION
        ENDIF

    ENDIF
    GOTO RX_EXIT
    '*******************************************
KEY6:
    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB ���۹��2	'11��
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOSUB �¸��������3
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB �������տ÷�
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOSUB �����������
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB ��ܿ����߳�����3cm
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN
            GOSUB �����ڼ�
        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB SOUND_ȫ��6
            GOSUB RND_MOTION
        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY7:
    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB ������	'6��
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOSUB �й�׼�1
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB û��޼ճ���
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO ������10
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOTO ���������
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN
            GOSUB ������ڼ�
        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB SOUND_ȫ��7
            GOSUB RND_MOTION
        ENDIF
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY8:
    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB �¿�ڵ���	'12��
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOSUB �Ⱦ��ֱ�
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB �ֻ�������
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO ��������50
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOTO ����
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN
            GOSUB �����ڼ�
        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB SOUND_ȫ��8
            GOSUB RND_MOTION
        ENDIF
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY9:

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB �������ϸ��Ͼ��	'7��
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOSUB �й�׼�2
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB �������ճ���
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO ��������10
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOTO �����������
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN
            GOSUB �̾����ڼ�
        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB SOUND_ȫ��9
            GOSUB RND_MOTION
        ENDIF	

    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY10: '0

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB �ͻͼ۴�	'12��
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO ��������ġ
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB �Ŵ��������
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO ������������
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF �ڼ� = 0 THEN
            IF ������������ = 0 THEN
                GOSUB  ��������
            ELSE
                GOSUB ���ǳ���
            ENDIF
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF  �ڼ� = 0 THEN

        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY11: ' ��

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOTO ��������50
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO �����޸���50
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO �����޸���50
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO �����޸���50
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO �����޸���50
            ELSE
                GOTO �����ɾƺ���
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO ����޸���			
            ELSE
                GOTO �����ɾƺ���
            ENDIF		
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF  �ڼ� = 0 THEN
            IF ������������ = 2 THEN
                GOTO �ȳ�������������50
            ELSE
                GOTO ��������50
            ENDIF
        ENDIF

    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY12: ' ��

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOTO ��������50
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO �����޸���40
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO �����޸���40
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO �����޸���40
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO �����޸���40
            ELSE
                GOTO �����ɾƺ���
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO ������������
            ELSE
                GOTO �����ɾƺ���
            ENDIF		
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF  �ڼ� = 0 AND ������������ = 0 THEN
            GOTO ��������50
        ENDIF

    ENDIF



    GOTO RX_EXIT
    '*******************************************
KEY13: '��

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB õõ�������ʿ�����50
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO �����ʿ�����70
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO �����ʿ�����70
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO �����ʿ�����70
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO �����ʿ�����70	
            ELSE
                GOTO �ɾƿ����ʿ�����
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO ��������ʿ�����70	
            ELSE
                GOTO �ɾƿ����ʿ�����
            ENDIF		
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOSUB õõ�������ʿ�����50
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO ��������ʿ�����20
            ENDIF		
        ENDIF
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY14: ' ��

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB  õõ�����ʿ�����50
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO ���ʿ�����70
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO ���ʿ�����70
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO ���ʿ�����70
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO ���ʿ�����70	
            ELSE
                GOTO �ɾƿ��ʿ�����
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO ������ʿ�����70	
            ELSE
                GOTO �ɾƿ��ʿ�����
            ENDIF		
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����

        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOSUB õõ�����ʿ�����50
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO ������ʿ�����20
            ENDIF		
        ENDIF
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY15: ' A

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            PRINT "DATEPLAY !"
            DELAY 500
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO �޼��������
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB �޹߰�����
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOSUB �޹߰�����
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB �޹߰�����
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF �ڼ� = 0 THEN

        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY16: ' POWER
    PRINT "OPEN MRSOUND.mrs !"
    GOSUB MOTOR_OFF
    GOSUB GOSUB_RX_EXIT

KEY16_1:

    GOSUB ����ONOFF_LED	

    ERX 4800,A,KEY16_1
    GOSUB SOUND_STOP
    '**** �׼Ǹ�庯ȯ �� �����ѱ� ****
    IF ����ONOFF = 1 AND A <> 16 THEN
        GOSUB MOTOR_FAST_ON
        GOSUB All_motor_mode3
    ENDIF
    IF A = 16 THEN		'POWER ��ư:�����ڼ����� ���� �ѱ�
        IF ����ONOFF = 1 THEN
            GOSUB MOTOR_ON
        ELSE
            GOSUB MOTOR_OFF
        ENDIF
    ELSEIF A = 27 OR A = 1 THEN	'D ��ư:�����
        Action_mode  = 0
        GOSUB SOUND_�����
        SPEED 10
        MOVE G6B,, 50, 90
        MOVE G6C,, 50, 90
        WAIT

        SPEED 10
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,100, 70, 30, , , 100
        MOVE G6C,100, 70, 30
        WAIT
        'GOSUB �������̸�Ʈ��
    ELSEIF A = 32 OR A = 2 THEN	'F ��ư:����Ʈ���
        Action_mode  = 1
        GOSUB SOUND_�������
        SPEED 10
        MOVE G6B,, 60, 90
        MOVE G6C,, 60, 90
        WAIT     	

        SPEED 8
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,188, 15, 20, , , 100
        MOVE G6C,188, 20, 90
        WAIT
        'GOSUB ����Ʈ��
    ELSEIF A = 23 OR A = 3 THEN	'G ��ư:���Ӹ��
        Action_mode  = 2
        GOSUB SOUND_���Ӹ��
        SPEED 10
        MOVE G6B,, 60, 90
        MOVE G6C,, 60, 90
        WAIT     	

        SPEED 10
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,170, 20, 80, , , 100
        MOVE G6C,140, 20, 80
        WAIT
        'GOSUB ������
    ELSEIF A = 20 OR A = 4 THEN	'B ��ư:�౸���
        Action_mode  = 3
        GOSUB SOUND_�౸���
        SPEED 10
        MOVE G6B,, 60, 90
        MOVE G6C,, 60, 90
        WAIT     	

        SPEED 10
        MOVE G6A,93,  76, 145,  93, 105, 100
        MOVE G6D,105,  76, 145,  93, 96, 100
        MOVE G6B,70, 35, 80, , , 100
        MOVE G6C,140, 35, 80
        WAIT
        'GOSUB �౸������
    ELSEIF A = 18 OR A = 5 THEN	'E ��ư:��ֹ����ָ��
        Action_mode  = 4
        GOSUB SOUND_��ֹ����ָ��
        SPEED 10
        MOVE G6B,, 60, 90
        MOVE G6C,, 60, 90
        WAIT     	

        SPEED 6
        MOVE G6A,100,  71, 145,  113, 100, 100
        MOVE G6D,100,  71, 145,  113, 100, 100
        MOVE G6B,70, 25, 80, , , 100
        MOVE G6C,70, 25, 80
        WAIT
        'GOSUB ��ֹ�������
    ELSEIF A = 17 OR A = 6 THEN ' C: ī�޶���
        Action_mode  = 5
        GOSUB SOUND_ī�޶���
        SPEED 10
        MOVE G6B,100, 60, 90
        MOVE G6C,100, 60, 90
        WAIT     	

        SPEED 10
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,140, 30, 30, , , 80
        MOVE G6C,140, 30, 30
        WAIT
    ELSEIF A = 15 OR A = 7 THEN	'A ��ư: MFȫ����
        Action_mode  = 6
        GOSUB SOUND_ȫ�����
        SPEED 10
        MOVE G6B,, 55, 90
        MOVE G6C,, 55, 90
        WAIT     	

        SPEED 10
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,160, 70, 90, , , 60
        MOVE G6C,180, 30, 20
        WAIT
        'GOSUB ������

    ELSEIF A = 26 THEN	'�� ��ư:�׼Ǹ�庯�� ����
        GOSUB MOTOR_FAST_ON
        SPEED 5
        MOVE G6A,97,  76, 145,  93, 102, 100
        MOVE G6D,97,  76, 145,  93, 102, 100
        WAIT
        SPEED 8
        MOVE G6B,, 50, 90, , , 100
        MOVE G6C,, 50, 90
        WAIT
        GOSUB �⺻�ڼ�
        'GOSUB ������

        GOSUB All_motor_Reset
        GOSUB SOUND_MODE_SELECT
        GOTO RX_EXIT


    ELSEIF A = 21 THEN 	' ���ư: �Ҹ� �ѱ�
        GOSUB SOUND_ALL_ON_MSG
    ELSEIF A = 31 THEN  ' ���ư: �Ҹ� ����
        GOSUB SOUND_ALL_OFF_MSG
    ELSEIF A = 30 THEN  ' ����ư: ������
        GOSUB SOUND_BGM2
        GOSUB SOUND_UP
        GOSUB ������
    ELSEIF A = 28 THEN  ' ����ư: �����ٿ�
        GOSUB SOUND_BGM2
        GOSUB SOUND_DOWN		
        GOSUB ������
    ELSE
        GOSUB ������
    ENDIF

    GOSUB GOSUB_RX_EXIT

    GOTO KEY16_1

    GOTO RX_EXIT

    '*******************************************
KEY17: ' C

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOTO ���Ӵ�1
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO ���ʿ��ڰ���
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO �º��������
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOSUB �������ν���
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOTO �º��������
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 AND �ڼ� = 0 THEN

        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY18: ' E
    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOTO ���մ�1

        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO ���ʿ�����20
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB �޼տ����οø���
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO �º��������
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        GOSUB �ڷ��Ͼ��
        GOTO RX_EXIT
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 AND �ڼ� = 0 THEN

        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************


KEY19: ' P2

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOTO ��������45
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO ��������60
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO ��������45
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO ��������45
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO ��������45	
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO �����������45		
            ENDIF		
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO ��������20	
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO �����������20		
            ENDIF		
        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY20: ' B	

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            PRINT "TIMEPLAY !"
            DELAY 500
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO �������������
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN

            GOSUB �����߰�����
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOSUB �����߰�����
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOSUB �����߰�����
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF �ڼ� = 0 THEN

        ENDIF
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY21: ' ��

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB �����δ���
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO ����ø������
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO �����޸���30
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO ������������
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            GOSUB �����δ���
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF  �ڼ� = 0 THEN

        ENDIF
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY22: ' *	

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN

            GOSUB ������������
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO ������20
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO ������10
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO ������20
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO ������20	
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO ���������20
            ENDIF		
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF �ڼ� = 0 THEN
            IF ������������ = 0 THEN
                GOSUB �ȳ�����
            ENDIF
        ENDIF

    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY23: ' G
    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOTO ����ü������'���մ�3
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO �����ʿ�����20
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOSUB �����տ����οø���
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO �º����������	
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        GOSUB �������Ͼ��
        GOTO RX_EXIT

    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF  �ڼ� = 0 THEN

        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY24: ' #

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOTO �ȵ��ۺ���
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO ��������20
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        GOTO ��������10
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        GOTO ��������20
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO ��������20	
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO �����������20	
            ENDIF		
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF  �ڼ� = 0 THEN
            IF ������������ <> 0 THEN
                GOSUB �ȳ�������
            ENDIF
        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY25: ' P1

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOTO ������45
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO ������60
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO ������45
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO ������45
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO ������45	
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO ���������45
            ENDIF		
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO ������20	
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO ���������20
            ENDIF		
        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY26: ' ��
    GOSUB SOUND_STOP
    IF �ڼ� = 1 THEN GOTO RX_EXIT

    IF Action_mode  = 4 THEN
        IF ������������ = 0 THEN
            SPEED 5
            GOSUB �⺻�ڼ�

        ELSE
            GOSUB Arm_motor_mode3
            SPEED 10
            MOVE G6B, , 60
            MOVE G6C, , 60
            WAIT	
            SPEED 8
            GOSUB �⺻�ڼ�	
        ENDIF
        GOSUB All_motor_Reset
        GOTO RX_EXIT
    ENDIF

    S7 = MOTORIN(7)
    S8 = MOTORIN(8)
    S13 = MOTORIN(13)
    S14 = MOTORIN(14)

    IF S7 < 25 OR S8 < 40 THEN
        SPEED 4
        MOVE G6B,,  50,  100
        MOVE G6C,,  50,  100
        WAIT
    ELSEIF S13 < 25 OR S14 < 40 THEN
        SPEED 4
        MOVE G6B,,  50,  100
        MOVE G6C,,  50,  100
        WAIT	
    ENDIF

    SPEED 5
    GOSUB �⺻�ڼ�	

    GOTO RX_EXIT
    '*******************************************
KEY27: ' D

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOTO ���Ӵ�2
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO �����ʿ��ڰ���
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO �º����������
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOSUB ���������ν���
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF �ڼ� = 0 THEN
            GOTO �º����������
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MFȫ����
        IF �ڼ� = 0 THEN

        ENDIF

    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY28: ' ��


    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB ���ʴ���
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO ���ʿ�����
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO ���ʿ�����20
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO ���ʿ�����20
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO ���ʿ�����20
            ELSE
                GOTO �ɾƿ��ʿ�����
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO ������ʿ�����20
            ELSE
                GOTO �ɾƿ��ʿ�����
            ENDIF		

        ENDIF
    ELSEIF  Action_mode  = 5 THEN 'ī�޶���
        IF �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN 'MFȫ����
        IF �ڼ� = 0 THEN

        ENDIF
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY29: ' ��

    IF Action_mode  = 0 THEN
        GOSUB SOUND_BGM1
        GOSUB ���ڸ�����
        GOSUB SOUND_STOP
        GOTO RX_EXIT
    ENDIF

    IF Action_mode  = 4 THEN
        IF �ڼ� = 0 THEN
            IF  ������������ = 0 THEN
                GOSUB Leg_motor_mode3

                SPEED 10
                MOVE G6A,100, 140,  37, 140, 100, 100
                MOVE G6D,100, 140,  37, 140, 100, 100
                WAIT

                SPEED 3
                GOSUB �����ڼ�	
            ELSE
                GOSUB Leg_motor_mode3

                SPEED 10
                MOVE G6A,100, 140,  37, 140, 100, 100
                MOVE G6D,100, 140,  37, 140, 100, 100
                WAIT

                SPEED 3
                MOVE G6A,100, 140,  28, 142, 100, 100
                MOVE G6D,100, 140,  28, 142, 100, 100
                WAIT
                �ڼ� = 1		
            ENDIF

        ELSE

            IF  ������������ = 0 THEN
                GOSUB Leg_motor_mode2
                SPEED 6
                MOVE G6A,100, 140,  37, 140, 100, 100
                MOVE G6D,100, 140,  37, 140, 100, 100
                WAIT

                SPEED 10
                GOSUB �⺻�ڼ�
                GOSUB Leg_motor_mode1
            ELSE
                GOSUB Leg_motor_mode2
                SPEED 6
                MOVE G6A,100, 140,  37, 140, 100, 100
                MOVE G6D,100, 140,  37, 140, 100, 100
                WAIT

                SPEED 10
                MOVE G6A,100,  76, 145,  85, 100
                MOVE G6D,100,  76, 145,  85, 100
                WAIT
                �ڼ� = 0
                GOSUB Leg_motor_mode1	
            ENDIF
        ENDIF	
        GOTO RX_EXIT
    ENDIF


    IF �ڼ� = 0 THEN
        GOSUB Leg_motor_mode3

        SPEED 10
        MOVE G6A,100, 140,  37, 140, 100, 100
        MOVE G6D,100, 140,  37, 140, 100, 100
        WAIT

        SPEED 3
        GOSUB �����ڼ�	
        GOSUB MOTOR_OFF
    ELSE
        GOSUB MOTOR_ON
        GOSUB Leg_motor_mode2


        SPEED 6
        MOVE G6A,100, 140,  37, 140, 100, 100
        MOVE G6D,100, 140,  37, 140, 100, 100
        WAIT

        SPEED 10
        GOSUB �⺻�ڼ�
        GOSUB Leg_motor_mode1
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY30: ' ��

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB �����ʴ���
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO �����ʿ�����
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO �����ʿ�����20
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO �����ʿ�����20
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            IF �ڼ� = 0 THEN
                GOTO �����ʿ�����20
            ELSE
                GOTO �ɾƿ����ʿ�����
            ENDIF
        ELSE
            IF �ڼ� = 0 THEN
                GOTO ��������ʿ�����20
            ELSE
                GOTO �ɾƿ����ʿ�����
            ENDIF		
        ENDIF
    ELSEIF  Action_mode  = 5 THEN 'ī�޶���
        IF  �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN 'MFȫ����
        IF �ڼ� = 0 THEN

        ENDIF
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY31: ' ��
    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB �ڷδ���
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO �޸�ø������
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO ����
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOTO ������������
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 THEN
            GOSUB �ڷδ���
        ENDIF
    ELSEIF  Action_mode  = 5 THEN 'ī�޶���
        IF  �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN 'MFȫ����
        IF �ڼ� = 0 THEN

        ENDIF
    ENDIF

    GOTO RX_EXIT
    '*******************************************

KEY32: ' F

    IF Action_mode  = 0 THEN '�����
        IF �ڼ� = 0 THEN
            GOSUB ���մ�2
        ENDIF
    ELSEIF Action_mode  = 1 THEN '����Ʈ���
        IF �ڼ� = 0 THEN
            GOTO ������������
        ENDIF
    ELSEIF Action_mode  = 2 THEN '���Ӹ��
        IF �ڼ� = 0 THEN
            GOTO ������������
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' �౸���
        IF �ڼ� = 0 THEN
            GOSUB �ڷν���
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' ��ֹ����ָ��
        IF ������������ = 0 AND �ڼ� = 0 THEN
            GOTO ������������
        ENDIF
        GOTO RX_EXIT
    ELSEIF  Action_mode  = 5 THEN 'ī�޶���
        IF  �ڼ� = 0 THEN

        ENDIF
    ELSEIF  Action_mode  = 6 THEN 'MFȫ����
        IF �ڼ� = 0 THEN

        ENDIF
    ENDIF

    GOTO RX_EXIT
    '*******************************************














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
CONST MIN = 61			'�ڷγѾ�������
CONST MAX = 107			'�����γѾ�������
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

SPEED 5
GOSUB �����ʱ��ڼ�
GOSUB �⺻�ڼ�



GOTO MAIN
'************************************************
'************************************************

MOTOR_FAST_ON:

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
    '************************************************
�ڷ��Ͼ��:

    HIGHSPEED SETOFF
    PTP SETON 				
    PTP ALLON				

    GOSUB Arm_motor_mode1
    GOSUB Leg_motor_mode1


    SPEED 15
    MOVE G6A,100, 150, 170,  40, 100
    MOVE G6D,100, 150, 170,  40, 100
    MOVE G6B, 150, 150,  45
    MOVE G6C, 150, 150,  45
    WAIT

    SPEED 15
    MOVE G6A,  100, 155,  110, 120, 100
    MOVE G6D,  100, 155,  110, 120, 100
    MOVE G6B, 190, 80,  15
    MOVE G6C, 190, 80,  15
    WAIT

    GOSUB Leg_motor_mode2
    SPEED 15	
    MOVE G6A,  100, 165,  25, 162, 100
    MOVE G6D,  100, 165,  25, 162, 100
    MOVE G6B,  155, 15, 90
    MOVE G6C,  155, 15, 90
    WAIT

    DELAY 50
    SPEED 12	
    MOVE G6A,  100, 150,  25, 162, 100
    MOVE G6D,  100, 150,  25, 162, 100
    MOVE G6B,  140, 15, 90
    MOVE G6C,  140, 15, 90
    WAIT


    SPEED 8
    MOVE G6A,  100, 138,  25, 155, 100
    MOVE G6D,  100, 138,  25, 155, 100
    MOVE G6B, 113,  30, 80
    MOVE G6C, 113,  30, 80
    WAIT

    DELAY 100
    SPEED 10
    GOSUB �⺻�ڼ�
    GOSUB Leg_motor_mode1
    �Ѿ���Ȯ�� = 1
    RETURN


    '**********************************************
�������Ͼ��:

    HIGHSPEED SETOFF
    PTP SETON 				
    PTP ALLON

    GOSUB Arm_motor_mode1
    GOSUB Leg_motor_mode1


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

        'HIGHSPEED SETON
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

        'HIGHSPEED SETON
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

    '**********************************************	
    '**********************************************	
    '************************************************
�����ʿ�����20:

    
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


    '**********************************************
������10:
    
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

    '************************************************
    '*******��Ÿ��� ����****************************
    '************************************************

�λ�1:

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
    GOSUB All_motor_Reset


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
    MOVE G6A,95, 163,  28, 160, 105
    MOVE G6D,95, 163,  28, 160, 105
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
    MOVE G6A,  100, 165,  28, 162, 100
    MOVE G6D,  100, 165,  28, 162, 100
    MOVE G6B,  155, 15, 90
    MOVE G6C,  155, 15, 90
    WAIT

    SPEED 10	
    MOVE G6A,  100, 150,  27, 162, 100
    MOVE G6D,  100, 150,  27, 162, 100
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

    SPEED 15
    MOVE G6A,100, 130, 120,  80, 100, 100
    MOVE G6D, 100, 130, 120,  80, 100, 100
    MOVE G6B,160, 160,  10
    MOVE G6C,160, 160,  10
    WAIT
    '
    SPEED 15
    MOVE G6A,100, 145, 150,  90, 100, 100
    MOVE G6D, 100, 145, 150,  90, 100, 100
    MOVE G6B,180, 90,  10
    MOVE G6C,180, 90,  10
    WAIT

    SPEED 10
    MOVE G6A, 100, 145,  85, 150, 100, 100
    MOVE G6D, 100, 145,  85, 150, 100, 100
    MOVE G6B,185,  40, 60
    MOVE G6C,185,  40, 60
    WAIT

    SPEED 15
    MOVE G6A, 100, 165,  55, 155, 100, 100
    MOVE G6D, 100, 165,  55, 155, 100, 100
    MOVE G6B,185,  10, 100
    MOVE G6C,185,  10, 100
    WAIT	

    GOSUB Leg_motor_mode2
    SPEED 15	
    MOVE G6A,  100, 165,  27, 162, 100
    MOVE G6D,  100, 165,  27, 162, 100
    MOVE G6B,  155, 15, 90
    MOVE G6C,  155, 15, 90
    WAIT

    SPEED 10	
    MOVE G6A,  100, 150,  27, 162, 100
    MOVE G6D,  100, 150,  27, 162, 100
    MOVE G6B,  140, 15, 90
    MOVE G6C,  140, 15, 90
    WAIT

    SPEED 6
    MOVE G6A,  100, 138,  27, 155, 100
    MOVE G6D,  100, 138,  27, 155, 100
    MOVE G6B, 113,  30, 80
    MOVE G6C, 113,  30, 80
    WAIT

    DELAY 100
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

    IF �ڼ� = 0 THEN
        GOSUB �λ�1
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY2:

    IF �ڼ� = 0 THEN
        GOSUB �λ�2
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY3:

    IF �ڼ� = 0 THEN
        GOSUB �����׼�
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY4:

    IF �ڼ� = 0 THEN
        GOSUB �¸��������1
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY5:

    IF �ڼ� = 0 THEN
        GOSUB �¸��������2
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY6:

    IF �ڼ� = 0 THEN
        GOSUB �¸��������3
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY7:

    IF �ڼ� = 0 THEN
        GOSUB �й�׼�1
    ENDIF



    GOTO RX_EXIT
    '*******************************************
KEY8:

    IF �ڼ� = 0 THEN
        GOSUB �Ⱦ��ֱ�
    ENDIF



    GOTO RX_EXIT
    '*******************************************
KEY9:


    IF �ڼ� = 0 THEN
        GOSUB �й�׼�2
    ENDIF



    GOTO RX_EXIT
    '*******************************************
KEY10: '0


    IF �ڼ� = 0 THEN
        GOTO ��������ġ
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY11: ' ��


    IF �ڼ� = 0 THEN
        GOTO �����޸���50
    ENDIF



    GOTO RX_EXIT
    '*******************************************
KEY12: ' ��


    IF �ڼ� = 0 THEN
        GOTO �����޸���40
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY13: '��


    IF �ڼ� = 0 THEN
        GOTO �����ʿ�����70
    ENDIF



    GOTO RX_EXIT
    '*******************************************
KEY14: ' ��


    IF �ڼ� = 0 THEN
        GOTO ���ʿ�����70
    ENDIF



    GOTO RX_EXIT
    '*******************************************
KEY15: ' A


    IF �ڼ� = 0 THEN
        GOTO �޼��������
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY16: ' POWER


    GOTO RX_EXIT

    '*******************************************
KEY17: ' C


    IF �ڼ� = 0 THEN
        GOTO ���ʿ��ڰ���
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY18: ' E

    IF �ڼ� = 0 THEN
        GOTO ���ʿ�����20
    ENDIF


    GOTO RX_EXIT
    '*******************************************


KEY19: ' P2


    IF �ڼ� = 0 THEN
        GOTO ��������60
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY20: ' B	


    IF �ڼ� = 0 THEN
        GOTO �������������
    ENDIF



    GOTO RX_EXIT
    '*******************************************
KEY21: ' ��


    IF �ڼ� = 0 THEN
        GOTO ����ø������
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY22: ' *	


    IF �ڼ� = 0 THEN
        GOTO ������20
    ENDIF



    GOTO RX_EXIT
    '*******************************************
KEY23: ' G

    IF �ڼ� = 0 THEN
        GOTO �����ʿ�����20
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY24: ' #


    IF �ڼ� = 0 THEN
        GOTO ��������20
    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY25: ' P1

    IF �ڼ� = 0 THEN
        GOTO ������60
    ENDIF



    GOTO RX_EXIT
    '*******************************************
KEY26: ' ��

    SPEED 5
    GOSUB �⺻�ڼ�	
    GOSUB All_motor_Reset
    GOTO RX_EXIT
    '*******************************************
KEY27: ' D


    IF �ڼ� = 0 THEN
        GOTO �����ʿ��ڰ���
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY28: ' ��



    IF �ڼ� = 0 THEN
        GOTO ���ʿ�����
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY29: ' ��



    IF �ڼ� = 0 THEN
        GOSUB Leg_motor_mode3

        SPEED 10
        MOVE G6A,100, 140,  37, 140, 100, 100
        MOVE G6D,100, 140,  37, 140, 100, 100
        WAIT

        SPEED 3
        GOSUB �����ڼ�	

    ELSE

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


    IF �ڼ� = 0 THEN
        GOTO �����ʿ�����
    ENDIF


    GOTO RX_EXIT
    '*******************************************
KEY31: ' ��

    IF �ڼ� = 0 THEN
        GOTO �޸�ø������
    ENDIF

    GOTO RX_EXIT
    '*******************************************

KEY32: ' F


    IF �ڼ� = 0 THEN
        GOTO ������������
    ENDIF


    GOTO RX_EXIT
    '*******************************************












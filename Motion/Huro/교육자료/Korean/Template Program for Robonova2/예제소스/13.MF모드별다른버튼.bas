
'****************************************
'***** ��Ż������ ���� ���α׷� *******
'****************************************

'******* �������� ***********************
DIM A AS BYTE
DIM A_old AS BYTE
DIM X AS BYTE
DIM Y AS BYTE
DIM ������� AS BYTE
DIM Action_mode AS BYTE
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

'*******���͹��⼳��*********************
DIR G6A,1,0,0,1,0,0	'���ʴٸ�:����0~5��
DIR G6D,0,1,1,0,1,0	'�����ʴٸ�:����18~23��
DIR G6B,1,1,1,1,1,1	'������:����6~11��
DIR G6C,0,0,0,0,0,0	'��������:����12~17��


'*******���͵��������****************
PTP SETON '�����׷캰 ���������� ����
PTP ALLON'��ü���� ������ ���� ����

'*******������ġ���ǵ��****************
GOSUB MOTOR_GET

'*******���ͻ�뼳��********************
GOSUB MOTOR_ON

'*******�ǿ����Ҹ�����******************
TEMPO 220
MUSIC "O23EAB7EA>3#C"
'***** �ʱ��ڼ��� **********************
SPEED 5
GOSUB �⺻�ڼ�

Action_mode = 0

'***** ���� �ݺ���ƾ **************
MAIN:

    ERX 4800,A,MAIN
    A_old = A

    IF A = 16 THEN
        GOSUB SOUND_MODE_SELECT
        GOTO ��庯ȯ
    ELSEIF A = 1 THEN
        SPEED 10
        IF Action_mode = 0 THEN			
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
        ELSEIF Action_mode = 1 THEN		
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
        ELSEIF Action_mode = 2 THEN		
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
        ELSEIF Action_mode = 3 THEN		
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
        ELSEIF Action_mode = 4 THEN		
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
        ELSEIF Action_mode = 5 THEN		
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
        ELSEIF Action_mode = 6 THEN		
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
        ENDIF
    ELSE
        MUSIC "F"    	
    ENDIF


    GOTO MAIN
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
    '************************************************
SOUND_MODE_SELECT:
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
��庯ȯ:

    ERX 4800,A,��庯ȯ


    IF A = 27 THEN	'D ��ư:�����
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

    ELSEIF A = 32 THEN	'F ��ư:����Ʈ���
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

    ELSEIF A = 23 THEN	'G ��ư:���Ӹ��
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

    ELSEIF A = 20 THEN	'B ��ư:�౸���
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

    ELSEIF A = 18 THEN	'E ��ư:��ֹ����ָ��
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

    ELSEIF A = 17 THEN ' C: ī�޶���
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
    ELSEIF A = 15 THEN	'A ��ư: MFȫ����
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

    ELSEIF A = 26 THEN	'�� ��ư:�׼Ǹ�庯�� ����
        SPEED 5
        MOVE G6A,97,  76, 145,  93, 102, 100
        MOVE G6D,97,  76, 145,  93, 102, 100
        WAIT
        SPEED 8
        MOVE G6B,, 50, 90, , , 100
        MOVE G6C,, 50, 90
        WAIT
        GOSUB �⺻�ڼ�

        GOSUB All_motor_Reset
        GOTO RX_EXIT

    ELSE
        MUSIC "C"
    ENDIF

    GOSUB GOSUB_RX_EXIT

    GOTO ��庯ȯ
    '*************************************
GOSUB_RX_EXIT: '���Ű��� �����·�ƾ

    ERX 4800, A, GOSUB_RX_EXIT2
    GOTO GOSUB_RX_EXIT
GOSUB_RX_EXIT2:
    RETURN
'*************************************
RX_EXIT: '���Ű��� �����·�ƾ	

    ERX 4800, A, MAIN

    GOTO RX_EXIT
    '*************************************
MOTOR_ON: '����Ʈ�������ͻ�뼳��
    MOTOR G24
    RETURN
    '***********************************
MOTOR_OFF: '����Ʈ�������ͼ�������
    MOTOROFF G6B
    MOTOROFF G6C
    MOTOROFF G6A
    MOTOROFF G6D
    RETURN
    '***********************************
MOTOR_GET: '��ġ���ǵ��
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,1
    GETMOTORSET G6C,1,1,1,0,0,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN

    '*******�⺻�ڼ�����*****************

�⺻�ڼ�:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    RETURN
    '*************************************	
All_motor_Reset:
    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    MOTORMODE G6B,1,1,1, , ,1
    MOTORMODE G6C,1,1,1
    RETURN
    '*************************************
All_motor_mode2:
    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    MOTORMODE G6B,2,2,2, , ,2
    MOTORMODE G6C,2,2,2
    RETURN
    '*************************************
All_motor_mode3:
    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    MOTORMODE G6B,3,3,3, , ,3
    MOTORMODE G6C,3,3,3
    RETURN
    '*************************************
Leg_motor_mode1:
    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    RETURN
    '*************************************
Leg_motor_mode2:
    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    RETURN
    '*************************************
Leg_motor_mode3:
    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    RETURN
    '*************************************
Leg_motor_mode4:
    MOTORMODE G6A,3,2,2,1,3
    MOTORMODE G6D,3,2,2,1,3
    RETURN
    '*************************************
Leg_motor_mode5:
    MOTORMODE G6A,3,2,2,1,2
    MOTORMODE G6D,3,2,2,1,2
    RETURN
    '*************************************
Arm_motor_mode1:
    MOTORMODE G6B,1,1,1
    MOTORMODE G6C,1,1,1
    RETURN
    '*************************************
Arm_motor_mode2:
    MOTORMODE G6B,2,2,2
    MOTORMODE G6C,2,2,2
    RETURN
    '*************************************
Arm_motor_mode3:
    MOTORMODE G6B,3,3,3
    MOTORMODE G6C,3,3,3
    RETURN
    '*************************************

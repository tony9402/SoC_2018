
'****************************************
'***** ��Ż������ ���� ���α׷� *******
'****************************************

'******* �������� ***********************
DIM A AS BYTE
DIM A_OLD AS BYTE
'*******���͹��⼳��*********************
DIR G6A,1,0,0,1,0,0	'���ʴٸ�:����0~5��
DIR G6D,0,1,1,0,1,0	'�����ʴٸ�:����18~23��
DIR G6B,1,1,1,1,1,1	'������:����6~11��
DIR G6C,0,0,0,0,0,0	'��������:����12~17��


'*******���͵��������****************
PTP SETON 		'�����׷캰 ���������� ����
PTP ALLON		'��ü���� ������ ���� ����

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

GOSUB MOTOR_ON
GOSUB SOUND_VOLUME_30

'***** ���� �ݺ���ƾ **************
MAIN:

    ERX 4800,A,MAIN
    A_OLD = A

    IF A = 1 THEN
        GOSUB SOUND_����
    ELSEIF A = 2 THEN
        GOSUB SOUND_����
    ELSEIF A = 3 THEN
        GOSUB SOUND_��
    ELSEIF A = 4 THEN
        GOSUB SOUND_BGM1
    ELSEIF A = 5 THEN
        GOSUB SOUND_BGM2
    ELSEIF A = 6 THEN
        GOSUB SOUND_BGM7
    ELSEIF A = 7 THEN
        GOSUB SOUND_BGM10
    ELSEIF A = 8 THEN
        GOSUB SOUND_�κ���ũ������
    ELSEIF A = 9 THEN
        GOSUB SOUND_����ü����
    ELSEIF A = 10 THEN
        GOSUB SOUND_�ȳ��ϼ���̴Ϸκ��������ߵȸ�Ż�������Դϴ�
    ELSEIF A = 21 THEN 	' ���ư: �Ҹ� �ѱ�
        GOSUB SOUND_ALL_ON_MSG
    ELSEIF A = 31 THEN  ' ���ư: �Ҹ� ����
        GOSUB SOUND_ALL_OFF_MSG
    ELSEIF A = 30 THEN  ' ����ư: ������
        GOSUB SOUND_UP
        GOSUB ������
    ELSEIF A = 28 THEN  ' ����ư: �����ٿ�
        GOSUB SOUND_DOWN		
        GOSUB ������
    ELSEIF A = 26 THEN	' ���ư:�Ҹ�����
        GOSUB SOUND_STOP
    ELSE

        GOSUB ������

    ENDIF




    GOTO MAIN

    '***************************************
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
    '******* ��������� **************
    '*************************************
������:
    TEMPO 230
    MUSIC "A"
    RETURN
    '************************************************
SOUND_����ü����: '
    PRINT "SOUND 47!"
    RETURN
SOUND_�κ���ũ������: '
    PRINT "SOUND 46!"
    RETURN
SOUND_�ȳ��ϼ���: '
    PRINT "SOUND 12!"
    RETURN
SOUND_�ȳ��ϼ���̴Ϸκ��������ߵȸ�Ż�������Դϴ�: '
    PRINT "SOUND 0!"
    RETURN
    '************************************************
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
SOUND_BGM12:
    PRINT "AUTO 42!"
    RETURN

SOUND_ALL_OFF_MSG:
    PRINT "SOUND 20!"
    DELAY 1500
    GOSUB SOUND_VOLUME_0
    RETURN

SOUND_ALL_ON_MSG:
    GOSUB SOUND_VOLUME_30
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

SOUND_VOLUME_50:
    PRINT "VOLUME 50 !"
    RETURN

SOUND_VOLUME_40:
    PRINT "VOLUME 40 !"
    RETURN

SOUND_VOLUME_30:
    PRINT "VOLUME 30 !"
    RETURN
SOUND_VOLUME_20:
    PRINT "VOLUME 20 !"
    RETURN
SOUND_VOLUME_10:
    PRINT "VOLUME 10 !"
    RETURN

SOUND_VOLUME_0:
    PRINT "VOLUME 0 !"
    RETURN

SOUND_STOP:
    PRINT "STOP !"
    RETURN

SOUND_UP:
    PRINT "UP 5 !"
    RETURN

SOUND_DOWN:
    PRINT "DOWN 5 !"
    RETURN

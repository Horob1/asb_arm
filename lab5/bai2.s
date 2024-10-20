/*	AREA RESET,DATA,READONLY
		DCD 0x20000000
		DCD Start
A DCD 1,0,1,1,1,0,1,0,1,1,1,0,1
N DCD 1
KETQUA DCD 0
	AREA MYCODE,CODE,READONLY
		ENTRY
KiemTra PROC
	CMP R3,R2
	BGT StopP
	ADD R3,#1
	LDR R4,[R1],#4
	B Check
Check 
	CMP R4,#1
	BEQ AddCount
	B KiemTra
AddCount
	ADD R5,#1
	B KiemTra
StopP
	BX LR
	ENDP
Start PROC
	MOV R0,#0
	LDR R1,=A
	LDR R2,N
	CMP R2,#1
	BLE Print
	MOV R3,#0
	MOV R5,#0
	BL KiemTra	
CheckChan
	SUB R5,#2
	CMP R5,#2
	BLT Print
	BEQ Print1
	BGT CheckChan
Print 
	MOV R6,#1
	B Stop
Print1
	MOV R6,#0
	B Stop
Stop
	B Stop
	END*/
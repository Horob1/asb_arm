/*	AREA RESET,DATA,READONLY
		DCD 0x20000000
		DCD Start
N DCD 20
KETQUA DCD 0
	AREA MYCODE,CODE,READONLY
		ENTRY
DuyetTatCaCacSo PROC
	ADD R2,#1;So hien tai can check
	MOV R3,#0;So tang dan
	MOV R4,#0;Dem so uoc
	CMP R2,R1
	BGT Stop
	B KiemTraChia
KiemTraChia
	MOV R5,R2
	ADD R3,#1
	CMP R3,R5
	BGT CheckSNT
	B Chia
Chia
	CMP R3,R5
	BEQ ChiaHet
	BGT KiemTraChia
	SUB R5,R3
	B Chia
ChiaHet
	ADD R4,#1
	B KiemTraChia
CheckSNT
	CMP R4,#2
	BNE DuyetTatCaCacSo
	ADD R0,#1
	B DuyetTatCaCacSo
Stop
	BX LR
	ENDP
Start PROC
	MOV R0,#0
	LDR R1,N
	MOV R2,#1
	BL DuyetTatCaCacSo
	LDR R6,=KETQUA
	STR R0,[R6]
EndProgram
	B EndProgram
	END*/
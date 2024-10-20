/*	AREA RESET,DATA,READONLY
		DCD 0x20000000
		DCD Start
A DCD 11,12,13,20,21,23
N DCD 6
KETQUA DCD 0
	AREA MYCODE,CODE,READONLY
		ENTRY
DuyetTatCaCacSo PROC
	ADD R8,#1
	LDR R2,[R7],#4
	MOV R3,#0;So tang dan
	MOV R4,#0;Dem so uoc
	CMP R8,R6
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
	ADD R0,R2
	B DuyetTatCaCacSo
Stop
	BX LR
	ENDP
Start PROC
	MOV R0,#0
	LDR R7,=A
	LDR R6,N
	MOV R8,#0
	BL DuyetTatCaCacSo
	LDR R9,=KETQUA
	STR R0,[R9]
StopProgram
	B StopProgram
	END
	*/
	
	
	
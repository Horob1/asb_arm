	AREA RESET, DATA, READONLY
		DCD 0x20000000
		DCD START
	AREA SOURCE, CODE, READONLY
		ENTRY

N EQU 3
X EQU 2
START
	MOV R0, #1 
	MOV R1, #1
	MOV R2, #X
LOOP
	CMP R1, #N
	BGT STOP
	MUL R0, R0, R2 
	ADD R1, #1
	B LOOP
STOP 
	B STOP
	END

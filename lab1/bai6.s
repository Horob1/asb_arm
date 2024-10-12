; tính tổng 1 + x^2 + x^3 + … + x^n.
	AREA RESET, DATA, READONLY
		DCD 0x20000000
		DCD Start
X 		DCD 2
	AREA MAINSOURCE, CODE, READONLY
		ENTRY

N EQU 3


Start
	MOV R4, #1
	LDR R3, X
	MOV R0, #1
	MOV R1, #0
Loop 
	CMP R1, #N
	BEQ Stop
	MUL R0, R0, R3
	ADD R4, R0
	ADD R1, #1
	B Loop
Stop 
	B Stop
	END
	
	
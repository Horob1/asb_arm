; tìm bội chung nhỏ nhất của 2 số
		DCD 0x20000000
		DCD Start
So1		DCD 20
So2		DCD 40
	
	AREA MAINSOURCE, CODE, READONLY
		ENTRY



Start
	LDR R0, So1
	LDR R1, So2
Loop 
	CMP R0, R1
	BGT HoanDoi
TiepTuc
	SUB R1, R0
	CMP R1, R0
	BEQ BCNN
	B Loop
HoanDoi
	MOV R2, R0
	MOV R0, R1
	MOV R1, R2
	B TiepTuc
BCNN
	MOV R3, R0 
	LDR R0, So1
	LDR R1, So2
	MUL R2, R1, R0
	UDIV R4, R2, R3
Stop 
	B Stop
	END
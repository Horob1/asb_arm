;tìm ước chung lớn nhất của 2 số
	AREA RESET, DATA, READONLY
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
	BEQ Stop
	B Loop
HoanDoi
	MOV R2, R0
	MOV R0, R1
	MOV R1, R2
	B TiepTuc
Stop 
	B Stop
	END


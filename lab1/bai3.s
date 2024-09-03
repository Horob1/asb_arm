;Tinh giai thua cua n
	AREA RESET, DATA, READONLY
		DCD 0x20000000
		DCD Start
	
	AREA MAINSOURCE, CODE, READONLY
		ENTRY
		
N EQU 4
	
Start
	MOV R1, #1
	MOV R2, #1 ; chua giai thua cua n
Loop
	CMP R1, N
	BGT Stop
	MUL R2, R1
	ADD R1, #1
	B Loop
Stop 
	B Stop
	END
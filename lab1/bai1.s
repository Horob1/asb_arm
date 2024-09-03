; Lab01 bai 01 tinh tong cac so 1->n

; Khai bao 
	AREA RESET, DATA, READONLY
		DCD 0x20000000 ; define a constant -> SP
		DCD Start
		
	AREA MAINSOURCE, CODE, READONLY
		ENTRY
		
Start 
	MOV R2, #0
	MOV R1, #1

LOOP
	CMP R1, #5 ; n = 5
	BGT STOP
	ADD R2, R1
	ADD R1, #1
	B LOOP
STOP B STOP
	END
	
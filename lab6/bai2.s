;DEM SO KI TU CUA SAU THEO KY TU KET THUC
CR  EQU 0x0D 
	AREA RESET, DATA, READONLY
	DCD 0x20001000
	DCD Main
Table DCB "Hello, World", CR 
			
	AREA Program, CODE, READONLY 
	ENTRY 
Main 
	LDR R0, =Table 		
	MOV R1, #0 			
Loop 
	LDRB R2, [R0], #1 	
	CMP R2, #CR 		
	BEQ Stop 			
	ADD R1, R1, #1 		
	B Loop 			
Stop B Stop
	END
	
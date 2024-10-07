; CHUONG TRINH SO SANH 2 XAU THEO DO DAI
    AREA RESET, DATA, READONLY
    DCD 0x20001000
    DCD Main
Len_1 DCD 4
Len_2 DCD 4
String_1 DCB "1234"
String_2 DCB "1234"
    
    AREA Program, CODE, READONLY 
    ENTRY 
Main
	LDR R0, Len_1
	LDR R1, Len_2
	CMP R0, R1
	BNE NotSame
	
	LDR R2, =String_1
	LDR R3, =String_2
Loop
	LDRB R4, [R2], #1
	LDRB R5, [R3], #1
	CMP R4, R5
	BNE NotSame
	
	SUBS R0, R0, #1
	
	BNE Loop
Same
	MOV R0, #1
	B Stop
NotSame
	MOV R0, #0
Stop B Stop
    END

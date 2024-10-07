; CHUAN HOA XAU
	AREA RESET, DATA, READONLY
    DCD 0x20001000
    DCD Main
	AREA Input, DATA, READONLY
InputString DCB "HELLO WORLD!", 0   

    AREA Output, DATA, READWRITE
OutputString DCB 0

    AREA Program, CODE, READONLY
    ENTRY

Main
    LDR R0, =InputString     
	LDR R4, =OutputString
    MOV R2, #0            

Loop_to_find_len
    LDRB R3, [R0, R2]
	CMP R3, #0
	BEQ InitForRvString
	ADD R2, R2, #1
	B Loop_to_find_len
InitForRvString	
;neu dung length thi bo qua buoc loop to find len
	SUBS R2, R2, #1
RvString
	LDRB R3, [R0, R2]
	STRB R3, [R4], #1
	CMP R2, #0
	BEQ Stop
	SUBS R2, R2, #1
	B RvString
Stop B Stop
    END

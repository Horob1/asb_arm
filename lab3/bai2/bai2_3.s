    AREA RESET, DATA, READONLY
    DCD 0x20001000    
    DCD Reset_Handler   

    ALIGN              
FAC	DCD 0 ; addressing a memory location {name: FAC, value: 0}
N	DCD 5 ; addressing a memory location {name: n, value: 5}    

    AREA MYSTACK, DATA, READWRITE
MY_STACK  DCD 0 

    AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler
	
FACTORIAL 	PROC
	LDR R2, =MY_STACK
	LDMIA R2, {R0, R1}
LOOP	
	MUL R1, R0, R1
	SUBS R0, R0, #1
	BGT LOOP
	BX LR
	ENDP

Reset_Handler 
    LDR R0, N 		;Load count into R0
	MOV R1, #1
	LDR R2, =MY_STACK
	STMIA R2, {R0, R1}
	BL  FACTORIAL
	LDR R2, =FAC 
	STR	R1, [R2]

STOP    
    B STOP             

    END

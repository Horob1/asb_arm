    AREA RESET, DATA, READONLY
    DCD 0x20001000    
    DCD Reset_Handler   

    ALIGN              
SUM_ODD		DCD 0 ; addressing a memory location {name: SUM_ODD, value: 0}
SUM_EVEN	DCD 0 ; addressing a memory location {name: SUM_EVEN, value: 0}
N			DCD 5 ; addressing a memory location {name: n, value: 5}      

    AREA MYSTACK, DATA, READWRITE
MY_STACK  DCD 0 

    AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

SUMF PROC
	LDR R3, =MY_STACK 
    LDMIA R3, {R0, R1, R2}
LOOP
	CMP R2, R0
	BGT END_OF_FUNC
	ADD R1, R2
	ADD R2, #2
	B LOOP
END_OF_FUNC
	BX LR
	ENDP

Reset_Handler 
    LDR 	R0, N 		;Load count into R0
	;caculate sum of odd num
	MOV 	R1, #0 		;Clear accumulator R1 <this register will store result of caculation>
	MOV 	R2, #1	
    LDR R3, =MY_STACK 
    STMIA R3, {R0, R1, R2}
	BL SUMF
	LDR R3, =SUM_ODD
	STR R1, [R3]
	;caculate sum of even num
	MOV R1, #0
	MOV R2, #2 
	LDR R3, =MY_STACK 
	STMIA R3, {R0, R1, R2}
	BL  SUMF 
	LDR R3, =SUM_EVEN 
	STR	R1, [R3]

STOP    
    B STOP             

    END

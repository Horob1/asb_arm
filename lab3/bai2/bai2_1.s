    AREA RESET, DATA, READONLY
    DCD 0x20001000    
    DCD Reset_Handler   

    ALIGN              
SUMP      DCD SUM     
SUM       DCD 0       
N         DCD 5       

    AREA MYSTACK, DATA, READWRITE
MY_STACK  DCD 0 

    AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

SUMF PROC
	LDR R3, =MY_STACK 
    LDMIA R3, {R0, R1}
LOOP
	ADD 	R0, R0, R1 	;Add number into R0
	SUBS 	R1, R1, #1 	;Decrement loop counter R1
	BGT 	LOOP 		;Branch back if R1 greater than zero
	
	BX LR
	ENDP

Reset_Handler 
  LDR R1, N          
  MOV R0, #0        
  LDR R3, =MY_STACK 
  STMIA R3, {R0, R1}
	BL SUMF
	LDR 	R3, =SUMP	;Load address of SUM to R3
	STR 	R0, [R3]	;Store SUM

STOP    
    B STOP             

    END

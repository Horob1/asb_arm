    AREA RESET, DATA, READONLY
    DCD 0x20001000    
    DCD Reset_Handler   

    ALIGN              
XN	DCD 0 ; addressing a memory location {name: XN, value: 0}
N	DCD 7 ; addressing a memory location {name: n, value: 7}
X	DCD 2 ; addressing a memory location {name: x, value: 2}

    AREA MYSTACK, DATA, READWRITE
MY_STACK  DCD 0 

    AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

XMUN 	PROC
	 LDR	R4, =MY_STACK
	 LDMIA	R4, {R0, R1, R2}
LOOP
	 MUL R2, R2, R1
	 SUBS R0, R0, #1
	 BGT LOOP
	 BX LR
	 ENDP

Reset_Handler 
	 LDR 	R0, N 		
	 LDR 	R1, X 
	 MOV	R2, #1
	 LDR	R4, =MY_STACK
	 STMIA	R4, {R0, R1, R2}
	 BL  	XMUN
	 
	 LDR 	R3, =XN 
	 STR	R2, [R3]
STOP	
         B STOP
	 END 	
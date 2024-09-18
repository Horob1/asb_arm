    AREA RESET, DATA, READONLY
    DCD 0x20001000    
    DCD Reset_Handler   

    ALIGN              
FX	DCD 0 ; addressing a memory location {name: FX, value: 0}
N	DCD 7 ; addressing a memory location {name: n, value: 7}
X	DCD 2 ; addressing a memory location {name: x, value: 2}

    AREA MYSTACK, DATA, READWRITE
MY_STACK  DCD 0 

    AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

BIEUTHUC 	PROC
	 LDR R5, =MY_STACK
	 LDMIA R5, {R0,R1,R2,R3}
LOOP
	 MUL R2, R2, R1
	 ADD R3, R2
	 SUBS R0, R0, #1
	 BGT LOOP
	 LDR R0, N
	 CMP R0, #1
	 BLT END_PROC
	 SUBS R3, R3, R1
END_PROC
	 BX LR
	 ENDP
Reset_Handler 
	 LDR 	R0, N 		
	 LDR 	R1, X 
	 MOV	R2, #1
	 MOV 	R3, #1
	 LDR R5, =MY_STACK
	 STMIA R5, {R0,R1,R2,R3}
	 BL  	BIEUTHUC
	 
	 LDR 	R4, =FX 
	 STR	R3, [R4]
STOP	
         B STOP
	 END 	
    AREA RESET, DATA, READONLY
    DCD 0x20001000    
    DCD Reset_Handler   

    ALIGN              
SUM	DCD 0 ; addressing a memory location {name: SUM, value: 0}
N	DCD 7 ; addressing a memory location {name: n, value: 7}

    AREA MYSTACK, DATA, READWRITE
MY_STACK  DCD 0 

    AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

SUMF 	PROC
	 LDR	R3, =MY_STACK
	 LDMIA	R3, {R0,R1,R2}
LOOP
	 ADD R1, R2
	 ADD R2, #5
	 CMP R2,R0
	 BLE LOOP
	 BX LR
	 ENDP

Reset_Handler 
	 LDR 	R0, N 		;Load count into R0
	 MOV 	R1, #0
	 MOV	R2, #0
	 LDR	R3, =MY_STACK
	 STMIA	R3, {R0,R1,R2}
	 BL  	SUMF
	 LDR 	R2, =SUM 
	 STR	R1, [R2]
STOP	
         B STOP
	 END 	
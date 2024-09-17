	 AREA    RESET, DATA, READONLY
		 DCD  0x20001000     ; stack pointer value when stack is empty
		 DCD  Reset_Handler  ; reset vector
  
       ALIGN ; setting for alignment of the stack in memory, default 4 bytes
FX	DCD 0 ; addressing a memory location {name: FX, value: 0}
N	DCD 7 ; addressing a memory location {name: n, value: 7}
X	DCD 2 ; addressing a memory location {name: x, value: 2}
           AREA    MYCODE, CODE, READONLY
   	   ENTRY
   	   EXPORT Reset_Handler
BIEUTHUC 	PROC
	 MUL R2, R2, R1
	 ADD R3, R2
	 SUBS R0, R0, #1
	 BGT BIEUTHUC
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
	 BL  	BIEUTHUC
	 
	 LDR 	R4, =FX 
	 STR	R3, [R4]
STOP	
         B STOP
	 END 	
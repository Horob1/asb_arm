	 AREA    RESET, DATA, READONLY
		 DCD  0x20001000     ; stack pointer value when stack is empty
		 DCD  Reset_Handler  ; reset vector
  
       ALIGN ; setting for alignment of the stack in memory, default 4 bytes
XN	DCD 0 ; addressing a memory location {name: XN, value: 0}
N	DCD 7 ; addressing a memory location {name: n, value: 7}
X	DCD 2 ; addressing a memory location {name: x, value: 2}
           AREA    MYCODE, CODE, READONLY
   	   ENTRY
   	   EXPORT Reset_Handler
XMUN 	PROC
	 MUL R2, R2, R1
	 SUBS R0, R0, #1
	 BGT XMUN
	 BX LR
	 ENDP

Reset_Handler 
	 LDR 	R0, N 		
	 LDR 	R1, X 
	 MOV	R2, #1
	 BL  	XMUN
	 
	 LDR 	R3, =XN 
	 STR	R2, [R3]
STOP	
         B STOP
	 END 	
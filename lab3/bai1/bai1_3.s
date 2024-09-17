	 AREA    RESET, DATA, READONLY
		 DCD  0x20001000     ; stack pointer value when stack is empty
		 DCD  Reset_Handler  ; reset vector
  
       ALIGN ; setting for alignment of the stack in memory, default 4 bytes
FAC	DCD 0 ; addressing a memory location {name: FAC, value: 0}
N	DCD 5 ; addressing a memory location {name: n, value: 5}
           AREA    MYCODE, CODE, READONLY
   	   ENTRY
   	   EXPORT Reset_Handler
FACTORIAL 	PROC
	 MUL R1, R0, R1
	 SUBS R0, R0, #1
	 BGT FACTORIAL
	 BX LR
	 ENDP

Reset_Handler 
	 LDR 	R0, N 		;Load count into R0
	 MOV 	R1, #1
	 BL  	FACTORIAL
	 
	 LDR 	R2, =FAC 
	 STR	R1, [R2]
STOP	
         B STOP
	 END 	
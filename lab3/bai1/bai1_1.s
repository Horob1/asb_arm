	 AREA    RESET, DATA, READONLY
		 DCD  0x20001000     ; stack pointer value when stack is empty
		 DCD  Reset_Handler  ; reset vector
  
       ALIGN ; setting for alignment of the stack in memory, default 4 bytes
SUMP      DCD SUM ; addressing a memory location {name: sump, value: adress of SUM}
SUM       DCD 0 ; addressing a memory location {name: sum, value: 0}
N         DCD 5 ; addressing a memory location {name: n, value: 5}
           AREA    MYCODE, CODE, READONLY
   	   ENTRY
   	   EXPORT Reset_Handler
; function to calculate sum of interger number from zero to n 
SUMUP 	PROC
	 ADD 	R0, R0, R1 	;Add number into R0
	 SUBS 	R1, R1, #1 	;Decrement loop counter R1
	 BGT 	SUMUP 		;Branch back if R1 greater than zero
	 BX 	LR ; Branch back to adress in LR (link register)
	 ENDP

Reset_Handler 
	 LDR 	R1, N 		;Load count into R1
	 MOV 	R0, #0 		;Clear accumulator R0
	 BL  	SUMUP
	 LDR 	R3, =SUMP	;Load address of SUM to R3
	 STR 	R0, [R3]	;Store SUM
    

STOP	
         B STOP
	 END 	
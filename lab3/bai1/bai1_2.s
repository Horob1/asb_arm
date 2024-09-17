	 AREA    RESET, DATA, READONLY
		 DCD  0x20001000     ; stack pointer value when stack is empty
		 DCD  Reset_Handler  ; reset vector
  
       ALIGN ; setting for alignment of the stack in memory, default 4 bytes
SUM_ODD	DCD 0 ; addressing a memory location {name: SUM_ODD, value: 0}
SUM_EVEN	DCD 0 ; addressing a memory location {name: SUM_EVEN, value: 0}
N	DCD 5 ; addressing a memory location {name: n, value: 5}
           AREA    MYCODE, CODE, READONLY
   	   ENTRY
   	   EXPORT Reset_Handler
SUMUP 	PROC
	 CMP R2, R0
	 BGT END_OF_FUNC
	 ADD R1, R2
	 ADD R2, #2
	 B SUMUP
END_OF_FUNC
	 BX LR
	 ENDP

Reset_Handler 
	 LDR 	R0, N 		;Load count into R0
	 ;caculate sum of odd num
	 MOV 	R1, #0 		;Clear accumulator R1 <this register will store result of caculation>
	 MOV 	R2, #1
	 
	 BL  	SUMUP
	 
	 LDR 	R3, =SUM_ODD
	 STR 	R1, [R3]
	 ;caculate sum of odd num
	 MOV 	R1, #0
	 MOV 	R2, #2
	 
	 BL  	SUMUP
	 
	 LDR 	R3, =SUM_EVEN 
	 STR	R1, [R3]
STOP	
         B STOP
	 END 	
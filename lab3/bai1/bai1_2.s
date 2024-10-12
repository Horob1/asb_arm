	;tổng các số chẵn, số lẻ <= N sử dụng thanh ghi 
	 AREA    RESET, DATA, READONLY
		 DCD  0x20001000   
		 DCD  Reset_Handler  
  
       ALIGN 
SUM_ODD	DCD 0 
SUM_EVEN	DCD 0 
N	DCD 5 
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
	 LDR 	R0, N 		
	
	 MOV 	R1, #0 		
	 MOV 	R2, #1
	 
	 BL  	SUMUP
	 
	 LDR 	R3, =SUM_ODD
	 STR 	R1, [R3]

	 MOV 	R1, #0
	 MOV 	R2, #2
	 
	 BL  	SUMUP
	 
	 LDR 	R3, =SUM_EVEN 
	 STR	R1, [R3]
STOP	
         B STOP
	 END 	
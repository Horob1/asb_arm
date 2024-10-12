;tính tổng các số <= N su dung thanh ghi
	 AREA    RESET, DATA, READONLY
		 DCD  0x20001000     
		 DCD  Reset_Handler  
  
       ALIGN 
SUMP      DCD SUM 
SUM       DCD 0 
N         DCD 5 
           AREA    MYCODE, CODE, READONLY
   	   ENTRY
   	   EXPORT Reset_Handler
SUMUP 	PROC
	 ADD 	R0, R0, R1 
	 SUBS 	R1, R1, #1 	
	 BGT 	SUMUP 		
	 BX 	LR 
	 ENDP

Reset_Handler 
	 LDR 	R1, N 		
	 MOV 	R0, #0 		
	 BL  	SUMUP
	 LDR 	R3, =SUMP	
	 STR 	R0, [R3]	
    

STOP	
         B STOP
	 END 	
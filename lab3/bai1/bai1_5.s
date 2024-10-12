	;tính giá trị x^n
	 AREA    RESET, DATA, READONLY
		 DCD  0x20001000    
		 DCD  Reset_Handler  
  
       ALIGN 
XN	DCD 0 
N	DCD 7 
X	DCD 2 
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
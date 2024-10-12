; dung register
	 AREA    RESET, DATA, READONLY
		 DCD  0x20001000
		 DCD  Reset_Handler 
		 
       ALIGN 
THUONG DCD 0
DU DCD 0
SO1	DCD 7 
SO2	DCD 2 

           AREA    MYCODE, CODE, READONLY
   	   ENTRY
   	   EXPORT Reset_Handler
	   
CHIA 	PROC
	SDIV R2, R0, R1
	MUL R3, R2, R1
	SUBS R3, R0, R3
	BX LR
	ENDP

	 
Reset_Handler 
	LDR R0, SO1
	LDR R1, SO2
	BL CHIA
	LDR R0, =THUONG
	LDR R1, =DU
	STR R2, [R0]
	STR R3, [R1]
STOP	
         B STOP
	 END 	
	;tìm ước chung lớn nhất của 2 số
	 AREA    RESET, DATA, READONLY
		 DCD  0x20001000     
		 DCD  Reset_Handler  
		 
       ALIGN 
UCLN DCD 0 
SO1	DCD 7 
SO2	DCD 2 

           AREA    MYCODE, CODE, READONLY
   	   ENTRY
   	   EXPORT Reset_Handler
	   
TIM_UCLN 	PROC
	CMP R0, R1
	BGT HoanDoi
TiepTuc
	SUB R1, R0
	CMP R1, R0
	BEQ END_PROC
	B TIM_UCLN
HoanDoi
	MOV R2, R0
	MOV R0, R1
	MOV R1, R2
	B TiepTuc
END_PROC
	BX LR
	ENDP
	 
Reset_Handler 
	LDR R0, SO1
	LDR R1, SO2
	BL TIM_UCLN
	LDR R2, =UCLN
	STR R1, [R2]
STOP	
         B STOP
	 END 	
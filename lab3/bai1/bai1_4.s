	 AREA    RESET, DATA, READONLY
		 DCD  0x20001000     ; stack pointer value when stack is empty
		 DCD  Reset_Handler  ; reset vector
  
       ALIGN ; setting for alignment of the stack in memory, default 4 bytes
SUM	DCD 0 ; addressing a memory location {name: SUM, value: 0}
N	DCD 7 ; addressing a memory location {name: n, value: 7}
           AREA    MYCODE, CODE, READONLY
   	   ENTRY
   	   EXPORT Reset_Handler
SUMF 	PROC
	 ADD R1, R2
	 ADD R2, #5
	 CMP R2,R0
	 BLE SUMF
	 BX LR
	 ENDP

Reset_Handler 
	 LDR 	R0, N 		;Load count into R0
	 MOV 	R1, #0
	 MOV	R2, #0
	 BL  	SUMF
	 
	 LDR 	R2, =SUM 
	 STR	R1, [R2]
STOP	
         B STOP
	 END 	
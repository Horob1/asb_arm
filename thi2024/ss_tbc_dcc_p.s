AREA RESET, DATA, READONLY
  DCD 0x20000000
  DCD Main
col DCB 4  
row DCB 4

matrix 
	DCB  1, 2, 3, 4
	DCB 2 ,1, 5, 8
	DCB 3 ,5 ,9 ,10 
	DCB  5, 9, 8, 1 

  AREA MYCODE, CODE, READONLY
  ENTRY
Main
  LDRB R0, col
  LDRB R1, row
  CMP R0,R1
  BNE Stop
  LDR R3,=matrix
  MOV R4,#0
  LDRB R5,col
  MOV R8,#0
  MOV R9,#0
Loop_main 
	CMP R8,R0
	BEQ Loop_sub
	
  LDRB R6,[R3,R4]
	ADD R10,R6
	
  ADD R4,#1
	ADD R4,R0
	
	ADD R8,#1
	B Loop_main
Loop_sub
	CMP R9,R0
	BEQ next
	SUB R5,#1
	LDRB R7,[R3,R5]
	ADD R11,R7
	ADD R5,R0
	
	ADD R9,#1
	B Loop_sub

next
		UDIV R1,R10,R0 ; tbc main
		UDIV R0,R11,R0 ; tbc sub
; so sanh tbc 
; do co chung so phan tu tren duong treo nen chi can so sanh tong 
    CMP R10,R11
    BGT MAIN_GT_SUB
    BLT MAIN_LT_SUB
    ;
    MOV R12, #0
    B Stop
MAIN_GT_SUB    
    MOV R12, #1
    B Stop
MAIN_LT_SUB
    MOV R12, #2
    B Stop
Stop B Stop
  END
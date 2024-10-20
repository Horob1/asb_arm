	AREA RESET , DATA ,READONLY
		DCD 0x20000000
		DCD Start ; 
matrix
	DCB 3, -7, 1
	DCB -8, 2, 1
	DCB 9, -6, 2
row	DCB 3
	AREA mycode, CODE ,READONLY
	ENTRY
Start
  LDR R0, =matrix ; dia chi matran
  LDRB R1, row
  MOV R2, #0 ; offset
  MOV R3, #0
  ADD R4, #0; buoc nhay
LOOP_FIND_AVG
  CMP R2, R1
  BEQ CAL_AVG
  LDRB R5, [R0, R4]
  ADD R3, R5
  ADD R4, R1
  ADD R4, #1
  ADD R2, #1
  B LOOP_FIND_AVG
CAL_AVG
	UDIV R6, R3, R1
	MUL R5, R6, R1
	ADD R6, #1
INIT_NEXT_LOOP
	MOV R2, #0 ; offset
  MOV R3, #0
  MOV R4, #0; buoc nhay
LOOP_CHECK
  CMP R2, R1
  BEQ STOP
  LDRB R5, [R0, R4]
  CMP R5, R6
  BLT SKIP
  ADD R3, #1
SKIP
  ADD R4, R1
  ADD R4, #1
  ADD R2, #1
  B LOOP_CHECK

STOP B STOP
  END
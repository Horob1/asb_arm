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
LOOP
  CMP R2, R1
  BEQ STOP
  LDRB R5, [R0, R4]

  MOV R6, R5
  LSR R6, #1
  LSL R6, #1
  CMP R6, R5
  BNE SKIP
  ADD R3, #1
SKIP
  ADD R4, R1
  SUB R4, #1
  ADD R2, #1
  B LOOP
STOP B STOP
  END
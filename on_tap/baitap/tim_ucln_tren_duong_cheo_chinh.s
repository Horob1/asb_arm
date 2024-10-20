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

UCLN PROC
	CMP R10, R11
	BGT HoanDoi
TiepTuc
	CMP R10, R11
	BEQ Stop_P
	SUB R11, R10
	B UCLN
HoanDoi
	MOV R12, R10
	MOV R10, R11
	MOV R11, R12
	B TiepTuc
Stop_P 
	BX LR 
ENDP

Start
  LDR R0, =matrix ; dia chi matran
  LDRB R1, row
  MOV R2, #1 ; offset
  ADD R4, R1, #1
  LDRB R11, [R0]
LOOP
	CMP R2, R1
	BEQ STOP
	LDRB R10, [R0, R4]
	BL UCLN
	ADD R2, #1
  B LOOP
STOP B STOP
  END
	AREA RESET , DATA ,READONLY
		DCD 0x20000000
		DCD Start ; 
row	EQU 3
col EQU 3
matrix
	DCB 3, 7, 1
	DCB 8, 2, 1
	DCB 9, 6, 2

  AREA mydata, DATA, READWRITE
newM DCB 0
	AREA mycode, CODE ,READONLY
	ENTRY

SX PROC
  MOV R2, #col
  MUL R6, R2, R1
  ; for(i=0; i<row; i++) for(j=i+1; j<row; j++) so sanh mt[i] and mt[j] neu > thi swap mt[i] and mt[j]
	MOV R2, #0
LOOP_P_1
  CMP R2, #row
  BEQ Stop_P 
  MOV R3, R2
  ADD R3, #1
LOOP_P_2
  CMP R3, #row
  BEQ INIT_FOR_NEXT_P1
  ADD R7, R6, R2
  LDRB R4, [R8, R7]
  ADD R7, R6, R3
  LDRB R5, [R8, R7]
  CMP R4, R5
  BLE INIT_FOR_NEXT_P2
  ADD R7, R6, R2
  STRB R5, [R8, R7]
  ADD R7, R6, R3
  STRB R4, [R8, R7]  
INIT_FOR_NEXT_P2
  ADD R3, #1
  B LOOP_P_2
INIT_FOR_NEXT_P1
  ADD R2, #1
  B LOOP_P_1
Stop_P 
	BX LR 
	ENDP

Start
  LDR R0, =matrix ; dia chi matran
  LDR R8, =newM
; luu mtr => new mtr
  MOV R1, #col
  MOV R2, #row
  MUL R1, R1, R2
  MOV R2, #0
LOOP_TF_MTR
  CMP R2, R1
  BEQ END_TF_TR
  LDRB R4, [R0, R2]
  STRB R4, [R8, R2]
  ADD R2, #1
  B LOOP_TF_MTR
END_TF_TR
  MOV R1, #0
LOOP
  CMP R1, #row
  BEQ STOP
  BL SX
  ADD R1, #1
  B LOOP
STOP B STOP
  END
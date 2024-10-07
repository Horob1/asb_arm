  AREA RESET, DATA, READONLY
  DCD 0x20000000
  DCD Main
N DCB 7
K DCB 5

  AREA CODE, CODE, READONLY
  ENTRY
Main
  MOV R0, #1
  LDRB R1, N ; chua n
  MOV R2, #1; chua tu

CalNumerator 
  CMP R0, R1
  BGT InitForCalDenominator
  MUL R2,R0,R2 
  ADD R0,R0,#1
  B CalNumerator
InitForCalDenominator
  MOV R0, #1
  LDRB R3,K ; chua k
  MOV R4,#1 ; chua mau
  SUB R5,R1,R3
  CMP R5, #0
  BEQ Cal
CalDenominator
  CMP R0, R5
  BGT Cal
  MUL R4, R4, R0
  ADD R0,R0,#1
  B CalDenominator

Cal
  UDIV R0, R2, R4
Stop B Stop
  END
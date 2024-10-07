  AREA RESET, DATA, READONLY
  DCD 0x20000000
  DCD Main
col1 DCB 3
row1 DCB 3
col2 DCB 3
row2 DCB 3
m1 
  DCB 1,2,3
  DCB 1,2,3
  DCB 1,2,3
m2 
  DCB 3,2,1
  DCB 3,2,1
  DCB 3,2,1
  AREA MYDATA, DATA, READWRITE
m3 DCB 0 

  AREA MYCODE, CODE, READONLY
  ENTRY
Main
  LDRB R0, col1
  LDRB R1, col2

  CMP R0, R1
  BNE Stop

  LDRB R2, row1
  LDRB R3, row2
  BNE Stop

  MUL R0, R0, R2 ; chi can du lieu ben trong R0 ~ length
  LDR R1, =m1
  LDR R2, =m2
  LDR R3, =m3
  MOV R4, #0
Loop
  CMP R0, R4
  BEQ Stop
  LDRB R5, [R1, R4]
  LDRB R6, [R2, R4]
  SUBS R5, R5, R6
  STRB R5, [R3, R4]
  ADD R4, R4, #1
  B Loop

Stop B Stop


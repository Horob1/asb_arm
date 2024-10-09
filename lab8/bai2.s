  AREA RESET, DATA, READONLY
  DCD 0X20000000
  DCD MAIN
XauRo DCB "Sinh Vien KMA", 0
K DCB "ZYXWVUTSRQPONMLKJIHGFEDCBAzyxwvutsrqponmlkjihgfedcba"
  AREA MYDATA, DATA, READWRITE
XauMa DCB 0
  AREA MYCODE, CODE, READONLY
  ENTRY

ENCODE PROC
  CMP R1, #0x20
  BEQ STOP_P
  CMP R1, #0x61
  BLT UPPERCASE
  SUB R1, R1, #0x7B; 0x61 + 26 (decimal)
  LDRB R1, [R2, R1]
  B STOP_P
UPPERCASE
  SUB R1, R1, #0x41
  LDRB R1, [R2, R1]
  B STOP_P
STOP_P
  BX LR
  ENDP

MAIN
  LDR R0, =XauRo
  LDR R2, =K
  LDR R3, =XauMa
LOOP
  LDRB R1, [R0], #1
  CMP R1, #0
  BEQ STOP
  BL ENCODE 
  STRB R1, [R3], #1
  B LOOP
STOP B STOP
  END


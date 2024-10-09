  AREA RESET, DATA, READONLY
  DCD 0X20000000
  DCD MAIN
XauRo DCB "Sinh Vien KMA", 0
K DCB 3
  AREA MYDATA, DATA, READWRITE
XauMa DCB 0
  AREA MYCODE, CODE, READONLY
  ENTRY

ENCODE PROC
  CMP R1, #0x20
  BEQ STOP_P
  ADD R1, R1, R2

  CMP R1, #0X5A
  BLE STOP_P
  CMP R1, #0X61
  BLE HASH_UP
  CMP R1, #0X7A
  BLE STOP_P
  SUB R1, R1, #0X7A
  ADD R1, R1, #0X61
  B STOP_P
HASH_UP
  SUB R1, R1, #0X61
  ADD R1, R1, #0X5A
  B STOP_P
STOP_P
  BX LR
  ENDP

MAIN
  LDR R0, =XauRo
  LDRB R2, K
  LDR R3, =XauMa
LOOP
  LDRB R1, [R0], #1
  CMP R1, #0
  BEQ STOP
  BL ENCODE 
  STRB R1, [R3], #1
  B LOOP
  ;R2 PHAI CHUA K
  ;R1 CHUA KI HIEU CAN HASH

STOP B STOP
  END


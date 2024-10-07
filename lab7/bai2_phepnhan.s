  AREA RESET, DATA, READONLY
  DCD 0x20000000
  DCD Main
col1 EQU 2
row1 EQU 2
col2 EQU 2
row2 EQU 2
m1 
  DCB 1,2
  DCB 3,4
m2 
  DCB 5,6
  DCB 7,8
  AREA MYDATA, DATA, READWRITE
m3 DCB 0 

  AREA MYCODE, CODE, READONLY
  ENTRY
Main
  MOV R0, #col1
  MOV R1, #row2
  CMP R0, R1 ; row2 = col1 va la r3 
  BNE Stop

  LDR R0, =m1
  LDR R1, =m2
  LDR R2, =m3

;for (i=0; i<3; i++) {
; for(j=0; j<3; j++) {
;   a =0;
;   for(k=0; k<3; k++) {
;     a += m1[i,k]*m2[k,j]  
;   }
;   m3[i,j] = a
; }
;}
	MOV R4, #0
Loop_1
  CMP R4, #row1
  BEQ Stop
  MOV R5, #0
Loop_2
  CMP R5, #col2
  BEQ NEXT_L1
  MOV R6, #0
  MOV R12, #0
Loop_3
  CMP R6, #col1
  BEQ NEXT_L2
  ; tinh toan o day
  MOV R10, #row1
  MUL R10, R10, R4
  ADD R7, R10, R6 
  LDRB R7, [R0, R7]
  MOV R10, #row2
  MUL R10, R10, R6
  ADD R8, R10, R5
  LDRB R8, [R1, R8]
  MUL R9, R7, R8
  ADD R12, R12, R9 
  ;
  ADD R6, R6, #1
  B Loop_3

NEXT_L2
  ADD R5, R5, #1
  STRB R12, [R2], #1
  B Loop_2

NEXT_L1
  ADD R4, R4, #1
  B Loop_1
Stop B Stop
  END


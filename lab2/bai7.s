; tổng các số chẵn, lẻ trong ma trận
	AREA RESET , DATA ,READONLY
		DCD 0x20000000 ; do dai du lieu la bao nhieu
		DCD Start ; 
	ALIGN 
; ma tran 4*5
matrix
	DCD 3 , -7, 1 , -4, 5
	DCD -8, 3 , -1, 4, -2
	DCD 9 , -6, 2 , -3, 7
	DCD -5, 8 , -9, 1, -4
	DCD -5, 8 , -9, 1, -4
row	   DCD 5
column DCD 5
;khai bao vung nho chua ket qua	
	AREA KQ, DATA ,READWRITE
tong_chan DCD 0
tong_le DCD 0
; khai bao vung chua ma nguon
	AREA mycode, CODE ,READONLY
	EXPORT Start
	ENTRY
Start
	LDR R0, =matrix
	LDR R1, row 
	LDR R2, column
	MUL R1, R1, R2 ; length
	MOV R2, #0 ; index
	MOV R3, #0 ; index of adress by byte
	MOV R4, #0 ; Tong chan
	MOV R5, #0 ; Tong le
Loop
	CMP R2, R1
	BEQ KetQua
	LDR R6, [R0,R3]
	MOV R7, R6
	LSR R7, #1
	LSL R7, #1
	SUBS R8, R6, R7
	CMP R8, #0
	BEQ chan_cong
	ADDS R5, R6
	B buoc_nhay
chan_cong
	ADDS R4, R6
buoc_nhay
	ADD R2, #1
	ADD R3, #4
	B Loop
KetQua
	LDR R9, =tong_chan
	LDR R10, =tong_le
	STR R4, [R9]
	STR R5, [R10]
Stop 
	SWI &11
	END
	

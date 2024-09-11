; tinh tong so trong chuoi	
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
tong DCD 0
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
	MOV R4, #0 ; Tong
Loop
	CMP R2, R1
	BEQ KetQua
	LDR R5, [R0,R3]
	MOV R6, R5
	MOV R8, #5
	SDIV R6, R6, R8
	MUL R6, R6, R8
	SUBS R7, R5, R6
	CMP R7, #0
	BEQ them
	B next
them 
	ADDS R4, R5
next
	ADD R2, #1
	ADD R3, #4
	B Loop
KetQua
	LDR R8, =tong
	STR R4, [R8]
Stop 
	SWI &11
	END
	

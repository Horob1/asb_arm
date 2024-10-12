; đếm số phần tử dương, âm trong ma trận
	AREA RESET , DATA ,READONLY
		DCD 0x20000000 ; do dai du lieu la bao nhieu
		DCD Start ; 
	ALIGN 
; ma tran 4*5
matrix
	DCD 3, -7, 1, -4, 5
	DCD -8, 3, -1, 4, -2
	DCD 9, -6, 2, -3, 7
	DCD -5, 8, -9, 1, -4
row	   DCD 4
column DCD 5
;khai bao vung nho chua ket qua	
	AREA KQ, DATA ,READWRITE
COUNT_AM DCD 0
COUNT_DUONG DCD 0
; khai bao vung chua ma nguon
	AREA mycode, CODE ,READONLY
	EXPORT Start
	ENTRY
Start
	LDR R1, row
	LDR R0, column
	MUL R1, R1, R0 ; so luong phan tu trong ma tran
	LDR R0, =matrix
	MOV R2, #0 ; index
	MOV R3, #0 ; congdan
	MOV R4, #0; +
	MOV R5, #0; -
	
Loop
	CMP R2, R1
	BGE Stop
	LDR R6, [R0, R3]
	CMP R6, #0      
	BEQ next     
	BGT is_positive
	ADD R5, #1
	B next
is_positive
	ADD R4, #1
next
	ADD R2, #1
	ADD R3, #4
	B Loop
Stop 
	LDR R0, =COUNT_AM
	LDR R1, =COUNT_DUONG
	STR R4, [R1]
	STR R5, [R0]
	SWI &11
	END
	

;tính tổng các phần tử trong ma trận
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
Tong DCD 0
; khai bao vung chua ma nguon
	AREA mycode, CODE ,READONLY
	EXPORT Start
	ENTRY
Start
	LDR R1, row
	LDR R0, column
	MUL R1, R1, R0 ; so luong phan tu trong ma tran
	LDR R0, =matrix

	MOV R2, #0 ; tong
	MOV R3, #0 ; index
	MOV R4, #0 ; congdan
	
Loop
	CMP R3, R1
	BGE Stop
	LDR R5, [R0, R4]
	ADDS R2, R5
	ADDS R4, #4
	ADDS R3, #1
	B Loop
Stop 
	LDR R0, =Tong
	STR R2, [R0]
	SWI &11
	END
	

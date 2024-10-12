; tìm giá trị lớn nhất, nhỏ nhất trên đường chéo chính, chéo phụ
	AREA RESET , DATA ,READONLY
		DCD 0x20000000 ; do dai du lieu la bao nhieu
		DCD Start ; 
	ALIGN 

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
max_in_main DCD 0
min_in_main DCD 0
max_in_sub DCD 0
min_in_sub DCD 0
; khai bao vung chua ma nguon
	AREA mycode, CODE ,READONLY
	EXPORT Start
	ENTRY
Start
	MOV R0, #4
	LDR R1, row
	LDR R2, =matrix
	LDR R5, [R2]; max
	LDR R6, [R2]; min 
	; tinh tren duong cheo chinh
Initial_for_main
	MOV R8, R1
	ADD R8, #1
	MUL R0, R0, R8
	MOV R3, #0; index
	MOV R4, #0; congdan
Loop_main
	CMP R3, R1
	BGE End_main
	LDR R7, [R2, R4]
	CMP R7, R6
	BLT main_swap_min
	CMP R7, R5
	BGT main_swap_max
main_swap_max
	MOV R5, R7
	B main_next
main_swap_min
	MOV R6, R7
main_next
	ADD R4, R0
	ADD R3, #1
	B Loop_main
End_main
	LDR R7, =max_in_main
	LDR R8, =min_in_main
	STR R5, [R7]
	STR R6, [R8]
Initial_for_sub
	MOV R0, #4
	MOV R8, R1
	SUB R8, #1
	MUL R4, R8, R0 ;cong dan
	MOV R3, #0; index
	MUL R8, R8, R0
	LDR R5, [R2,R4]; max
	LDR R6, [R2,R4]; min 
Loop_sub
	CMP R3, R1
	BGE End_sub
	LDR R7, [R2, R4]
	CMP R7, R6
	BLT sub_swap_min
	CMP R7, R5
	BGT sub_swap_max
sub_swap_max
	MOV R5, R7
	B sub_next
sub_swap_min
	MOV R6, R7
sub_next
	ADD R4, R8
	ADD R3, #1
	B Loop_sub
End_sub
	LDR R7, =max_in_sub
	LDR R8, =min_in_sub
	STR R5, [R7]
	STR R6, [R8]
Stop 
	SWI &11
	END
	

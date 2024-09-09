; tinh tong so trong chuoi	
	AREA RESET , DATA ,READONLY
		DCD 0x20001000 ; do dai du lieu la bao nhieu
		DCD Start ; 
	ALIGN 
array DCD 7,3,1,4,9
length DCD 5
;khai bao vung nho chua ket qua	
	AREA KQ, DATA ,READWRITE
VALUE_MAX DCD 0
VALUE_MIN DCD 0
; khai bao vung chua ma nguon
	AREA mycode, CODE ,READONLY
	EXPORT Start
	ENTRY
Start
	LDR R0, =array ; load dia chi cua phan tu dau tien chuoi vao R0
	LDR R1, length ; load gia tri cua length va r1
	LDR R2, [R0]; min
	LDR R3, [R0]; max
	MOV R4, #4 ; cong dan
	MOV R5, #1; index
	
Loop
	CMP R5, R1
	BGE Stop
	LDR R6, [R0, R4]
	CMP R2, R6
	BLT Tiep_1
	MOV R2, R6
	B Tiep_2
Tiep_1
	CMP R3, R6
	BGT Tiep_2
	MOV R3, R6
Tiep_2
	ADD R5, #1
	ADD R4, #4
	B Loop
Stop 
	LDR R0, =VALUE_MAX
	LDR R1, =VALUE_MIN
	STR R2, [R1]
	STR R3, [R0]
	SWI &11
	END
	

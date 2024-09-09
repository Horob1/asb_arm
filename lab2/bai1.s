; tinh tong so trong chuoi	
	AREA RESET , DATA ,READONLY
		DCD 0x20001000 ; do dai du lieu la bao nhieu
		DCD Start ; 
	ALIGN 
array DCD 3,3,1,4,5
length DCD 5
;khai bao vung nho chua ket qua	
	AREA KQ, DATA ,READWRITE
Tong DCD 0
; khai bao vung chua ma nguon
	AREA mycode, CODE ,READONLY
	EXPORT Start
	ENTRY
Start
	LDR R0, =array ; load dia chi cua phan tu dau tien chuoi vao R0
	LDR R4, =length ; load dia chi cua length va r1
	LDR R4, [R4] ; r1 is free ; length
	MOV R2, #0 ; tong
	MOV R5, #0 ; cong dan
	MOV R3, #0; index
	
Loop
	CMP R3, R4
	BGE Stop
	
	LDR R1, [R0, R5]
	ADD R2, R1
	ADD R5, #4
	ADD R3, #1
	B Loop
Stop 
	LDR R3, =Tong
	STR R2, [R3]
	SWI &11
	END
	

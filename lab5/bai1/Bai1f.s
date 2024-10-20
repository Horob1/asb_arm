
/*	AREA RESET, DATA, READONLY
		DCD 0x20001000
		DCD Reset_Handler
	ALIGN
DV DCB "1AF" ;Du lieu dau vao 0x1AF
SPT DCD 3
	AREA KETQUA, DATA, READWRITE
DR DCD 0,0,0,0
KQ DCB 0
	AREA MYCODE, CODE, READONLY
;=====================================
;Doc cac ky tu
CHUYEN_CHU_SANG_CS16 PROC
	POP {R7}
	CMP R7, #0x46 ;Chu F
	BGT THOAT ; Khong hop le
	CMP R7, #0x41 ;Chu A
	SUBGE R7, #0x37 ;Chu A tuong duong voi so 10
	AND R7, #0x0F ; Dam bao rang so tu 0-Fa
	PUSH {R7}
	BX LR
	ENDP
DOC_BIT PROC
	LSRS R4, #1 
	MOVCC R5, #0 
	MOVCS R5, #1 
	STRB R5, [R2], #-1
	ADD R8,#1
	BX LR
	ENDP
	ENTRY
Reset_Handler PROC
	LDR R0, =DV
	LDR R1, SPT
	LDR R2, =DR
	MOV R3, #1
	MOV R8,#0
LOOP PROC
	CMP R3, R1
	BGT DoneChuyen16Sang2 
	LDRB R4, [R0], #1
	PUSH {R4}
	BL CHUYEN_CHU_SANG_CS16
	POP {R4}
	ADD R2, #3; Tien them 3 bit de viet nguoc lai
	BL DOC_BIT
	BL DOC_BIT
	BL DOC_BIT
	BL DOC_BIT; vi 1 ky tu o 16 -> 4 ky tu cs 2
	ADD R3, #1;
	ADD R2, #5 ;nhay den o trong tiep theo
	B LOOP
DoneChuyen16Sang2;Bat dau chuyen tu 2->8
	LDR R0,=KQ
	MOV R5,#1
	MOV R6,#2
	MOV R7,#4
Loop
	LDRB R9,[R2],#-1
	CMP R8,#0
	BLE THOAT
ChuyenTuHe2Sang8
	MOV R10,#0
	LDRB R9,[R2],#-1
	MUL R9,R5
	ADD R10,R9
	SUB R8,#1
	CMP R8,#0
	BLE GANTHOAT
	LDRB R9,[R2],#-1
	MUL R9,R6
	ADD R10,R9
	SUB R8,#1
	CMP R8,#0
	BLE GANTHOAT
	LDRB R9,[R2],#-1
	MUL R9,R7
	ADD R10,R9
	SUB R8,#1
	CMP R8,#0
	BLE GANTHOAT
	STRB R10,[R0],#-1
	B ChuyenTuHe2Sang8
GANTHOAT
	STRB R10,[R0],#-1
	B THOAT	
THOAT
	SWI &11
	END*/
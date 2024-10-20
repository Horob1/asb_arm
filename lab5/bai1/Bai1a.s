/*	AREA RESET, DATA, READONLY
		DCD 0x20001000
		DCD Reset_Handler
	ALIGN 
CR EQU 0x0D
DV DCB "1AF", CR 
DF DCD 0,0,0
SPT DCB 3
	AREA KETQUA, DATA, READWRITE
DR DCB 0
	AREA MYCODE, CODE, READONLY
	EXPORT Reset_Handler
CHUYEN_CHU_SANG_CS16 PROC
	POP {R7}
	CMP R7, #0x46 ;Chu F
	BGT THOAT ; Khong hop le
	CMP R7, #0x41 ;Chu A
	SUBGE R7, #0x37 
	AND R7, #0x0F 
	PUSH {R7}
	BX LR
	ENDP
;=====================================
;Viet ky tu ra cac o nho bang cach dich phai
;Sau day lay bit vua dich ra luu vao sau cung
;Sau day dich con tro ra truoc 
DOC_BIT PROC
	LSRS R4, #1 ; Dich phai so luu trong thanh ghi R4
	MOVCC R5, #0 ; neu bit dich ra la 0
	MOVCS R5, #1 ; neu bit dich ra la 1
	STRB R5, [R2], #-1; luu bit day vao va dich R2 ra truoc
	BX LR
	ENDP
;=====================================
	ENTRY
Reset_Handler PROC
	LDR R0, =DV
	LDR R1, SPT
	LDR R2, =DR
	MOV R3, #1
LOOP
	CMP R3, R1
	BGT THOAT 
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
THOAT
	LDR R6,=DR
	SWI &11
	END*/
;tim min, max va dem so phan tu lon hon tbc trong day so

	AREA RESET, DATA, READONLY	
		DCD 0x20000000
		DCD Main
	ALIGN
A DCB 1, 2, 5, 3, 9, 7
N DCB 6

	AREA MYCODE, CODE, READONLY
	EXPORT Main
	ENTRY
Main
	LDR R0, =A; R0 chua dia chi cua day
	LDR R1, N; R1 chua so phan tu
	LDR R2, [R0]; chi phan tu dau tien cua day
	MOV R3, R2; chua min
	MOV R4, R2; chua max
	MOV R5, R2; chua tong
	MOV R6, #1; chua index
	
LOOP
	CMP R6, R1
	BEQ STOP
	LDR R2, [R0, R6]; R2 chua phan tu hien tai
	ADD R6, R6, #1
	ADD R5, R2;
	CMP R2, R3
	BLT MIN
	CMP R2, R4
	BGT MAX
	B LOOP
	
MIN
	MOV R3, R2
	B LOOP
MAX
	MOV R4, R2
	B LOOP
STOP	
	B STOP
	END



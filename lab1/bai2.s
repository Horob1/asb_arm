; Tinh tong chan le < N
	AREA RESET, DATA, READONLY
		DCD 0x20000000
		DCD Start
	
	AREA MAINSOURCE, CODE, READONLY
		ENTRY
	
SoLuongPhanTu EQU 5

Start
	MOV R1, #0 ; Tong chan
	MOV R2, #0 ; Tong le 
	MOV R3, #0 ; Chay i -> n cua chan	
	MOV R4, #1 ; Chay i -> n cua le
	
TongSoChan 
	ADD R1, R3
	ADD R3, #2
	CMP R3, SoLuongPhanTu
	BLS TongSoChan
	
TongSoLe
	ADD R2, R4
	ADD R4, #2
	CMP R4, SoLuongPhanTu
	BLS TongSoLe

Stop
	B Stop
	END
 
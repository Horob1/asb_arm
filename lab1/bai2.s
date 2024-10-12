	AREA RESET, DATA, READONLY
		DCD 0x20000000
		DCD Start
	
	AREA MAINSOURCE, CODE, READONLY
		ENTRY
	
SoLuongPhanTu EQU 5

Start
	MOV R1, #0 
	MOV R2, #0
	MOV R3, #0 
	MOV R4, #1 
	
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
 
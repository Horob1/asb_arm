# Giải thích Bài 3 lab 2: Tính trung bình cộng của chuỗi số
	AREA RESET, DATA, READONLY
		DCD 0x20001000 ; Địa chỉ bắt đầu của dữ liệu
		DCD Start ; Địa chỉ bắt đầu của chương trình
	ALIGN 
array DCD 3, 3, 1, 4, 5  ; Chuỗi dữ liệu gồm 5 số: 3, 3, 1, 4, 5
length DCD 5             ; Độ dài của chuỗi là 5 phần tử

; Khai báo vùng nhớ chứa kết quả
	AREA KQ, DATA, READWRITE
Tong DCD 0               ; Biến lưu trữ kết quả tổng hoặc trung bình cộng

; Khai báo vùng chứa mã nguồn
	AREA mycode, CODE, READONLY
	EXPORT Start           ; Xuất nhãn Start cho chương trình
	ENTRY                  ; Điểm bắt đầu của chương trình

Start
	; Load địa chỉ của phần tử đầu tiên của chuỗi vào R0
	LDR R0, =array         ; Tải địa chỉ của chuỗi array vào R0
	
	; Load độ dài của chuỗi vào R4
	LDR R4, length         ; Tải giá trị của length vào R4 (R4 = 5)

	; Khởi tạo các thanh ghi
	MOV R2, #0             ; R2 dùng để lưu tổng
	MOV R5, #0             ; R5 dùng để tính địa chỉ của các phần tử tiếp theo
	MOV R3, #0             ; R3 là chỉ số (index = 0)

Loop
	CMP R3, R4             ; So sánh chỉ số với độ dài chuỗi
	BGE Stop               ; Nếu chỉ số >= length, nhảy đến nhãn Stop

	; Tải phần tử hiện tại của chuỗi vào R1
	LDR R1, [R0, R5]       ; Tải phần tử từ địa chỉ (R0 + R5) vào R1
	
	; Cộng giá trị của phần tử vào tổng
	ADD R2, R2, R1         ; R2 = R2 + R1
	
	; Tăng giá trị chỉ số và địa chỉ để xét phần tử tiếp theo
	ADD R5, R5, #4         ; Tăng địa chỉ (4 byte cho mỗi phần tử)
	ADD R3, R3, #1         ; Tăng chỉ số R3
	B Loop                 ; Quay lại nhãn Loop để xét phần tử tiếp theo

Stop 
	; Chia tổng cho số phần tử để tính trung bình cộng
	UDIV R2, R2, R4        ; R2 = R2 / R4 (R2 chứa trung bình cộng)
	
	; Lưu kết quả trung bình cộng vào biến Tong
	LDR R3, =Tong          ; Tải địa chỉ của biến Tong vào R3
	STR R2, [R3]           ; Lưu giá trị trung bình cộng vào biến Tong
	
	SWI &11                ; Gọi lệnh hệ thống (phụ thuộc vào hệ thống cụ thể)
	END                    ; Kết thúc chương trình

# Giải thích Bài 7 lab 1: Tìm ước chung lớn nhất (UCLN) của 2 số

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000   ; Định địa chỉ cho stack pointer
    DCD Start        ; Định địa chỉ cho nhãn Start
So1 DCD 20           ; Khai báo số thứ nhất (So1 = 20)
So2 DCD 40           ; Khai báo số thứ hai (So2 = 40)

; Khai báo vùng nhớ có tên là MAINSOURCE chứa mã nguồn, ở chế độ chỉ đọc
AREA MAINSOURCE, CODE, READONLY
    ENTRY            ; Chỉ định điểm vào của chương trình

Start
    LDR R0, So1      ; Tải giá trị của So1 vào thanh ghi R0
    LDR R1, So2      ; Tải giá trị của So2 vào thanh ghi R1

Loop
    CMP R0, R1       ; So sánh R0 và R1
    BGT HoanDoi      ; Nếu R0 > R1, nhảy tới nhãn HoanDoi

TiepTuc
    SUB R1, R0       ; R1 = R1 - R0 (lấy hiệu của R1 và R0)
    CMP R1, R0       ; So sánh giá trị mới của R1 với R0
    BEQ Stop         ; Nếu R1 = R0, tìm thấy UCLN, nhảy tới nhãn Stop
    B Loop           ; Quay lại nhãn Loop để tiếp tục lặp

HoanDoi
    MOV R2, R0       ; Lưu tạm giá trị R0 vào R2
    MOV R0, R1       ; Đổi giá trị R0 = R1
    MOV R1, R2       ; Đổi giá trị R1 = R2 (giá trị cũ của R0)
    B TiepTuc        ; Quay lại nhãn TiepTuc để tiếp tục tính toán

Stop
    B Stop           ; Dừng chương trình tại nhãn Stop (vòng lặp vô hạn)
    END              ; Kết thúc chương trình

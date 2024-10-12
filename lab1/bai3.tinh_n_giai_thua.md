# Giải thích Bài 3 Lab 1: Tính giai thừa của n

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000   ; Định địa chỉ cho stack pointer
    DCD Start        ; Định địa chỉ cho nhãn Start

; Khai báo vùng nhớ có tên là MAINSOURCE chứa mã nguồn, ở chế độ chỉ đọc
AREA MAINSOURCE, CODE, READONLY
    ENTRY            ; Chỉ định điểm vào của chương trình

; Khai báo số n (N) là 4
N EQU 4

Start
    MOV R1, #1       ; Biến đếm, bắt đầu từ 1
    MOV R2, #1       ; Biến lưu kết quả giai thừa (ban đầu là 1)

Loop
    CMP R1, N        ; So sánh giá trị R1 với N
    BGT Stop         ; Nếu R1 > N, nhảy đến nhãn Stop

    MUL R2, R1       ; R2 = R2 * R1 (tính giai thừa)
    ADD R1, #1       ; Tăng R1 lên 1 (chuyển sang giá trị tiếp theo)
    B Loop           ; Quay lại nhãn Loop để tiếp tục lặp

Stop
    B Stop           ; Dừng chương trình tại nhãn Stop (vòng lặp vô hạn)
    END              ; Kết thúc chương trình
```

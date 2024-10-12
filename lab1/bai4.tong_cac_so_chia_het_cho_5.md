# Giải thích Bài 4 Lab 1: Tính tổng các số chia hết cho 5 và nhỏ hơn hoặc bằng n

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000   ; Định địa chỉ cho stack pointer
    DCD Start        ; Định địa chỉ cho nhãn Start

; Khai báo vùng nhớ có tên là MAINSOURCE chứa mã nguồn, ở chế độ chỉ đọc
AREA MAINSOURCE, CODE, READONLY
    ENTRY            ; Chỉ định điểm vào của chương trình

; Khai báo giá trị n (N) là 16
N EQU 16

Start
    MOV R1, #0       ; R1 sẽ lưu tổng các số chia hết cho 5
    MOV R2, #5       ; R2 là biến đếm, bắt đầu từ 5 (số chia hết cho 5 nhỏ nhất)

Loop
    CMP R2, N        ; So sánh R2 với N (n)
    BGT Stop         ; Nếu R2 > N, nhảy đến nhãn Stop để dừng

    ADD R1, R2       ; Cộng R2 vào tổng R1
    ADD R2, #5       ; Tăng R2 lên 5 (chuyển sang số chia hết cho 5 tiếp theo)
    B Loop           ; Quay lại nhãn Loop để tiếp tục lặp

Stop
    B Stop           ; Dừng chương trình tại nhãn Stop (vòng lặp vô hạn)
    END              ; Kết thúc chương trình
```

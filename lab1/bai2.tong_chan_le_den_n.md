# Giải thích Bài 2 Lab 1: Tính tổng số chẵn và lẻ nhỏ hơn N

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000   ; Định địa chỉ cho stack pointer
    DCD Start        ; Định địa chỉ cho nhãn Start

; Khai báo vùng nhớ có tên là MAINSOURCE chứa mã nguồn, ở chế độ chỉ đọc
AREA MAINSOURCE, CODE, READONLY
    ENTRY            ; Chỉ định điểm vào của chương trình

; Khai báo số lượng phần tử (N) là 5
SoLuongPhanTu EQU 5

Start
    MOV R1, #0       ; R1 sẽ lưu tổng các số chẵn
    MOV R2, #0       ; R2 sẽ lưu tổng các số lẻ
    MOV R3, #0       ; R3 là biến đếm cho số chẵn (i = 0, 2, 4,...)
    MOV R4, #1       ; R4 là biến đếm cho số lẻ (i = 1, 3, 5,...)

TongSoChan
    ADD R1, R3       ; Cộng R3 vào tổng số chẵn R1
    ADD R3, #2       ; Tăng R3 lên 2 (chuyển sang số chẵn tiếp theo)
    CMP R3, SoLuongPhanTu ; So sánh R3 với N
    BLS TongSoChan   ; Nếu R3 <= N, tiếp tục vòng lặp tính tổng số chẵn

TongSoLe
    ADD R2, R4       ; Cộng R4 vào tổng số lẻ R2
    ADD R4, #2       ; Tăng R4 lên 2 (chuyển sang số lẻ tiếp theo)
    CMP R4, SoLuongPhanTu ; So sánh R4 với N
    BLS TongSoLe     ; Nếu R4 <= N, tiếp tục vòng lặp tính tổng số lẻ

Stop
    B Stop           ; Dừng chương trình tại nhãn Stop (vòng lặp vô hạn)
    END              ; Kết thúc chương trình
```

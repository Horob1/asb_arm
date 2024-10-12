# Giải thích Bài 6 lab 1: Tính tổng 1 + x^2 + x^3 + … + x^n

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000   ; Định địa chỉ cho stack pointer
    DCD Start        ; Định địa chỉ cho nhãn Start
X   DCD 2            ; Khai báo giá trị X = 2 (cơ số)

; Khai báo vùng nhớ có tên là MAINSOURCE chứa mã nguồn, ở chế độ chỉ đọc
AREA MAINSOURCE, CODE, READONLY
    ENTRY            ; Chỉ định điểm vào của chương trình

; Khai báo biến N là số mũ
N EQU 3

Start
    MOV R4, #1       ; R4 lưu tổng, khởi tạo tổng là 1 (phần tử đầu tiên trong chuỗi)
    LDR R3, X        ; Tải giá trị X vào thanh ghi R3
    MOV R0, #1       ; R0 lưu lũy thừa của X, bắt đầu từ X^1 (bằng 1)
    MOV R1, #0       ; R1 là biến đếm, bắt đầu từ 0

Loop
    CMP R1, #N       ; So sánh R1 với N
    BEQ Stop         ; Nếu R1 = N, kết thúc vòng lặp

    MUL R0, R0, R3   ; R0 = R0 * R3 (tính lũy thừa tiếp theo của X)
    ADD R4, R0       ; Cộng giá trị R0 (lũy thừa hiện tại của X) vào tổng R4
    ADD R1, #1       ; Tăng R1 lên 1 (đếm lũy thừa tiếp theo)
    B Loop           ; Quay lại nhãn Loop để tiếp tục lặp

Stop
    B Stop           ; Dừng chương trình tại nhãn Stop (vòng lặp vô hạn)
    END              ; Kết thúc chương trình
```

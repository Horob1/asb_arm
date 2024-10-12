# Giải thích Bài 5 lab 1: Tính giá trị x^n (Lũy thừa của x với n)

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000   ; Định địa chỉ cho stack pointer
    DCD START        ; Định địa chỉ cho nhãn START
X   DCD 2            ; Khai báo biến X = 2 (giá trị của x)

; Khai báo vùng nhớ có tên là SOURCE chứa mã nguồn, ở chế độ chỉ đọc
AREA SOURCE, CODE, READONLY
    ENTRY            ; Chỉ định điểm vào của chương trình

; Khai báo hằng số N là 3 (n = 3)
N EQU 3

START
    MOV R0, #1       ; Biến lưu kết quả lũy thừa (ban đầu bằng 1)
    MOV R1, #1       ; Biến đếm, bắt đầu từ 1
    LDR R2, X        ; Tải giá trị của X vào thanh ghi R2

LOOP
    CMP R1, #N       ; So sánh R1 với N (số mũ n)
    BGT STOP         ; Nếu R1 > N, nhảy tới nhãn STOP để kết thúc

    MUL R0, R0, R2   ; R0 = R0 * R2 (nhân kết quả lũy thừa với X)
    ADD R1, #1       ; Tăng R1 lên 1 (chuyển sang lũy thừa tiếp theo)
    B LOOP           ; Quay lại nhãn LOOP để tiếp tục lặp

STOP
    B STOP           ; Dừng chương trình tại nhãn STOP (vòng lặp vô hạn)
    END              ; Kết thúc chương trình
```

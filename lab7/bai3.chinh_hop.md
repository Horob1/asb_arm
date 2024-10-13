# Giải thích Bài 3 lab 7: Tính tổ hợp (nCk)

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000   ; Định địa chỉ cho stack pointer
    DCD Main         ; Định địa chỉ cho nhãn Main

; Khai báo giá trị n và k
N DCB 7              ; Khai báo n = 7
K DCB 5              ; Khai báo k = 5

; Khai báo vùng mã nguồn
AREA CODE, CODE, READONLY
    ENTRY            ; Chỉ định điểm vào của chương trình

Main
    MOV R0, #1       ; R0 là biến đếm ban đầu, khởi tạo bằng 1
    LDRB R1, N       ; Load giá trị n vào R1
    MOV R2, #1       ; R2 sẽ lưu tử số của tổ hợp (ban đầu là 1)

; Bắt đầu tính tử số (numerator)
CalNumerator
    CMP R0, R1       ; So sánh R0 với n
    BGT InitForCalDenominator  ; Nếu R0 > n, nhảy đến tính mẫu số
    MUL R2, R0, R2   ; Tử số = tử số * R0
    ADD R0, R0, #1   ; Tăng R0 lên 1
    B CalNumerator   ; Quay lại nhãn để tiếp tục tính tử số

; Bắt đầu tính mẫu số (denominator)
InitForCalDenominator
    MOV R0, #1       ; Reset lại R0 về 1 để bắt đầu tính mẫu
    LDRB R3, K       ; Load giá trị k vào R3
    MOV R4, #1       ; R4 sẽ lưu mẫu số (ban đầu là 1)
    SUB R5, R1, R3   ; R5 = n - k
    CMP R5, #0       ; Kiểm tra nếu R5 = 0
    BEQ Cal          ; Nếu R5 = 0, nhảy đến nhãn tính kết quả

CalDenominator
    CMP R0, R5       ; So sánh R0 với R5
    BGT Cal          ; Nếu R0 > R5, nhảy đến nhãn tính kết quả
    MUL R4, R4, R0   ; Mẫu số = mẫu số * R0
    ADD R0, R0, #1   ; Tăng R0 lên 1
    B CalDenominator ; Quay lại nhãn để tiếp tục tính mẫu số

; Tính tổ hợp (nCk)
Cal
    UDIV R0, R2, R4  ; Chia tử số cho mẫu số, kết quả lưu trong R0

Stop
    B Stop           ; Dừng chương trình tại nhãn Stop (vòng lặp vô hạn)
    END              ; Kết thúc chương trình
```

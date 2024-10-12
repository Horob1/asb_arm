# Giải thích Bài 1.1 Lab 3: Tính tổng các số nhỏ hơn hoặc bằng N sử dụng thanh ghi chung

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000      ; Địa chỉ bắt đầu cho stack pointer
    DCD Reset_Handler    ; Địa chỉ cho hàm Reset_Handler

ALIGN
SUMP DCD SUM           ; Địa chỉ lưu tổng
SUM DCD 0              ; Khởi tạo tổng bằng 0
N DCD 5                ; Giá trị N là 5

; Khai báo vùng mã nguồn
AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

SUMUP PROC
    ADD R0, R0, R1      ; Cộng R1 vào R0 (tính tổng)
    SUBS R1, R1, #1     ; Giảm R1 đi 1, đồng thời cập nhật cờ (flags)
    BGT SUMUP           ; Nếu R1 > 0, nhảy tới nhãn SUMUP
    BX LR               ; Quay lại hàm gọi

ENDP

Reset_Handler
    LDR R1, N           ; Tải giá trị N vào R1
    MOV R0, #0          ; Khởi tạo R0 = 0 (biến lưu tổng)
    BL SUMUP            ; Gọi hàm SUMUP
    LDR R3, =SUMP       ; Tải địa chỉ của SUMP vào R3
    STR R0, [R3]       ; Lưu giá trị tổng vào địa chỉ SUMP

STOP
    B STOP              ; Dừng tại nhãn STOP (vòng lặp vô hạn)
END
```

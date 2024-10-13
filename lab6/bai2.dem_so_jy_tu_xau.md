# Giải thích Bài 2 lab 6: Đếm số ký tự của chuỗi dựa trên ký tự kết thúc (CR)

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
CR  EQU 0x0D           ; Đặt ký tự CR (Carriage Return) là 0x0D

AREA RESET, DATA, READONLY
    DCD 0x20001000     ; Định địa chỉ cho stack pointer
    DCD Main           ; Định địa chỉ bắt đầu của chương trình

; Khai báo chuỗi cần đếm ký tự
Table DCB "Hello, World", CR  ; Chuỗi kết thúc bằng ký tự CR (0x0D)

; Khai báo vùng chứa mã nguồn của chương trình
AREA Program, CODE, READONLY
    ENTRY              ; Chỉ định điểm vào của chương trình

Main
    ; Tải địa chỉ chuỗi vào thanh ghi R0, và khởi tạo bộ đếm R1
    LDR R0, =Table     ; Tải địa chỉ chuỗi Table vào R0
    MOV R1, #0         ; Khởi tạo bộ đếm R1 = 0

Loop
    ; Đọc từng ký tự của chuỗi và kiểm tra ký tự kết thúc CR
    LDRB R2, [R0], #1  ; Tải ký tự hiện tại vào R2, tăng R0 lên 1
    CMP R2, #CR        ; So sánh ký tự hiện tại với ký tự CR
    BEQ Stop           ; Nếu gặp ký tự CR, nhảy tới nhãn Stop để dừng

    ; Tăng bộ đếm
    ADD R1, R1, #1     ; Tăng giá trị bộ đếm R1 lên 1
    B Loop             ; Quay lại nhãn Loop để đọc ký tự tiếp theo

Stop
    B Stop             ; Dừng chương trình tại nhãn Stop (vòng lặp vô hạn)
    END                ; Kết thúc chương trình
```

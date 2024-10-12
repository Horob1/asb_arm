# Giải thích Bài 1 Lab 1 Tính tổng các số từ 1 đến N

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY

; Định địa chỉ đầu cho stack (thanh ghi stack pointer)
    DCD 0x20000000

; Định địa chỉ cho nhãn START
    DCD START

; Khai báo vùng nhớ có tên là MAINSOURCE, chứa mã nguồn, ở chế độ chỉ đọc
AREA MAINSOURCE, CODE, READONLY
    ENTRY

START
    ; Khởi tạo giá trị
    MOV R2, #0    ; Đặt thanh ghi R2 = 0, đây sẽ là biến tổng (sum)
    MOV R1, #1    ; Đặt thanh ghi R1 = 1, đây là biến chạy (counter)

LOOP
    CMP R1, #5    ; So sánh giá trị của R1 với 5 (n = 5)
    BGT STOP      ; Nếu R1 > 5, nhảy đến nhãn STOP

    ; Thực hiện cộng dồn
    ADD R2, R1    ; R2 = R2 + R1 (cộng giá trị của R1 vào tổng R2)
    ADD R1, #1    ; R1 = R1 + 1 (tăng giá trị biến chạy lên 1)
    B LOOP        ; Nhảy về nhãn LOOP để lặp lại

STOP
    B STOP        ; Dừng lại ở nhãn STOP và lặp vô hạn tại đó

    END           ; Kết thúc chương trình
```

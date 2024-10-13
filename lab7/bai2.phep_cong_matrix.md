# Giải thích Bài 2-1 lab 7: Cộng hai ma trận 3x3

```assembly
; Khai báo vùng nhớ RESET, lưu dữ liệu ma trận và các kích thước ma trận ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000     ; Địa chỉ khởi tạo
    DCD Main           ; Địa chỉ bắt đầu của chương trình

col1 DCB 3             ; Số cột của ma trận 1 (3 cột)
row1 DCB 3             ; Số hàng của ma trận 1 (3 hàng)
col2 DCB 3             ; Số cột của ma trận 2 (3 cột)
row2 DCB 3             ; Số hàng của ma trận 2 (3 hàng)

; Khai báo ma trận 1 (m1) và ma trận 2 (m2) với các giá trị tương ứng
m1
    DCB 1,2,3          ; Hàng 1 của ma trận 1
    DCB 1,2,3          ; Hàng 2 của ma trận 1
    DCB 1,2,3          ; Hàng 3 của ma trận 1

m2
    DCB 3,2,1          ; Hàng 1 của ma trận 2
    DCB 3,2,1          ; Hàng 2 của ma trận 2
    DCB 3,2,1          ; Hàng 3 của ma trận 2

; Khai báo vùng nhớ MYDATA chứa ma trận kết quả (m3)
AREA MYDATA, DATA, READWRITE
m3 DCB 0               ; Ma trận 3 sẽ lưu kết quả cộng của m1 và m2

; Khai báo vùng mã nguồn (chứa chương trình) và đánh dấu điểm vào chương trình
AREA MYCODE, CODE, READONLY
ENTRY

Main
    LDRB R0, col1       ; Load số cột của ma trận 1 vào R0
    LDRB R1, col2       ; Load số cột của ma trận 2 vào R1
    CMP R0, R1          ; So sánh số cột của hai ma trận
    BNE Stop            ; Nếu số cột khác nhau, dừng chương trình

    LDRB R2, row1       ; Load số hàng của ma trận 1 vào R2
    LDRB R3, row2       ; Load số hàng của ma trận 2 vào R3
    CMP R2, R3          ; So sánh số hàng của hai ma trận
    BNE Stop            ; Nếu số hàng khác nhau, dừng chương trình

    MUL R0, R0, R2      ; Tính tổng số phần tử (R0 = số hàng * số cột)

    LDR R1, =m1         ; Load địa chỉ của ma trận 1 vào R1
    LDR R2, =m2         ; Load địa chỉ của ma trận 2 vào R2
    LDR R3, =m3         ; Load địa chỉ của ma trận 3 (kết quả) vào R3
    MOV R4, #0          ; Khởi tạo bộ đếm R4 = 0

Loop
    CMP R0, R4          ; Kiểm tra nếu đã cộng hết các phần tử
    BEQ Stop            ; Nếu hết, dừng chương trình

    LDRB R5, [R1, R4]   ; Lấy phần tử từ ma trận 1 (m1) tại vị trí R4 vào R5
    LDRB R6, [R2, R4]   ; Lấy phần tử từ ma trận 2 (m2) tại vị trí R4 vào R6
    ADDS R5, R5, R6     ; Cộng hai phần tử: R5 = R5 + R6
    STRB R5, [R3, R4]   ; Lưu kết quả vào ma trận 3 (m3) tại vị trí R4
    ADD R4, R4, #1      ; Tăng bộ đếm R4 lên 1
    B Loop              ; Lặp lại vòng lặp cho đến khi xử lý hết các phần tử

Stop
    B Stop              ; Dừng chương trình và lặp vô hạn tại nhãn Stop

END                     ; Kết thúc chương trình
```

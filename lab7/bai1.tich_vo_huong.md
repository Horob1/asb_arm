# Giải thích Bài 1 lab 7: Nhân hai vector và tính tổng (Dot Product of Two Vectors)

```assembly
; Khai báo vùng nhớ RESET, lưu dữ liệu ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000        ; Địa chỉ khởi tạo
    DCD Main              ; Địa chỉ bắt đầu của chương trình

LENGTH DCB 5              ; Số phần tử của hai vector (5 phần tử)
VECTOR_1 DCB 1,1,1,1,1    ; Vector thứ nhất với các phần tử [1, 1, 1, 1, 1]
VECTOR_2 DCB 2,2,2,2,2    ; Vector thứ hai với các phần tử [2, 2, 2, 2, 2]

; Khai báo vùng mã nguồn (chứa chương trình)
AREA CODE, CODE, READONLY
ENTRY                     ; Đánh dấu điểm vào của chương trình

Main
    LDRB R0, LENGTH        ; Load số lượng phần tử từ LENGTH vào R0
    CMP R0, #0             ; Kiểm tra xem LENGTH có bằng 0 không
    BEQ Stop               ; Nếu LENGTH = 0, dừng chương trình

    LDR R1, =VECTOR_1      ; Load địa chỉ của VECTOR_1 vào R1
    LDR R2, =VECTOR_2      ; Load địa chỉ của VECTOR_2 vào R2
    MOV R6, #0             ; Khởi tạo biến tổng (R6 = 0)

Loop
    LDRB R3, [R1], #1      ; Load phần tử tiếp theo của VECTOR_1 vào R3
    LDRB R4, [R2], #1      ; Load phần tử tiếp theo của VECTOR_2 vào R4
    MUL R5, R3, R4         ; Nhân hai phần tử: R5 = R3 * R4
    ADDS R6, R6, R5        ; Cộng kết quả vào tổng: R6 = R6 + R5
    SUBS R0, R0, #1        ; Giảm R0 (đếm ngược số phần tử)
    CMP R0, #0             ; Kiểm tra nếu đã hết phần tử
    BNE Loop               ; Nếu chưa hết, lặp lại

Stop
    B Stop                 ; Dừng chương trình và lặp vô hạn tại nhãn Stop

END                        ; Kết thúc chương trình
```

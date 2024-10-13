# Giải thích Bài 2-3 lab 7: Nhân hai ma trận 2x2

```assembly
AREA RESET, DATA, READONLY
    DCD 0x20000000     ; Địa chỉ khởi tạo
    DCD Main           ; Địa chỉ bắt đầu của chương trình

; Khai báo kích thước ma trận
col1 EQU 2             ; Số cột của ma trận 1
row1 EQU 2             ; Số hàng của ma trận 1
col2 EQU 2             ; Số cột của ma trận 2
row2 EQU 2             ; Số hàng của ma trận 2

; Khai báo các ma trận
m1
    DCB 1, 2           ; Hàng 1 của ma trận 1: [1, 2]
    DCB 3, 4           ; Hàng 2 của ma trận 1: [3, 4]

m2
    DCB 5, 6           ; Hàng 1 của ma trận 2: [5, 6]
    DCB 7, 8           ; Hàng 2 của ma trận 2: [7, 8]

; Khai báo vùng nhớ để lưu kết quả ma trận m3
AREA MYDATA, DATA, READWRITE
m3 DCB 0               ; Ma trận kết quả sau phép nhân

; Khai báo mã lệnh
AREA MYCODE, CODE, READONLY
ENTRY

Main
    MOV R0, #col1      ; Load số cột của ma trận 1 vào R0
    MOV R1, #row2      ; Load số hàng của ma trận 2 vào R1
    CMP R0, R1         ; Kiểm tra điều kiện hàng của ma trận 2 phải bằng cột của ma trận 1
    BNE Stop           ; Nếu không thỏa mãn, dừng chương trình

    LDR R0, =m1        ; Load địa chỉ ma trận 1 vào R0
    LDR R1, =m2        ; Load địa chỉ ma trận 2 vào R1
    LDR R2, =m3        ; Load địa chỉ ma trận kết quả vào R2

; Vòng lặp thực hiện nhân ma trận
; for (i = 0; i < 2; i++)
    MOV R4, #0         ; Khởi tạo biến đếm i = 0

Loop_1
    CMP R4, #row1      ; Kiểm tra nếu i < số hàng ma trận 1
    BEQ Stop           ; Nếu i >= số hàng, dừng chương trình

    MOV R5, #0         ; Khởi tạo biến đếm j = 0

; for (j = 0; j < 2; j++)
Loop_2
    CMP R5, #col2      ; Kiểm tra nếu j < số cột ma trận 2
    BEQ NEXT_L1        ; Nếu j >= số cột, quay lại vòng lặp i

    MOV R6, #0         ; Khởi tạo biến đếm k = 0
    MOV R12, #0        ; Khởi tạo biến lưu tạm thời kết quả nhân tích lũy

; for (k = 0; k < 2; k++)
Loop_3
    CMP R6, #col1      ; Kiểm tra nếu k < số cột ma trận 1
    BEQ NEXT_L2        ; Nếu k >= số cột, dừng vòng lặp k

    ; Tính toán: m1[i,k] * m2[k,j]
    MOV R10, #row1     ; Tính offset của m1[i,k]
    MUL R10, R10, R4   ; R10 = i * số cột ma trận 1
    ADD R7, R10, R6    ; R7 = i * số cột + k
    LDRB R7, [R0, R7]  ; Load phần tử m1[i,k] vào R7

    MOV R10, #row2     ; Tính offset của m2[k,j]
    MUL R10, R10, R6   ; R10 = k * số cột ma trận 2
    ADD R8, R10, R5    ; R8 = k * số cột + j
    LDRB R8, [R1, R8]  ; Load phần tử m2[k,j] vào R8

    ; Nhân m1[i,k] * m2[k,j] và cộng dồn vào kết quả
    MUL R9, R7, R8     ; R9 = m1[i,k] * m2[k,j]
    ADD R12, R12, R9   ; R12 += R9 (tích lũy kết quả)

    ; Tăng k và quay lại vòng lặp k
    ADD R6, R6, #1
    B Loop_3

; Lưu kết quả vào m3[i,j]
NEXT_L2
    ADD R5, R5, #1     ; Tăng biến đếm j
    STRB R12, [R2], #1 ; Lưu kết quả vào m3[i,j]
    B Loop_2           ; Quay lại vòng lặp j

; Quay lại vòng lặp i
NEXT_L1
    ADD R4, R4, #1     ; Tăng biến đếm i
    B Loop_1           ; Quay lại vòng lặp i

; Kết thúc chương trình
Stop
    B Stop
    END
```

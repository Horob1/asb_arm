# Giải thích Bài 8 lab 2: Tính tổng các số chia hết cho 5 trong ma trận

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000   ; Định địa chỉ cho stack pointer
    DCD Start        ; Định địa chỉ cho nhãn Start
    ALIGN            ; Đảm bảo vùng nhớ được căn chỉnh

; Khai báo ma trận 4x5
matrix
    DCD 3, -7, 1, -4, 5
    DCD -8, 3, -1, 4, -2
    DCD 9, -6, 2, -3, 7
    DCD -5, 8, -9, 1, -4
    DCD -5, 8, -9, 1, -4

; Khai báo số hàng và số cột của ma trận
row     DCD 4        ; Số hàng
column  DCD 5        ; Số cột

; Khai báo vùng nhớ chứa kết quả
AREA KQ, DATA, READWRITE
tong DCD 0           ; Tổng các số chia hết cho 5

; Khai báo vùng chứa mã nguồn
AREA mycode, CODE, READONLY
    EXPORT Start
    ENTRY

Start
    LDR R0, =matrix  ; Tải địa chỉ của ma trận vào R0
    LDR R1, row      ; Tải số hàng vào R1
    LDR R2, column   ; Tải số cột vào R2
    MUL R1, R1, R2   ; Tính số phần tử trong ma trận (R1 = rows * columns)
    MOV R2, #0       ; Khởi tạo biến chỉ số (index) bằng 0
    MOV R3, #0       ; Khởi tạo chỉ số địa chỉ tính bằng byte (tính từ 0)
    MOV R4, #0       ; Khởi tạo tổng các số chia hết cho 5 bằng 0

Loop
    CMP R2, R1       ; So sánh chỉ số với số phần tử
    BEQ KetQua       ; Nếu chỉ số == số phần tử, nhảy đến nhãn KetQua

    LDR R5, [R0, R3] ; Tải giá trị tại vị trí (R0 + R3) vào R5
    MOV R6, R5       ; Sao chép giá trị R5 vào R6 để thực hiện kiểm tra chia hết
    MOV R8, #5       ; Tải giá trị 5 vào R8

    SDIV R6, R6, R8  ; Chia R6 cho 5
    MUL R6, R6, R8   ; Nhân lại R6 với 5 (tính giá trị chia hết cho 5)
    SUBS R7, R5, R6  ; Tính R7 = R5 - R6 (R7 = 0 nếu R5 chia hết cho 5)
    CMP R7, #0       ; So sánh R7 với 0
    BEQ them         ; Nếu R7 == 0, nhảy đến nhãn them

    B next           ; Nhảy đến nhãn next nếu không chia hết

them
    ADDS R4, R5      ; Nếu R5 chia hết cho 5, cộng vào tổng R4

next
    ADD R2, #1       ; Tăng chỉ số index lên 1
    ADD R3, #4       ; Tăng chỉ số địa chỉ lên 4 (tính theo byte)
    B Loop           ; Quay lại nhãn Loop để tiếp tục lặp

KetQua
    LDR R8, =tong    ; Tải địa chỉ của biến tổng vào R8
    STR R4, [R8]     ; Lưu tổng vào vùng nhớ

Stop
    SWI &11          ; Dừng chương trình
    END              ; Kết thúc chương trình
```

# Giải thích Bài 7 lab 2: Tính tổng các số chẵn và lẻ trong ma trận

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

; Khai báo số hàng và số cột của ma trận
row     DCD 4        ; Số hàng
column  DCD 5        ; Số cột

; Khai báo vùng nhớ chứa kết quả
AREA KQ, DATA, READWRITE
tong_chan DCD 0      ; Tổng các số chẵn
tong_le   DCD 0      ; Tổng các số lẻ

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
    MOV R3, #0       ; Khởi tạo chỉ số địa chỉ bằng 0 (tính bằng byte)
    MOV R4, #0       ; Khởi tạo tổng các số chẵn bằng 0
    MOV R5, #0       ; Khởi tạo tổng các số lẻ bằng 0

Loop
    CMP R2, R1       ; So sánh index với số phần tử
    BEQ KetQua       ; Nếu index == số phần tử, nhảy đến nhãn KetQua

    LDR R6, [R0, R3] ; Tải giá trị ma trận tại vị trí (R0 + R3) vào R6
    MOV R7, R6       ; Sao chép giá trị R6 vào R7
    LSR R7, #1       ; Dịch phải R7 1 bit (chia cho 2)
    LSL R7, #1       ; Dịch trái R7 1 bit (nhân với 2)

    SUBS R8, R6, R7  ; Tính R8 = R6 - R7 (R8 = 0 nếu số chẵn, khác 0 nếu số lẻ)
    CMP R8, #0       ; So sánh R8 với 0
    BEQ chan_cong    ; Nếu R8 == 0, nhảy đến nhãn chan_cong

    ADDS R5, R6      ; Nếu là số lẻ, cộng vào tổng lẻ
    B buoc_nhay      ; Nhảy đến nhãn buoc_nhay

chan_cong
    ADDS R4, R6      ; Nếu là số chẵn, cộng vào tổng chẵn

buoc_nhay
    ADD R2, #1       ; Tăng chỉ số index lên 1
    ADD R3, #4       ; Tăng chỉ số địa chỉ lên 4 (tính theo byte)
    B Loop           ; Quay lại nhãn Loop để tiếp tục lặp

KetQua
    LDR R9, =tong_chan  ; Tải địa chỉ của biến tổng chẵn vào R9
    LDR R10, =tong_le    ; Tải địa chỉ của biến tổng lẻ vào R10
    STR R4, [R9]         ; Lưu tổng chẵn vào vùng nhớ
    STR R5, [R10]        ; Lưu tổng lẻ vào vùng nhớ

Stop 
    SWI &11              ; Dừng chương trình
    END                  ; Kết thúc chương trình

# Giải thích Bài 5 lab 2: Đếm số phần tử dương và âm trong ma trận

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000   ; Định địa chỉ cho stack pointer
    DCD Start        ; Địa chỉ bắt đầu chương trình
    ALIGN            ; Đảm bảo căn chỉnh bộ nhớ

; Khai báo ma trận 4x5
matrix
    DCD 3, -7, 1, -4, 5    ; Dòng 1
    DCD -8, 3, -1, 4, -2    ; Dòng 2
    DCD 9, -6, 2, -3, 7     ; Dòng 3
    DCD -5, 8, -9, 1, -4    ; Dòng 4
row   DCD 4                  ; Số dòng của ma trận
column DCD 5                 ; Số cột của ma trận

; Khai báo vùng nhớ chứa kết quả
AREA KQ, DATA, READWRITE
COUNT_AM DCD 0               ; Biến lưu số lượng phần tử âm
COUNT_DUONG DCD 0            ; Biến lưu số lượng phần tử dương

; Khai báo vùng chứa mã nguồn
AREA mycode, CODE, READONLY
EXPORT Start                ; Xuất nhãn Start để chương trình có thể gọi
ENTRY                       ; Chỉ định điểm vào của chương trình

Start
    LDR R1, row             ; Tải số dòng vào thanh ghi R1
    LDR R0, column          ; Tải số cột vào thanh ghi R0
    MUL R1, R1, R0          ; Tính số lượng phần tử trong ma trận (R1 = row * column)
    LDR R0, =matrix         ; Tải địa chỉ ma trận vào thanh ghi R0
    MOV R2, #0              ; Khởi tạo biến index (R2) bằng 0
    MOV R3, #0              ; Khởi tạo biến offset (congdan) bằng 0
    MOV R4, #0              ; Khởi tạo biến đếm số phần tử dương (R4) bằng 0
    MOV R5, #0              ; Khởi tạo biến đếm số phần tử âm (R5) bằng 0

Loop
    CMP R2, R1              ; So sánh chỉ số index (R2) với số lượng phần tử (R1)
    BGE Stop                 ; Nếu index >= số lượng phần tử, nhảy đến nhãn Stop

    LDR R6, [R0, R3]         ; Tải phần tử hiện tại từ ma trận vào R6
    CMP R6, #0               ; So sánh giá trị R6 với 0
    BEQ next                 ; Nếu bằng 0, nhảy đến nhãn next
    BGT is_positive          ; Nếu lớn hơn 0, nhảy đến nhãn is_positive

    ; Nếu phần tử nhỏ hơn 0
    ADD R5, #1               ; Tăng biến đếm số phần tử âm (R5) lên 1
    B next                   ; Nhảy đến nhãn next

is_positive
    ADD R4, #1               ; Tăng biến đếm số phần tử dương (R4) lên 1

next
    ADD R2, #1               ; Tăng chỉ số index (R2) lên 1
    ADD R3, #4               ; Tăng offset (congdan) lên 4 (kích thước mỗi phần tử là 4 byte)
    B Loop                   ; Quay lại nhãn Loop để tiếp tục lặp

Stop
    LDR R0, =COUNT_AM        ; Tải địa chỉ biến COUNT_AM vào R0
    LDR R1, =COUNT_DUONG     ; Tải địa chỉ biến COUNT_DUONG vào R1
    STR R4, [R1]             ; Lưu số lượng phần tử dương vào biến COUNT_DUONG
    STR R5, [R0]             ; Lưu số lượng phần tử âm vào biến COUNT_AM
    SWI &11                  ; Gọi dịch vụ hệ thống để kết thúc chương trình
    END                      ; Kết thúc chương trình
```

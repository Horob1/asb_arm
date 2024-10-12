# Giải thích Bài 6 lab 2: Tìm giá trị lớn nhất và nhỏ nhất trên đường chéo chính và chéo phụ của ma trận 5x5

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20000000   ; Định địa chỉ cho stack pointer
    DCD Start        ; Địa chỉ bắt đầu chương trình
    ALIGN            ; Đảm bảo căn chỉnh bộ nhớ

; Khai báo ma trận 5x5
matrix
    DCD 3 , -7, 1 , -4, 5    ; Dòng 1
    DCD -8, 3 , -1, 4, -2     ; Dòng 2
    DCD 9 , -6, 2 , -3, 7     ; Dòng 3
    DCD -5, 8 , -9, 1, -4     ; Dòng 4
    DCD -5, 8 , -9, 1, -4     ; Dòng 5
row   DCD 5                  ; Số dòng của ma trận
column DCD 5                 ; Số cột của ma trận

; Khai báo vùng nhớ chứa kết quả
AREA KQ, DATA, READWRITE
max_in_main DCD 0           ; Biến lưu giá trị lớn nhất trên đường chéo chính
min_in_main DCD 0           ; Biến lưu giá trị nhỏ nhất trên đường chéo chính
max_in_sub DCD 0            ; Biến lưu giá trị lớn nhất trên đường chéo phụ
min_in_sub DCD 0            ; Biến lưu giá trị nhỏ nhất trên đường chéo phụ

; Khai báo vùng chứa mã nguồn
AREA mycode, CODE, READONLY
EXPORT Start                ; Xuất nhãn Start để chương trình có thể gọi
ENTRY                       ; Chỉ định điểm vào của chương trình

Start
    MOV R0, #4              ; Khởi tạo R0 với 4 (kích thước mỗi phần tử ma trận)
    LDR R1, row             ; Tải số dòng vào thanh ghi R1
    LDR R2, =matrix         ; Tải địa chỉ ma trận vào thanh ghi R2
    LDR R5, [R2]            ; Lưu giá trị đầu tiên vào R5 (max)
    LDR R6, [R2]            ; Lưu giá trị đầu tiên vào R6 (min)

    ; Tính toán trên đường chéo chính
Initial_for_main
    MOV R8, R1
    ADD R8, #1
    MUL R0, R0, R8           ; Tính kích thước dòng để truy cập
    MOV R3, #0               ; Khởi tạo chỉ số index (R3) bằng 0
    MOV R4, #0               ; Khởi tạo offset (congdan) bằng 0

Loop_main
    CMP R3, R1               ; So sánh chỉ số index với số lượng dòng
    BGE End_main             ; Nếu index >= số lượng dòng, nhảy đến nhãn End_main
    LDR R7, [R2, R4]         ; Tải phần tử hiện tại từ ma trận vào R7
    CMP R7, R6               ; So sánh giá trị R7 với giá trị min
    BLT main_swap_min        ; Nếu R7 < min, nhảy đến nhãn main_swap_min
    CMP R7, R5               ; So sánh R7 với max
    BGT main_swap_max        ; Nếu R7 > max, nhảy đến nhãn main_swap_max

main_swap_max
    MOV R5, R7               ; Cập nhật giá trị max
    B main_next              ; Nhảy đến nhãn main_next

main_swap_min
    MOV R6, R7               ; Cập nhật giá trị min

main_next
    ADD R4, R0               ; Cập nhật offset cho phần tử tiếp theo
    ADD R3, #1               ; Tăng chỉ số index lên 1
    B Loop_main              ; Quay lại nhãn Loop_main để tiếp tục lặp

End_main
    LDR R7, =max_in_main     ; Tải địa chỉ biến max_in_main vào R7
    LDR R8, =min_in_main     ; Tải địa chỉ biến min_in_main vào R8
    STR R5, [R7]             ; Lưu giá trị max vào biến max_in_main
    STR R6, [R8]             ; Lưu giá trị min vào biến min_in_main

; Tính toán trên đường chéo phụ
Initial_for_sub
    MOV R0, #4               ; Khởi tạo lại R0 với 4
    MOV R8, R1
    SUB R8, #1               ; Giảm R8 đi 1 để tính chỉ số cho đường chéo phụ
    MUL R4, R8, R0           ; Tính offset cho đường chéo phụ
    MOV R3, #0               ; Khởi tạo chỉ số index cho đường chéo phụ
    MUL R8, R8, R0           ; Tính kích thước đường chéo phụ
    LDR R5, [R2, R4]         ; Lưu giá trị đầu tiên của đường chéo phụ vào R5 (max)
    LDR R6, [R2, R4]         ; Lưu giá trị đầu tiên của đường chéo phụ vào R6 (min)

Loop_sub
    CMP R3, R1               ; So sánh chỉ số index với số lượng dòng
    BGE End_sub              ; Nếu index >= số lượng dòng, nhảy đến nhãn End_sub
    LDR R7, [R2, R4]         ; Tải phần tử hiện tại từ đường chéo phụ vào R7
    CMP R7, R6               ; So sánh R7 với min
    BLT sub_swap_min         ; Nếu R7 < min, nhảy đến nhãn sub_swap_min
    CMP R7, R5               ; So sánh R7 với max
    BGT sub_swap_max         ; Nếu R7 > max, nhảy đến nhãn sub_swap_max

sub_swap_max
    MOV R5, R7               ; Cập nhật giá trị max

    B sub_next               ; Nhảy đến nhãn sub_next

sub_swap_min
    MOV R6, R7               ; Cập nhật giá trị min

sub_next
    ADD R4, R8               ; Cập nhật offset cho phần tử tiếp theo
    ADD R3, #1               ; Tăng chỉ số index lên 1
    B Loop_sub               ; Quay lại nhãn Loop_sub để tiếp tục lặp

End_sub
    LDR R7, =max_in_sub      ; Tải địa chỉ biến max_in_sub vào R7
    LDR R8, =min_in_sub      ; Tải địa chỉ biến min_in_sub vào R8
    STR R5, [R7]             ; Lưu giá trị max vào biến max_in_sub
    STR R6, [R8]             ; Lưu giá trị min vào biến min_in_sub

Stop 
    SWI &11                  ; Gọi dịch vụ hệ thống để kết thúc chương trình
    END                      ; Kết thúc chương trình

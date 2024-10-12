# Giải thích Bài 4 lab 2: Tính tổng các phần tử trong ma trận 4x5

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
Tong DCD 0                   ; Biến lưu tổng các phần tử trong ma trận

; Khai báo vùng chứa mã nguồn
AREA mycode, CODE, READONLY
EXPORT Start                ; Xuất nhãn Start để chương trình có thể gọi
ENTRY                       ; Chỉ định điểm vào của chương trình

Start
    LDR R1, row             ; Tải số dòng vào thanh ghi R1
    LDR R0, column          ; Tải số cột vào thanh ghi R0
    MUL R1, R1, R0          ; Tính số lượng phần tử trong ma trận (R1 = row * column)
    LDR R0, =matrix         ; Tải địa chỉ ma trận vào thanh ghi R0

    MOV R2, #0              ; Khởi tạo R2 là tổng (tổng = 0)
    MOV R3, #0              ; Khởi tạo R3 là chỉ số (index) (index = 0)
    MOV R4, #0              ; Khởi tạo R4 là giá trị offset (congdan = 0)

Loop
    CMP R3, R1              ; So sánh chỉ số (index) với số lượng phần tử (R1)
    BGE Stop                 ; Nếu index >= số lượng phần tử, nhảy đến nhãn Stop

    LDR R5, [R0, R4]         ; Tải phần tử hiện tại trong ma trận vào R5
    ADDS R2, R5              ; Cộng R5 vào tổng (R2)
    ADDS R4, #4              ; Tăng offset lên 4 (kích thước mỗi phần tử là 4 byte)
    ADDS R3, #1              ; Tăng chỉ số lên 1 (tiến tới phần tử tiếp theo)
    B Loop                   ; Quay lại nhãn Loop để tiếp tục lặp

Stop 
    LDR R0, =Tong            ; Tải địa chỉ biến Tong vào R0
    STR R2, [R0]             ; Lưu tổng vào biến Tong
    SWI &11                  ; Gọi dịch vụ hệ thống để kết thúc chương trình
    END                      ; Kết thúc chương trình

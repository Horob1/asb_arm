# Giải thích Bài 2 lab 2: Tìm giá trị lớn nhất và nhỏ nhất trong chuỗi số

```assembly
; Khai báo vùng nhớ cho dữ liệu (RESET)
AREA RESET, DATA, READONLY
    DCD 0x20001000     ; Địa chỉ bắt đầu của dữ liệu
    DCD Start          ; Địa chỉ bắt đầu của chương trình (Start)
    ALIGN              ; Căn chỉnh dữ liệu

array DCD 7, 3, 1, 4, 9  ; Chuỗi dữ liệu cần tìm giá trị lớn nhất và nhỏ nhất
length DCD 5             ; Độ dài của chuỗi (5 phần tử)

; Khai báo vùng nhớ chứa kết quả
AREA KQ, DATA, READWRITE
VALUE_MAX DCD 0          ; Biến chứa giá trị lớn nhất
VALUE_MIN DCD 0          ; Biến chứa giá trị nhỏ nhất

; Khai báo vùng chứa mã nguồn
AREA mycode, CODE, READONLY
    EXPORT Start         ; Xuất nhãn Start cho chương trình
    ENTRY                ; Điểm bắt đầu của chương trình

Start
    ; Load địa chỉ của phần tử đầu tiên của chuỗi vào R0
    LDR R0, =array       ; Tải địa chỉ của chuỗi array vào R0
    
    ; Load độ dài của chuỗi vào R1
    LDR R1, length       ; Tải giá trị của biến length vào R1 (R1 = 5)

    ; Khởi tạo giá trị nhỏ nhất (R2) và lớn nhất (R3) với phần tử đầu tiên
    LDR R2, [R0]         ; Tải phần tử đầu tiên của chuỗi vào R2 (min)
    LDR R3, [R0]         ; Tải phần tử đầu tiên của chuỗi vào R3 (max)

    ; Thiết lập biến chạy cho chuỗi
    MOV R4, #4           ; R4 dùng để tính địa chỉ của các phần tử tiếp theo
    MOV R5, #1           ; R5 là chỉ số (index = 1)

Loop
    CMP R5, R1           ; So sánh chỉ số với độ dài chuỗi
    BGE Stop             ; Nếu chỉ số >= length, nhảy đến nhãn Stop

    ; Tải phần tử hiện tại của chuỗi vào R6
    LDR R6, [R0, R4]     ; Tải phần tử từ địa chỉ (R0 + R4) vào R6

    ; So sánh giá trị nhỏ nhất
    CMP R2, R6           ; So sánh min (R2) với phần tử hiện tại (R6)
    BLT Tiep_1           ; Nếu R2 < R6, nhảy đến nhãn Tiep_1
    MOV R2, R6           ; Cập nhật giá trị nhỏ nhất (R2 = R6)
    B Tiep_2             ; Nhảy đến nhãn Tiep_2

Tiep_1
    ; So sánh giá trị lớn nhất
    CMP R3, R6           ; So sánh max (R3) với phần tử hiện tại (R6)
    BGT Tiep_2           ; Nếu R3 > R6, bỏ qua cập nhật max
    MOV R3, R6           ; Cập nhật giá trị lớn nhất (R3 = R6)

Tiep_2
    ; Tăng biến chạy để xét phần tử tiếp theo
    ADD R5, #1           ; Tăng chỉ số R5
    ADD R4, #4           ; Tăng địa chỉ (mỗi phần tử chiếm 4 byte)

    ; Quay lại vòng lặp để xét phần tử tiếp theo
    B Loop               ; Quay lại nhãn Loop

Stop
    ; Lưu kết quả vào các biến VALUE_MAX và VALUE_MIN
    LDR R0, =VALUE_MAX   ; Load địa chỉ của VALUE_MAX vào R0
    LDR R1, =VALUE_MIN   ; Load địa chỉ của VALUE_MIN vào R1
    STR R2, [R1]         ; Lưu giá trị nhỏ nhất (R2) vào VALUE_MIN
    STR R3, [R0]         ; Lưu giá trị lớn nhất (R3) vào VALUE_MAX
    
    SWI &11              ; Gọi lệnh hệ thống (phụ thuộc vào hệ thống cụ thể)
    END                  ; Kết thúc chương trình


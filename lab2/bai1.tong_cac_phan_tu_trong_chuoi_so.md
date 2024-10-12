# Giải thích Bài 1 lab 2: Tính tổng các số trong chuỗi

```assembly
; Khai báo vùng nhớ cho dữ liệu (RESET)
AREA RESET, DATA, READONLY
    DCD 0x20001000  ; Địa chỉ bắt đầu của dữ liệu
    DCD Start       ; Địa chỉ bắt đầu của chương trình (Start)
    ALIGN           ; Căn chỉnh dữ liệu

array DCD 3, 3, 1, 4, 5  ; Chuỗi dữ liệu cần tính tổng
length DCD 5             ; Độ dài của chuỗi (5 phần tử)

; Khai báo vùng nhớ chứa kết quả
AREA KQ, DATA, READWRITE
Tong DCD 0               ; Biến chứa kết quả tổng

; Khai báo vùng chứa mã nguồn
AREA mycode, CODE, READONLY
    EXPORT Start         ; Xuất nhãn Start cho chương trình
    ENTRY                ; Điểm bắt đầu của chương trình

Start
    ; Load địa chỉ của phần tử đầu tiên của chuỗi vào R0
    LDR R0, =array       ; Tải địa chỉ của chuỗi array vào R0

    ; Load độ dài của chuỗi vào R4
    LDR R4, =length      ; Tải địa chỉ của biến length vào R4
    LDR R4, [R4]         ; Tải giá trị của length vào R4 (R4 = 5)

    MOV R2, #0           ; Khởi tạo tổng (R2 = 0)
    MOV R5, #0           ; Biến chạy để tính địa chỉ từng phần tử (R5 = 0)
    MOV R3, #0           ; Biến chỉ số (index = 0)

Loop
    CMP R3, R4           ; So sánh chỉ số hiện tại với độ dài chuỗi
    BGE Stop             ; Nếu index >= length, nhảy đến nhãn Stop

    ; Tải giá trị của phần tử hiện tại vào R1 và cộng vào tổng
    LDR R1, [R0, R5]     ; Tải phần tử từ địa chỉ (R0 + R5) vào R1
    ADD R2, R1           ; Cộng giá trị của R1 vào R2 (tổng)

    ; Tăng địa chỉ phần tử tiếp theo và chỉ số
    ADD R5, #4           ; Tăng địa chỉ đến phần tử tiếp theo
    ADD R3, #1           ; Tăng chỉ số

    B Loop               ; Quay lại vòng lặp Loop để tiếp tục

Stop
    ; Lưu kết quả tổng vào biến Tong
    LDR R3, =Tong        ; Load địa chỉ của biến Tong vào R3
    STR R2, [R3]         ; Lưu tổng từ R2 vào địa chỉ của Tong

    SWI &11              ; Gọi lệnh hệ thống (phụ thuộc vào hệ thống cụ thể)
    END                  ; Kết thúc chương trình
```

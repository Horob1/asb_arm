# Giải thích Bài 1.2 lab 3: Tính tổng các số chẵn và số lẻ nhỏ hơn hoặc bằng N sử dụng thanh ghi

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000      ; Địa chỉ bắt đầu cho stack pointer
    DCD Reset_Handler    ; Địa chỉ cho hàm Reset_Handler

ALIGN
SUM_ODD  DCD 0          ; Biến lưu tổng các số lẻ
SUM_EVEN DCD 0          ; Biến lưu tổng các số chẵn
N        DCD 5          ; Giá trị N là 5

; Khai báo vùng mã nguồn
AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

SUMUP PROC
    CMP R2, R0           ; So sánh R2 với N (được lưu trong R0)
    BGT END_OF_FUNC      ; Nếu R2 > N, nhảy đến END_OF_FUNC
    ADD R1, R2           ; Cộng R2 (số lẻ hoặc số chẵn) vào R1 (tổng)
    ADD R2, #2           ; Tăng R2 lên 2 (đi tới số tiếp theo lẻ hoặc chẵn)
    B SUMUP              ; Quay lại SUMUP để tiếp tục lặp
END_OF_FUNC
    BX LR                ; Quay lại hàm gọi
ENDP

Reset_Handler 
    LDR R0, N            ; Tải giá trị N vào R0

    MOV R1, #0           ; Khởi tạo R1 (tổng lẻ) bằng 0
    MOV R2, #1           ; Bắt đầu với số lẻ, khởi tạo R2 = 1

    BL SUMUP             ; Gọi hàm SUMUP để tính tổng các số lẻ

    LDR R3, =SUM_ODD     ; Tải địa chỉ của SUM_ODD vào R3
    STR R1, [R3]        ; Lưu tổng các số lẻ vào SUM_ODD

    MOV R1, #0           ; Khởi tạo R1 (tổng chẵn) bằng 0
    MOV R2, #2           ; Bắt đầu với số chẵn, khởi tạo R2 = 2

    BL SUMUP             ; Gọi hàm SUMUP để tính tổng các số chẵn

    LDR R3, =SUM_EVEN    ; Tải địa chỉ của SUM_EVEN vào R3
    STR R1, [R3]        ; Lưu tổng các số chẵn vào SUM_EVEN

STOP
    B STOP               ; Dừng tại nhãn STOP (vòng lặp vô hạn)
END

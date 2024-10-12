# Giải thích Bài 1.5 lab 3: Tính giá trị x^n

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000     ; Giá trị cho stack pointer khi stack rỗng
    DCD Reset_Handler   ; Địa chỉ cho vector reset

ALIGN ; Thiết lập cho việc căn chỉnh vùng nhớ, mặc định là 4 bytes
XN  DCD 0              ; Địa chỉ để lưu giá trị x^n
N   DCD 7              ; Địa chỉ chứa giá trị n (ở đây là 7)
X   DCD 2              ; Địa chỉ chứa giá trị x (ở đây là 2)

; Khai báo vùng mã nguồn
AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

XMUN PROC
    MUL R2, R2, R1      ; Nhân R2 với R1 (R2 = R2 * x)
    SUBS R0, R0, #1     ; Giảm R0 đi 1 (đếm ngược n)
    BGT XMUN            ; Nếu R0 > 0, quay lại thực hiện hàm XMUN
    BX LR               ; Quay lại hàm gọi
ENDP

Reset_Handler 
    LDR R0, N           ; Tải giá trị n vào R0
    LDR R1, X           ; Tải giá trị x vào R1
    MOV R2, #1          ; Khởi tạo R2 bằng 1 (biến lưu trữ kết quả)
    BL XMUN             ; Gọi hàm XMUN để tính x^n

    LDR R3, =XN         ; Tải địa chỉ của XN vào R3
    STR R2, [R3]        ; Lưu kết quả vào địa chỉ XN

STOP    
    B STOP              ; Dừng tại nhãn STOP (vòng lặp vô hạn)
END

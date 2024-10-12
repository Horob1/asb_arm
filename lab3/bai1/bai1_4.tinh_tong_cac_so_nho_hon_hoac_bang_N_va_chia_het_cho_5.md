# Giải thích Bài 1.4 lab 3: Tính tổng các số <= N và chia hết cho 5

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000     ; Giá trị cho stack pointer khi stack rỗng
    DCD Reset_Handler   ; Địa chỉ cho vector reset

ALIGN ; Thiết lập cho việc căn chỉnh vùng nhớ, mặc định là 4 bytes
SUM DCD 0              ; Địa chỉ một vùng nhớ để lưu tổng các số chia hết cho 5
N   DCD 7              ; Địa chỉ một vùng nhớ chứa giá trị N (ở đây là 7)

; Khai báo vùng mã nguồn
AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

SUMF PROC
    ADD R1, R2          ; Cộng giá trị của R2 vào R1 (tổng)
    ADD R2, #5          ; Tăng giá trị R2 thêm 5
    CMP R2, R0          ; So sánh R2 với R0 (N)
    BLE SUMF            ; Nếu R2 <= N, quay lại thực hiện hàm SUMF
    BX LR               ; Quay lại hàm gọi
ENDP

Reset_Handler 
    LDR R0, N           ; Tải giá trị N vào R0
    MOV R1, #0          ; Khởi tạo tổng (R1) bằng 0
    MOV R2, #0          ; Khởi tạo biến chạy (R2) bằng 0
    BL SUMF             ; Gọi hàm SUMF để tính tổng

    LDR R2, =SUM        ; Tải địa chỉ của SUM vào R2
    STR R1, [R2]       ; Lưu tổng vào địa chỉ SUM

STOP    
    B STOP              ; Dừng tại nhãn STOP (vòng lặp vô hạn)
END

# Giải thích Bài 1.6 lab 3: Tính tổng 1 + x^2 + x^3 + ... + x^n

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000     ; Giá trị cho stack pointer khi stack rỗng
    DCD Reset_Handler   ; Địa chỉ cho vector reset

ALIGN ; Thiết lập cho việc căn chỉnh vùng nhớ, mặc định là 4 bytes
FX  DCD 0              ; Địa chỉ để lưu giá trị tổng \(1 + x^2 + x^3 + \ldots + x^n\)
N   DCD 7              ; Địa chỉ chứa giá trị \(n\) (ở đây là 7)
X   DCD 2              ; Địa chỉ chứa giá trị \(x\) (ở đây là 2)

; Khai báo vùng mã nguồn
AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

BIEUTHUC PROC
    MUL R2, R2, R1      ; Nhân R2 với R1 (R2 = R2 * x)
    ADD R3, R3, R2      ; Cộng giá trị R2 vào R3 (tổng)
    SUBS R0, R0, #1     ; Giảm R0 đi 1 (đếm ngược n)
    BGT BIEUTHUC        ; Nếu R0 > 0, quay lại thực hiện hàm BIEUTHUC
    LDR R0, N           ; Tải lại giá trị N vào R0
    CMP R0, #1          ; So sánh R0 với 1
    BLT END_PROC        ; Nếu R0 < 1, nhảy đến END_PROC
    SUBS R3, R3, R1     ; Giảm tổng R3 đi R1 (x^1)
END_PROC
    BX LR               ; Quay lại hàm gọi
ENDP

Reset_Handler
    LDR R0, N           ; Tải giá trị N vào R0
    LDR R1, X           ; Tải giá trị X vào R1
    MOV R2, #1          ; Khởi tạo R2 bằng 1 (bắt đầu với x^0)
    MOV R3, #1          ; Khởi tạo R3 bằng 1 (tổng)
    BL BIEUTHUC         ; Gọi hàm BIEUTHUC để tính tổng

    LDR R4, =FX         ; Tải địa chỉ của FX vào R4
    STR R3, [R4]        ; Lưu kết quả vào địa chỉ FX

STOP
    B STOP              ; Dừng tại nhãn STOP (vòng lặp vô hạn)
END
```

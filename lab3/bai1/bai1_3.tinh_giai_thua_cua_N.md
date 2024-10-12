# Giải thích Bài: Tính giai thừa của N

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000     ; Giá trị cho stack pointer khi stack rỗng
    DCD Reset_Handler   ; Địa chỉ cho vector reset

ALIGN ; Thiết lập cho việc căn chỉnh vùng nhớ, mặc định là 4 bytes
FAC DCD 0             ; Địa chỉ một vùng nhớ {tên: FAC, giá trị: 0}
N   DCD 5             ; Địa chỉ một vùng nhớ {tên: N, giá trị: 5}

; Khai báo vùng mã nguồn
AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

FACTORIAL PROC
    MUL R1, R0, R1     ; Nhân R1 với R0 và lưu kết quả vào R1
    SUBS R0, R0, #1    ; Giảm giá trị R0 đi 1, và cập nhật cờ Zero
    BGT FACTORIAL      ; Nếu R0 > 0, quay lại thực hiện hàm FACTORIAL
    BX LR              ; Quay lại hàm gọi
ENDP

Reset_Handler 
    LDR R0, N          ; Tải giá trị N vào R0
    MOV R1, #1         ; Khởi tạo R1 (giai thừa) bằng 1
    BL FACTORIAL       ; Gọi hàm FACTORIAL

    LDR R2, =FAC       ; Tải địa chỉ của FAC vào R2
    STR R1, [R2]      ; Lưu kết quả giai thừa vào FAC

STOP
    B STOP             ; Dừng tại nhãn STOP (vòng lặp vô hạn)
END

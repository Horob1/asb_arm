# Giải thích Bài 1.7 lab 3: Tìm Ước Chung Lớn Nhất (UCLN) của 2 số

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000     ; Giá trị cho stack pointer khi stack rỗng
    DCD Reset_Handler   ; Địa chỉ cho vector reset

ALIGN ; Thiết lập cho việc căn chỉnh vùng nhớ, mặc định là 4 bytes
UCLN DCD 0            ; Địa chỉ để lưu giá trị ước chung lớn nhất
SO1  DCD 7            ; Địa chỉ chứa số thứ nhất (ở đây là 7)
SO2  DCD 2            ; Địa chỉ chứa số thứ hai (ở đây là 2)

; Khai báo vùng mã nguồn
AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

TIM_UCLN PROC
    CMP R0, R1          ; So sánh R0 (SO1) và R1 (SO2)
    BGT HoanDoi         ; Nếu R0 > R1, nhảy đến nhãn HoanDoi
TiepTuc
    SUB R1, R1, R0      ; R1 = R1 - R0
    CMP R1, #0          ; So sánh R1 với 0
    BEQ END_PROC        ; Nếu R1 = 0, nhảy đến END_PROC
    B TIM_UCLN          ; Quay lại hàm TIM_UCLN để tiếp tục tính

HoanDoi
    MOV R2, R0          ; Di chuyển giá trị R0 vào R2
    MOV R0, R1          ; Di chuyển giá trị R1 vào R0
    MOV R1, R2          ; Di chuyển giá trị R2 vào R1
    B TiepTuc           ; Quay lại nhãn TiepTuc

END_PROC
    BX LR               ; Quay lại hàm gọi
ENDP

Reset_Handler 
    LDR R0, SO1        ; Tải giá trị SO1 vào R0
    LDR R1, SO2        ; Tải giá trị SO2 vào R1
    BL TIM_UCLN        ; Gọi hàm TIM_UCLN để tính UCLN
    LDR R2, =UCLN      ; Tải địa chỉ của UCLN vào R2
    STR R0, [R2]       ; Lưu kết quả vào địa chỉ UCLN

STOP    
    B STOP             ; Dừng tại nhãn STOP (vòng lặp vô hạn)
END

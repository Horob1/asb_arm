# Giải thích Bài: Thực hiện phép chia và lưu kết quả

### 1 Dùng register truyền parameter

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000      ; Địa chỉ bắt đầu cho stack pointer
    DCD Reset_Handler    ; Địa chỉ cho hàm xử lý reset

ALIGN
THUONG DCD 0           ; Biến lưu thương (quotient)
DU     DCD 0           ; Biến lưu dư (remainder)
SO1    DCD 7           ; Số chia (dividend)
SO2    DCD 2           ; Số bị chia (divisor)

; Khai báo vùng chứa mã nguồn
AREA MYCODE, CODE, READONLY
    ENTRY               ; Chỉ định điểm vào của chương trình
    EXPORT Reset_Handler ; Xuất hàm Reset_Handler để sử dụng

CHIA PROC
    SDIV R2, R0, R1    ; R2 = R0 / R1 (thương)
    MUL R3, R2, R1     ; R3 = R2 * R1 (tính lại giá trị đã chia)
    SUBS R3, R0, R3    ; R3 = R0 - R3 (tính dư)
    BX LR               ; Quay lại địa chỉ gọi hàm
ENDP

Reset_Handler 
    LDR R0, SO1        ; Tải giá trị của SO1 vào R0 (số chia)
    LDR R1, SO2        ; Tải giá trị của SO2 vào R1 (số bị chia)
    BL CHIA            ; Gọi hàm CHIA để thực hiện phép chia
    LDR R0, =THUONG    ; Tải địa chỉ của biến THUONG vào R0
    LDR R1, =DU        ; Tải địa chỉ của biến DU vào R1
    STR R2, [R0]       ; Lưu thương vào biến THUONG
    STR R3, [R1]       ; Lưu dư vào biến DU

STOP    
    B STOP             ; Dừng chương trình tại nhãn STOP (vòng lặp vô hạn)
END
```

### 2 Dùng stack

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000      ; Địa chỉ bắt đầu cho stack pointer
    DCD Reset_Handler    ; Địa chỉ nhãn Reset_Handler

; Khai báo dữ liệu
ALIGN
THUONG      DCD 0       ; Biến lưu thương của phép chia
DU          DCD 0       ; Biến lưu số dư của phép chia
SO1         DCD 7       ; Số chia (SO1)
SO2         DCD 2       ; Số bị chia (SO2)

; Khai báo vùng nhớ cho stack
AREA MYSTACK, DATA, READWRITE
MY_STACK    DCD 0       ; Vùng nhớ cho stack

; Khai báo vùng mã nguồn
AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

; Định nghĩa thủ tục CHIA
CHIA PROC
    LDR R4, =MY_STACK     ; Tải địa chỉ MY_STACK vào R4
    LDMIA R4, {R0,R1}     ; Nạp giá trị từ MY_STACK vào R0 và R1
    SDIV R2, R0, R1       ; R2 = R0 / R1 (tính thương)
    MUL R3, R2, R1        ; R3 = R2 * R1 (tính lại giá trị bị chia)
    SUBS R3, R0, R3       ; R3 = R0 - R3 (tính số dư)
    STMIA R4, {R2,R3}     ; Lưu thương và số dư vào MY_STACK
    BX LR                  ; Trở về từ thủ tục
    ENDP

; Hàm khởi động
Reset_Handler 
    LDR R0, SO1           ; Tải giá trị SO1 vào R0
    LDR R1, SO2           ; Tải giá trị SO2 vào R1
    LDR R4, =MY_STACK     ; Tải địa chỉ MY_STACK vào R4
    STMIA R4, {R0,R1}     ; Lưu SO1 và SO2 vào MY_STACK
    BL CHIA                ; Gọi thủ tục CHIA
    LDR R0, =THUONG       ; Tải địa chỉ biến THUONG vào R0
    LDR R1, =DU           ; Tải địa chỉ biến DU vào R1
    LDR R4, =MY_STACK     ; Tải địa chỉ MY_STACK vào R4
    LDMIA R4, {R2,R3}     ; Nạp thương và số dư từ MY_STACK vào R2 và R3
    STR R2, [R0]          ; Lưu thương vào THUONG
    STR R3, [R1]          ; Lưu số dư vào DU
STOP
    B STOP                ; Dừng chương trình tại nhãn STOP (vòng lặp vô hạn)
    END                   ; Kết thúc chương trình
```
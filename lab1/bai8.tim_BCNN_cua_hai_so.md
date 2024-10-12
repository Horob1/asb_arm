# Giải thích Bài 8 lab 1: Tìm bội chung nhỏ nhất (BCNN) của 2 số

```assembly
; Khai báo vùng nhớ cho dữ liệu (RESET) và địa chỉ bắt đầu của chương trình
AREA RESET, DATA, READONLY
    DCD 0x20000000   ; Địa chỉ bắt đầu của stack pointer
    DCD Start        ; Địa chỉ bắt đầu của chương trình (Start)
So1 DCD 20           ; Số thứ nhất (So1 = 20)
So2 DCD 40           ; Số thứ hai (So2 = 40)

; Khai báo vùng mã nguồn (CODE) cho chương trình, ở chế độ chỉ đọc
AREA MAINSOURCE, CODE, READONLY
    ENTRY            ; Điểm vào của chương trình

Start
    ; Tải giá trị của So1 và So2 vào thanh ghi
    LDR R0, So1      ; Tải So1 (20) vào thanh ghi R0
    LDR R1, So2      ; Tải So2 (40) vào thanh ghi R1

Loop
    ; So sánh hai giá trị
    CMP R0, R1       ; So sánh giá trị của R0 và R1
    BGT HoanDoi      ; Nếu R0 > R1, nhảy đến nhãn HoanDoi

TiepTuc
    ; Trừ giá trị của R0 từ R1
    SUB R1, R0       ; R1 = R1 - R0
    CMP R1, R0       ; So sánh lại giá trị mới của R1 với R0
    BEQ BCNN         ; Nếu R1 = R0, tìm được UCLN, nhảy đến nhãn BCNN
    B Loop           ; Nếu chưa tìm thấy, quay lại vòng lặp Loop

HoanDoi
    ; Hoán đổi giá trị của R0 và R1
    MOV R2, R0       ; Lưu giá trị của R0 vào thanh ghi tạm R2
    MOV R0, R1       ; R0 = R1
    MOV R1, R2       ; R1 = giá trị cũ của R0 (trong R2)
    B TiepTuc        ; Quay lại TiepTuc để tiếp tục tính toán

BCNN
    ; Tính BCNN dựa trên công thức BCNN = (So1 * So2) / UCLN
    MOV R3, R0       ; Lưu UCLN vào thanh ghi R3
    LDR R0, So1      ; Tải lại giá trị của So1 vào R0
    LDR R1, So2      ; Tải lại giá trị của So2 vào R1
    MUL R2, R1, R0   ; R2 = R1 * R0 (So1 * So2)
    UDIV R4, R2, R3  ; R4 = (So1 * So2) / UCLN (lấy thương, không dư)

Stop
    B Stop           ; Chương trình dừng lại tại nhãn Stop
    END              ; Kết thúc chương trình
```

# Giải thích Bài 3 Lab 8: Mã hóa chuỗi bằng ánh xạ hoán vị

```assembly
; Khai báo vùng nhớ RESET chứa dữ liệu, chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0X20000000      ; Địa chỉ stack pointer
    DCD MAIN            ; Địa chỉ bắt đầu chương trình tại nhãn MAIN

XauRo DCB "Sinh Vien KMA", 0 ; Chuỗi ký tự gốc "Sinh Vien KMA", kết thúc bằng ký tự NULL (0)

; Bảng ánh xạ hoán vị cho các ký tự từ A-Z và a-z (vị trí đã được hoán đổi)
K DCB 11,12,4,17,0,3,5,22,1,24,20,10,25,8,6,21,7,9,18,14,15,13,16,19,23,2;
    ; Bảng này chứa các giá trị ánh xạ từ 0-25 (đại diện cho A-Z hoặc a-z)
    ; Mỗi giá trị sẽ ánh xạ một ký tự sang một ký tự khác dựa trên bảng hoán vị

; Khai báo vùng nhớ MYDATA có thể đọc/ghi
AREA MYDATA, DATA, READWRITE
XauMa DCB 0             ; Bộ nhớ để lưu chuỗi đã mã hóa

; Khai báo vùng mã nguồn, chỉ đọc
AREA MYCODE, CODE, READONLY
    ENTRY               ; Điểm vào của chương trình

; Hàm mã hóa ENCODE
ENCODE PROC
    CMP R1, #0x20       ; So sánh ký tự hiện tại với khoảng trắng (ASCII 0x20)
    BEQ STOP_P          ; Nếu là khoảng trắng, bỏ qua và dừng xử lý

    CMP R1, #0x61       ; So sánh với ký tự 'a' (0x61)
    BLT UPPERCASE       ; Nếu nhỏ hơn 'a', tức là ký tự in hoa, chuyển sang xử lý in hoa

    ; Mã hóa ký tự thường (lowercase)
    SUB R1, R1, #0x61   ; Chuyển ký tự thường từ 'a' thành chỉ số (0-25)
    LDRB R4, [R2, R1]   ; Lấy giá trị hoán vị từ bảng ánh xạ
    ADD R1, R4, #0x61   ; Chuyển chỉ số hoán vị về ký tự thường tương ứng
    B STOP_P            ; Kết thúc xử lý

UPPERCASE
    ; Mã hóa ký tự in hoa (uppercase)
    SUB R1, R1, #0x41   ; Chuyển ký tự in hoa từ 'A' thành chỉ số (0-25)
    LDRB R4, [R2, R1]   ; Lấy giá trị hoán vị từ bảng ánh xạ
    ADD R1, R4, #0x41   ; Chuyển chỉ số hoán vị về ký tự in hoa tương ứng
    B STOP_P            ; Kết thúc xử lý

STOP_P
    BX LR               ; Kết thúc hàm ENCODE
    ENDP

; Chương trình chính MAIN
MAIN
    LDR R0, =XauRo      ; Load địa chỉ của chuỗi gốc (XauRo) vào R0
    LDR R2, =K          ; Load địa chỉ của bảng ánh xạ hoán vị (K) vào R2
    LDR R3, =XauMa      ; Load địa chỉ của chuỗi mã hóa (XauMa) vào R3

LOOP
    LDRB R1, [R0], #1   ; Load từng ký tự từ chuỗi gốc vào R1 và tăng địa chỉ R0
    CMP R1, #0          ; So sánh với ký tự NULL (kết thúc chuỗi)
    BEQ STOP            ; Nếu gặp ký tự NULL, dừng chương trình

    BL ENCODE           ; Gọi hàm ENCODE để mã hóa ký tự
    STRB R1, [R3], #1   ; Lưu ký tự đã mã hóa vào chuỗi mã hóa (XauMa) và tăng địa chỉ R3
    B LOOP              ; Quay lại LOOP để xử lý ký tự tiếp theo

STOP
    B STOP              ; Dừng chương trình tại nhãn STOP
    END                 ; Kết thúc chương trình
```

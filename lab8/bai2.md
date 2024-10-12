# Giải thích Bài 2 Lab 8: Mã hóa chuỗi bằng bảng mã hóa

> Ý tưởng với mỗi một chữ cái ta sẽ mã hóa thành 1 chữ cái khác theo 1 bảng cho trước

Ví dụ về bảng mã hóa

| Chữ cái ban đầu | Sau khi mã hóa |
|-----------------|----------------|
| B               | C              |
| ...             | ...            |
| z               | j              |

Tôi đã chọn lưu bảng này vào máy tính bằng cách chỉ lưu kí tự sau khi mã hóa thành 1 chuỗi, khi mã hóa sẽ dựa vào index của kí tự trong sâu. Ví dụ: A là chữ cái đầu tiên của ta coi nó có index là 0 ta sẽ xem sâu khí tự mã hóa và biến nó thành kí tự đang được lưu tại vị trí 0 của sâu kí tự mã hóa (tạm gọi sâu này là sâu K)

Tương tự B sẽ thành kí tự có index bằng 1 của sâu K,...

Đặc biệt các chữ thường ví dụ:

| Chữ cái thường | Index trong sâu K |
|----------------|-------------------|
| a              | 0 + 26            |
| b              | 1 + 26            |
| ...            | ...               |

```assembly
; Khai báo vùng nhớ RESET chứa dữ liệu, chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0X20000000      ; Địa chỉ stack pointer
    DCD MAIN            ; Địa chỉ bắt đầu chương trình tại nhãn MAIN
XauRo DCB "Sinh Vien KMA", 0 ; Chuỗi ký tự "Sinh Vien KMA" cần mã hóa, kết thúc bằng ký tự NULL (0)

; Bảng mã hóa (bảng dịch ngược ký tự)
K DCB "ZYXWVUTSRQPONMLKJIHGFEDCBAzyxwvutsrqponmlkjihgfedcba" 
    ; Bảng mã hóa

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
    SUB R1, R1, #0x61   ; Dịch ký tự thường từ 'a' thành chỉ số (0-25)
    ADD R1, R1, #26     ; Đặt chỉ số vào khoảng của bảng chữ thường trong bảng dịch
    LDRB R1, [R2, R1]   ; Lấy ký tự tương ứng trong bảng mã hóa
    B STOP_P            ; Kết thúc xử lý

UPPERCASE
    ; Mã hóa ký tự in hoa (uppercase)
    SUB R1, R1, #0x41   ; Dịch ký tự in hoa từ 'A' thành chỉ số (0-25)
    LDRB R1, [R2, R1]   ; Lấy ký tự tương ứng trong bảng mã hóa
    B STOP_P            ; Kết thúc xử lý

STOP_P
    BX LR               ; Kết thúc hàm ENCODE
    ENDP

; Chương trình chính MAIN
MAIN
    LDR R0, =XauRo      ; Load địa chỉ của chuỗi gốc (XauRo) vào R0
    LDR R2, =K          ; Load địa chỉ của bảng mã hóa (K) vào R2
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
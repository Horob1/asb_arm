# Giải thích Bài 4 lab 6: Chuẩn hóa xâu (Title Case) với cách xử lý khoảng trắng

```assembly
; Khai báo vùng nhớ RESET, lưu dữ liệu ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000  ; Định địa chỉ cho stack pointer
    DCD Main        ; Định địa chỉ cho nhãn Main

; Khai báo vùng dữ liệu chứa chuỗi đầu vào InputString
AREA Input, DATA, READONLY
InputString
    DCB "  HELLO   WORLD!   ", 0  ; Chuỗi đầu vào, kết thúc bằng ký tự null (0)

; Khai báo vùng dữ liệu chứa chuỗi đầu ra OutputString
AREA Output, DATA
OutputString
    SPACE 20                       ; Dành 20 byte cho chuỗi đầu ra
ALIGN                               ; Căn chỉnh bộ nhớ

; Khai báo vùng chương trình chứa mã lệnh
AREA Program, CODE, READONLY
ENTRY                              ; Chỉ định điểm vào của chương trình

Main
    LDR R0, =InputString            ; Load địa chỉ của InputString vào R0
    LDR R1, =OutputString           ; Load địa chỉ của OutputString vào R1
    MOV R2, #1                      ; Đặt biến R2 là cờ để kiểm tra khoảng trắng

Loop
    LDRB R3, [R0], #1               ; Load byte từ InputString vào R3 và tăng địa chỉ R0
    CMP R3, #0                      ; So sánh R3 với ký tự null (0)
    BEQ Done                        ; Nếu gặp ký tự null, nhảy đến nhãn Done

    CMP R3, #' '                    ; So sánh R3 với ký tự khoảng trắng (' ')
    BEQ CheckSpace                  ; Nếu là khoảng trắng, nhảy đến CheckSpace

    CMP R2, #1                      ; Kiểm tra giá trị của cờ R2 (đang ở đầu từ?)
    BNE LowerCase                   ; Nếu không phải đầu từ, chuyển sang LowerCase

    AND R4, R3, #0xDF               ; Chuyển ký tự thường thành ký tự hoa (AND với 0xDF)
    STRB R4, [R1], #1               ; Lưu ký tự đã chuyển đổi vào OutputString
    MOV R2, #0                      ; Đặt cờ R2 về 0 (đã xử lý đầu từ)
    B Loop                          ; Quay lại vòng lặp chính

CheckSpace
    CMP R2, #1                      ; Kiểm tra xem khoảng trắng có thừa không
    BEQ Loop                        ; Nếu thừa, bỏ qua và quay lại vòng lặp
    MOV R2, #1                      ; Đặt cờ R2 = 1 (đánh dấu đầu từ mới)
    STRB R3, [R1], #1               ; Lưu khoảng trắng vào OutputString
    B Loop                          ; Quay lại vòng lặp chính

LowerCase
    ORR R4, R3, #0x20               ; Chuyển ký tự hoa thành ký tự thường (OR với 0x20)
    STRB R4, [R1], #1               ; Lưu ký tự thường vào OutputString
    B Loop                          ; Quay lại vòng lặp chính

Done
    STRB R2, [R1]                   ; Kết thúc chuỗi đầu ra bằng ký tự null
    SWI &11                         ; Kết thúc chương trình

    END                             ; Kết thúc chương trình
```

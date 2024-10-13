# Giải thích Bài 5 lab 6: Nối chuỗi (Concatenating Strings)

```assembly
; Khai báo vùng nhớ RESET, lưu dữ liệu ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20002000           ; Đặt địa chỉ khởi tạo
    DCD Main                 ; Đặt địa chỉ bắt đầu của chương trình
DT1 DCB "SINH VIEN", 0        ; Chuỗi đầu tiên "SINH VIEN", kết thúc bằng ký tự null
DT2 DCB "KMA", 0              ; Chuỗi thứ hai "KMA", kết thúc bằng ký tự null

; Khai báo vùng dữ liệu có thể ghi
AREA MYDATA, DATA, READWRITE
DT3 DCB 0                     ; Vùng bộ nhớ để chứa chuỗi kết quả, khởi tạo bằng 0 (null)

; Khai báo vùng mã nguồn (chứa chương trình)
AREA Program, CODE, READONLY
ENTRY                          ; Đánh dấu điểm vào của chương trình

; Hàm ConcatStrings: Sao chép chuỗi từ R0 vào R1
ConcatStrings PROC
LoopCopy
    LDRB R2, [R0], #1          ; Lấy từng byte từ chuỗi nguồn (R0) và tăng địa chỉ R0
    CMP R2, #0                 ; Kiểm tra ký tự kết thúc chuỗi (null)
    BEQ Done                   ; Nếu gặp ký tự null, kết thúc sao chép
    STRB R2, [R1], #1          ; Lưu byte vào chuỗi đích (R1) và tăng địa chỉ R1
    B LoopCopy                 ; Tiếp tục lặp cho đến khi gặp ký tự null

Done
    BX LR                      ; Kết thúc hàm và quay lại hàm chính
ENDP                           ; Kết thúc hàm ConcatStrings

; Chương trình chính
Main
    LDR R0, =DT1               ; Load địa chỉ của chuỗi DT1 vào R0 (chuỗi "SINH VIEN")
    LDR R1, =DT3               ; Load địa chỉ của chuỗi đích DT3 vào R1
    BL ConcatStrings           ; Gọi hàm ConcatStrings để sao chép chuỗi DT1 vào DT3

    MOV R2, #32                ; Đặt ký tự khoảng trắng (ASCII 32) vào R2
    STRB R2, [R1], #1          ; Lưu khoảng trắng vào cuối chuỗi DT3 và tăng địa chỉ R1

    LDR R0, =DT2               ; Load địa chỉ của chuỗi DT2 ("KMA") vào R0
    BL ConcatStrings           ; Gọi hàm ConcatStrings để sao chép chuỗi DT2 vào DT3

Stop
    B Stop                     ; Dừng chương trình, lặp vô hạn
    END                        ; Kết thúc chương trình
```

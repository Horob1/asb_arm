# Giải thích Bài 3 lab 6: Chuẩn hóa xâu (Đảo ngược chuỗi)

```assembly
; Khai báo vùng nhớ RESET, lưu dữ liệu ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000  ; Định địa chỉ cho stack pointer
    DCD Main        ; Định địa chỉ cho nhãn Main

; Khai báo vùng dữ liệu chứa chuỗi đầu vào InputString
AREA Input, DATA, READONLY
InputString DCB "HELLO WORLD!", 0  ; Chuỗi đầu vào kết thúc bằng ký tự null (0)

; Khai báo vùng dữ liệu chứa chuỗi đầu ra OutputString
AREA Output, DATA, READWRITE
OutputString DCB 0  ; Chuỗi đầu ra, bắt đầu từ giá trị 0 (rỗng)

; Khai báo vùng chương trình chứa mã lệnh
AREA Program, CODE, READONLY
ENTRY               ; Chỉ định điểm vào của chương trình

Main
    LDR R0, =InputString  ; Load địa chỉ của InputString vào R0
    LDR R4, =OutputString ; Load địa chỉ của OutputString vào R4
    MOV R2, #0            ; Biến đếm R2, khởi tạo bằng 0

Loop_to_find_len
    LDRB R3, [R0, R2]     ; Load một byte từ chuỗi đầu vào vào R3
    CMP R3, #0            ; So sánh ký tự hiện tại với ký tự null (0)
    BEQ InitForRvString   ; Nếu gặp ký tự null, nhảy đến nhãn InitForRvString
    ADD R2, R2, #1        ; Tăng biến đếm R2 lên 1
    B Loop_to_find_len    ; Quay lại vòng lặp để kiểm tra ký tự tiếp theo

InitForRvString
    ; Khi đã tìm được độ dài chuỗi, trừ đi 1 để bắt đầu từ ký tự cuối
    SUBS R2, R2, #1

RvString
    LDRB R3, [R0, R2]     ; Load ký tự từ vị trí R2 của InputString vào R3
    STRB R3, [R4], #1     ; Lưu ký tự vào OutputString, sau đó tăng R4 lên 1
    CMP R2, #0            ; Kiểm tra nếu R2 == 0 (đã duyệt hết chuỗi)
    BEQ Stop              ; Nếu đúng, nhảy đến nhãn Stop
    SUBS R2, R2, #1       ; Giảm biến đếm R2 (lùi về ký tự trước đó)
    B RvString            ; Quay lại vòng lặp để tiếp tục đảo chuỗi

Stop
    B Stop                ; Vòng lặp vô hạn tại nhãn Stop
    END                   ; Kết thúc chương trình
```

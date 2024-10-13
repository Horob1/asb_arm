# Giải thích Bài 1 lab 6: So sánh hai chuỗi theo độ dài và nội dung

```assembly
; Khai báo vùng nhớ có tên là RESET lưu dữ liệu và ở chế độ chỉ đọc
AREA RESET, DATA, READONLY
    DCD 0x20001000    ; Định địa chỉ cho stack pointer
    DCD Main          ; Định địa chỉ bắt đầu của chương trình

; Khai báo độ dài và nội dung hai chuỗi
Len_1 DCD 4           ; Độ dài của chuỗi 1
Len_2 DCD 4           ; Độ dài của chuỗi 2
String_1 DCB "1234"   ; Chuỗi 1 là "1234"
String_2 DCB "1234"   ; Chuỗi 2 là "1234"

; Khai báo vùng chứa mã nguồn của chương trình
AREA Program, CODE, READONLY
    ENTRY             ; Chỉ định điểm vào của chương trình

Main
    ; Tải độ dài của chuỗi 1 và chuỗi 2 vào các thanh ghi R0 và R1
    LDR R0, Len_1     ; Tải độ dài chuỗi 1 vào R0
    LDR R1, Len_2     ; Tải độ dài chuỗi 2 vào R1

    ; So sánh độ dài hai chuỗi
    CMP R0, R1        ; So sánh R0 và R1 (độ dài chuỗi)
    BNE NotSame       ; Nếu độ dài khác nhau, nhảy đến nhãn NotSame

    ; Tải địa chỉ của hai chuỗi vào các thanh ghi R2 và R3
    LDR R2, =String_1 ; Tải địa chỉ chuỗi 1 vào R2
    LDR R3, =String_2 ; Tải địa chỉ chuỗi 2 vào R3

Loop
    ; So sánh từng ký tự của hai chuỗi
    LDRB R4, [R2], #1 ; Tải từng byte của chuỗi 1 vào R4, tăng địa chỉ R2
    LDRB R5, [R3], #1 ; Tải từng byte của chuỗi 2 vào R5, tăng địa chỉ R3
    CMP R4, R5        ; So sánh ký tự của hai chuỗi
    BNE NotSame       ; Nếu ký tự khác nhau, nhảy đến nhãn NotSame

    ; Giảm độ dài của chuỗi, nếu hết ký tự thì thoát vòng lặp
    SUBS R0, R0, #1   ; Giảm độ dài chuỗi 1
    BNE Loop          ; Nếu còn ký tự, quay lại so sánh tiếp

Same
    ; Nếu hai chuỗi giống nhau
    MOV R0, #1        ; Đặt R0 = 1 (chuỗi giống nhau)
    B Stop            ; Dừng chương trình

NotSame
    ; Nếu hai chuỗi khác nhau
    MOV R0, #0        ; Đặt R0 = 0 (chuỗi khác nhau)

Stop
    B Stop            ; Dừng chương trình tại nhãn Stop (vòng lặp vô hạn)
    END               ; Kết thúc chương trình
```

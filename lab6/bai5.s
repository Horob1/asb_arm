	AREA RESET, DATA, READONLY
        DCD 0x20002000
        DCD Main
DT1 DCB "SINH VIEN", 0           
DT2 DCB "KMA", 0      

    AREA MYDATA, DATA, READWRITE
DT3 DCB 0         

    AREA Program, CODE, READONLY
    ENTRY
ConcatStrings PROC
LoopCopy
    LDRB R2, [R0], #1       
    CMP R2, #0               
    BEQ Done                
    STRB R2, [R1], #1        
    B LoopCopy               
Done               
    BX LR 
ENDP	

Main
    LDR R0, =DT1             
    LDR R1, =DT3             
    BL ConcatStrings         

    MOV R2, #32              
    STRB R2, [R1], #1        

    LDR R0, =DT2            
    BL ConcatStrings        

Stop B Stop                
    END                      

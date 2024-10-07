    ; CHUAN HOA XAU
        AREA RESET, DATA, READONLY
        DCD 0x20001000
        DCD Main
        AREA Input, DATA, READONLY
    InputString
        DCB "  HELLO   WORLD!   ", 0   

        AREA Output, DATA
    OutputString
        SPACE 20                      
        ALIGN
        AREA Program, CODE, READONLY
        ENTRY

    Main
        LDR R0, =InputString     
        LDR R1, =OutputString    
        MOV R2, #1              

    Loop
        LDRB R3, [R0], #1        
        CMP R3, #0               
        BEQ Done             

        CMP R3, #' '            
        BEQ CheckSpace         

        CMP R2, #1               
        BNE LowerCase            

        AND R4, R3, #0xDF        
        STRB R4, [R1], #1      
        MOV R2, #0             
        B Loop

    CheckSpace
        CMP R2, #1               
        BEQ Loop                 
        MOV R2, #1               
        STRB R3, [R1], #1       
        B Loop

    LowerCase
        ORR R4, R3, #0x20      
        STRB R4, [R1], #1       
        B Loop

    Done
        STRB R2, [R1]            
        SWI &11                  

        END

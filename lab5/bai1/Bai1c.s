/*;Chuyen tu he 10 sang 16
	AREA RESET, DATA, READONLY
			DCD 0x20000000
			DCD Reset_Handler
input   DCD 25    
        AREA MYDATA, DATA, READWRITE
result  DCB 0, 0    

        AREA MYCODE, CODE, READONLY
			ENTRY
Reset_Handler
        LDR R0, input
        MOV R1, R0
        LDR R2, =result
		ADD R2,#100
convert_loop
        CMP R1, #0     
        BEQ done       
        MOV R3, R1    
        AND R3, #0x0F         
        CMP R3, #9
        BLE digit_num
        ADD R3, #7         
digit_num
        ADD R3, #48   
        STRB R3, [R2], #-1
        LSRS R1, #4
        B convert_loop
done
        SWI 0x11      
        END
*/
.MODEL SMALL
.STACK 100H
.DATA
A DB ?
B DB ?
C DB ?  

EQUI_MSG DB 0AH, 0DH, "EUILATERAL$"
ISO_MSG DB 0AH, 0DH, "ISO$"
SCA_MSG DB 0AH, 0DH, "SCA$"


.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    
    MOV AH, 01H
    INT 21H
    MOV A, AL
    
    INT 21H
    MOV B, AL
    
    INT 21H
    MOV C, AL
    
    MOV BL, B
    CMP A, BL
    JE CASE0 ; A=B
    JNE CASE1 ; A!=B
    
    JMP ENDCASE
    CASE0:   ; A = B
        CMP BL, C
        JNE ISO
        JE  EQUI
        
    
    
    JMP ENDCASE
    CASE1:   ; A != B
        CMP BL, C
        JNE SCA
        JE ISO
    
    
    
    ENDCASE:
    
    
    EQUI:
    LEA DX, EQUI_MSG
    JMP DISPLAY
    
    ISO:        
    LEA DX, ISO_MSG
    JMP DISPLAY
    
    SCA:       
    LEA DX, SCA_MSG
    JMP DISPLAY
    
    
    DISPLAY:
    MOV AH, 09H
    INT 21H
    
    
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN

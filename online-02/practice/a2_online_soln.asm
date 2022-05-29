.MODEL SMALL
.STACK 100H
.DATA
INPUT   DW ?  

A_P     DB 0AH, 0DH, "A+$"
A       DB 0AH, 0DH, "A$"
A_M     DB 0AH, 0DH, "A-$"
B_P     DB 0AH, 0DH, "B+$"
B       DB 0AH, 0DH, "B$"
F       DB 0AH, 0DH, "F$"
INVALID DB 0AH, 0DH, "INVALID$"


.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    
    XOR BX, BX
    
    TOP:       
    MOV AH, 01H
    INT 21H   
    
    CMP AL, 0DH
    JE BREAK
    
    CMP AL, 0AH
    JE BREAK
    
    
    AND AX, 000FH
    
    MOV CX, AX
    
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX
    
    
    
    
    JMP TOP
    BREAK: 
    
    MOV INPUT, BX
    
    CMP BX, 100
    JG DISPLAY_INVALID
    
    CMP BX, 80
    JGE DISPLAY_A_P
    
    CMP BX, 75
    JGE DISPLAY_A
    
    CMP BX, 70
    JGE DISPLAY_A_M
    
    CMP BX, 65
    JGE DISPLAY_B_P
    
    CMP BX, 60
    JGE DISPLAY_B
    
    CMP BX, 00
    JGE DISPLAY_F
    
    JMP DISPLAY_INVALID
    
    
    
    
    
    DISPLAY_A_P:
    LEA DX, A_P
    JMP DISPLAY 
    
    DISPLAY_A:
    LEA DX, A
    JMP DISPLAY
    
    DISPLAY_A_M:
    LEA DX, A_M
    JMP DISPLAY
    
    DISPLAY_B_P:
    LEA DX, B_P
    JMP DISPLAY
    
    DISPLAY_B:
    LEA DX, B
    JMP DISPLAY
    
    DISPLAY_F:
    LEA DX, F
    JMP DISPLAY
    
    DISPLAY_INVALID:
    LEA DX, INVALID
    JMP DISPLAY
    
    DISPLAY:
    MOV AH, 09H
    INT 21H
    
    
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN

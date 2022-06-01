.MODEL SMALL
.STACK 100H
.DATA

N DW ?
CR EQU 0DH
LF EQU 0AH

NO_CHAR_MSG DB CR,LF,"NOT A LETTER$"
VOWEL_MSG   DB CR,LF,"VOWEL$"
CONSO_MSG   DB CR,LF,"CONSONANT$"

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 01H
    INT 21H
    
    OR  AL, 20H
    
    CMP AL, 'A'
    JNGE NO_CHAR
    CMP AL, 'Z'
    JNLE NO_CHAR
    
    CMP AL, 'A'
    JE VOWEL   
    
    CMP AL, 'E'
    JE VOWEL
    
    CMP AL, 'I'
    JE VOWEL
    
    CMP AL, 'O'
    JE VOWEL
    
    CMP AL, 'U'
    JE VOWEL  
    
    JMP CONSO
    
    
    
    VOWEL:
    LEA DX, VOWEL_MSG
    JMP DISPLAY
    
    
    CONSO:
    LEA DX, CONSO_MSG
    JMP DISPLAY

    
    NO_CHAR:
    LEA DX, NO_CHAR_MSG
    JMP DISPLAY
    
    DISPLAY:
    MOV AH, 09H
    INT 21H
    
    EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN

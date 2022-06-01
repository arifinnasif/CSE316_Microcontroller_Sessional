.MODEL SMALL
.STACK 100H
.DATA
MAX   DW 0
IDX   DW 0 
CNT   DW 0
LEN   DW 0

STR   DB 100 DUP(?)
NL    DB 0AH, 0DH, '$' 




.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 01H
    XOR BX, BX 
    
    LEA SI, STR
    
    TOP:  
     
    
    INT 21H   
    
    CMP AL, 0DH
    JE BREAK
    
    CMP AL, 0AH
    JE BREAK
    
    INC CNT
    
    
    ; IF1 AL >= BL
    CMP AL, BL
    JNGE ELSE1
    
    ; THEN1
    INC LEN  
    
    ; IF2 LEN > MAX
    MOV CX, LEN
    CMP CX, MAX
    JNG ENDIF1 
    
    ; THEN2
    MOV MAX, CX
    MOV CX, CNT
    SUB CX, MAX
    MOV IDX, CX
    
    
    
    JMP ENDIF1
    
    ELSE1:
    MOV LEN, 1
    
    ENDIF1:
    
    
    MOV BL, AL 
    MOV [SI], AL
    INC SI
    JMP TOP
    BREAK: 
    
    MOV AH, 09H
    LEA DX, NL
    INT 21H
    
    LEA SI, STR
    ADD SI, IDX
    
    MOV CX, 0
    MOV AH, 02H
    
    TOP2:
    CMP CX, MAX
    JNL SKIP
    
    MOV DL, [SI]
    INT 21H
    
    INC SI
    INC CX
    JMP TOP2
    SKIP:
    
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN

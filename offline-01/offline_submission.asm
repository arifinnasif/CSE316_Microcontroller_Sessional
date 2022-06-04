.MODEL SMALL 
.STACK 100H 
.DATA


PROMPT1					DB "ENTER ARRAY SIZE: $"
PROMPT2					DB CR, LF, "ENTER ARRAY ELEMENTS:", '$'
SORTED_MSG				DB CR, LF, "THE SORTED ARRAY:", '$'
BSEARCH_MSG				DB "SEARCH ELEMENTS IN THE SORTED ARRAY$"
PROMPT3					DB CR, LF, "> ", '$'

INPUT_PROC_TEMP			DB 0
OUTPUT_PROC_OUTSTRING	DB "000000$" 
OUTPUT_PROC_IS_NEG		DB 0 
BINARY_SEARCH_PROC_X	DW ?  
NOT_FOUND_MSG			DB "NOT FOUND$"

N						DW ?
X						DW ?
CNT						DW 0

ARR						DW 200 DUP(?)

CR						EQU 0DH
LF						EQU 0AH

NL						DB CR,LF,'$'

.CODE 
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, PROMPT1
    MOV AH, 09H
    INT 21H
    
    CALL INPUT
    POP N
    
    LEA DX, PROMPT2
    MOV AH, 09H
    INT 21H
    
    LEA SI, ARR
    
    
    CMP N, 0
    JNG EXIT
    SORT_LOOP:
        CALL NEWLINE
        CALL INPUT
        POP X
        XOR CX, CX
        FIRST_STEP:
        CMP SI, OFFSET ARR
        JE LAST_STEP
        
        MOV AX, X
        CMP [SI-2], AX
        JNG LAST_STEP
        DEC SI
        DEC SI
        INC CX
        PUSH [SI]
        JMP FIRST_STEP
    
    
    
        LAST_STEP:
        MOV AX, X
        MOV [SI], AX
        EMPTY_THE_STACK:
        INC SI
        INC SI
        CMP CX, 0
        JLE END_EMPTY_THE_STACK
        
        POP [SI]
        DEC CX
        
        JMP EMPTY_THE_STACK
        
        END_EMPTY_THE_STACK:

        
        
        
        
        
    
    INC CNT
    MOV BX, CNT
    CMP BX, N
    JNGE SORT_LOOP
    END_SORT_LOOP:
    
    
    LEA DX, SORTED_MSG
    MOV AH, 09H
    INT 21H
    
    
    MOV CNT, 0
    MOV BX, N
    LEA SI, ARR
    
    
    OUTPUT_LOOP:   
    CALL NEWLINE
    PUSH SI
    PUSH [SI]
    CALL OUTPUT
    POP SI
    
    INC SI
    INC SI
    
    
    
    
    
    INC CNT
    CMP CNT, BX
    JGE END_OUTPUT_LOOP
    JMP OUTPUT_LOOP
    END_OUTPUT_LOOP:
    
    
    CALL NEWLINE
    LEA DX, BSEARCH_MSG
    MOV AH, 09H
    INT 21H
    
    
    ;BINARY SEARCH
    INF_LOOP:
    CALL NEWLINE
    LEA DX, PROMPT3
    MOV AH, 09H
    INT 21H
    
    CALL INPUT
    POP X       
    
    
    ;PUSH OFFSET ARR
    LEA DX, ARR
    PUSH DX
    PUSH N              
    PUSH X
    CALL BINARY_SEARCH
    CALL NEWLINE
    
    POP AX
    CMP AX, 0
    JL NOT_FOUND
    SUB AX, OFFSET ARR
    SHR AX, 1
    PUSH AX
    CALL OUTPUT
    
    JMP INF_LOOP
    NOT_FOUND:
    LEA DX, NOT_FOUND_MSG
    MOV AH, 09H
    INT 21H
    JMP INF_LOOP  
    
    
      
    EXIT:
	; INTERRUPT TO EXIT
    MOV AH, 4CH
    INT 21H
    
  
MAIN ENDP 

; WORD INPUT()
; 
; REGS: AX, BX, CX, DX
INPUT PROC
    ; FAST BX = 0
    XOR BX, BX 
    MOV INPUT_PROC_TEMP, 00
    
    ; CHECK FOR -
    MOV AH, 01H
    INT 21H
    CMP AL, '-'
    JNE PRELOOP 
    MOV INPUT_PROC_TEMP, 1 ; DL = 1 => NUMBER = NEG 
    XOR AL, AL ; CLEARING THE INPUT AL
    
    PRELOOP:
    AND AL, 0FH
    MOV BL, AL
    
    INPUT_LOOP: 
    ; CHAR INPUT 
    MOV AH, 1
    INT 21H
    
    ; IF \N\R, STOP TAKING INPUT
    CMP AL, CR    
    JE END_INPUT_LOOP
    CMP AL, LF
    JE END_INPUT_LOOP
    
    ; FAST CHAR TO DIGIT
    ; ALSO CLEARS AH
    AND AX, 000FH
    
    ; SAVE AX 
    MOV CX, AX
    
    ; BX = BX * 10 + AX
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX
    JMP INPUT_LOOP
    
    END_INPUT_LOOP:
    

    
    CMP INPUT_PROC_TEMP, 01
    JNE RETURN
    
    NEG BX
    
    RETURN:
    POP DX
    PUSH BX
    PUSH DX
    
    
    RET
INPUT ENDP

; VOID OUTPUT(WORD N)
; 
; REGS: AX, CX, DX, SI, BP, SP
OUTPUT PROC
    LEA SI, OUTPUT_PROC_OUTSTRING
    ADD SI, 6
    MOV BP, SP
    MOV AX, [BP+2]
    
    CMP AX, 0     
    JL IS_NEG
    MOV OUTPUT_PROC_IS_NEG, 0
    
    JMP END_IS_NEG
    IS_NEG:  
    MOV OUTPUT_PROC_IS_NEG, 1
    NEG AX
    
    END_IS_NEG:
    
    PRINT_LOOP:
        DEC SI
        
        MOV DX, 0
        ; DX:AX = 0000:AX
        
        MOV CX, 10
        DIV CX
        
        ADD DL, '0'
        MOV [SI], DL
        
        CMP AX, 0
        JNE PRINT_LOOP
    
    
    CMP OUTPUT_PROC_IS_NEG, 0
    JE END_ADD_MINUS
    
    ;ADD MINUS
    DEC SI
    MOV [SI], '-'
    
    END_ADD_MINUS:
    MOV DX, SI
    MOV AH, 9
    INT 21H
    
    RET 2

OUTPUT ENDP

; VOID NEWLINE()
; 
; REGS: AX, DX
NEWLINE PROC
    LEA DX, NL
    MOV AH, 09H
    INT 21H
    RET
NEWLINE ENDP

; WORD BINARY_SEARCH(ARR, N, X)
; RETURNS ADDRESS TO THE MEMORY LOCATION WHERE X IS IN THE ARR
; OR -1 IF X NOT FOUND IN ARR
; 
; REGS: BX, CX, SI, DI, BP, SP
BINARY_SEARCH PROC
    MOV BP, SP
    MOV CX, [BP+2] ; CX HOLDS THE X TO BE FOUND
    MOV SI, [BP+6]
    MOV DI, SI
    ADD DI, [BP+4] ; [BP+4] IS N
    ADD DI, [BP+4]
    DEC DI
    DEC DI
    BINARY_SEARCH_LOOP: 
    ;MOV DX, [DI]
    ;CMP [SI], DX
    CMP SI, DI
    JG END_BINARY_SEARCH_LOOP 
    
    MOV BX, DI
    SUB BX, SI
    SHR BX, 2
    SHL BX, 1 ; ROUND OFF TO EVEN
    
    ADD BX, SI ; BX = MID = SI+(DI-SI)/2
    
    CMP [BX], CX 
    JE BINARY_SEARCH_RETURN
    JG BINARY_SEARCH_GREATER
    ;MID < X
    MOV SI, BX
    INC SI
    INC SI
    
    JMP BINARY_SEARCH_ENDIF
    BINARY_SEARCH_GREATER:
    ;MID > X
    MOV DI, BX
    DEC DI
    DEC DI
    
    BINARY_SEARCH_ENDIF:
    
    
    JMP BINARY_SEARCH_LOOP
    END_BINARY_SEARCH_LOOP:
    MOV BX, -1
    
    BINARY_SEARCH_RETURN:
    MOV [BP+6], BX
    RET 4
    
BINARY_SEARCH ENDP    
END MAIN 

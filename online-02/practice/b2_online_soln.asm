.MODEL SMALL 
.STACK 100H 
.DATA

N DW ?
CR EQU 0DH
LF EQU 0AH 

x1 db ?
x2 db ?

y1 db ?
y2 db ?
prmt db "ENTER COORD: $"

1_msg db cr, lf, "1st quad$"
2_msg db cr, lf, "2nd quad$"
3_msg db cr, lf, "3rd quad$"
4_msg db cr, lf, "4th quad$"
axis_msg db cr, lf, "on axis$"
x_axis_msg db cr, lf, "on x axis$"
y_axis_msg db cr, lf, "on y axis$"
ctr_msg db cr, lf, "center$"

.CODE 
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    
    lea dx, prmt
    mov ah, 09h
    int 21h
    
    
    
    ;input x
    mov ah, 01h
    
    int 21h  
    mov x1, al
    
    int 21h   
    mov x2, al
    and x2, 0fh 
    
    cmp x1, '-'
    je  case1
    
    jmp end_case1
    case0:     ;x is pos
                 
    jmp end_case1                 
    case1:; x is neg 
    neg x2
    
    end_case1:
    
    
    ;remove ws
    mov ah, 01h
    int 21h 
    
    
    
    ;input y
    mov ah, 01h
    
    int 21h  
    mov y1, al
    
    int 21h   
    mov y2, al
    and y2, 0fh 
    
    cmp y1, '-'
    je  case3
    
    jmp end_case2
    case2:     ;x is pos
                 
    jmp end_case2                 
    case3:; x is neg 
    neg y2
    
    end_case2:
    
    
    
    
    
    ;-----------------
    
    cmp x2, 0
    
    jg x_pos
    jl x_neg
    je x_zero
    
    jmp end_x
    x_pos:
        cmp y2, 0
        je x_axis
        jg first
        jl fourth
        
    
    
    jmp end_x
    x_neg:
        cmp y2, 0
        je x_axis
        jg second
        jl third
    
    
    jmp end_x
    x_zero:
        cmp y2, 0
        je ctr
        jmp y_axis
    
    
    end_x:
    
   
   
   
    ;-----------------
    
    first:
    lea dx, 1_msg
    jmp display
    
    
    second:
    lea dx, 2_msg
    jmp display
    
    
    third:
    lea dx, 3_msg
    jmp display
    
    
    fourth:
    lea dx, 4_msg
    jmp display
    
    
    axis:
    lea dx, axis_msg
    jmp display
    
    x_axis:
    lea dx, x_axis_msg
    jmp display
    
    y_axis:
    lea dx, y_axis_msg
    jmp display
    
    
    ctr:
    lea dx, ctr_msg
    jmp display
    
    
    display:
    mov ah, 09h
    int 21h
    jmp exit
    
    
    
    
    
    
    
    
    
      

	; interrupt to exit
	exit:
    MOV AH, 4CH
    INT 21H
    
  
MAIN ENDP 
END MAIN 


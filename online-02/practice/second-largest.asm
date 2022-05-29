.model small
.stack 100h
.data
a db ?
b db ?
c db ?

ans db ?

msg db 0ah, 0dh, "all are equal$"

.code
main proc
    
    mov ax, @data
    mov ds, ax
    
    ;input
    mov ah, 01
    int 21h
    mov a, al 
    
    mov ah, 01
    int 21h
    mov b, al
    
    mov ah, 01
    int 21h
    mov c, al
    
    
    mov bl, a
    cmp bl, b
    jg case0 ; a>b
    jl case1 ; a<b
    je case2 ; a=b
    
    jmp end_case
    case0: ; if a>b
        mov cl, c
        cmp b, cl
        jge ansb
        cmp cl, a
        jg ansa
        je ansb 
        ; c is in between a and b
        jmp ansc
    
    
    jmp end_case
    case1: ; if a<b 
        mov cl, c
        cmp b, cl
        jl ansb
        je ansa
        cmp cl, a
        jle ansa 
        ; c is in between a and b
        jmp ansc
    
    
    
    jmp end_case
    case2: ; if a=b 
        mov cl, c
        cmp b, cl
        je noans
        jg ansc
        jl ansa
    
    
    end_case:
    
    
        
    ansa:
    mov cl, a
    mov ans, cl
    jmp display
    
    ansb:
    mov cl, b
    mov ans, cl
    jmp display
    
    ansc:
    mov cl, c
    mov ans, cl
    jmp display
    
    noans:
    lea dx, msg
    mov ah, 09h
    int 21h
    jmp exit

    display:              
    mov dl, ans 
    ;mov al, ans
    mov ah, 02h
    int 21h
     
    exit:
    mov ah, 4ch
    int 21h

main endp
end main

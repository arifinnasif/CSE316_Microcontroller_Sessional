.model small
.stack 100h
.data   
x db ?


cr equ 0dh
lf equ 0ah
nl db cr, lf, '$'

.code
main proc
    mov ax, @data
    mov ds, ax
    
    
    ;input
    mov ah, 01h
    int 21h
    sub al, 'a'
    mov x, al
    
    
    
    
    ;26-2x
    mov bl, x
    add bl, bl
    
    neg bl
    
    add bl, 25
    add bl, 'A'
    
    
    ;output
    mov ah, 02h
    mov dl, bl
    int 21h
    
    
    
    mov ah, 4ch
    int 21h
main endp
end main

.model small
.stack 100h
.data

x db ?

cr equ 0ah
lf equ 0dh

.code

main proc
    mov ax, @data
    mov ds, ax
    
    ;<input>
    mov ah, 01h
    int 21h
    ;</input>
    
    
    
    mov ah, 00h
    
    sub al, 'a'
    
    
    neg al
    add al, 17
    
    mov x, al
    
    ;<newline>
    mov dl, cr
    mov ah, 02h
    int 21h
    
    mov dl, lf
    mov ah, 02h
    int 21h
    ;</newline>
    
    
    ;<get 2 digit>
    mov ah, 00h
    mov al, x
    
    mov bl, 10
    div bl
    
    mov dx, ax
    
    add dl, '0'
    mov ah, 02h
    int 21h
    
    mov dl, dh 
    add dl, '0'
    int 21h
    ;</get 2 digit>
    
    
    
    mov ah, 4ch
    int 21h
main endp
end main

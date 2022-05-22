.model small
.stack 100h
.data
x db ?
y db ?
z db ?
.code

main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 01h
    int 21h   
    
    sub al, '0'
    mov x, al
    
    mov ah, 01h
    int 21h   
    
    sub al, '0'
    mov y, al
    
    mov ax, 0
    mov al, x
    sub al, y
    sub al, y
    
    mov z, al
    
    mov dl, z
    add dl, '0'
    mov ah, 02h
    int 21h
    
    mov ah, 4ch
    int 21h
main endp
end main

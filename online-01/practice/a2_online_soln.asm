.model small
.stack 100h
.data

s_large db "*******$"
s_medium db "***$"
s_small db "**$"
name1 db ?
name2 db ?
name3 db ?

cr equ 0ah
lf equ 0dh

.code

main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 01h
    int 21h
    
    mov name1, al
    
    
    mov ah, 01h
    int 21h
    
    mov name2, al
    
    
    mov ah, 01h
    int 21h
    
    mov name3, al
    
    
    ;<new line>
    mov dl, lf
    mov ah, 02h
    int 21h
    
    mov dl, cr
    mov ah, 02h
    int 21h
    ;</new line>
    
    
    ;l1
    lea dx, s_large
    mov ah, 09h
    int 21h
    
    ;new line
    mov dl, lf
    mov ah, 02h
    int 21h
    
    mov dl, cr
    mov ah, 02h
    int 21h
    
    
    ;l2
    lea dx, s_large
    mov ah, 09h
    int 21h
    
    ;new line
    mov dl, lf
    mov ah, 02h
    int 21h
    
    mov dl, cr
    mov ah, 02h
    int 21h
    
    ;l3
    lea dx, s_medium
    mov ah, 09h
    int 21h
    
    mov dl, name1
    mov ah, 02h
    int 21h
    
    lea dx, s_medium
    mov ah, 09h
    int 21h
    
    
    ;new line
    mov dl, lf
    mov ah, 02h
    int 21h
    
    mov dl, cr
    mov ah, 02h
    int 21h
    
    
    ;l4
    lea dx, s_small
    mov ah, 09h
    int 21h
    
    mov dl, name1
    mov ah, 02h
    int 21h
    
    mov dl, name2
    mov ah, 02h
    int 21h
    
    mov dl, name3
    mov ah, 02h
    int 21h
    
    lea dx, s_small
    mov ah, 09h
    int 21h
    
    
    ;new line
    mov dl, lf
    mov ah, 02h
    int 21h
    
    mov dl, cr
    mov ah, 02h
    int 21h
    
    
    ;l5
    lea dx, s_medium
    mov ah, 09h
    int 21h
    
    mov dl, name3
    mov ah, 02h
    int 21h
    
    lea dx, s_medium
    mov ah, 09h
    int 21h
    
    
    ;new line
    mov dl, lf
    mov ah, 02h
    int 21h
    
    mov dl, cr
    mov ah, 02h
    int 21h
    
    
    ;l6
    lea dx, s_large
    mov ah, 09h
    int 21h
    
    
    ;new line
    mov dl, lf
    mov ah, 02h
    int 21h
    
    mov dl, cr
    mov ah, 02h
    int 21h
    
    
    ;l7
    lea dx, s_large
    mov ah, 09h
    int 21h
    
    
    
    
    mov ah, 4ch
    int 21h
main endp
end main

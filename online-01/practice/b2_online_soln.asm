.model small
.stack 100h
.data

cr equ 0dh
lf equ 0ah

x db ?

isodd db ?

ans db ?

str1 db "Enter an UPPERCASE letter: $"
str2 db "The answer: $"

nl db cr, lf, '$'

.code
main proc
    mov ax, @data
    mov ds, ax
    
    
    
    
    ;<newline>
    ;lea dx, nl
    ;mov ah, 09h
    ;int 21h 
    ;</newline>
    
    
    ;<input char>
    ;mov ah, 01h
    ;int 21h    
    ;mov ;;x;; , al
    ;</input char>
    
    
    ;<output char>
    ;<optional manipulation>
    ;add ;;?;;, ;;?;;
    ;</optional manipulation>
    ;mov ah, 02h
    ;mov dl, ;;?;;
    ;int 21h
    ;</output char>
    
    
    
    ;;show promp1
    lea dx, str1
    mov ah, 09h
    int 21h
    
    
    
    ;<input char>
    mov ah, 01h
    int 21h    
    mov x, al
    ;</input char>
    
    ;calculate
    sub x, 'A' ;got offset
    mov ax, 0
    mov al, x
    
    mov bl, 2
    div bl
    
    mov isodd, ah
    
    ;;
    mov ax, 0
    mov al, x
    neg al
    add al, 24
    add al, isodd
    add al, isodd
    
    ;;making char
    add al, 'a'
    mov ans, al
    
    
    
    
    ;<newline>
    lea dx, nl
    mov ah, 09h
    int 21h 
    ;</newline>
    
    
    ;;show promp1
    lea dx, str2
    mov ah, 09h
    int 21h
    
    ;<output char>
    ;<optional manipulation>
    ;add ;;?;;, ;;?;;
    ;</optional manipulation>
    mov ah, 02h
    mov dl, ans
    int 21h
    ;</output char>
    
    
    
    
    mov ah, 4ch
    int 21h
main endp
end main
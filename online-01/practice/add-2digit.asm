.model small
.stack 100h
.data
num1 dw ?
num2 dw ?

sum2 db ?
sum1 db ?
sum0 db ?

.code

main proc
    mov ax, @data
    mov ds, ax

    ;take num11
    mov ah, 01h
    int 21h

    mov ah, 00h
    sub al, '0'
    mov dx, 10
    mul dx

    mov num1, ax


    ;take num10
    mov ah, 01h
    int 21h

    mov ah, 00h
    sub al, '0'
    
    add num1, ax


    ;take num21
    mov ah, 01h
    int 21h

    mov ah, 00h
    sub al, '0'
    mov dx, 10
    mul dx

    mov num2, ax


    ;take num20
    mov ah, 01h
    int 21h

    mov ah, 00h
    sub al, '0'
    
    add num2, ax

    ; add
    mov ax, num1
    add ax, num2
    
    ;'div bx' divides dx:ax by bx
    ;so clean up dx before dividing
    mov dx, 0

    ;get 0th digit
    mov bx, 100
    div bl
    mov sum2, al
    add sum2, '0'

    ;get 1st digit
    mov al, ah
    mov ah, 00h
    mov bx, 10
    div bl
    mov sum1, al 
    add sum1, '0'

    ;get 2nd digit
    mov sum0, ah
    add sum0, '0'

    ;output
    mov dl, sum2
    mov ah, 02h
    int 21h

    mov dl, sum1
    int 21h

    mov dl, sum0
    int 21h

    mov ah, 4ch
    int 21h
main endp
end main
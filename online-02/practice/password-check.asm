.model small
.stack 100h
.data


has_l db 0
has_u db 0
has_digit db 0
has_pr db 1

msg0 db 0ah, 0dh, "invalid password$"
msg1 db 0ah, 0dh, "valid password$"

.code
main proc
    
    mov ax, @data
    mov ds, ax
    
    mov ah, 01h
    input:     
    int 21h
    
    ; al<=z and al>=a
    cmp al, 'a'
    jnge end_l
    cmp al, 'z'
    jnle end_l
        mov has_l, 1
    end_l:
    
    ; al<=Z and al>=A
    cmp al, 'A'
    jnge end_u
    cmp al, 'Z'
    jnle end_u
        mov has_u, 1
    end_u: 
    
    ; al<=0 and al>=9
    cmp al, '0'
    jnge end_d
    cmp al, '9'
    jnle end_d
        mov has_digit, 1
    end_d:
    
    
     
    
    ; break if line end
    cmp al, 0ah
    je break
    cmp al, 0dh
    je break 
    
    ; al<21h or al>7eh
    cmp al, 21h
    jl then
    cmp al, 7eh
    jg then
    jmp end_pr
    then:
        mov has_pr, 0
    
    end_pr:
    
    jmp input
    break:
    
    mov bl, has_l
    cmp bl, 0
    je no
    
    mov bl, has_u
    cmp bl, 0
    je no
    
    mov bl, has_digit
    cmp bl, 0
    je no
    
    mov bl, has_pr
    cmp bl, 0
    je no
    
    jmp yes
    
    no:
    lea dx, msg0
    mov ah, 09h
    int 21h
    jmp exit
    
    yes:
    lea dx, msg1
    mov ah, 09h
    int 21h
    jmp exit
     
    exit:
    mov ah, 4ch
    int 21h

main endp
end main

.model small
.stack 100h

.data
is_magic db 0
proc_in dw ?
proc_tmp dw 0 

main_loop_cnt dw 0
main_tmp dw 0
number dw 100

.code

main proc
    mov ax, @data
    mov ds, ax
    
    main_loop:
    inc main_loop_cnt
    mov ax, main_loop_cnt
    cmp ax, number
    jg end_main_loop
    
    mov proc_in, ax
    call check_magic       
    xor ax, ax
    mov al, is_magic
    add main_tmp, ax
    
    
    
    
    
    jmp main_loop   
    end_main_loop:
    
    
    mov ah, 4ch
    int 21h
main endp   

check_magic proc
    mov proc_tmp, 0
    
    mov cx, 1
    
    proc_loop:
    inc cx
    cmp cx, proc_in
    jge end_proc_loop
    xor dx, dx
    mov ax, proc_in
    div cx         
    cmp dx, 0
    jne proc_loop  
    add proc_tmp, cx
    mov bx, proc_tmp  
    cmp bx, proc_in
    jge return_1
    
    
                      
    jmp proc_loop                  
    end_proc_loop:
    mov is_magic, 0
    ret
    
    return_1:
    mov is_magic, 1
    ret
    
check_magic endp    

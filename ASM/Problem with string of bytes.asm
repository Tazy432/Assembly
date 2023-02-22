bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;A string of bytes A is given . Save into another string B all values from A divisible with 7
    s db 14,7,20,30
    ls equ $-s
    aux db 0
    aux2 db 0
    b resb ls

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi,0
        mov ecx,ls
        mov edi,0
        repeta:
            mov ax,0
            mov al,byte[s+esi]
            mov dl,al
            cbw
            mov bl,7
            idiv bl;al=cat,ah=rest s[esi]/7
            cmp ah,0
            je divizibil
            inc esi
            jmp repeta
            divizibil:
                mov byte[b+edi],dl
                inc edi
                inc esi
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

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
    ; a string of bytes s is given , construct a string b where each element from b represents the sum of two consecutive elements from string A
    ; ex: a=2,3,4 => b=5,7
    s db 5,4,3,2
        ls equ $-s
        b resb ls-1

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ; exit(0)
        mov esi,0
        mov ecx,ls-1
        repeta:
            mov al,byte[s+esi]
            mov bl,byte[s+esi+1]
            sub al,bl
            mov byte[b+esi],al
            inc esi
            mov al,0
            mov bl,0
        loop repeta
            
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

bits 32 ; assembling for the 32 bits architecture
; declare the EntryPoint (a label defining the very first instruction of the program)
global start        
; declare external functions needed by our program
extern exit,printf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll 
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ; A string of words s is given . Compute another string d containing only the high bytes multyple of 7
    s dw 1234h,7654h,6773h
    ls equ ($-s)/2
    aux dw 0
    news resb ls
    formatprint 

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi,0
        mov edi,0
        mov ecx,ls
        repeta:
            mov bx,word[s+esi]
            mov byte[news+edi],bl
            inc edi
            add esi,2
        loop repeta
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

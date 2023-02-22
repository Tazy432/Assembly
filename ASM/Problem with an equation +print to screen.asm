bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit ,printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ; solve this ,a-(b/(-c)+d*5) and print the result on the screen
    a dd 100
    b db 10
    c dw -3
    d dw -2
    aux dw 0
    formatprint db '%d',0;
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; b/(-c
        ;-c
        mov bx,0
        sub bx,[c];bx=-c
        ; b byte -> dx:ax
        mov al,[b]
        cbw;al->ax
        cwd;
        idiv bx;ax->dx:ax/bx= ax cat , dx rest
        mov [aux],ax
        mov ax,5
        imul word[d];dx:ax =d*5
        ;transfer dx:ax in cx:bx=d*5
        mov bx,ax
        mov cx,dx
        mov ax,[aux]
        cwd
        add ax,bx
        adc dx,cx
        mov bx,word[a+0]
        mov cx,word[a+2]
        sub bx,ax
        sbb cx,dx
        ; pentru printare folosim printf
        ; salvare pe stiva parametrii functiei:printf( format , valoare de printat)
        ; stiva are dim 32 de biti - doubleword
        push cx
        push bx
        push dword formatprint
        ;am pus 2 worduri pe stiva , - un double word
        call [printf]
        add esp,4*2;2-2 dd am pus pe stiva , cx:bx si formatul de printare
        ;eliberam stiva
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

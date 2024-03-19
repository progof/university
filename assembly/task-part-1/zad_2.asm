;Oleh Ortynskyi, 1k212, czwartek 9:45

DATA1 segment
    txt1 db "Simple text 1", 10, 13, '$'
    txt2 db "Simple text 2", 10, 13, '$'
DATA1 ends

CODE1 segment
    ASSUME cs:CODE1, ds:DATA1, ss:STOS1
START:
    ; inicjalizacja stosu
    mov ax, seg STOS1
    mov ss, ax
    mov sp, offset top

    mov cx, 5 ; licznik powtórzeń

    petla:
    push cx

    ; wybór napisu na podstawie parzystości/nieparzystości licznika
    mov dx, offset txt1
    test cx, 1
    jz even_number
    mov dx, offset txt2

    even_number:
    call napis

    pop cx
    loop petla

    mov ax, 4c00h
    int 21h ; Przerwanie DOS - koniec programu

; podprogram napis
napis:
    mov ax, DATA1
    mov ds, ax
    mov ah, 9
    int 21h
    ret

CODE1 ends

STOS1 segment STACK
    dw 256 dup(?)
    top dw ?
STOS1 ends

END START

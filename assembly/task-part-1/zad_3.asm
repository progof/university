;Oleh Ortynskyi, 1k212, czwartek 9:45

DATA1 segment
    tekst1 db "   0000", 10, 13, '$'
    tekst2 db "1111", 10, 13, '$'
DATA1 ends

CODE1 segment
    ASSUME cs:CODE1, ds:DATA1, ss:STOS1
START:
    ; Inicjalizacja stosu
    mov ax, seg STOS1
    mov ss, ax
    mov sp, offset top

    mov cx, 4 ; Licznik zewnętrznej pętli (liczba wierszy)

    petla_zewnetrzna:
    mov bx, 3 ; Licznik wewnętrznej pętli (liczba kolumn)

    petla_wewnetrzna:
    ; Wybór tekstu na podstawie parzystości/nieparzystości licznika
    test cx, 1
    jz even_row
    mov dx, offset tekst2
    jmp po_przejsciu

    even_row:
    mov dx, offset tekst1

    po_przejsciu:
    call napis

    dec bx
    jnz petla_wewnetrzna

    loop petla_zewnetrzna

    mov ax, 4c00h
    int 21h ; Przerwanie DOS - koniec programu

; Podprogram napis
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


DATA1 SEGMENT
    txt1 DB "Cyfra ", 13, 10, '$' ; Tekst komunikatu
DATA1 ENDS

CODE1 SEGMENT
    ASSUME CS:CODE1, DS:DATA1, SS:STOS1



WYPISZ_CYFRE PROC
    ; Zapisz cyfrę z AL do BL, aby zwolnić AL dla funkcji DOS.
    mov bl, al

    ; Konwersja wartości ASCII cyfry na kod znaku.
    add bl, '0'

    ; Wypisz cyfrę na ekranie.
    mov dx, 0 ; Standardowe wyjście (konsola)
    mov ah, 2 ; Funkcja wypisania znaku
    mov dl, bl ; Kod znaku w rejestrze DL
    int 21h

    ; Zwróć sterowanie do programu głównego.
    ret
WYPISZ_CYFRE ENDP


START:
    ; Inicjalizacja stosu.
    mov ax, SEG STOS1
    mov ss, ax
    mov sp, OFFSET top

    ; Wypisz cyfrę 3.
    mov al, 14
    call WYPISZ_CYFRE

    ; Zakończ program.
    mov ax, 4C00h
    int 21h

; Stos
STOS1 SEGMENT STACK
    dw 256 DUP(?)
    top DW ?
STOS1 ENDS

CODE1 ENDS

END START
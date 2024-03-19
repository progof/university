;Oleh Ortynskyi, 1k212, czwartek 9:45

DATA1 segment
X DW 0 ; zmienna przechowująca wsp. X
Y DW 0 ; zmienna przechowująca wsp. Y
kolor DB 0 ; rezerwujemy 1 bajt na kolor
DATA1 ends

CODE1 segment
ASSUME cs:CODE1, ds:DATA1, ss:STOS1

Set_pixel320 PROC
    ;obliczamy odpowiedni adres w pamieci obrazu
    mov AX,0A000h
    mov ES,AX ; do ES segment pamieci ekranu
    mov AX, Y
    mov DX,320
    mul DX
    mov dx,X
    add ax,dx
    mov di,ax
    mov AL,kolor ; do AL=kolor
    mov ES:[DI],AL ; zapalamy punkt w pamieci obrazu
    ret
Set_pixel320 ENDP

START:
;inicjalizacja stosu
    mov ax,seg STOS1
    mov ss,ax
    mov sp,offset top
; przelaczenie karty w graficzny tryb 13h
    mov ah,00h ; do AH numer funkcji przerwania 10h
    mov al,13h ; do AL numer włączanego trybu
    int 10h ; włączamy tryb graficzny 13h
; - oczekiwanie na naciśnięcie dowolnego klawisza
    mov ax,0 ; funkcja 00 przerwania 16h czeka na klawisz
    int 16h ; przerwanie obsługujące klawiaturę
; ustalamy wsp. punktu i jego kolor…
    mov X,160 ; współrzędna X (środek ekranu)
    mov Y,0 ; początkowa współrzędna Y
    mov cx, 100 ; liczba iteracji pętli (100 pikseli)

draw_line:
    mov al, cl ; Ustawienie koloru na aktualną wartość licznika
    mov kolor, al ; Ustawienie koloru piksela
    call Set_pixel320 ; rysowanie piksela
    inc Y ; zwiększamy współrzędną Y o 1 piksel
    loop draw_line ; powtarzamy pętlę

; znow oczekiwanie na naciśnięcie dowolnego klawisza
    mov ax,0
    int 16h
; powrot do trybu tekstowego
    mov ah,00h ; do AH numer funkcji przerwania 10h
    mov al,03h ; do AL numer włączanego trybu
    int 10h ; 03 oznacza tryb tekstowy
; zakończenie programu
    mov ax,4c00h ; wywolaniem funkcji 4ch przerwania INT 21h
    int 21h ;kończymy program

CODE1 ends

STOS1 segment STACK
    dw 256 dup(?)
top dw ?
STOS1 ends
END START

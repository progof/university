;Oleh Ortynskyi, 1k212, czwartek 9:45

DATA1 segment
txt1 db "To jest napis! :)", 10, 13, '$'
DATA1 ends

CODE1 segment
	ASSUME cs:CODE1, ds:DATA1, ss:STOS1
START:
	;inicjalizacja stosu
	mov ax,seg STOS1
	mov ss,ax
	mov sp,offset top

	call napis
	call napis 

	mov ax,4c00h
	int 21h ; Przerwanie DOS - koniec programu
	
	;podprogram napis
	napis: 	mov ax,seg txt1
			mov ds,ax
			mov dx,offset txt1
			mov ah,9
			int 21h
			ret
CODE1 	ends

STOS1 segment STACK
	dw 256 dup(?)
top dw ? 
STOS1 ends
END START
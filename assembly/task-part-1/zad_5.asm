;Oleh Ortynskyi, 1k212, czwartek 9:45

DATA1 segment
  number_start db 10, 13, "Number ", "$"
  dot_end db ".", 10, 13, "$"
DATA1 ends

CODE1 segment
  ASSUME cs:CODE1, ds:DATA1, ss:STOS1

START:
  mov ax, seg STOS1
  mov ss, ax
  mov sp, offset top

  mov ah, 1
  int 21h
  call print_number

  mov ah, 4ch
  int 21h

print_number: 
  push ax
  mov ax, seg number_start
  mov ds, ax
  mov dx, offset number_start

  mov ah, 9
  int 21h

  pop ax
  mov dl, al
  mov ah, 2
  int 21h

  mov ax, seg dot_end
  mov ds, ax
  mov dx, offset dot_end

  mov ah, 9
  int 21h
  ret

CODE1 ends
STOS1 segment STACK
  dw 256 dup(?)
  top dw ?
STOS1 ends

END START
[bits 16]
[org 0x7c00]

inicio:
   mov si, mensaje
   mov ah, 0x0e

imprimir_bucle:
   lodsb
   cmp al, 0
   je detenerse
   int 0x10
   jmp imprimir_bucle

detenerse:
   hit
   jmp detenerse

mensaje db 'albonchoSO', 0

times 510-($-$$) db 0
dw 0xAA55
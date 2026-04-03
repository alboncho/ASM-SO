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

/* CODIGO CON FUNCIONES Y DOS MENSAJES

[bits 16]
[org 0x7c00]

inicio:
  mov si, mensaje1
  call imprimir

  mov si, mensaje2
  call imprimir

fin:
  hlt 
  jmp fin


imprimir:
  mov ah, 0x0e

.loop:
  lodsb
  cmp al, 0
  je .fin
  int 0x10
  jmp .loop

.fin:
  ret 

mensaje1 db "hello ", 0
mensaje2 db "albonchoOS...", 0

times 510-($-$$) db 0
dw 0xaa55

--------------------------------- */

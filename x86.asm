/* 📚 PRIMERO: ¿QUÉ SON EAX, EBX, ECX, EDX?

Imagina que el procesador tiene cajitas dentro de él donde puede guardar números temporalmente. Son como variables súper rápidas.

   EAX → "Acumulador" (Accumulator). Se usa mucho para operaciones matemáticas y resultados.

   EBX → "Base" (Base). A veces apunta a datos.

   ECX → "Contador" (Counter). Se usa para contar repeticiones.

   EDX → "Datos" (Data). Se usa para extender operaciones o guardar datos.                               */

/* Registros de propósito general (32 bits)
Registro	   Nombre	      Uso común	               ¿Puedo usarlo para lo que quiera?
----------------------------------------------------------------------------------------
EAX	      Acumulador	   Resultados de operaciones, ✅ Sí, pero convenciones 
                           syscall número	               lo usan para esto
----------------------------------------------------------------------------------------
EBX	      Base	         Direcciones base, syscall  ✅ Sí
                           argumento 1	
----------------------------------------------------------------------------------------
ECX	      Contador	      Bucles, syscall argumento 2✅ Sí
----------------------------------------------------------------------------------------
EDX	      Datos	         Operaciones de             ✅ Sí
                           multiplicación/división, 
                           syscall argumento 3	
----------------------------------------------------------------------------------------
ESI	      Fuente	      Operaciones con cadenas    ✅ Sí
                           (source index)	
----------------------------------------------------------------------------------------
EDI	      sDestino	      Operaciones con cadenas    ✅ Sí
                           (destination index)	
----------------------------------------------------------------------------------------
EBP	      Base pointer	Pila (stack frame)	      ⚠️ Cuidado
----------------------------------------------------------------------------------------
ESP	      Stack pointer	Pila (no tocar sin saber)	⚠️ Peligroso                        */

/*

EAX = 0x12345678

0x12 0x34 0x56 0x78
│    │    │    │
│    │    │    └─── AL (byte bajo) = 0x78
│    │    └──────── AH (byte alto de AX) = 0x56
│    └───────────── parte alta de AX? No exactamente
└────────────────── parte alta de EAX

Más claro:
- AL = byte 0 (bits 0-7)    = 0x78
- AH = byte 1 (bits 8-15)   = 0x56
- AX = bytes 0-1 (16 bits)  = 0x5678
- EAX = bytes 0-3 (32 bits) = 0x12345678              


Registro 32 bits	Registro 16 bits	Registros 8 bits

   EAX	         AX	               AH (alto), AL (bajo)
   EBX	         BX	               BH, BL
   ECX	         CX	               CH, CL
   EDX	         DX	               DH, DL

🔧 PARTE 3: mov al, [x] ¿SE PUEDE?

¡SÍ! Y es una buena práctica cuando solo quieres 1 byte.
assembly

x db '5'    ; x es dirección 2000, en 2000 hay 0x35

mov al, [x]    ; AL = 0x35 (el carácter '5')
mov ah, [y]    ; AH = 0x33 (el carácter '3')

Ahora AX (16 bits) = 0x3335 (AH=0x33, AL=0x35)

*/

section .text  ; Codigo .text en ARM

global _start  ; Punto de entrada '_start'

_start:     ; Etiqueta
   mov eax, [x]      ; COPIA el valor que esta en la direccion de 'x' hacia 'eax'
   sub eax, '0'      ; 'eax' = 5 (ASCII 0x35 - 0x30 = 5)
   /* Registros de 32 bits - cargar y convertir primer numero

   En ensamblador, mov significa COPIA. Copia el valor de un lugar a otro, y el original NO se borra.

   'mov eax, [x]'
      - mov = mover datos.
      - eax = registro de 32 bits (como una variable dentro del procesador) 'r0' en ARM
      - [x] 
         contenido en la direccion de memoria donde esta 'x'
         Como 'x' contiene el caracter '5' (ox35), ahora 'eas = 0x35'                   
   
   'sub eas, '0'' 
      Resta el valor ASCII del '0' (que es 0x30).
      '0x35 - 0x30 = 0x05' - ahora 'eas = 5' (numero, no caracter).                */

   mov ebx, [y]      ; 'ebx' es otro registro de 32 bits
   sub ebx, '0'      ; Resta '0' - 'ebx = 3'

   add eax, ebx      ; Sumar 
   add eax, '0'      ; Convertir a caracter
   /* 
   'add eax, abx'
      - 'eax' tenía 5, 'ebx' tenia 3 - ahora 'eax = 8'           
   
   'add eax, '0'
      - Le suma '0' (0x30) para convertirlo en el caracter '8' (0x38)
      - Porque quermos mostrar el resultado como texto.                             */

   mov [sum], eax      ; Guardar resultado en memoria
   /*
   - Guarda el byte bajo de 'eax' (porque 'sum' es 1 byte) en la direccion de 'sum'
   - en 'sum' queda el caracter '8'                                                 */

   /* Llamada al sistema (syscall) en Linux x86 para escribir en pantalla. */
; Syscall write (4)
   mov eax, 4        ; Número de syscall (OBLIGATORIO en eax)
   mov ebx, 1        ; 1er argumento: file descriptor (ebx)
   mov ecx, msg      ; 2do argumento: dirección del buffer (ecx)
   mov edx, len      ; 3er argumento: longitud (edx)
   int 0x80

   /* Mostrar el resultado (suma)                                                   */
   mov ecx, sum      ; Ahora 'ecs' apunta a 'sum'
   mov edx, 1        ; Solo byte (el resultado)
   mov ebx, 1        
   mov eax, 4
   int 0x80

   /* Terminar el programa */
   mov eax, 1     ; syscall 'exit'
   int 0x80       ; interrupcion

section .data     ; Datos inicializaods (con valores definidos)
   x db '5'
   y db '3'
   msg db  "sum of x and y is "
   len equ $ - msg

   /* 
   - x db '5'
      Define un byte (db = define byte) con el caracter '5'. En memoria se guarda el valor ASCII del '5', que es 0x35 (53 en decimal)   
   
   - y db '3'
      Igual, guarda el caracter '3' = 0x33
      
   - msg db "sum of x and y is "
      Define una cadena de texto
   
   - len equ $ - msg 
      Calcula la longitud de msg, '$' es la posicion actual, 'msg' es la posicion inicial, la resta da el tamaño. 'equ' define un valor fijo en ensamblado.
      
         👉 significa: “len vale eso para siempre”             */

segment .bss      ; Datos sin inicializar (solo se reserva espacio)
   sum resb 1

   /*
   - sum resb 1
      Reserva 1 byte (resb = reserve byte) para guardar el resultado de la suma. NO tiene valor inicial          */



/* VERSIO MODIFICADA, Registros de 8 bits:-----------------------------------------

section .data
   x db '5'
   y db '3'

section .bss
   sum resb 1

section .text
   global _start

_start:
   ; Usando registros de 8 bits
   mov al, [x]      ; AL = '5' (0x35)
   sub al, '0'      ; AL = 5
   
   mov bl, [y]      ; BL = '3' (0x33)
   sub bl, '0'      ; BL = 3
   
   add al, bl       ; AL = 8
   add al, '0'      ; AL = '8' (0x38)
   
   mov [sum], al    ; Guarda AL (1 byte) en sum
   
   ; Imprimir mensaje (igual que antes)
   mov ecx, msg
   mov edx, len
   mov ebx, 1
   mov eax, 4
   int 0x80
   
   ; Imprimir resultado
   mov ecx, sum     ; Dirección de sum
   mov edx, 1       ; 1 byte
   mov ebx, 1
   mov eax, 4
   int 0x80
   
   mov eax, 1
   int 0x80
--------------------------------------------------------------------------------*/

/* 📊 PARTE 5: TABLA COMPLETA DE REGISTROS

32 bits	16 bits	8 bits alto	8 bits bajo	¿Para qué?
EAX	AX	AH	AL	Acumulador (matemáticas)
EBX	BX	BH	BL	Base (direcciones)
ECX	CX	CH	CL	Contador (bucles)
EDX	DX	DH	DL	Datos (I/O, multiplicación)
ESI	SI	—	—	Source Index (cadenas)
EDI	DI	—	—	Destination Index (cadenas)
EBP	BP	—	—	Base Pointer (pila)
ESP	SP	—	—	Stack Pointer (pila)

Nota: ESI, EDI, EBP, ESP NO se dividen en alto/bajo de 8 bits.                     */
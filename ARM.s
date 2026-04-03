/*📌 Estructura general del código

El código tiene dos partes principales:
    .text → Aquí va el código (las instrucciones que hace el CPU).
    .data → Aquí van los datos (el texto que queremos mostrar).

*/

.text               @ Aquí empieza el código para el CPU
.global _start      @ '_start' es el nombre de una etiqueta
                    @ '.global' le dice al ensamblador: "Esta etiqueta tiene que ser visible desde fuera, para que el sistema operativo sepa donde empezar a ejecutar el programa"

_start:         
    /* 1. Preparar el mensaje */

    /*  
    - 'ldr' = load register 
    - 'r0'  = el registro, como cajita dentro del CPU donde guardamos numeros
    - '=hola_texto' significa: "la direccion de memoria donde empieza el texto", es como si 'r0' apuntara al principio de la frase.    */
    ldr r0, =hola_texto   @ Guardar en 'r0' la direccion del texto
    
/* 2. El bucle para imprimir (carácter por carácter) */
imprimir:
    /*  
    - 'ldrb' = load register byte
    - 'r1'   = es otra cajita (registro) donde guardamos el dato.
    - '[r0]' = significar: "ve a la direccion que esta en r0 y saca el  byte que hay alli".
    - '#1'    significa: "despues de cargar, suma 1 a 'r0' para que apunte al siguiente caracter".                 */
    ldrb r1, [r0], #1     @ Carga 1 byte en r1 y suma 1 a r0 (puntero)

    /* 
    - 'cmp' = significa "compare"
    - comparamos 'r1' con '0'
    - '#0'      es el numero 0, En ACII, el 0 significa fin de cadena (el caracter nulo \0).
    - El resultado de esta comparacion se guarda en las "bnaderas" del CPU.       */
    cmp r1, #0            @ ¿Llegamos al final del texto (un 0)?

    /* 
    - 'beq'     significa "branch if equals" (salta si son iguales)
    - Si la comparacion anterior dijo r1 era igual a 0, saltamos a la etiqueta 'fin'
    - Esto es para saber si llegamos al final del texto     .*/
    beq fin               @ Si r1 es 0, saltamos al final

    /* 3. Mandar el carácter al dispositivo UART */

    /* 
    - Cargamos en 'r2' la direccion de la consola (el dispositivo de muestra letras en pantalla).
    - '0xff201000' es una direccion especial en el CPulator donde esta la UART (el aparato que imprime) */
    ldr r2, =0xff201000   @ Dirección de la "Consola" en CPulator

    /*
    - 'str' = significa "store register" (guardar registro)
    - Guardamos el valor 'r1' (que es el caracter) en la direccion que tiene 'r2' (la consola)  
    - Asi el caracter aparece en la pantalla            */
    str r1, [r2]          @ Escribe el carácter en la consola
    
    /*
    - 'b' = significa "branch" (salta)       
    - Esto hace que el programa vuelvea a la etiqueta 'imprimir' para repetir el proceso con la siguiente letra         */
    b imprimir            @ Vuelve a repetir para la siguiente letra

fin:                @ Etiqueta que marca el final del programa.        
    /*
    - 'b fin' = hace qu el programa salte a si mismo, creando un bucle infinito
    - Esto es necesario porque si el programa termina, el CPU seguiria ejecutando basura y podria romperse      */
    b fin                 @ Bucle infinito para que el CPU no explote

/* COMO TERMINAR UN SISTEMA REAL

mov r0, #0      @ codigo de salida 0
mov r7, #1      @ llamada "exit"
svcc 0          @ llamada al sistema



'mov' = move (mover)
'r0'  = register 0 (primera cajita)
'#0'  = el numero 0

Guarda el numero 0 en r0
¿Por que? Cuando terminas un programa, puedes decirle al sistema operativo si termino bien o mal:

    - 0 = Todo salio bien 
    - 1, 2, etc. = Algo salio mal

En linux, si pones #324, le estas diciendo al sistema operativo: "Termine con codigo de error 324"

mov r0, #0      @ codigo de salida 0



'r7' = registro 7
'#1' = el numero 1

Guarda el numero 1 en r7.
¿Por que? El sistema operativo ofrece MUCHAS operaciones:

    - #1 = "exit" (terminar programa)
    - #4 = "wirte" (escribir en pantalla)
    - #3 = "read" (leer del teclado)
    - #11 = "execve" (Ejecutar otro programa)

Cada numero es como un código de operaciones. Le dices al sistema operativo: "Quiero que hagas la operacion numero X".

mov r7, #1      @ llamada "exit"


'svc' = SuperVisor Call (llamada al supervisor)
'0' = numero (en este caso no se usa, puede ser cualquier numero)

¿que hace? esta instruccino hace qu ele CPU haga algo magico:
    1. Interrumpe su ejecucion normal
    2. Cambia a modo supervisor (modo privilegiado)
    3. Salta al codigo del sistema operativo
    4. El SO mira r7 para saber que operacion hacer (en este caso #1 = exit)
    5. EL SO mira r0 para saber el codigo de salida (#0 = todo bien)
    6. EL SO terimna el programa y vuelve al shell/terminal

svc 0           @ llamada al sistema       


🔢 ¿Por qué #0 puede ser cualquier número?

En las llamadas al sistema:

    - r0, r1, r2... son argumentos (parámetros)
    - r7 es el número de la operación

Para exit (operación #1):

    - r0 = código de salida (puede ser 0, 1, 2, 324, cualquier número)
    - No necesita más argumentos

Para write (operación #4):

    - r0 = ¿dónde escribir? (1 = pantalla, 2 = error, etc.)
    - r1 = dirección del texto
    - r2 = cuántos caracteres escribir
    - r7 = 4 (código de write)

*/

.data               @ Aquí guardamos los datos (cosas que no son instrucciones)

/*
- Etiqueta que marca donde empieza nuestro texto        */
hola_texto:
    /*
    - '.asciz'      significa "ASCII string with zero terminator     
    - Guarda el texot "Hola Mundo, alboncho!\n!" en memoria
    - El '\n' es un salto de linea
    - Al final, automaticamente añade un 0 (caracter nulo) para saber donde termina     */
    .asciz "Hola Mundo, alboncho!\n"




/* USANDO 'bx' 'lr' & 'bl'

.global _start
_start:
    ldr r0, =alboncho
    bl imprimir

fin:
    b fin

imprimir:
loop:
    ldrb r1, [r0], #1
    cmp r1, #0
    beq done

    ldr r2, =0xff201000
    str r1, [r2]

    b loop

done:
    bx lr

.data
alboncho:
    .asciz "alboncho el mejor"
------------------------------ */

## 📎️ Aquí tienes un mapa rápido de tu programa

1. [**Conceptos Generales**](#️-1-conceptos-generales-el-traductor)
   - ¿Qué es un S.O.?, Kernel, Llamadas al sistema (syscalls), Modos de ejecución (usuario vs. kernel).
2. [**Procesos y CPU**](#️-2-administración-de-procesos)
   - Hilos (threads), Sincronización, Concurrencia, Deadlocks, Planificación (Scheduling).
3. [**Administración de Memoria (Índice Completo)**](#️-3-vamos-a-entrar-al-punto-3-administración-de-memoria)

   #### # **[NIVEL ANTECEDENTE Y HARDWARE BASE]**

   3.1. [**Antecedentes y Hardware Base**](#31-antecedentes-y-hardware-base)

      - Arquitectura Von Neumann: La base de todo (CPU + Memoria + E/S).
      - Tecnologías de Almacenamiento:
        - Núcleos de Ferrita (Memoria de anillos magnéticos antigua).
        - Escalas de Integración (SSI, MSI, LSI, VLSI): De pocos transistores a millones.
        - Memoria ROM y RAM Física.

   3.2. [**Conceptos de Gestión y Control**](#32-conceptos-de-gestión-y-control)
     - Gestión de Espacio: Direcciones disponibles, ocupadas y libres.
     - Mecanismos de Control:
        - Registro de Frontera (Limit Register): Para que un proceso no se pase a la memoria de otro.
        - Unidad de Gestión de Memoria (MMU): Traducción de direcciones.
            
   #### # **MUNDO 1: GESTION DE MEMORIA PRINCIPAL (todo en RAM)**

   3.3. [**Sistemas Monotarea y Asignación Contigua Simple**](#33-sistemas-monotarea-y-asignacion-contigua-simple)
      - Uso definido de memoria: Un solo proceso es dueño de todo.
      - Técnica de Overlays (Superposiciones): Cómo meter un programa grande en una memoria chica dividiéndolo por partes (Aquí entra lo de .POO - Program Overlays Object).

   3.4. [**Sistemas Multitarea: Asignación Particionada Estática (Fija)**](#34-sistemas-multitarea-asignacion-particionada-estática)
      - Partición Fija con Cola por Partición: Cada tamaño de memoria tiene su propia fila.
      - Partición Fija con Cola Única: Todos esperan en una fila y entran al primer hueco que sirva.
      - Medidas de Eficiencia: Uso de memoria, desperdicio y Nivel de Multiprogramación (NM).
      - Fragmentación Real (Interna): El espacio que sobra dentro de una partición fija.

   3.5. [**Asignación Particionada Dinámica (Variable)**](#35)
      - Asignación según el proceso: La partición se crea al tamaño exacto del proceso.
      - Compactación (Garbage Collection de Memoria): Mover procesos para juntar los huecos libres.
         - Criterios: Al llegar trabajos, periódicamente o por falta de espacio.
      - Estrategias de Ajuste (Placement Algorithms):
         - Primer Ajuste (First-Fit).
         - Mejor Ajuste (Best-Fit).
         - Peor Ajuste (Worst-Fit).
         - Siguiente Ajuste (Next-Fit).

   3.6. [**Organización Lógica y Física (Reubicación)**]
      - Direcciones Absolutas: El programa nace con una dirección fija (hay que recompilar para moverlo).
      - Direcciones Relativas: El programa usa direcciones respecto a "cero".
      - Registro de Relatividad (Base Register): Suma la dirección base en tiempo de ejecución.

   3.7. **Asignación Particionada Paginada Simple y Segmentada Simple**
     - Paginación Simple: División en bloques físicos (Frames) y páginas lógicas.
        - PMT (Page Map Table): Tabla de páginas.
        - Algoritmos de Traduccion de Direcciones (NUEVO)
           - Traduccion Directa (usando tablas en memoria)
           - Traduccion Asociativa (Uso de Memoria Caché / Registros Asociativos para no ir a la RAM cada vez)
           - Costo de ubicaar una direccion (Tiempo de acceso)
     - Segmentación Simple: División por módulos lógicos (Código, Datos, Stack).
        - SMT (Segment Map Table): Tabla de segmentos (Dirección inicial, final, estado).
        - Criterios de asignacion (NUEVO): Como los segmentos son de tamaños variables, usan los mismo algoritmos que la particion dinamica (Primer ajuste, peor ajuste, mejor ajuste, siguiente ajuste) para buscar huecos en la RAM
            
   #### # **Mundo 2: MEMORIA VIRTUAL (RAM + DISCO)**
   3.8. **Memoria Virtual (Paginación y Segmentación por Demanda)**
      - RAM + DASP (Direct Access Storage Device / Disco): Uso de SWAP.
      - Asignación Paginada Dinámica/Demanda: Solo cargas lo que usas.
         - Fallo de Pagina (Page Fault) y la grafica tj(x) vs NP(Y) (Hiperpaginacion/Thrashing)
         - Bit de control de PMT (NUEVO)
            - Bits de referencia/Uso: "1" si la pagina fue leida hace poco, "0" si nadie la toca.
            - Bit de modificado (Dirty Bit): "1" si se altero y hay que guardarla en el disco antes de borrarla.
            - Bit de Presencia/Reemplazo: "1" si eta en RAM, "0" si esta en el disco.
         - Algoritmos de Reemplazo de Pagina (NUEVO): Quien se va dela RAM cuando esta llena)
            - FIFO: El primero en entrar es el primero en salir.
            - LIFO: El ultimo en entrar es el primero en salir (poco usado)
            - OPT (optimo): Reemplaza la pagina que tardara mas tiempo en volver a usarse (imposible en la vida real, es solo teorico)
            - LRU (Least Recently Used): Saca a la que lleva mas tiempo si nser usada.
            - NRU (Not Recently Used): Saca a la que no se ha usado en el ultimo siclo de reloj
            - Clock (Algoritmo del Reloj a fondo): Una mancecilal gira por los amrcos de RAM apagando el "Bit de Referencia" buscnado una victima.
         - Conjunto de trabajo (Working Set) y Ventanas: Cuantas paginas necesita un proceso activamente para no colapsar.
      - Asignación Segmentada Dinámica/Demanda: Segmentos que cargan cuando se llaman.
      - Lo que me preguntaste de la gráfica tj(x) y NP(y)

4. **Entrada/Salida**
   - Drivers, interrupciones de hardware, cómo se mueve el brazo del disco duro.
5. **Gestión de archivos**
6. **Seguridad y performance de los sistemas operativos**

---

## 📎️ 1. Conceptos Generales (El "Traductor")

Imagina que el hardware (procesador, RAM) habla un idioma eléctrico muy complejo. Tú, como usuario, hablas un idioma de "ventanas y clics". El Sistemas Operativo es el traductor y el policía de tráfico.
Conceptos que debes dominar hoy:

   - **Kernel (Núcleo):** Es la única parte del software que tiene control total sobre el hardware. Corre en Modo Privilegiado.
   - **Llamadas al sistema (System Calls):** Si un programa (como Chrome) quiere escribir un archivo, no puede tocar el disco duro directamente. Debe pedirle permiso al Kernel mediante una syscall. Es como pedirle permiso al guardia para entrar a una bóveda.
   - **Interrupciones:** Es la forma en que el hardware le dice a la CPU: "¡Oye, detente, alguien movió el ratón!" o "Ya terminé de imprimir".

---

## 📎️ 2. Administración de Procesos

Aquí es donde la cosa se pone interesante. Un proceso es básicamente un programa en ejecución.
Concurrencia y Sincronización

Imagina que dos personas (procesos) quieren escribir en la misma hoja de papel (memoria) al mismo tiempo. Si no se sincronizan, el resultado será un garabato ilegible. A esto se le llama 'Condición de Carrera'.

   - **Sincronización:** Son las reglas (como Semáforos o Monitores) para que los procesos esperen su turno.
   - **Interbloqueo (Deadlock):** Es el "abrazo mortal". El Proceso A tiene el Recurso 1 y espera el 2. El Proceso B tiene el Recurso 2 y espera el 1. Nadie se mueve. Es un choque en una intersección donde nadie retrocede.

### Las Interrupciones en este contexto

Cuando un proceso está usando el procesador, el S.O. usa una interrupción de reloj para quitarle el mando después de unos milisegundos y dárselo a otro. Así es como parece que tu PC hace muchas cosas a la vez (Multitarea), aunque en realidad solo está saltando muy rápido entre tareas.

### ¿Qué es la CPU en este contexto?

Cuando hablamos de S.O., la CPU (Unidad Central de Procesamiento) es el "Cerebro" o el Ejecutor.

   - Imaginalo como un único trabajador extremadamente rápido.
   - Aunque parece que tu computadora hace 10 cosas a la vez (escuchar música, escribir, navegar), la CPU en realidad solo puede hacer una micro-tarea a la vez.
   - Lo que hace el S.O. es engañarnos: le da 1 milisegundo a la música, 1 milisegundo al mouse, 1 milisegundo al teclado. Eso se llama Conmutación de Contexto.

### ¿Semáforos? (No son los de la calle, pero se parecen)

En programación, un Semáforo es una variable especial (un número) que sirve para controlar el acceso a un recurso compartido (como una impresora o una variable en memoria).

Imagina un baño público con 3 cabinas:

   - Afuera hay un letrero con el número 3 (el Semáforo).
   - Llega una persona, entra y el número baja a 2.
   - Llegan dos más, entran y el número baja a 0.
   - Si llega una cuarta persona y ve el 0, se tiene que quedar esperando afuera (bloqueado).
   - Cuando alguien sale, el número sube a 1 y el que esperaba puede entrar.

   En resumen: El semáforo es un contador que decide quién pasa y quién espera para que no choquen (Concurrencia).

#### ¿Y los Monitores?

Si el Semáforo es un "contador" que tú como programador debes cuidar de no arruinar, el Monitor es como una "Habitación Segura".

   - Es un nivel más alto de abstracción (más moderno).
   - En un Monitor, el lenguaje de programación garantiza que solo un proceso a la vez esté dentro de esa habitación ejecutando código.
   - Si alguien ya está adentro "escribiendo en el archivo", los demás que intenten entrar se quedan automáticamente en una fila afuera. Tú no tienes que andar subiendo o bajando números manualmente como en los semáforos.

#### Diferencia rápida:

   - **Semáforo:** Es una herramienta manual (tú controlas el número). Si te olvidas de "subirlo" al salir, dejas a todos bloqueados para siempre (un error común).
   - **Monitor:** Es una herramienta automática. El compilador se encarga de que nadie choque adentro.
  
---

### ¡Perfecto! Vamos a usar un ejemplo clásico para entender cómo se llega a un Interbloqueo (Deadlock) usando Semáforos.

Imagina que tenemos dos procesos (como dos pestañas de Chrome o dos programas) llamados Proceso A y Proceso B. Ambos necesitan usar dos recursos: el Escáner y la Impresora.

#### Paso 1: Los Semáforos (Las llaves)

Para que no usen el Escáner al mismo tiempo, el Sistema Operativo pone una "llave" (Semáforo) en cada uno:

   - **Semáforo S:** La llave del Escáner. (Valor inicial = 1, significa disponible)
   - **Semáforo I:** La llave de la Impresora. (Valor inicial = 1, disponible)

#### Paso 2: La ejecución "Normal" (Sin errores)

   - El Proceso A toma la llave S (Escáner). El valor baja a 0.
   - El Proceso A toma la llave I (Impresora). El valor baja a 0.
   - Usa ambos, termina, y devuelve las llaves (los valores vuelven a 1).
   - Luego el Proceso B hace lo mismo. ¡Todo bien!

#### Paso 3: El Desastre (El Deadlock)

Aquí es donde ocurre el error por falta de sincronización. Imagina que ambos procesos arrancan al mismo tiempo (Concurrencia):

   - **Proceso A ejecuta:** Pedir llave S (Escáner). Conseguido. (A tiene el Escáner).
   - **Proceso B ejecuta:** Pedir llave I (Impresora). Conseguido. (B tiene la Impresora).
   - **Proceso A ahora intenta:** Pedir llave I (Impresora). ¡ERROR! La tiene el Proceso B. A se queda esperando.
   - **Proceso B ahora intenta:** Pedir llave S (Escáner). ¡ERROR! La tiene el Proceso A. B se queda esperando.

#### Resultado: Interbloqueo (Deadlock)

   - A no suelta el Escáner hasta que tenga la Impresora.
   - B no suelta la Impresora hasta que tenga el Escáner.
   - Ambos se quedan congelados para siempre. ---

#### ¿Cómo se soluciona esto? (Sincronización)

El Sistema Operativo tiene varias estrategias que verás en tu materia:

   - **Prevención:** Obligar a que todos pidan los recursos en el mismo orden (Primero siempre el Escáner, luego la Impresora). Así, si B intenta pedir la impresora antes, el S.O. no lo deja hasta que A termine.
   - **Detección y Recuperación:** El S.O. se da cuenta de que nadie se mueve y "mata" a uno de los procesos para liberar sus llaves.
   - **Algoritmo del Banquero:** El S.O. analiza si darte una llave te va a llevar a un choque. Si ve peligro, te dice "No, espera aunque la llave esté ahí".

---

### Perfecto, vamos con las Interrupciones. Este es el concepto que une el hardware (lo físico) con el software (el S.O.).

Imagina que estás en tu cuarto estudiando (eres la CPU) y estás muy concentrado leyendo un libro (ejecutando un Proceso). De repente, suena el timbre de la casa.

¿Qué haces? No puedes ignorarlo para siempre. Dejas un separador en la página que ibas, vas a la puerta, atiendes a quien llegó, y luego regresas exactamente a la misma línea donde te quedaste. Eso es una interrupción.

#### ¿Cómo funciona en la computadora?

   - **Ejecución normal:** La CPU está procesando un programa (ej. Word).
   - **Evento de Hardware:** Alguien presiona una tecla o llega un paquete de datos por internet. El hardware envía una señal eléctrica a la CPU.
   - **El "Separador de libros":** La CPU guarda el estado actual (qué estaba haciendo y en qué número de línea iba) en una zona especial llamada Stack.
   - **Atención (ISR):** La CPU salta a una parte del Sistema Operativo llamada Manejador de Interrupciones (Interrupt Service Routine). El S.O. dice: "Ah, presionaron la letra 'A', ponla en el documento".
   - **Retorno:** Una vez atendida la emergencia, la CPU recupera el "separador" y sigue con el programa original como si nada hubiera pasado.

#### ¿Por qué son tan importantes? (Conexión con el Punto 2)

Sin interrupciones, la CPU tendría que estar preguntando a cada rato: "¿Ya moviste el mouse? ¿Ya? ¿Y ahora? ¿Ya terminó la impresora?". A esto se le llama Polling (encuesta) y es una pérdida de tiempo total.

Las interrupciones permiten que la CPU sea reactiva: solo trabaja cuando hay algo real que hacer.
Tipos de Interrupciones que verás en tu examen:

|Tipo|Origen|Ejemplo|
|-|-|-|
|Hardware|             	Periféricos|		El teclado, el mouse o el disco duro terminó de leer.
|Software (Exceptions)|	El programa 	|Una división entre cero (x/0) o intentar acceder a memoria prohibida.
|Reloj (Timer)|	         El S.O.      |	Es la más importante. Cada pocos milisegundos el reloj interrumpe a la CPU para que el S.O. pueda quitarle el turno a un proceso y dárselo a otro (Multitarea).

#### ¿Cómo se relaciona esto con lo que ya vimos?

¿Recuerdas el Deadlock o los Semáforos? El Sistema Operativo usa las interrupciones de reloj para asegurarse de que si un proceso se queda "trabado" o esperando un semáforo demasiado tiempo, no congele toda la computadora. El S.O. retoma el control gracias a la interrupción y decide qué hacer.

---

### ¡Excelente! Entramos a la Planificación del Procesador (CPU Scheduling).

Si el S.O. es el policía de tránsito, la Planificación es el semáforo inteligente que decide: "¿A qué proceso le doy la CPU ahora y por cuánto tiempo?".

Imagina una fila en el banco. Hay diferentes formas de atender a la gente, y cada una tiene sus ventajas y desventajas. En Sistemas Operativos, estas formas se llaman Algoritmos de Planificación.

#### Conceptos Clave

Antes de ver los algoritmos, debes conocer dos términos que seguro te preguntarán:

   - **Ráfaga de CPU (CPU Burst):** El tiempo que un proceso necesita usar el procesador antes de detenerse (por ejemplo, para esperar que el usuario escriba algo).
   - **Preoperativo (Preemptive) vs. No Preoperativo:**

      - **No Preoperativo:** Si un proceso toma la CPU, no la suelta hasta que termina o se bloquea solo.
      - **Preoperativo (Apropiativo):** El S.O. tiene el poder de interrumpir al proceso a mitad de camino para darle la CPU a otro (es el más común hoy en día).

#### Los Algoritmos más comunes

Aquí es donde los libros de Silberschatz o Stallings se ponen intensos con ejercicios matemáticos. Veamos los 4 principales:

#### FCFS (First-Come, First-Served)

Es la fila del súper: el primero que llega es el primero que se atiende.

   - Problema: Si llega un proceso gigante primero (ej. un video pesado), los procesos cortitos (ej. mover el mouse) tienen que esperar horas. Esto se llama Efecto Convoy.

#### SJF (Shortest Job First)

"El más corto primero". El S.O. mira su lista y elige al que terminará más rápido.

   - **Ventaja:** Minimiza el tiempo de espera promedio.
   - **Problema:** Si siempre llegan procesos cortitos, un proceso largo podría no ejecutarse nunca (esto se llama Inanición o Starvation).

#### Round Robin (RR) - El más famoso

Es el que usan los sistemas modernos (Windows, Linux). Cada proceso recibe un pequeño trozo de tiempo llamado Cuanto (Quantum) (ej. 10ms).

   - El Proceso A usa sus 10ms.
   - ¡Interrupción! El S.O. lo manda al final de la fila.
   - Entra el Proceso B por otros 10ms.
   - Resultado: Todos sienten que la PC les hace caso al mismo tiempo.

#### Prioridades

Cada proceso tiene un número de importancia. El S.O. siempre atiende al de mayor prioridad.

   > **Dato curioso:** Para evitar que un proceso de baja prioridad muera de "hambre", se usa el Envejecimiento (Aging): entre más tiempo espera un proceso, más sube su prioridad automáticamente.

---

### ¡Esa es la pregunta del millón! La respuesta corta es: El Sistema Operativo es quien decide, pero lo hace a través de un componente específico llamado Planificador (Scheduler).

Aquí es donde la teoría que acabamos de ver se encuentra con la realidad de tu computadora:

#### El "Jefe de Tráfico": El Scheduler y el Dispatcher

En el Punto 2 de tu materia, verás que hay dos entidades trabajando juntas:

   - **El Scheduler (Planificador):** Es el "cerebro". Él mira la lista de procesos que están listos para ejecutarse y, basándose en el algoritmo (como Round Robin), elige cuál sigue.
   - **El Dispatcher (Despachador):** Es el "brazo ejecutor". Es el que realmente quita al proceso actual de la CPU, guarda su estado (el "separador de libros" que vimos en las interrupciones) y sienta al nuevo proceso en la "silla" del procesador.

#### ¿Qué algoritmo usa una CPU real (Windows, Linux, Mac)?

En la vida real, los sistemas operativos no usan un solo algoritmo puro (como solo Round Robin o solo SJF). Usan algo más inteligente llamado Colas Multinivel con Retroalimentación (Multilevel Feedback Queues).

Imagina que el S.O. tiene varias filas, no solo una:

   - **Fila de Alta Prioridad:** Para procesos del sistema o cosas que el usuario está tocando ahora (como el mouse o el teclado). Aquí se usa un Quantum muy pequeñito para que la respuesta sea instantánea.
   - **Fila de Prioridad Media:** Para programas comunes.
   - **Fila de Baja Prioridad:** Para procesos pesados que están "de fondo" (como una descarga o un antivirus). Aquí se usan Quantums más grandes o FCFS.

Lo "inteligente": Si un proceso en la fila de alta prioridad se porta mal y usa demasiada CPU, el S.O. lo "castiga" y lo baja a una fila de menor prioridad. Si un proceso lleva mucho tiempo esperando abajo, el S.O. le aplica Aging (Envejecimiento) y lo sube de fila.

#### ¿Quién decide qué algoritmo usar?

Tú no lo decides, ni el procesador (Intel/AMD) tampoco. Lo decide el equipo que programó el Kernel del Sistema Operativo.

   - Los ingenieros de Microsoft decidieron qué algoritmo usa Windows para que los juegos corran bien.
   - Los ingenieros de Linux decidieron usar uno llamado Completely Fair Scheduler (CFS), que trata de que todos los procesos reciban exactamente la misma proporción de la CPU.

---

### ¡Qué buen ojo! Los Hilos (o Threads) son fundamentales porque son la evolución de los procesos. Si el proceso es el "contenedor", el hilo es el que "hace el trabajo".

Para entenderlo fácil: Un Proceso es como una Casa, y los Hilos son las Personas que viven dentro.

#### ¿Qué es un Hilo?

Un hilo es la unidad básica de utilización de la CPU. Es básicamente un "mini-proceso" que vive dentro de un proceso padre.

   - **Proceso:** Es pesado. Crear uno nuevo requiere mucha memoria porque el S.O. tiene que asignarle su propio espacio aislado.
   - **Hilo:** Es liviano. Varios hilos dentro de un mismo proceso comparten la misma memoria (la misma cocina, el mismo baño de la casa), pero cada uno tiene su propia tarea (uno cocina, otro limpia).

#### ¿Dónde se encuentran los hilos?

Viven dentro del espacio de direcciones de un proceso.

Imaginalo así:

   - El Proceso tiene el código, los archivos abiertos y los datos (variables globales).
   - Cada Hilo tiene su propio "PC" (Program Counter para saber qué línea de código está leyendo) y su propio "Stack" (para sus variables locales).

#### Ejemplo en la vida real: Tu navegador (Chrome/Brave)

Cuando abres una pestaña de tu navegador, eso es un Proceso. Pero dentro de esa pestaña pasan muchas cosas al mismo tiempo gracias a los hilos:

   - **Hilo 1:** Se encarga de descargar las imágenes de la página.
   - **Hilo 2:** Se encarga de mostrar el texto.
   - **Hilo 3:** Se encarga de responder a tus clics.

Si no hubiera hilos, la página se "congelaría" mientras descarga las fotos y no podrías ni mover el mouse dentro de ella.

#### ¿Por qué se usan? (Beneficios)

   - **Economía:** Es mucho más rápido crear un hilo que un proceso.

   - **Comunicación:** Como comparten la misma memoria, no necesitan hacer "llamadas al sistema" complicadas para hablar entre ellos.

   - **Paralelismo:** Si tienes una CPU con varios núcleos (como casi todas hoy), puedes poner el Hilo 1 en el Núcleo A y el Hilo 2 en el Núcleo B. ¡Trabajo doble en el mismo tiempo!

- El peligro de los Hilos (Conexión con lo que ya vimos)

¿Recuerdas los Semáforos? Se usan principalmente por culpa de los hilos. Como los hilos comparten la misma memoria, si dos hilos intentan cambiar la misma variable al mismo tiempo sin un semáforo... ¡PUM!, los datos se corrompen.

#### Resumen para tu examen:

   - Un proceso puede tener uno o muchos hilos.
   - Los hilos de un mismo proceso comparten: Código, Datos y Recursos (archivos).
   - Los hilos de un mismo proceso NO comparten: Registro de CPU y Pila (Stack).

---

### Multitarea, Multiproceso y Multiprogramacion

Para entenderlo, imagina que la CPU es un cocinero.

#### Multitarea (Multitasking)

La multitarea es una ilusión de simultaneidad. Es cuando un solo procesador (un solo núcleo) alterna tan rápido entre varios procesos que parece que los está haciendo todos a la vez.

   - **Cómo funciona:** Usa el algoritmo Round Robin que vimos antes. El S.O. le da un "quantum" de tiempo a Word, luego a Spotify, luego al Navegador.
   - **En nuestro ejemplo:** Un solo cocinero pica cebolla por 5 segundos, luego revuelve la sopa por 5 segundos, luego corta carne por 5 segundos. Al final, las tres cosas avanzan "al mismo tiempo", pero el cocinero solo tiene un par de manos.
   - **Clave:** La multitarea se refiere a la capacidad del S.O. de manejar muchos programas con un solo procesador.

#### Multiproceso (Multiprocessing)

El multiproceso es simultaneidad real. Es cuando tienes dos o más CPUs (o núcleos) físicos trabajando de verdad al mismo tiempo.

   - **Cómo funciona:** El S.O. asigna el Proceso A a la CPU 1 y el Proceso B a la CPU 2. Ambos se ejecutan en el mismo instante de tiempo.
   - **En nuestro ejemplo:** Tienes a dos cocineros. Uno está picando cebolla mientras el otro, al mismo tiempo, está revuelta la sopa. No hay engaño, hay más "músculo" de hardware.
  
#### Diferencias rápidas para tu examen

|Concepto|		¿Qué lo hace posible?|									Característica principal|
|---|---|---|
|Multitarea		|El Software (Algoritmos de planificación del S.O.)|		Alterna procesos rápidamente  (Conmutación de contexto).
|Multiproceso	|El Hardware (Tener varios núcleos o CPUs)			|	Ejecuta procesos en paralelo real.

#### ¿Cómo se conectan con lo que ya vimos?

   - **Multiproceso + Hilos:** Si tienes un programa con muchos hilos (como un editor de video) y una computadora con multiproceso, el S.O. mandará cada hilo a un núcleo distinto. ¡Ahí es cuando tu PC vuela!
   - **Multitarea + Interrupciones:** La multitarea depende totalmente de la interrupción de reloj. Si el reloj no interrumpiera al proceso actual, este se quedaría con la CPU para siempre y no habría multitarea.

#### Un dato extra: Multiprogramación

A veces los profesores lanzan este tercer término. La **Multiprogramación** es simplemente tener varios procesos cargados en la memoria RAM al mismo tiempo, listos para que la CPU los use. Si no hay multiprogramación, no puede haber multitarea.

---

## 📎️ 3. Vamos a entrar al Punto 3: Administración de Memoria.


Si la CPU es el cocinero y los procesos son las recetas, la Memoria RAM es la mesa de trabajo. El problema es que la mesa tiene un tamaño limitado y muchos procesos quieren un espacio en ella al mismo tiempo.

### El gran problema: ¿Dónde te pones?

Imagina que un programa (Proceso A) cree que está solo en el mundo y quiere guardarse en la posición de memoria 0. Pero resulta que el Sistema Operativo ya está ahí. Si el programa escribe en la posición 0, ¡borra al S.O. y la computadora explota! (metafóricamente).

Para evitar esto, el S.O. inventó dos tipos de direcciones:

   - **Dirección Lógica (o Virtual):** Es la dirección que ve el programa. El programa cree que tiene una memoria limpia que empieza en 0.
   - **Dirección Física:** Es la ubicación real en los chips de la RAM.

### La Unidad de Gestión de Memoria (MMU)

Hay un hardware llamado MMU que funciona como un mapa. Cuando el programa dice "quiero el dato en la dirección 5", la MMU le suma un número (base) y lo traduce a la dirección real, por ejemplo, la 1005.

### Paginación: El rompecabezas moderno

Antiguamente, los procesos tenían que estar en un bloque de memoria "contiguo" (todo juntito). Si no había un hueco lo suficientemente grande, el programa no abría.

Hoy usamos Paginación:

   - Dividimos la memoria física en trozos fijos llamados Marcos (Frames).
   - Dividimos el proceso en trozos del mismo tamaño llamados Páginas.
   - La magia: Las páginas de un mismo programa pueden estar desordenadas en la RAM. La página 1 puede estar al principio y la página 2 al final. El S.O. usa una Tabla de Páginas para recordar dónde puso cada trozo.

### Memoria Virtual (El truco final)

¿Alguna vez te has preguntado cómo puedes abrir un juego de 50GB si solo tienes 8GB de RAM?

La Memoria Virtual permite ejecutar procesos que son más grandes que la memoria física.

   - El S.O. solo carga en la RAM las páginas que estás usando en este preciso segundo.
   - El resto del programa se queda guardado en el Disco Duro (en un espacio llamado Swap o archivo de paginación).
   - Si de repente necesitas una parte que está en el disco, ocurre un Fallo de Página (Page Fault): la CPU se detiene, el S.O. busca el trozo en el disco, lo sube a la RAM y tú sigues jugando como si nada.

### Fragmentación: El desperdicio

Este es un tema clásico de examen. Es el espacio que se desperdicia:

   - **Fragmentación Interna:** Te dan un bloque de 4KB pero solo usas 3KB. Ese 1KB sobrante nadie más lo puede usar.
   - **Fragmentación Externa:** Hay muchos huecos pequeños entre procesos, pero ninguno es lo suficientemente grande para un proceso nuevo. (Es como tener asientos libres en un cine, pero todos separados, y llega una pareja que quiere sentarse junta).

### Resumen rápido de Memoria:

   - **Protección:** Un proceso no puede tocar la memoria de otro.
   - **Abstracción:** El programa usa direcciones lógicas; el S.O. las traduce a físicas.
   - **Eficiencia:** Con la paginación y memoria virtual, usamos la RAM de forma inteligente.

---

### El Fallo de Página (Page Fault) 

Es como cuando vas a buscar un ingrediente a la mesa de la cocina (RAM) y te das cuenta de que lo dejaste en la despensa (Disco Duro). Tienes que detenerte, ir por él y volver.

Vamos a verlo paso a paso con un ejemplo de un programa que estás usando: Photoshop.
El Escenario

   - Photoshop es un programa gigante (pesa mucho).
   - Tu Memoria RAM está casi llena.
   - El S.O. decide que, como no estás usando la herramienta de "Texto" de Photoshop ahorita, esa parte del programa se quede en el Disco Duro.

#### Paso a paso del Page Fault

   - **La Solicitud:** De repente, haces clic en la herramienta de "Texto". La CPU intenta leer la dirección de memoria donde debería estar esa función (Dirección Lógica).
   - **El "¡No está!":** La CPU consulta la Tabla de Páginas y ve que el bit de "presencia" está en 0. Esto significa: "Esa página no está en la RAM".
   - **La Interrupción:** Se genera una excepción (Page Fault). La CPU deja de ejecutar Photoshop y le da el control al Sistema Operativo.
   - **La Búsqueda:** El S.O. mira en su lista y dice: "Ah, la herramienta de texto está guardada en este sector del Disco Duro".
   - **El Intercambio (Swap):**

      - Si la RAM está llena, el S.O. elige una página vieja que no estés usando (por ejemplo, el buscador de archivos) y la manda al disco para hacer espacio.

      - Luego, trae la página de "Texto" del disco y la mete en la RAM.

   - **Actualización:** El S.O. pone el bit de presencia en 1 en la Tabla de Páginas.
   - **Reintento:** La CPU vuelve a ejecutar la instrucción de Photoshop exactamente donde se quedó. Ahora, como el dato ya está en la RAM, todo fluye normal.

#### ¿Por qué sientes que tu computadora se pone lenta?

Seguro te ha pasado que abres un programa y la PC se "congela" un segundo mientras escuchas el disco trabajar (o ves el led del disco parpadear). Eso es una tormenta de Page Faults.

Si el S.O. se la pasa más tiempo moviendo páginas del disco a la RAM que ejecutando programas, ocurre un fenómeno llamado Thrashing (Hiperpaginación). Es el punto donde la PC deja de responder porque la RAM es insuficiente para lo que intentas hacer.
Conceptos Clave para tu examen de Memoria:

   - **Algoritmos de Reemplazo de Páginas**: Cuando la RAM se llena y hay que sacar a alguien para meter una página nueva, ¿a quién sacamos?

      - **FIFO:** El primero que llegó es el primero que sale.
      - **LRU (Least Recently Used):** Sacamos al que lleva más tiempo sin ser usado. (Es el más eficiente).
      - **Óptimo:** Sacar al que tardará más tiempo en volver a ser usado (es imposible de saber el futuro, pero sirve para comparar).

---

### Stack, Head, Leak, Buffer y Memoria Virtual
Imagina que la memoria de un programa es como un restaurante:

#### Stack (Pila)

Es la memoria automática y rápida.

   - **Qué es:** Es donde se guardan las variables locales de una función (por ejemplo, una x dentro de un sumar()) y las direcciones de retorno.
   - **Cómo funciona:** Funciona como una pila de platos. El último que entra es el primero que sale (LIFO). Cuando una función termina, el "plato" se quita automáticamente y la memoria se libera sola.
   - **Dato:** Es pequeña pero muy veloz.

#### Heap (Montículo)

Es la memoria manual y flexible.

   - **Qué es:** Es un gran espacio libre donde pides memoria cuando no sabes cuánta vas a necesitar (por ejemplo, si el usuario va a subir una foto y no sabes si pesa 1MB o 10MB).
   - **Cómo funciona:** El programador tiene que pedirla (con comandos como malloc o new) y, muy importante, tiene que devolverla.
   - **Dato:** Es mucho más grande que el Stack, pero más lenta de gestionar.

#### Memory Leak (Fuga de Memoria)

Es el error de olvidarse de "limpiar".

   - **Qué es:** Ocurre cuando un programa pide memoria en el Heap, termina de usarla, pero no la libera.
   - **El problema:** Esa memoria se queda marcada como "ocupada" aunque nadie la esté usando. Si el programa sigue corriendo y olvidando liberar memoria, eventualmente se acaba toda la RAM y la PC se traba.
   - **Ejemplo:** Es como si en el restaurante los clientes se fueran pero nadie limpiara las mesas. Pronto no habría sitio para nuevos clientes.

#### Memoria Virtual

Es el "truco de magia" del Sistema Operativo.

   - **Qué es:** Es una técnica que hace que el programa crea que tiene mucha RAM disponible, cuando en realidad el S.O. está usando un pedazo del Disco Duro para simular RAM extra.
   - **Diferencia:** Mientras que el Stack y el Heap son formas de organizar la memoria dentro de un programa, la Memoria Virtual es cómo el S.O. gestiona la RAM total del sistema.

#### Buffer

Es una zona de espera temporal.

   - **Qué es:** Un espacio de memoria usado para guardar datos mientras se mueven de un lugar a otro (normalmente entre dispositivos de diferentes velocidades).
   - **Ejemplo:** Cuando ves un video en YouTube, se carga un "buffer". La internet es lenta y tu pantalla es rápida, así que el video se guarda en el buffer para que no se corte mientras lo ves.
   - **Peligro:** Si un programa intenta meter más datos de los que caben en el buffer, ocurre el famoso Buffer Overflow, un error que los hackers usan para tomar control de sistemas.

#### ¿Donde viven? 

   - **Stack y Heap:** Sí, viven dentro de la RAM (mientras el programa se ejecuta).
   - **Memory Leak:** Sí, es RAM que se queda "secuestrada".
   - **Buffer:** Casi siempre es RAM, aunque puede existir en otros chips de hardware.
   - **Memoria Virtual:** Es un híbrido. Es la combinación de tu RAM física + un pedazo de tu Disco Duro (SSD/HDD)

---

### 3.1 Antecedentes y Hardware Base

#### Arquitectura Von Neumann

Es el modelo en el que se basan casi todas las computadoras actuales. El concepto clave aquí es el Programa Almacenado.

- **¿Qué es?:** Antes, para cambiar la tarea de una computadora, había que recablearla físicamente. Von Neumann dijo: "Guardemos las instrucciones (software) en la misma memoria que los datos".
- **Componentes:** 
   1.  **CPU:** El cerebro (ALU para cálculos y UC para control).
   2.  **Memoria Principal:** Donde viven datos e instrucciones.
   3.  **Sistemas de E/S:** El puente con el mundo.

- **El "Cuello de Botella":** Como los datos y las instrucciones viajan por el mismo bus (camino), la CPU suele ir más rápido que la memoria, y por eso inventamos la jerarquía de memoria (Caché, RAM, Disco).

#### Tecnologías de Almacenamiento: El camino al Silicio

Núcleos de Ferrita (La prehistoria):
Antes de los chips, la memoria eran pequeños anillos de cerámica ferromagnética atravesados por cables.

   - Cómo funcionaba: Cada anillo guardaba 1 bit. Dependiendo de la dirección de la corriente, el anillo se magnetizaba en un sentido (0) o en otro (1).
   - Dato curioso: Eran memorias "no volátiles" (no perdían la info al apagar la luz), pero eran gigantescas y pesadas. ¡Imagínate lo que ocuparía 1 GB de estos anillos!

Escalas de Integración (La evolución del chip):
Esto es lo que permitió que pasáramos de computadoras del tamaño de una habitación a tu smartphone. Se refiere a cuántos componentes (transistores) caben en un solo chip:

   - SSI (Small Scale Integration): Menos de 10 transistores. (Puertas lógicas simples).
   - MSI (Medium Scale Integration): 10 a 100 transistores. (Contadores, decodificadores).
   - LSI (Large Scale Integration): 100 a 10,000 transistores. (Primeros microprocesadores de 8 bits).
   - VLSI (Very Large Scale Integration): Más de 10,000 (hoy son miles de millones). Aquí es donde nacen los sistemas operativos modernos porque ya hay potencia suficiente.

#### Memoria ROM vs. RAM Física

Para el examen, no las veas solo como "solo lectura" y "lectura/escritura", sino por su rol en el arranque:

   - **ROM (Read Only Memory):** Es memoria no volátil. Aquí vive el Firmware o el BIOS/UEFI. Es lo primero que lee la CPU al encenderse para saber cómo despertar al resto del hardware.
   - **RAM (Random Access Memory):** Es memoria volátil y rápida.
      - **Acceso Aleatorio:** Significa que tardas lo mismo en leer el primer byte que el último (a diferencia de una cinta magnética).
      - **Importancia para el S.O.:** Es el "tablero de trabajo". El S.O. debe decidir qué procesos tienen derecho a estar aquí.

#### Concepto Extra Importante: El Mapa de Memoria

Algo que tu profesor seguro mencionó o mencionará es que la memoria no es un bloque infinito. Está dividida en:

   1. **Memoria Baja:** Generalmente reservada para los vectores de interrupción y el núcleo (Kernel) del S.O.
   2. **Memoria Alta:** Donde cargan tus programas de usuario.

   > **Nota:** En ciberseguridad, entender la arquitectura Von Neumann es clave, porque al estar los datos y las instrucciones en el mismo lugar, un atacante puede inyectar "datos" que luego engañan a la CPU para que los ejecute como "instrucciones" (esto es el famoso Buffer Overflow).

---

### 3.2 Conceptos de Gestión y Control

#### Gestión de Espacio: El inventario de la RAM

El S.O. debe saber en todo momento qué partes de la memoria están siendo usadas y cuáles no. Para esto utiliza una estructura de datos (como una lista o un mapa de bits) para clasificar las direcciones:

   - **Direcciones Ocupadas:** Espacio asignado al Kernel o a procesos de usuario activos. No pueden ser tocadas por otros procesos.
   - **Direcciones Libres (Huecos):** Bloques de memoria que no tienen dueño actual. El S.O. busca aquí cuando un nuevo programa pide "permiso para entrar".
   - **Direcciones Disponibles:** Es el total de la memoria física que el sistema puede direccionar.

##### Ejemplo

Imagina un estacionamiento. Las ocupadas son los autos parqueados, las libres son los espacios vacíos y las disponibles son el total de plazas que el arquitecto diseñó. Si intentas parquear donde ya hay un auto (dirección ocupada), chocas. El S.O. evita ese choque.

#### Mecanismos de Control: Los Guardias

Aquí es donde el profesor se pone técnico con el hardware que protege la memoria.

Registro de Frontera (Limit Register) y Registro Base:
En los sistemas antiguos (y como base de los modernos), la CPU usa dos registros físicos para proteger la memoria:

   1. **Registro Base:** Guarda la dirección física más baja (donde empieza el proceso).
   2. **Registro de Límite (Frontera):** Guarda el tamaño del proceso (cuánta memoria tiene permitida).

##### ¿Cómo funciona el control?

Cada vez que un proceso genera una dirección de memoria, el hardware verifica:
¿Dirección >= Registro Base? y ¿Dirección < (Registro Base + Límite)?
Si la respuesta es NO, la CPU lanza un error de protección (el famoso Segmentation Fault en Linux) y detiene el programa.

#### Unidad de Gestión de Memoria (MMU)

Este es un chip (o parte de la CPU) que hace el trabajo sucio de traducción. Es el que permite que exista la Memoria Virtual.

   - **Dirección Lógica (Virtual):** La que ve el programador (siempre empieza en 0, por comodidad).
   - **Dirección Física (Real):** La ubicación real en los chips de RAM.

##### El proceso de traducción

Cuando tu código dice READ [Dirección 100], la MMU intercepta ese 100, le suma el Registro Base (digamos que el proceso empieza en la 5000) y busca en la RAM la dirección física 5100.

##### Ejemplo Práctico (Para que se lo expliques al profesor)

Supongamos que tienes un programa "Calculadora":

   1. El S.O. lo carga en la RAM a partir de la dirección 12000.
   2. El Registro Base se configura en 12000.
   3. La Calculadora mide 500 bytes, así que el Registro de Límite es 500.
   4. Si la Calculadora intenta leer su propio dato en la posición 10, la MMU traduce: 12000+10=12010. ¡PERMITIDO!
   5. Si la Calculadora (quizás por un virus o un error) intenta leer la posición 600, el hardware ve que 600>500. ¡BLOQUEADO! (Violación de acceso).

---

### 3.3 Sistemas Monotarea y Asignacion Contigua Simple

#### Uso Definido de Memoria (Monotarea)

En este esquema, el mundo es muy sencillo: Solo puede haber un proceso a la vez en la memoria.

   - **Distribución:** La memoria se divide típicamente en dos secciones:
      1. Una parte para el Sistema Operativo (usualmente en las direcciones bajas).
      2. Una parte para el Proceso del Usuario (direcciones altas).
   - **Asignación Contigua:** El programa debe ocupar un bloque de memoria único y seguido. Si el programa mide 10 KB, necesita 10 KB de espacio ininterrumpido.
   - **Desventaja:** Si el proceso no usa toda la memoria disponible, el resto se desperdicia totalmente. Además, si el proceso es más grande que la RAM disponible... simplemente no puede ejecutar.

#### Técnica de Overlays (Superposiciones)

¿Qué hacías si tu programa medía 64 KB pero solo tenías 32 KB de RAM? Inventabas los Overlays.

   - **¿Qué es?:** Es dividir un programa en piezas lógicas que no se necesitan al mismo tiempo.
   - **El truco:** el programa Solo mantienes en memoria el "Núcleo" (Driver) d y vas cargando y descargando las demás partes (los Overlays) según sea necesario, usando el mismo espacio físico de memoria.

El concepto de **.POO** (Program Overlays Object):
Aquí es donde conectamos con lo que mencionó tu profesor. Los archivos .POO (objetos de superposición de programa) son esos módulos o "bloques" que residen en el disco y que el programa principal llama para que se "encimen" en la RAM.

##### Ejemplo de una aplicación de contabilidad antigua:
   1. Raíz (Siempre en RAM): El menú principal y el manejador de memoria.
   2. Overlay A (Módulo de Ingresos): Se carga cuando vas a registrar ventas.
   3. Overlay B (Módulo de Reportes): Cuando terminas de vender, el S.O. borra el módulo A de la RAM y carga el módulo B en ese mismo lugar.

   > **Nota importante:** El Sistema Operativo no hacía esto automáticamente. El programador tenía que diseñar la estructura de overlays a mano. Era un trabajo artesanal y muy propenso a errores (si el Overlay A intentaba llamar a una función del Overlay B mientras este no estaba cargado, el sistema explotaba).

##### Ejemplo para el examen:

Si el profesor te pregunta: "Tengo una memoria de 100 KB y un programa con una Raíz de 20 KB, un Módulo de Datos de 50 KB y un Módulo de Impresión de 40 KB. ¿Puedo ejecutarlo en un sistema monotarea?"

   - **Sin Overlays:** No, porque 20+50+40=110 KB (Supera los 100 KB).
   - **Con Overlays:** Sí, porque cargas la Raíz (20) + el Módulo de Datos (50) = 70 KB. Cuando termines con los datos, descargas los 50 KB y cargas los 40 KB de Impresión. El uso máximo de RAM sería de 70 KB.

---

### 3.4 Sistemas Multitarea: Asignacion Particionada Estática

#### ¿Cómo se organizan los procesos? (Las Colas)

Imagina que la RAM está dividida en tres particiones: Pequeña (100K), Mediana (250K) y Grande (500K). Hay dos formas de manejar a los procesos que quieren entrar:

##### A. Una Cola por Partición

Cada partición tiene su propia fila de espera.

   - **La regla:** Un proceso se va a la cola de la partición más pequeña en la que quepa.
   - **El problema:** Puede que la cola de la partición de 500K esté vacía, pero la de 100K esté llenísima. Tienes memoria libre, pero los procesos de la fila de 100K no pueden usarla porque "no les toca". Es muy ineficiente.

##### B. Cola Única (El "Supermercado")

Todos los procesos están en una sola fila. Cuando se libera cualquier partición, el S.O. mira quién es el primero en la fila que cabe en ese hueco y lo mete.

   - **Mejora:** Aprovecha mejor la memoria disponible.

#### Medidas de Eficiencia y NM

Tu profesor te pidió calcular qué tan bien estamos usando la memoria. Aquí están las claves:

`U = (Memoria ocupada por procesos / Memoria total de usuario) × 100%`

   - **Uso de Memoria:** Es la suma de los tamaños de los procesos que están corriendo actualmente.
   - **Desperdicio:** Es la memoria que no se usa.
   `Desperdicio = Fragmentación interna total + Memoria libre en particiones vacías`
   - **Nivel de Multiprogramación (NM):** Es simplemente cuántos procesos hay en la memoria en un momento dado. Si hay 3 procesos en 3 particiones, el NM=3.
   `NM_real = Número de particiones ocupadas en un instante dado`


#### Fragmentación Real (Interna)

Este es un concepto "fijo" de examen.

   - **Definición:** Es el espacio que sobra dentro de una partición porque el proceso es más pequeño que el hueco.

##### Ejemplo

Si metes un proceso de 70K en una partición fija de 100K, tienes 30K de Fragmentación Interna. Esos 30K se pierden; no puedes meter a nadie más ahí hasta que el proceso de 70K termine.

##### Resolviendo el ejemplo de tu clase (Medidas de Eficiencia)

Mencionaste un ejercicio con colas. Vamos a interpretarlo con lógica de "Cola Única" o "Por partición":
````
   Cola 1 (pequeña): 70, 85, 140, 37, 80
   Cola 2 (mediana): 150, 120, 23, 99, 151
   Partición fija de 150K (ejemplo).
````

Si tienes una partición de 150K y le metes el proceso de 70K:
```
   1. Fragmentación Interna: 150−70=80K.
   2. Uso de memoria: 70K.
   3. Eficiencia de esa partición: (70/150)×100=46%. ¡Es malísima! Estás desperdiciando más de la mitad.
```
#### El "Truco" de las Direcciones Absolutas

En estos sistemas viejos, los programas se compilaban con Direcciones Absolutas.

   - **¿Qué significa?:** Que el programa decía: "Yo solo funciono si me cargan en la dirección 2000".
   - **Consecuencia:** Si la partición que empieza en la 2000 está ocupada, el programa no puede entrar, aunque haya otras 10 particiones libres. Había que volver a compilar para asignarle otra dirección. (Esto es lo que mencionaste de "combinación/volver a compilar").

---

### 3.5 Asignación Particionada Dinámica (Variable)

#### Asignación según el proceso

En este sistema, no existen particiones previas. Cuando un proceso llega, el S.O. mira cuánta RAM necesita y "corta" un pedazo de memoria exactamente de ese tamaño.

   - **Adiós a la Fragmentación Interna:** Como la partición es del tamaño exacto del proceso, no sobra nada dentro.
   - **Hola a la Fragmentación Externa:** A medida que los procesos terminan y salen, van dejando "huecos" de distintos tamaños por toda la RAM. Si llega un proceso nuevo y ninguno de los huecos es lo suficientemente grande por sí solo (aunque la suma de todos sí alcance), el proceso no puede entrar.

#### Compactación (Garbage Collection de Memoria)

Para solucionar la fragmentación externa, el S.O. hace un "Tetris". Mueve todos los procesos que están en ejecución hacia un extremo de la memoria (digamos, hacia arriba) para que todos los huecos pequeños se junten en un solo gran bloque libre al final.

Criterios para compactar (¿Cuándo hacerlo?):
   - **Al llegar trabajos:** Solo si un proceso nuevo no cabe en ningún hueco actual.
   - **Periódicamente:** Cada cierto tiempo (ej. cada 5 segundos) para mantener la casa limpia.
   - **Por falta de espacio:** Cuando el porcentaje de memoria libre total es bajo.

   > ⚠️ **El Gran Costo:** Compactar es carísimo para el CPU. Mientras se mueven los procesos, el sistema se detiene (o se pone lentísimo). En la UMSA suelen preguntar: "¿Cuál es el costo de la compactación?" Respuesta: Tiempo de CPU y detención de la ejecución.

#### Estrategias de Ajuste (Placement Algorithms)

Cuando hay varios huecos libres y llega un proceso nuevo, el S.O. debe decidir en cuál meterlo. Estas son las 4 estrategias:

|Estrategia|			Lógica|										Pros/Contras|
|---|---|---|
|Primer Ajuste (First-Fit) 	|	Recorre la memoria y mete al proceso en el primer hueco donde quepa.		|Es el más rápido.|
|Mejor Ajuste (Best-Fit)  |	 		Busca en toda la lista el hueco que sea más parecido al tamaño del proceso.| 		Deja huecos minúsculos que no sirven para nada después.|
|Peor Ajuste (Worst-Fit)| 		Busca el hueco más grande de todos.	|		Intenta dejar huecos grandes útiles,pero suele ser el más ineficiente.  |
|Siguiente Ajuste (Next-Fit)  | 	Igual que el primero, pero empieza a buscar desde donde se quedó la última vez |		Distribuye mejor los procesos a lo largo de la memoria.|

#### Ejemplo para el examen:

Tienes huecos libres de: 100K, 500K, 200K, 300K. Llega un proceso de 210K.

   - **First-Fit:** Lo mete en el de 500K (porque es el primero que encuentra donde cabe).
   - **Best-Fit:** Lo mete en el de 300K (es el que más se ajusta, sobra menos).
   - **Worst-Fit:** Lo mete en el de 500K (el más grande de todos).

#### Lo que mencionaste del "NM" y "Cambio de Contexto"

Cuando usas particiones dinámicas, el Nivel de Multiprogramación (NM) cambia todo el tiempo porque depende de cuántos procesos quepan físicamente.
Cada vez que el S.O. detiene un proceso para moverlo (compactación) o para meter otro, ocurre un Cambio de Contexto: guardar lo que hacía el proceso A para atender al administrador de memoria.

---

### 3.6 Organización Lógica y Física (Reubicación)

#### Direcciones Absolutas (El pasado rígido)

En los sistemas más primitivos, las direcciones que escribía el programador eran las mismas que usaba el hardware.

   - **El Problema:** El programa dice explícitamente: "Guarda este dato en la celda 500". Si la celda 500 ya está ocupada por otro proceso, tu programa no puede correr.
   - **La "Solución" (Pésima):** Tenías que recompilar el código fuente cambiando todas las direcciones a, por ejemplo, la 2000. Si luego querías moverlo a la 3000... adivina: a recompilar otra vez. Esto es lo que mencionaste de "combinación/volver a compilar".

#### Direcciones Relativas (Organización Lógica)

Para solucionar esto, inventamos la separación entre lo que el programa cree que usa y lo que realmente usa.

   - **Dirección Lógica (Relativa):** El programa se escribe pensando que empieza en la dirección 0. Todas sus instrucciones son relativas a ese cero (ej. "salta 10 posiciones adelante").
   - **Ventaja:** Al programa no le importa dónde lo ponga el S.O., él siempre se siente como si estuviera al principio de su propio mundo.

#### Registro de Relatividad o Registro Base (Reubicación Dinámica)

Aquí es donde ocurre la magia en tiempo de ejecución. La CPU usa un registro especial (físico) para hacer la suma al vuelo.

La fórmula mágica de la MMU:
            `Dirección Física = Dirección Lógica + Registro de Relatividad (Base)`

#### Ejemplo paso a paso

   1. Tu programa (con direcciones relativas) quiere leer el dato en la posición 10.
   2. El S.O. decidió cargar tu programa en la dirección física 5000. Por lo tanto, pone 5000 en el Registro de Relatividad.
   3. Cuando la CPU ejecuta la instrucción, la MMU hace: 10+5000=5010.
   4. Si el S.O. decide compactar y mueve tu programa a la dirección 8000, solo tiene que cambiar el valor del registro a 8000.
   5. La próxima vez que el programa pida la posición 10, la MMU hará: 10+8000=8010.

   > ¡El programa nunca se enteró de que lo movieron! Por eso esto es fundamental para la multiprogramación moderna.

#### Lo que mencionaste de "Volver a compilar" vs "Relativas"

Para tu examen, recuerda esto:

   - **Vinculación en tiempo de Compilación:** Produce direcciones Absolutas. Es rígido.
   - **Vinculación en tiempo de Ejecución:** Usa direcciones Relativas y un Registro Base. Es flexible y permite la compactación y el intercambio (swapping).

#### Concepto de "Registro de Límite" (Nuevamente)

Para que el control sea total, el S.O. usa el Registro Base (para saber dónde empieza) y el Registro de Límite (para saber dónde termina).

   - Si la dirección lógica es mayor al límite, ¡PUM! Error de segmentación.

   > **Dato:** En ciberseguridad, entender la diferencia entre dirección lógica y física es vital para entender cómo funcionan los exploits de memoria como el ASLR (Address Space Layout Randomization), que mueve los programas de lugar al azar para que los hackers no sepan dónde atacar.

---

### 3.7 Asignación Particionada Paginada y Segmentada

#### Paginación Simple (División por tamaño)

Aquí el S.O. corta todo en trozos del mismo tamaño, como si fueran las hojas de un cuaderno.
   - **Páginas (Lógicas):** Son los trozos en los que se divide el programa.
   - **Marcos o Frames (Físicos):** Son los trozos en los que se divide la memoria RAM.
   - **La Regla de Oro:** El tamaño de la página debe ser igual al tamaño del marco (típicamente potencias de 2, como 2k).
   - **Ventaja:** No necesitas que el programa esté todo junto. Puedes poner la Página 0 en el Marco 5 y la Página 1 en el Marco 100. ¡Adiós a la fragmentación externa!

##### PMT (Page Map Table)

Es el "traductor". Cada proceso tiene su propia PMT.

   - **Contenido:** Tiene el índice de la página y el número del marco físico donde está guardada.
   - **Funcionamiento:** Cuando el CPU pide la "Página 2, dirección 10", el S.O. mira la PMT, ve que la Página 2 está en el Marco 40, y te lleva allá.

##### Algoritmos de Traduccion 

El gran problema de la paginación es que, para leer un solo dato, la CPU tiene que hacer dos accesos a la RAM: uno para leer la Tabla de Páginas (PMT) y otro para leer el dato real. Eso es lento. Por eso existen estos tres conceptos:

###### 1. Traducción Directa (El camino largo)

Es el método básico. La **PMT** (Tabla de Mapas de Página) se guarda íntegramente en la Memoria RAM.


   - **Proceso:**
      1. La CPU quiere la dirección lógica (p,d) —página y desplazamiento—.
      2. La CPU va a la RAM a buscar la PMT.
      3. Lee la PMT para saber en qué Marco (f) está la página.
      4. Vuelve a ir a la RAM, pero ahora a la dirección física real para traer el dato.

   - **Problema:** Es muy lento porque la RAM, aunque es rápida, no le llega ni a los talones a la velocidad de la CPU. Ir dos veces a la RAM por cada instrucción hace que la computadora se sienta a la mitad de su velocidad real.

*Formula de direccion fisica:*
`Dirección Física = (Nº Marco × Tamaño de página) + Desplazamiento`

*Formula de acceso efectivo (sin cache):*
`t_efectivo = 2 × t_RAM`

(donde t_RAM es el tiempo de acceso a memoria)

###### 2. Traducción Asociativa (El camino rápido)

Aquí es donde entra el hardware especial: los Registros Asociativos o la famosa TLB (Translation Lookaside Buffer). Es una memoria pequeñísima, carísima y ultra veloz que vive dentro de la MMU (CPU).

   - **¿Cómo funciona?** Es como una "lista de favoritos". La TLB guarda las últimas traducciones que hiciste (Página → Marco).

   - **Proceso:**

      1. La CPU pregunta por la página p.
      2. Primero busca en la TLB (esto toma casi 0 tiempo).
      3. Si está (Hit): Obtiene el Marco inmediatamente. Solo hace un acceso a la RAM (para el dato).
      4. Si no está (Miss): Tiene que hacer el camino largo (Traducción Directa), pero guarda el resultado en la TLB para la próxima vez.

*Tiempo de acceso efectivo:*
`t_efectivo = (t_TLB + t_RAM) × Prob_acierto + (t_TLB + 2×t_RAM) × (1 - Prob_acierto)`

###### 3. Costo de ubicar una dirección (Tiempo de Acceso Efectivo)

En la UMSA suelen pedirte que calcules esto matemáticamente. Se llama EAT (Effective Access Time).

**Variables:**

   - **m:** Tiempo de acceso a la RAM (ej. 100 nanosegundos).
   - **c:** Tiempo de acceso a la TLB/Registros Asociativos (ej. 20 nanosegundos).
   - **h:** Tasa de acierto (Hit ratio), qué tan seguido encontramos la página en la TLB (ej. 80% o 0.8).

**La fórmula:**

```
                  EAT = h⋅(c+m) + (1−h) ⋅ (c+2m)
```

   - **Traducción:** Si aciertas (h), pagas el tiempo de la TLB y un acceso a RAM. Si fallas (1−h), pagas la TLB y dos accesos a la RAM (uno por la tabla y otro por el dato).

###### Ejemplo de examen:

Si la RAM tarda 100 ns, la TLB 20 ns y acertamos el 90% de las veces, ¿cuál es el costo promedio?

   1. **Acierto (90%):** 20 (TLB)+100 (RAM)=120 ns
   2. **Fallo (10%):** 20 (TLB)+100 (Tabla)+100 (Dato)=220 ns
   3. **Promedio:** (0.9⋅120)+(0.1⋅220)=108+22=130 ns

**Conclusión:** Sin TLB, siempre tardarías 200 ns (dos viajes a RAM). Con la traducción asociativa, bajaste el costo a 130 ns. ¡Mucho mejor!

##### Ejercicio

*Un sistema tiene páginas de 2 KB. Un proceso P1 tiene 3 páginas cargadas en RAM según su PMT:*

|Página|	Marco|	Presencia|
|--|--|--|
|0|	5|	1|
|1|	3|	1|
|2|	7|	1|

Tamaño de página = 2 KB = 2048 bytes.

Preguntas:
a) ¿Cuántos bits para desplazamiento y cuántos para página si la dirección lógica es de 16 bits?
b) Traduzca las siguientes direcciones lógicas a físicas (en decimal):

- 1500
- 3200
- 5000
 
c) Si t_RAM = 100 ns y t_TLB = 20 ns, con probabilidad de acierto TLB = 90%, calcule el tiempo de acceso efectivo con y sin TLB.

**Resolución**
**a) Bits para página y desplazamiento**

Tamaño de página = 2 KB = 2048 bytes = 2^11.

- Bits de desplazamiento (d) = 11 (para direccionar dentro de la página).
- Dirección lógica total = 16 bits.
- Bits de página (p) = 16 - 11 = 5 (máximo 2^5 = 32 páginas por proceso).

**b) Traducción de direcciones**

Fórmula general:

```
Nº Página    = Dirección Lógica / Tamaño de página (división entera)
Desplazamiento = Dirección Lógica % Tamaño de página (módulo)
Dirección Física = (Nº Marco × Tamaño de página) + Desplazamiento
```

Dirección 1500:

```
Nº Página = 1500 / 2048 = 0
Desplazamiento = 1500 % 2048 = 1500
Nº Marco (según PMT, página 0) = 5
Dirección Física = (5 × 2048) + 1500 = 10240 + 1500 = 11740
```

Respuesta: Dir. Lógica 1500 → Dir. Física 11740

Dirección 3200:

```
Nº Página = 3200 / 2048 = 1 (porque 1×2048 = 2048, 2×2048 = 4096 > 3200)
Desplazamiento = 3200 % 2048 = 1152
Nº Marco (página 1) = 3
Dirección Física = (3 × 2048) + 1152 = 6144 + 1152 = 7296
```

Respuesta: Dir. Lógica 3200 → Dir. Física 7296

Verificación: 3200 - 2048 = 1152, justo el desplazamiento.

Dirección 5000:

```
Nº Página = 5000 / 2048 = 2 (2×2048 = 4096, 3×2048 = 6144)
Desplazamiento = 5000 % 2048 = 904
Nº Marco (página 2) = 7
Dirección Física = (7 × 2048) + 904 = 14336 + 904 = 15240
```

Respuesta: Dir. Lógica 5000 → Dir. Física 15240

**c) Tiempo de acceso efectivo**

Sin TLB (solo traducción directa):

```
t_efectivo = 2 × t_RAM = 2 × 100 ns = 200 ns
```

Con TLB (t_TLB = 20 ns, prob_acierto = 0.90):

```
t_efectivo = (t_TLB + t_RAM) × 0.90 + (t_TLB + 2×t_RAM) × 0.10
t_efectivo = (20 + 100) × 0.90 + (20 + 200) × 0.10
t_efectivo = 120 × 0.90 + 220 × 0.10
t_efectivo = 108 + 22 = 130 ns
```

Respuesta: Sin TLB = 200 ns, Con TLB = 130 ns. La TLB reduce un 35% el tiempo de acceso





#### Segmentación Simple (División por lógica)

A diferencia de la paginación, aquí dividimos el programa según lo que hace, no por su tamaño. Los trozos (segmentos) tienen tamaños diferentes.

   - **Módulos:** Un segmento para el código (instrucciones), otro para los datos (variables) y otro para la pila (stack).
   - **SMT (Segment Map Table):** Es la tabla de inventario de estos capítulos.
      - **Dirección Inicial (Base):** Dónde empieza el segmento en la RAM.
      - **Dirección Final o Longitud (Límite):** Dónde termina.
      - **Estado:** Si está cargado o no.

##### Traducción en Segmentacion

Dirección lógica: `(nº_segmento, desplazamiento)`

Proceso:

1. Obtener nro de segmento y desplazamiento
2. Buscar en SMT: verificar presencia, limite.
3. Si desplazamiento < tamaño: **DireccionFisica = Direccion Base + desplazamiento**
4. Si desplazamiento >= tamaño: **Error de segmentacion (Segmentation Fault**

##### Diferencias Clave para tu examen:

|Característica|		Paginación|						Segmentación|
|---|----|----|
|¿Quién divide?	|	El Sistema Operativo.|			El Programador / Compilador.  |
|Tamaño de trozos|	Fijo (Ej. todos de 4KB).|		Variable (depende de la función).|
|Visibilidad			|Invisible para el usuario.|		Visible (el programador sabe qué es cada segmento).|
|Fragmentación		|Causa Interna (en la última página).	| 			Causa Externa (huecos entre segmentos).   |
            

##### Las Tablas de Control que mencionó tu profesor

Mencionaste el BMT (Block Memory Table). Esto es lo que el S.O. usa para administrar la RAM física:
   - **BMT:** Registra todos los marcos (bloques) de la RAM y dice si están libres o quién es el dueño.
   - **PMT:** Registra las páginas de un proceso específico.

##### ¿Cómo se calcula la dirección? (Lo de 2k)

Si el profesor te da una dirección de 16 bits y te dice que la página es de 1KB (1024=210):
   - Los 10 bits de la derecha son el Desplazamiento (offset) dentro de la página.
   - Los 6 bits restantes son el Número de Página.

##### Criterios de Asignación de Segmentos

###### 1. Primer Ajuste (First-Fit)

El S.O. recorre la lista de huecos libres desde el principio y mete el segmento en el primer lugar donde quepa.

   - **Por qué se usa:** Es el más rápido. No pierde tiempo comparando todos los huecos.
   - **Problema:** Tiende a llenar el principio de la memoria con fragmentos pequeños, obligando a búsquedas más largas después.

###### 2. Mejor Ajuste (Best-Fit)

El S.O. busca en toda la memoria y elige el hueco que deje el menor espacio sobrante posible.

   - **Por qué se usa:** Intenta aprovechar los huecos pequeños que ya existen.
   - **Problema:** Genera mucha fragmentación externa (deja "migajas" de memoria de 1KB o 2KB que son tan pequeñas que ningún otro segmento podrá usar jamás). Además, es lento porque debe revisar toda la lista.

###### 3. Peor Ajuste (Worst-Fit)

El S.O. busca el hueco más grande disponible y mete el segmento ahí.

   - **La lógica (irónica):** Al usar el hueco más grande, el pedazo que sobra sigue siendo lo suficientemente grande como para que quepa otro segmento después.
   - **Problema:** En la práctica, desperdicia rápidamente los bloques grandes de memoria que podrías necesitar para procesos gigantes.

###### 4. Siguiente Ajuste (Next-Fit)

Es una variante del Primer Ajuste, pero en lugar de empezar siempre desde la dirección 0, empieza a buscar desde donde se quedó la última vez.

   - **Por qué se usa:** Distribuye los segmentos de forma más uniforme por toda la RAM y evita saturar el inicio de la memoria.

###### Ejemplo Práctico para tu examen

Tienes tres huecos libres en la RAM: 20KB, 100KB, y 40KB (en ese orden).
Llega un segmento de código que mide 30KB.

   1. **First-Fit:** Lo mete en el de 100KB (es el primero donde cabe, ignorando el de 20KB).

   2. **Best-Fit:** Lo mete en el de 40KB (es el que mejor le queda, solo sobran 10KB).

   3. **Worst-Fit:** Lo mete en el de 100KB (es el más grande, sobran 70KB).

   4. **Next-Fit:** Si la última vez asignamos algo en el hueco de 100KB, empezará a buscar a partir del de 40KB.

###### ¿Cómo se controla esto físicamente? (La Tabla de Segmentos)

Para que esto funcione, el S.O. mantiene la SMT (Segment Map Table). En tu clase mencionaron la e.d.u. (Estructura de Datos de Usuario o de Unidad), que básicamente registra:

   - **Número de Segmento:** (0 para código, 1 para datos...)
   - **Dirección Base:** Dónde empieza el hueco elegido.
   - **Límite:** El tamaño exacto del segmento para que no se pase de la raya.

   > **Dato Clave:** Si usas cualquiera de estos algoritmos, tarde o temprano tendrás que usar la Compactación que vimos antes, porque la RAM se llenará de huecos (Fragmentación Externa) y el brazo del "recolector de basura" tendrá que juntarlos.

##### Ejercicio

*En un sistema con segmentacion, inicialmente la RAM de usuario (400KB) tiene:*

- SO: 0-60 KB (60 KB)
- S0 (Segmento 0 de P1): 60-140 KB (80 KB)
- Hueco H1: 140 - 220 KB (80 KB)
- S1 (Segmento 1 de P1): 220 - 300 KB (80 KB)
- Hueco H2: 300 - 400 KB (100 KB)

*Llega un proceso P2 con tres segmentos:*

- Segmento Código: 70 KB
- Segmento Datos: 50 KB
- Segmento Stack: 30 KB

*Asigne los segmentos de P2 usando:*

a) First-Fit
b) Best-Fit

*Luego, dado el SMT resultante para P2 con First-Fit, traduzca:*

- Dir. Lógica (Código, 200) → a Dir. Física.
- Dir. Lógica (Datos, 60000) → ¿qué ocurre?

Resolucion:

**a) First-Fit para P2**

Huecos iniciales:

- H1: 140 KB - 220 KB (80 KB)
- H2: 300 KB - 400 KB (100 KB)

Procesamos segmentos en orden (Código, Datos, Stack).

Segmento Código (70 KB):

- Recorremos huecos: H1 (80 ≥ 70) → Sirve.
- Asignamos en H1, dirección base = 140 KB.
- H1 se parte: nuevo H1' = (140+70=210 KB, 80-70=10 KB).

```
Memoria actualizada:
[SO 60][S0 80][Código 70][H1' 10][S1 80][H2 100]
 0    60    140         210     220    300    400
```

Segmento Datos (50 KB):

- Huecos: H1'(10) no sirve (10 < 50), H2(100 ≥ 50) → Sirve.
- Asignamos en H2, base = 300 KB.
- H2 se parte: nuevo H2' = (300+50=350 KB, 100-50=50 KB).
```
[SO 60][S0 80][Código 70][H1' 10][S1 80][Datos 50][H2' 50]
 0    60    140         210     220    300       350    400
```

Segmento Stack (30 KB):

- Huecos: H1'(10) no sirve. H2'(50 ≥ 30) → Sirve.
- Asignamos en H2', base = 350 KB.
- H2' se parte: nuevo H2'' = (350+30=380 KB, 50-30=20 KB).

```
Mapa final:
[SO 60][S0 80][Código 70][H1' 10][S1 80][Datos 50][Stack 30][H2'' 20]
 0    60    140         210     220    300       350      380    400
```

SMT de P2 (First-Fit):

|Segmento|Tamaño|Direccion Base|Limite|Presencia|
|--|--|--|--|--|
|0 (Codigo)|70 KB| 140 KB|70 KB|1|
|1 (Datos)|50 KB| 300 KB|50 KB|1|
|0 (Stack)|30 KB| 350 KB|30 KB|1|

**b) Best-Fit para P2**

Huecos iniciales: H1(80), H2(100).

Código (70 KB):

- Ambos ajustan (80 y 100). Menor sobrante: H1 (sobra 10) vs H2 (sobra 30). → H1.
- Misma base: 140 KB.
- H1' = (210, 10).

Datos (50 KB):

- H1'(10) no, H2(100) sobra 50.
- (No hay opción, solo H2). Base: 300 KB.
- H2' = (350, 50).

Stack (30 KB):

- H1'(10) no, H2'(50) sobra 20.
- Base: 350 KB.
- H2'' = (380, 20).

Resultado: Idéntico a First-Fit (coincide en este caso).

SMT de P2 (Best-Fit): Igual al de First-Fit.


**c) Traducción de Direcciones Segmentadas**

Dirección Lógica: (Segmento 0, desplazamiento 200 bytes)

Recordar: Dirección base en bytes.

- 70 KB = 70 × 1024 = 71680 bytes.
- Desplazamiento 200 bytes.
- Verificar límite: ¿200 < 71680? Sí.
- Dir. Física = Dirección Base + desplazamiento
- Dir. Base de Segmento 0 = 140 KB = 140 × 1024 = 143360 bytes.
- Dir. Física = 143360 + 200 = 143560 bytes.

En KB: 143560 / 1024 ≈ 140.19 KB (dentro del segmento Código).

Dirección Lógica: (Segmento 1, desplazamiento 60000 bytes)

- Segmento 1 (Datos): tamaño = 50 KB = 51200 bytes.
- Desplazamiento = 60000 bytes.
- Verificar límite: ¿60000 < 51200? NO.
- ERROR: Violación de segmento (Segmentation Fault). El proceso intenta acceder más allá del límite del segmento de datos. El MMU lo detecta y lanza una excepción.




















---

### 3.8 Memoria Virtual (EL "Truco" del Almacenamiento)

#### RAM + DASP (Direct Access Storage Device)

El DASP es simplemente el término técnico para tu Disco Duro o SSD.
   - **Uso de SWAP (Intercambio):** El S.O. reserva un pedazo del disco para que actúe como una "extensión" de la RAM.
   - Cuando la RAM física se llena, el S.O. mueve los datos que no estás usando en ese microsegundo al disco. A esto se le llama Swap Out. Cuando los vuelves a necesitar, los trae de vuelta: Swap In. 

#### Asignación por Demanda (Paginada y Segmentada)

En los puntos anteriores, asumíamos que para ejecutar un programa, este tenía que estar todo cargado en la RAM. Con la Memoria Virtual, eso cambia: Solo cargas lo que necesitas en el momento.

##### Paginación por Demanda (Paginación Dinámica):
El programa está dividido en páginas, pero solo las páginas que el CPU está leyendo ahora mismo están en la RAM.

   - **Bit de Presencia/Ausencia:** La Tabla de Páginas (PMT) tiene una columna extra. Si el bit es 1, la página está en RAM. Si es 0, está en el disco.
   - **Fallo de Página (Page Fault):** Si el CPU pide una página que tiene un 0, ocurre una "interrupción" (excepción). El S.O. detiene todo, va al disco, busca la página, la sube a la RAM y pone el bit en 1.

*Tiempo de Fallo de Pagina (t_page_fault):*
- Tiempo de aceso a disco (seek + latency + transferencia) = millones de ci
- Por eso los fallos de página son carisimos.

##### Segmentación por Demanda (Segmentación Dinámica)

Es la misma lógica, pero con los capítulos (segmentos) del programa.
   - Por ejemplo, si tu programa tiene un segmento de "Ayuda" o de "Impresión", el S.O. no los carga en la RAM a menos que tú hagas clic en el botón de ayuda. Esto ahorra muchísima memoria.

##### BIts de control en la PTM

###### 1. Bit de Presencia / Ausencia (P)

Es el primer guardia de seguridad. Indica si la página que el proceso busca está realmente en la RAM física o si todavía sigue en el disco (DASP).

   - **Si es 1:** La página está en RAM. La MMU traduce la dirección y todo sigue normal.
   - **Si es 0:** La página no está en RAM. Se genera un Fallo de Página (Page Fault). El S.O. debe ir al disco, traerla, ponerla en un marco libre y cambiar el bit a 1.

###### 2. Bit de Referencia / Uso (R)

Este sirve para medir la "popularidad" de una página. Ayuda al S.O. a decidir quién es prescindible.

   - **Si es 1:** Alguien acaba de leer o escribir en esa página.
   - **Si es 0:** Nadie la ha tocado en un tiempo.

   - **¿Cómo funciona?** Periódicamente (en cada pulso de reloj), el S.O. pone todos los Bits de Referencia en 0. Si un proceso usa una página, el hardware automáticamente pone el bit en 1. Así, el S.O. sabe quién está "activo" y quién está "dormido".

###### 3. Bit de Modificado / Sucio (M o Dirty Bit)

Este es vital para la velocidad del sistema. Indica si el contenido de la página en RAM es distinto al que está guardado en el disco.

   - **Si es 0 (Limpia):** La página solo se leyó. El contenido en RAM y en Disco es idéntico.
   - **Si es 1 (Sucia):** El proceso escribió algo (cambió un dato). La copia de la RAM es "más nueva" que la del disco.
   - **¿Por qué importa?** Cuando el S.O. decide sacar una página de la RAM para meter otra:

      - Si el bit es **0**, simplemente la borra (total, ya hay una copia igual en el disco). **¡Es súper rápido!**

      - Si el bit es **1**, el S.O. está obligado a **escribir la página en el disco** antes de borrarla de la RAM para no perder los cambios. Esto es lento.

###### El "Semáforo" del Sistema Operativo

Imagina que el S.O. tiene que elegir a una "víctima" para sacarla de la RAM. Mira los bits y hace este razonamiento:

   - **R=0, M=0:** El mejor candidato. No se usa hace tiempo y no hay que guardar nada en el disco.
   - **R=0, M=1:** Regular. No se usa hace tiempo, pero hay que trabajar (escribir en disco) antes de sacarla.
   - **R=1, M=0:** Mal candidato. Se está usando mucho, aunque esté limpia.
   - **R=1, M=1:** El peor candidato. Se usa mucho y encima habría que escribir en disco.

###### Un detalle para tu "Biblia Linux" 📖

En Linux, puedes ver estadísticas de esto. Cuando haces un vmsat o miras el estado de la memoria, el sistema está usando estos bits por detrás para gestionar el Swapping. Como futuro Red Teamer, recuerda que si logras manipular estos bits (en un ataque de nivel de Kernel), podrías hacer que el sistema crea que una página maliciosa es "intocable" y nunca la saque de la memoria.

##### Algoritmos de Reemplazo de Página

Vamos a usar un ejemplo base:

    Memoria RAM: Tiene capacidad para 3 marcos (3 espacios).
    Cadena de referencia: 1, 2, 3, 4, 1, 2, 5

###### 1. FIFO (First-In, First-Out)

Es el más simple. El S.O. trata a los marcos como una fila (queue). La página que lleva más tiempo en la RAM es la que se va, sin importar si se está usando mucho o no.

   - **Ejemplo:**

      1. Entra 1, luego 2, luego 3. (RAM llena: [1, 2, 3])

      2. Llega el 4. ¿Quién entró primero? El 1. Se va el 1 y entra el 4. (RAM: [4, 2, 3])

      3. Llega el 1 otra vez. ¡Fallo! Se va el 2. (RAM: [4, 1, 3])

   - **Problema:** Sufre de la Anomalía de Belady: a veces, si le das más RAM al sistema, ¡tienes más fallos de página! Es ilógico, pero pasa con FIFO.

###### 2. LIFO (Last-In, First-Out)

Saca a la página que acaba de llegar. Es muy ineficiente porque lo más probable es que si algo acaba de entrar, sea porque se necesita ahora mismo. Casi no se usa, pero es bueno saber que existe como concepto "espejo" de FIFO.

###### 3. OPT (Algoritmo Óptimo)

Es el "Santo Grial". Saca la página que tardará más tiempo en volver a ser usada en el futuro.

   - **Ejemplo:** Si tengo [1, 2, 3] y la cadena que sigue es 4, 1, 2...
      - Miro al futuro: El 1 se usará pronto, el 2 también. El 3 no aparece más.
      - **Víctima:** El 3.

   - **Realidad:** Es imposible de implementar porque el S.O. no tiene una bola de cristal para predecir el futuro. Se usa solo para comparar qué tan buenos son los otros algoritmos.

###### 4. LRU (Least Recently Used)

Es el más equilibrado. Mira hacia el pasado. Saca la página que no se ha usado por el período de tiempo más largo.

   - **Ejemplo:** Tengo [1, 2, 3]. Se usan en este orden: 1, 2, 1, 3, 2.

      - Si llega el 4, miro cuál se usó hace más tiempo atrás: fue el 3.
      - Víctima: El 3.

   - **Costo:** Requiere mucho hardware o listas para llevar el tiempo exacto de cada uso.

###### 5. NRU (Not Recently Used)

Usa los bits que vimos antes (Referencia R y Modificado M). Divide las páginas en 4 clases:

   - **Clase 0:** R=0, M=0 (No usada, No modificada) -> Primeras en morir.
   - **Clase 1:** R=0, M=1 (No usada, pero Sucia).
   - **Clase 2:** R=1, M=0 (Usada, pero Limpia).
   - **Clase 3:** R=1, M=1 (Usada y Sucia) -> Intocables.

###### 6. Algoritmo del Reloj (Clock) - A fondo

Es una forma barata de hacer LRU. Imagina los marcos de RAM en un círculo (como un reloj). Una manecilla (puntero) recorre los marcos:

1. Si el **Bit de Referencia** es 1: Le da una "segunda oportunidad". Pone el bit en 0 y pasa a la siguiente página.
2. Si el **Bit de Referencia** es 0: ¡Esa es la víctima! La expulsa y mete la nueva página ahí.

###### 7. Conjunto de Trabajo (Working Set) y Ventanas

Esto es para evitar la Hiperpaginación (cuando el S.O. pasa más tiempo swapeando que trabajando).

   - **Working Set (W):** Es la colección de páginas que un proceso ha usado en los últimos Δ (delta) segundos.

   - **La Ventana (Δ):** Es el intervalo de tiempo que definimos para observar.

      - Si Δ es muy pequeño, el proceso no tendrá suficientes páginas en RAM y habrá muchos fallos.
      - Si Δ es muy grande, desperdiciamos RAM guardando páginas que ya no se usan.

**El objetivo del S.O.:** Mantener el "Working Set" de cada proceso en la RAM. Si no hay suficiente RAM para el Working Set de todos, el S.O. debe suspender un proceso por completo (llevarlo todo al disco) para dejar que los demás respiren.

#### Asignacion Segementada por Demanda

Traer segmentos lógicos completos desde el disco solo cuando se invocan.

##### 1. El Concepto: "Solo si lo llamas"

A diferencia de la segmentación simple (donde todo el programa debía estar en la RAM), aquí el Sistema Operativo solo carga en la memoria física los segmentos que el proceso está ejecutando actualmente.

   - **En el Disco (DASP):** Reside todo el programa dividido en sus segmentos (Código, Datos, Stack, Librerías).
   - **En la RAM:** Solo están los segmentos "vivos".
   - **La Invocación:** Si el programa intenta acceder a una función que está en el "Segmento de Reportes" y este no está en RAM, se genera una Falla de Segmento (similar a la falla de página). El S.O. corre al disco, busca el segmento completo y lo trae a un hueco libre.

##### 2. La Tabla de Segmentos (SMT) con Bits de Control

Para que esto funcione, la tabla de segmentos se vuelve más compleja. Ahora cada entrada tiene:

   - **Dirección Base:** Dónde empieza en RAM.
   - **Límite:** Tamaño del segmento.
   - **Bit de Presencia (P):** 1 si está en RAM, 0 si está en disco.
   - **Bit de Modificado (M):** Para saber si hay que actualizar el disco al sacarlo.
   - **Protección:** (Lectura, Escritura, Ejecución).

##### 3. Diferencia Crítica: Segmentación vs. Paginación por Demanda

Esta es pregunta clásica de examen:

   - **Paginación por Demanda:** Es más eficiente para el S.O. porque no tiene que buscar "huecos" del tamaño exacto (los marcos siempre son iguales). No hay fragmentación externa.
   - **Segmentación por Demanda:** Es mejor para compartir memoria. Por ejemplo, si tienes 10 procesos usando la misma librería de gráficos, solo cargas un segmento de esa librería en RAM y todos los procesos apuntan a él. Además, protege mejor: puedes marcar el "Segmento de Código" como Solo Ejecución para que nadie pueda inyectar código malicioso (viste, ahí está el Sombrero Rojo 🎩).

##### 4. El problema: La Fragmentación Externa

Como los segmentos tienen tamaños distintos (el de Código puede medir 50KB y el de Datos 200KB), al traerlos y llevarlos al disco, la RAM se empieza a llenar de "huecos".

   - Si quieres traer un segmento de 100KB y tienes tres huecos de 40KB repartidos, no puedes cargarlo, aunque tengas 120KB libres en total.
   - **Solución:** El S.O. debe aplicar **Compactación** o usar una combinación llamada **Sistemas Paginados/Segmentados** (lo mejor de ambos mundos).

##### 5. Resumen de la "Biblia" para este punto:
   > "La Segmentación por Demanda permite que el espacio de direcciones lógico sea mucho más grande que la memoria física, cargando módulos completos basados en la lógica del programador solo cuando son referenciados."

#### Conceptos "de examen" que mencionó tu profesor

   - **Administración de Memoria (Lógica vs. Física):** La memoria virtual separa totalmente estas dos. Para el proceso (Lógica), él tiene gigas de espacio infinito. Para la RAM (Física), solo hay unos cuantos pedacitos del proceso.
   - **Estado de la Tabla (Gantts / Tiempo):** A veces los profes piden diagramas de Gantt para ver cuándo un proceso estuvo bloqueado esperando a que el disco trajera una página (el tiempo de espera del Page Fault).
   - **PMT y BMT en Virtual:** 
      - **La PMT** ahora es más grande porque incluye direcciones en el disco.
      - **La BMT** (Block Memory Table) ahora debe gestionar qué marcos están "sucios" (si se modificaron y hay que guardarlos en disco antes de borrarlos).

#### Resumen de la "Biblia" de Memoria

Para que no te vuelvas a perder en clase, mira esta jerarquía:
   - **Contigua:** El proceso entra entero y en un solo bloque.
   - **Particionada Fija:** Cajones pre-hechos (Fragmentación Interna).
   - **Particionada Dinámica:** Cajones a medida (Fragmentación Externa / Compactación).
   - **Paginación/Segmentación Simple:** El proceso se pica en trozos, pero sigue estando todo en RAM.
   - **Memoria Virtual (Por Demanda):** El proceso se pica en trozos y solo una parte está en RAM; el resto vive en el disco.

#### ¿Por qué esto es importante para un "Sombrero Rojo"?

En ciberseguridad, la memoria virtual es donde ocurre el ASLR que te mencioné y donde se gestionan los permisos de ejecución. Un ataque común es el "Thrashing" (Hiperpaginación): un virus puede forzar al sistema a pedir tantas páginas de memoria que el S.O. se la pasa moviendo datos entre el disco y la RAM, congelando la computadora por completo.

---

## 📎  4. Drivers (Controladores de Dispositivos)

Los Drivers (Controladores de Dispositivos) son el puente de comunicación. Imagina que el Sistema Operativo es un Rey que habla un idioma culto, y los dispositivos (teclado, disco duro, impresora) son extranjeros que hablan dialectos extraños. El Driver es el traductor oficial.

#### ¿Qué es un Driver?

Es un software especializado que permite al Sistema Operativo interactuar con un hardware específico. Sin el driver, el S.O. no sabe qué comandos enviarle al aparato.

Características clave:

   - **Abstracción:** El driver oculta los detalles feos del hardware. El S.O. solo dice "Escribe este dato", y el driver se pelea con los voltajes y los cables.
   - **Kernel Mode:** La mayoría de los drivers corren en el "espacio del núcleo". Si un driver falla, puede congelar toda la computadora (el famoso Pantallazo Azul).
   - **Estandarización:** Existen clases de drivers (como los de USB o Discos) para que el S.O. no necesite un driver distinto para cada marca de mouse.

#### ¿Cómo se comunican? (El flujo de datos)

Hay tres formas principales en las que el driver y el hardware se "hablan":

   1. **E/S Programada (Polling):** El driver le pregunta al hardware constantemente: "¿Ya terminaste? ¿Ya terminaste?". Es muy ineficiente porque gasta CPU en preguntar.
   2. **Basada en Interrupciones:** El driver le da una orden al hardware y se va a hacer otra cosa. Cuando el hardware termina, lanza una "Interrupción" para avisarle al CPU. (Esto lo veremos a detalle en el siguiente punto).
   3. **DMA (Direct Memory Access):** Para mover mucha información (como un video), el hardware escribe directamente en la RAM sin molestar al CPU. El driver solo da el permiso inicial.

#### Estructura de un Driver

Para tu examen, recuerda que un driver suele tener estas partes:

   - **Manejador de interrupciones:** Qué hacer cuando el hardware grita "¡Listo!".
   - **Interfaz de usuario:** Cómo lo ve el programador (por ejemplo, /dev/sda en Linux).
   - **Código de inicialización:** Configura el aparato cuando lo conectas.

Un dato para tu "Biblia Linux" 📖

#### En Linux, casi todo es un archivo. Los drivers se manifiestan en la car}peta /dev/.

   - **Drivers de Bloque:** Manejan datos en pedazos grandes (discos duros).
   - **Drivers de Carácter:** Manejan datos byte a byte (teclados, puertos seriales).
   
---

### Las Interrupciones de Hardware

Las interrupciones de Hardware son el mecanismo más eficiente que tiene el Sistema Operativo para reaccionar a eventos del mundo exterior. Sin ellas, la CPU perdería el 90% de su tiempo preguntando "¿ya pulsaste una tecla?" o "¿ya terminó de leer el disco?".

Imagina que estás cocinando (CPU) y pones agua a hervir (Disco Duro). No te quedas mirando el agua sin hacer nada; te pones a picar cebolla y solo cuando escuchas el silbato de la tetera, dejas la cebolla y vas a apagar el fuego. El silbato es la interrupción.

#### El Ciclo de una Interrupción

Cuando un dispositivo de hardware (como tu tarjeta de red o el teclado) necesita atención, ocurre este proceso exacto:

   1. **La Señal:** El hardware envía una señal eléctrica por una línea especial llamada IRQ (Interrupt Request).
   2, **El Pausa:** La CPU termina la instrucción que está ejecutando en ese microsegundo y guarda su "estado" (registros y dónde se quedó) en el Stack.
   3, **El Salto:** La CPU consulta el Vector de Interrupciones, que es una tabla en memoria que dice: "Si grita el teclado, ve a la dirección de memoria X".
   4. **El Manejador (ISR):** Se ejecuta el Interrupt Service Routine (ISR), que es un pedazo de código del Driver que sabe qué hacer con ese evento.
   5. **El Regreso:** Una vez atendido, la CPU recupera lo que guardaba en el Stack y sigue con el programa que estaba antes como si nada hubiera pasado.

#### Tipos de Interrupciones

Para tu examen, diferencia bien estas dos:

   - **Interrupciones de Hardware (Externas):** Generadas por dispositivos físicos (asíncronas, pueden ocurrir en cualquier momento). Ejemplo: Mover el ratón.
   - **Excepciones / Traps (Internas):** Generadas por la propia CPU cuando algo sale mal en el código. Ejemplo: Dividir entre cero o un Page Fault (que ya vimos).

#### El Controlador de Interrupciones (PIC/APIC)

Como hay muchos dispositivos y solo una CPU, existe un chip "secretario" llamado Controlador de Interrupciones. Él decide qué interrupción es más importante:

   - Si el Disco Duro y el Mouse gritan al mismo tiempo, el controlador le da paso primero al Disco porque es más crítico.
   - **NMI (Interrupción No Enmascarable):** Es una interrupción de "pánico" que la CPU no puede ignorar (como un error de memoria físico o sobrecalentamiento).

---

### Planificacion de Disco (Disk Schelduling)

Directo al grano! Vamos a hablar de la Planificación de Disco (Disk Scheduling). Esto es pura mecánica: cómo movemos el cabezal (el "brazo") sobre los platos giratorios para leer datos sin que el brazo se vuelva loco moviéndose de un lado a otro.

Imagina que el disco es un viejo tocadiscos, pero con miles de pistas. Si el proceso A pide un dato en la pista 10 y el proceso B pide uno en la pista 500, el brazo tiene que viajar físicamente. Ese viaje se llama Seek Time (Tiempo de Búsqueda) y es lo más lento de una computadora.

#### Los Algoritmos de Movimiento del Brazo

Aquí es donde el S.O. decide en qué orden atiende las peticiones de lectura/escritura para ahorrar energía y tiempo.

#### FCFS (First-Come, First-Served)

Es el más justo pero el más tonto. Atiende las peticiones tal como llegan.

   - **El problema:** Si llegan peticiones en las pistas [10, 200, 11, 199], el brazo va a estar cruzando todo el disco de ida y vuelta como un péndulo. Muy ineficiente.

#### SSTF (Shortest Seek Time First)

Atiende primero la petición que esté más cerca de la posición actual del brazo.

   - **Ventaja:** Minimiza el movimiento.
   - **Peligro:** Puede causar inanición. Si siempre llegan peticiones cerca de donde está el brazo, las que están lejos (en los extremos del disco) nunca se atenderán.

#### SCAN (El algoritmo del Elevador)

El brazo se mueve de un extremo al otro del disco atendiendo todas las peticiones que encuentra en su camino. Cuando llega al final, cambia de dirección y vuelve.

   - **Por qué es bueno:** Es muy eficiente y no deja a nadie esperando para siempre. Es como un ascensor que sube hasta el último piso y luego baja.

#### S-SCAN (Circular SCAN)

Es igual al SCAN, pero con un truco: cuando llega al final del disco, vuelve al principio de un solo salto (sin atender nada de regreso) y empieza otra vez.

   - **Lógica:** Provee un tiempo de espera más uniforme, porque las peticiones en los extremos no tienen que esperar a que el brazo vaya y vuelva.

#### LOOK y C-LOOK

Son versiones "inteligentes" de SCAN y C-SCAN. En lugar de ir hasta el borde físico del disco (pista 0 o pista 1000), el brazo solo llega hasta la última petición pendiente en esa dirección y luego se regresa. Si no hay más gente en el piso 10, el elevador no sube hasta el techo.

#### Conceptos que debes anotar para tu examen:

   - **Seek Time:** Tiempo que tarda el brazo en llegar a la pista.
   - **Latencia Rotacional:** Tiempo que tarda el disco en girar para que el dato pase por debajo del cabezal.
   - **Transfer Time:** Tiempo en que el dato realmente viaja del disco a la RAM.

¿Te gustaría que te explique por qué cuando "borras" algo en Windows o Linux, el archivo sigue ahí y cómo puedes recuperarlo con tus herramientas de forense? ¿Le entramos a los I-Nodos y sectores?

--- 

## 📎 5. Sistema de archivos

Imagina que el disco duro es un almacén gigante y vacío. El Sistema de Archivos es el que pone los estantes, etiqueta las cajas y lleva un libro de inventario para saber dónde está cada cosa.

#### ¿Qué es un Archivo realmente?

Para el usuario, es un icono. Para el S.O., es una colección de bloques de datos con un nombre y atributos (fecha, tamaño, permisos).

#### Tipos de acceso:

   - **Secuencial:** Tienes que leer desde el principio para llegar al final (como un cassette).
   - **Directo (Aleatorio):** Puedes saltar directamente a cualquier parte (como un CD o un archivo en tu SSD).

#### Estructura de Directorios

Los archivos no están "flotando". Se organizan en una estructura de Árbol.

   - **Directorio Raíz (/ en Linux, C:\ en Windows):** El tronco del árbol.
   - **Ruta Absoluta:** /home/alboncho/biblia_linux.txt (desde la raíz).
   - **Ruta Relativa:** Documents/proyectos/ (desde donde estás parado ahora).

#### La magia de los I-Nodos (Linux/Unix)

Como te gusta Linux, esto es vital. En Linux, el nombre del archivo es solo una etiqueta. La información real vive en el I-Nodo (Index Node).

Un **I-Nodo** contiene:

   - Tamaño del archivo.
   - Dueño y permisos (el famoso chmod).
   - Punteros: Direcciones de los bloques físicos en el disco donde están los datos.

#### ¿Por qué puedes recuperar archivos borrados?

Aquí viene lo que te interesa de forense. Cuando le das a "Eliminar":

   - El S.O. NO borra los datos (los 0s y 1s) del disco. Eso tardaría demasiado.
   - Simplemente va al índice (o al I-Nodo) y marca ese espacio como "Disponible".
   - Es como si en el índice de un libro borraras el renglón del Capítulo 5. Las páginas siguen ahí, pero el libro ya no sabe cómo llegar a ellas.

Por eso pudiste recuperar esos 4,600 archivos con PhotoRec: Mientras no guardes cosas nuevas que "chancen" (sobrescriban) esos sectores, los datos siguen vivos.

#### Métodos de Asignación (Cómo se guardan los bloques)

¿Cómo decide el S.O. en qué huecos poner el archivo?

   - **Contigua:** Todo el archivo en bloques seguidos. Es rápido pero causa mucha fragmentación externa (huecos vacíos).
   - **Encadenada:** Cada bloque tiene un puntero al siguiente (como una lista enlazada). No hay fragmentación, pero si se rompe un puntero, pierdes el resto del archivo.
   - **Indexada:** Se crea un bloque especial (el índice) que tiene todas las direcciones de los bloques del archivo. Es el método más usado hoy.

#### Sistemas de Archivos Famosos

   - **FAT32:** Viejo, compatible con todo, pero no admite archivos de más de 4GB.
   - **NTFS:** El estándar de Windows. Soporta permisos avanzados y recuperación de errores.
- EXT4: El estándar de Linux. Muy rápido y seguro.
   - **APFS:** El de Apple, optimizado para SSDs.

#### Fragmentación de Disco

Ocurre cuando un archivo se guarda en bloques muy separados entre sí.

   - En un HDD, esto es un desastre porque el brazo tiene que moverse mucho (aumenta el Seek Time).
   - En un SSD, la fragmentación no importa porque no hay piezas móviles. ¡Ojo! Nunca desfragmentes un SSD, solo gastas sus ciclos de vida.
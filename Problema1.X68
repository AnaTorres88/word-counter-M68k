*-----------------------------------------------------------
* Title      : Problema 1
* Written by : Ana Laura Torres Gonzalez
* Date       : 10/08/2023
* Description: Problema 1 del laboratorio 2
*-----------------------------------------------------------
CR  EQU       $0D
LF  EQU       $0A

START: ORG    $1000
* Cargar dialogo en direccion de memoria
    LEA DIALOG,A1
    MOVE #0,D2 ;D2 es flag para contar caracteres
    MOVE #0,D3 ; D3 para contar espacios
    MOVE #0,D4 ; D3 para contar palabras
* Mostrar prompt
    MOVE #14,D0
    TRAP #15
* Leer input de usuario
    MOVE #2,D0 ;lee el input con tarea #2
    TRAP #15
    MOVE A1,A0

LOOP:
    TST.B   (A0)+        ; Carga el sig. caractetr
    BEQ     INCREMENTSP     ;Ejecuta INCREMENTSP, para incrementar espacios
    BRA     INCREMENT ;Ejecuta INCREMENT, para incrementar caracteres

INCREMENTSP:
    CMP #$20,A0     ; Checa si caracter es espacio
    ADDQ #1,D3        ; Suma 1 al contador  
    BRA WORDSCOUNT    ; Ejecuta WORDSCOUNT
    BNE FINISHED
INCREMENT:
    ADDQ #1,D2          ; Incrementa contador de caracteres
    BRA LOOP            ; Ejecuta Subrutina LOOP, el ciclo
WORDSCOUNT:            ;Incrementa contador de palabras agregando 1 al total de esoacios 
    MOVE D3,D4  
    ADDQ #1,D4
FINISHED:              ; Ejecuta subrutinas para mostrar el numero de caracteres
    BRA SHOW_CHARS
    BRA SHOW_SPACES
    BRA SHOW_WORDS

    SIMHALT
SHOW_CHARS:
    LEA CHARS,A1 ;Muestra texto caracteres
    MOVE #14,D0
    TRAP #15

    MOVE D2,D1  ; Muestra num. de caracteres
    MOVE #3,D0
    TRAP #15
SHOW_SPACES:
    LEA SPACES,A1 ;Muestra texto espacios
    MOVE #14,D0
    TRAP #15

    MOVE D3,D1 ; Muestra num. de espacios
    MOVE #3,D0
    TRAP #15
SHOW_WORDS:
    LEA WORDS,A1 ;Muestra texto palabras
    MOVE #14,D0
    TRAP #15

    MOVE D4,D1  ; Muestra num. de palabras
    MOVE #3,D0
    TRAP #15

*Mensajes
DIALOG: DC.W    'ESCRIBE ALGO: ',CR,LF,0
CHARS: DC.B 'CARACTERES: ',0, LF,CR
SPACES: DC.B ' ESPACIOS: ',0, LF,CR
WORDS: DC.B ' PALABRAS: ',0, LF,CR


        END     START





















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

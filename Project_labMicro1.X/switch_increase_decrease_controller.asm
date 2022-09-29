#include "p18f4550.inc"


  CONFIG  FOSC = XT_XT ; Oscillator com Cristal de 4 MHz
  CONFIG  WDT = OFF    ; Watchdog Timer Enable bit (WDT enabled)
  CONFIG  LVP = OFF    ; Single-Supply ICSP Enable bit

VARIAVEIS UDATA_ACS 0
  CONTA2m   RES 1 ; Variavel auxiliar para contagem de 2 ms
  CONTA500m RES 1 ; Variavel auxiliar para contagem de 500 ms
 
RES_VECT  CODE    0x0000 ; processor reset vector
  GOTO    START          ; go to beginning of program
  
MAIN_PROG CODE ; let linker place main program
 
START
    MOVLW b'11000000'; Configura RB4 como saida e demais como entrada
    MOVWF TRISD
ESPERA    
    CALL ATRASO_500ms; Espera 500 ms
    CALL ATRASO_500ms; Espera 500 ms
LOOP    
    BTFSC PORTD,7    ; Verifica estado de SW1
    NOP              ; Se SW1 não estiver pressionada não faz nada
    INCFSZ PORTD     ; Caso contrário incrementa PORTD
    GOTO ESPERA      ; Espera 1 segundo 
    BTFSC PORTD,6    ; Verifica estado de SW1
    NOP              ; Se SW1 não estiver pressionada não faz nada
    DECFSZ PORTD     ; Caso contrário decrementa PORTD
    GOTO ESPERA      ; Espera 1 segundo
    GOTO LOOP        ; reinicia o processo 

ATRASO_2ms ; Subrotina que gera atraso de 2 ms
    MOVLW .152
    MOVWF CONTA2m ; Carrega contador para 200 interações
REPETE2      ; Inicio do loop    
    NOP      ; 10 NOPs -> 10 us
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    DECFSZ CONTA2m
    GOTO REPETE2  ; Repete interações até que CONTA2 = 0
    RETURN

ATRASO_500ms ; Subrotina que gera atraso de 500 ms
    MOVLW .250
    MOVWF CONTA500m ; Carrega contador para 250 interações
REPETE_500   ; Inicio d92o loop
    CALL ATRASO_2ms ; Espera 2 ms
    DECFSZ CONTA500m
    GOTO REPETE_500 ; Repete interações até que CONTA500 = 0
    RETURN
 
    END


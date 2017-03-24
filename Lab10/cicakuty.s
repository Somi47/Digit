DEF SW  0x81                ; DIP kapcsol� adatregiszter          (csak olvashat�)
DEF TR  0x82                ; Timer kezdo�llapot regiszter        (csak �rhat�)
DEF TM  0x82                ; Timer sz�ml�l� regiszter            (csak olvashat�)
DEF TC  0x83                ; Timer parancs regiszter             (csak �rhat�)
DEF TS  0x83                ; Timer st�tusz regiszter             (csak olvashat�)
DEF CDO 0xA4                ; GPIO C kimeneti adatregiszter       (�rhat�/olvashat�)
DEF CDI 0xA5                ; GPIO C adat az I/O l�bakon          (�rhat�/olvashat�)
DEF CDR 0xA6                ; GPIO C ir�nyregister (0: be, 1: ki) (�rhat�/olvashat�)


    CODE
    
    jmp start    ; Reset vektor
    jmp tmr_irq  ; Megszak�t�s vekor
    
    ; Program kezdete
start:
    ; PWM sz�ml�l� t�rl�se
    mov r10, #0
    mov r11, #0
    ; k�z�p�ll�s a kit�lt�si t�nyezon
    mov r12, #127
    mov r13, #1
    
    ; GPIO C port konfigur�l�sa
    ; GPIOC[1] kimenet �s 0, a t�bbi benenet    
    mov r0, #0x00
    mov CD0, r0
    mov r0, #0x02
    mov CDR, r0
    
    ; Az idoz�to be�ll�t�sa
    mov r0, #63
    mov TR, r0
    mov r0, #0x83
    mov TC, r0
    mov r0, TS
    
    ; Megszak�t�s enged�lyez�s a processzoron
    sti
loop:
    mov r0, #0
    mov r1, #0
wait:
    add r0, #15
    adc r1, #0
    jnc wait
    
    add r12, #1
    jmp loop ; v�gtelen ciklus
    
    ; Idoz�to magszak�t�s kezelo rutin
tmr_irq:
    mov r14, r10 ; PWM sz�ml�l� elm�sol�sa
    mov r15, r11
    
    sub r14, r12
    sbc r15, r13
    
    mov r5, #0
    rlc r5
    sl0 r5    
    mov CDO, r5
    
    add r10, #1
    adc r11, #0
    
    ; PWM sz�ml�l� v�g�llapot�nak tesztel�se
    tst r11, #10
    jz  irq_end
    ; Ha v�g�re �rt�nk a sz�ml�l�nak, akk null�zuk
    mov r10, #0
    mov r11, #0
 irq_end:
    mov r14, TS
    rti
    
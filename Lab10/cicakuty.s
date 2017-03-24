DEF SW  0x81                ; DIP kapcsoló adatregiszter          (csak olvasható)
DEF TR  0x82                ; Timer kezdoállapot regiszter        (csak írható)
DEF TM  0x82                ; Timer számláló regiszter            (csak olvasható)
DEF TC  0x83                ; Timer parancs regiszter             (csak írható)
DEF TS  0x83                ; Timer státusz regiszter             (csak olvasható)
DEF CDO 0xA4                ; GPIO C kimeneti adatregiszter       (írható/olvasható)
DEF CDI 0xA5                ; GPIO C adat az I/O lábakon          (írható/olvasható)
DEF CDR 0xA6                ; GPIO C irányregister (0: be, 1: ki) (írható/olvasható)


    CODE
    
    jmp start    ; Reset vektor
    jmp tmr_irq  ; Megszakítás vekor
    
    ; Program kezdete
start:
    ; PWM számláló törlése
    mov r10, #0
    mov r11, #0
    ; középállás a kitöltési tényezon
    mov r12, #127
    mov r13, #1
    
    ; GPIO C port konfigurálása
    ; GPIOC[1] kimenet és 0, a többi benenet    
    mov r0, #0x00
    mov CD0, r0
    mov r0, #0x02
    mov CDR, r0
    
    ; Az idozíto beállítása
    mov r0, #63
    mov TR, r0
    mov r0, #0x83
    mov TC, r0
    mov r0, TS
    
    ; Megszakítás engedélyezés a processzoron
    sti
loop:
    mov r0, #0
    mov r1, #0
wait:
    add r0, #15
    adc r1, #0
    jnc wait
    
    add r12, #1
    jmp loop ; végtelen ciklus
    
    ; Idozíto magszakítás kezelo rutin
tmr_irq:
    mov r14, r10 ; PWM számláló elmásolása
    mov r15, r11
    
    sub r14, r12
    sbc r15, r13
    
    mov r5, #0
    rlc r5
    sl0 r5    
    mov CDO, r5
    
    add r10, #1
    adc r11, #0
    
    ; PWM számláló végállapotának teszteláse
    tst r11, #10
    jz  irq_end
    ; Ha végére értünk a számlálónak, akk nullázuk
    mov r10, #0
    mov r11, #0
 irq_end:
    mov r14, TS
    rti
    
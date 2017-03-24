DEF LD  0x80                ; LED adatregiszter                   (�rhat�/olvashat�)
DEF ADO 0xA0                ; GPIO A kimeneti adatregiszter       (�rhat�/olvashat�)
DEF ADI 0xA1                ; GPIO A adat az I/O l�bakon          (�rhat�/olvashat�)
DEF ADR 0xA2                ; GPIO A ir�nyregister (0: be, 1: ki) (�rhat�/olvashat�)

    CODE
    
start:
    ; GPIO A inicializ�l�sa
    mov r0,  #0x01 ; A[0] chip select enged�lyez�se
    mov ADO, r0   ; A[1] �rajel tilt�s
    mov r0,  #0x03 ; Portok ir�ny�nak inicializ�l�sa A[2]MISO bemenet: 0
    mov ADR, r0
    
    ;LED-ek t�rl�se
    mov r0, #0x00
    mov LD, r0
    
loop:
    jsr wait_1s   ; v�rakoz�s szubrutin h�v�s
    jsr tmp121_rd ; beolvas�s szubrutin h�v�s
    sl0 r8 ;legnagyobb kil�ptet�se carrybe
    rlc r9
    mov LD, r9
    jmp loop
    
    
    ; Hom�rs�klet belovas�s szubrutin
tmp121_rd:
    mov r0,  #0x00 ;CSn = 0
    mov ADO, r0
    mov r1,  #16
tmp121_loop:
    mov r0,  #0x02;
    mov ADO, r0
    mov r0,  ADI    ;GPIO beolvas�s
    and r0,  #0x04  ;Csak MISO �rdekel minket
    add r0,  #0xff  ; C = MISO
    rlc r8          ; MISO (C) bel�ptet�se a regiszterekbe
    rlc r9
    mov r0,  #0x00  ; CSn=0, SCK=0
    mov ADO, r0
    sub r1, #1
    jnz tmp121_loop  ;Ha van m�g beolvasand� bit, akkor megy a ciklus tov�bb
    mov r0, #0x01
    mov ADO, r0     ;CSn=1
    rts             ;Visszat�r�s a h�v�hoz
    
    ; V�rakoz� szubrutin
wait_1s:
    mov r0, #0x00
    mov r1, #0x00
    mov r2, #0x00
wait_loop:
    add r0, #13
    adc r1, #0
    adc r2, #0
    jnc wait_loop
    rts
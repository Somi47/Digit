DEF LD  0x80                ; LED adatregiszter                   (írható/olvasható)
DEF ADO 0xA0                ; GPIO A kimeneti adatregiszter       (írható/olvasható)
DEF ADI 0xA1                ; GPIO A adat az I/O lábakon          (írható/olvasható)
DEF ADR 0xA2                ; GPIO A irányregister (0: be, 1: ki) (írható/olvasható)

    CODE
    
start:
    ; GPIO A inicializálása
    mov r0,  #0x01 ; A[0] chip select engedélyezése
    mov ADO, r0   ; A[1] órajel tiltás
    mov r0,  #0x03 ; Portok irányának inicializálása A[2]MISO bemenet: 0
    mov ADR, r0
    
    ;LED-ek törlése
    mov r0, #0x00
    mov LD, r0
    
loop:
    jsr wait_1s   ; várakozás szubrutin hívás
    jsr tmp121_rd ; beolvasás szubrutin hívás
    sl0 r8 ;legnagyobb kiléptetése carrybe
    rlc r9
    mov LD, r9
    jmp loop
    
    
    ; Homérséklet belovasás szubrutin
tmp121_rd:
    mov r0,  #0x00 ;CSn = 0
    mov ADO, r0
    mov r1,  #16
tmp121_loop:
    mov r0,  #0x02;
    mov ADO, r0
    mov r0,  ADI    ;GPIO beolvasás
    and r0,  #0x04  ;Csak MISO érdekel minket
    add r0,  #0xff  ; C = MISO
    rlc r8          ; MISO (C) beléptetése a regiszterekbe
    rlc r9
    mov r0,  #0x00  ; CSn=0, SCK=0
    mov ADO, r0
    sub r1, #1
    jnz tmp121_loop  ;Ha van még beolvasandó bit, akkor megy a ciklus tovább
    mov r0, #0x01
    mov ADO, r0     ;CSn=1
    rts             ;Visszatérés a hívóhoz
    
    ; Várakozó szubrutin
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
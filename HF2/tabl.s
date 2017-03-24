DEF LD  0x80                ; LED adatregiszter (írható/olvasható)

; digit kód: 4136275 -> 4 5 1 4 3 9 6 8 2 9 7 C 5

    CODE
init: ; Adatok memoriaban tarolasa
    mov r0, #0x45
    mov 0x00, r0
    mov r0, #0x14
    mov 0x01, r0
    mov r0, #0x39
    mov 0x02, r0
    mov r0, #0x68
    mov 0x03, r0
    mov r0, #0x29
    mov 0x04, r0
    mov r0, #0x7C
    mov 0x05, r0
    mov r0, #0x50
    mov 0x06, r0
    
start:
    mov r1, #0x00  ; Ciklus iterátor, az olvasandó memóriacím helye
    mov r2, #0x07 ; Kilépési feltétel
loop:
    cmp r2, r1    ; Kilépési feltétel ellenorzése
    jz  loop_end
    mov r0, (r1)   ; Memoria beolvasása
    mov r15, #0x00 ; Számláló ciklusunkénti nullázása
    ; Shiftelés, és ha 1-es volt shiftelve, akkor inkrementálás
    ; Ciklusva szervezve is lehetne, de nem lenne sokkal rövidebb
    sl0 r0
    adc r15, #0x00 ; Inkrementálás
    sl0 r0
    adc r15, #0x00 ; Inkrementálás
    sl0 r0
    adc r15, #0x00 ; Inkrementálás
    sl0 r0
    adc r15, #0x00 ; Inkrementálás
    sl0 r0
    adc r15, #0x00 ; Inkrementálás
    sl0 r0
    adc r15, #0x00 ; Inkrementálás
    sl0 r0
    adc r15, #0x00 ; Inkrementálás
    sl0 r0
    adc r15, #0x00 ; Inkrementálás
    
    mov (r1), r15 ; A
    
    add r1, #0x01 ; Ciklus iterátor növelése
    jmp loop
loop_end:
    mov LD, r15  ; Ledeken megjelenítés

    


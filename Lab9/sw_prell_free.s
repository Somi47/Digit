;*******************************************************************************
;* Labor 9_1a feladat:                                                         *
;* A kapcsolók programozott pergésmenetsítése                                  *
;* Alapállapotban minden kapcsoló 1 állapotú. (8 biten ez 0xFF). Várakozunk    *
;* bármelyik kapcsoló megnyomására, azaz egy 1->0 átmenetre. Ha ez megtörténik,*
;* akkor egy újabb számláló ciklus indul és várunk arra, hogy adott ideig      *
;* egyfolytában aktív legyen. Ha egy pillanatra is visszavált, újrakezdjük     *
;* a figyelést. Ugyanezt elvégezzük a 0->1 átmenetnél is                       *
;*******************************************************************************
DEF LD  0x80                ; LED regiszter          (írható/olvasható)
DEF SW  0x81                ; DIP kapcsoló regiszter (csak olvasható)

    CODE

start:
    mov     r1, #0          ; Számláló törlése
wait_press:  
    mov     r0, SW          ; Beolvassuk a kapcsolók állapotát.
    xor     r0, #0xFF       ; Állapot ellenõrzése, ha mindegyik 1 
    jz      wait_press      ; akkor várunk aktiválásra
    mov     r2, #0          ; Pergésmentesítõ késleltetõ számláló

pressed:    
    add     r2, #1          ; Pergésmentesítõ számláló inkrementálása 
    jc      prell_end1      ; Ha eléri a 255-öt akkor stabil érték
    mov     r0, SW          ; Beolvassuk a kapcsolók állapotát.
    xor     r0, #0xFF       ; Állapot ellenõrzése, ha véletlenül mindegyik 1 
    jz      wait_press      ; akkor nem stabil, visszaugrunk és várunk aktiválásra
    jmp     pressed         ; Stabil érték ellenérzése  
    
prell_end1:    
    add     r1, #1          ; Az érvényes megnyomás számláló inkrementálása
    mov     LD, r1          ; Érték kijelzése
    
wait_release:
    mov     r0, SW          ; Beolvassuk a nyomógombok állapotát.
    xor     r0, #0xFF       ; Állapot ellenõrzése
    jnz     wait_release    ; Várunk elengedésre
    mov     r2, #0          ; Pergésmentesítõ késleltetõ számláló

released:    
    add     r2, #1          ; Pergésmentesítõ számláló inkrementálása 
    jc      prell_end0      ; Ha eléri a 255-öt akkor stabil érték
    mov     r0, SW          ; Beolvassuk a kapcsolók állapotát.
    xor     r0, #0xFF       ; Állapot ellenõrzése, ha véletlenül nem mindegyik 1 
    jnz     wait_release    ; akkor nem stabil, visszaugrunk és várunk elengedésre
    jmp     released        ; Stabil érték ellenérzése    
    
prell_end0:
    jmp     wait_press       ; Várakozás újabb aktiválásra
 

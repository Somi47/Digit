;*******************************************************************************
;* Labor 9_1a feladat:                                                         *
;* A kapcsol�k programozott perg�smenets�t�se                                  *
;* Alap�llapotban minden kapcsol� 1 �llapot�. (8 biten ez 0xFF). V�rakozunk    *
;* b�rmelyik kapcsol� megnyom�s�ra, azaz egy 1->0 �tmenetre. Ha ez megt�rt�nik,*
;* akkor egy �jabb sz�ml�l� ciklus indul �s v�runk arra, hogy adott ideig      *
;* egyfolyt�ban akt�v legyen. Ha egy pillanatra is visszav�lt, �jrakezdj�k     *
;* a figyel�st. Ugyanezt elv�gezz�k a 0->1 �tmenetn�l is                       *
;*******************************************************************************
DEF LD  0x80                ; LED regiszter          (�rhat�/olvashat�)
DEF SW  0x81                ; DIP kapcsol� regiszter (csak olvashat�)

    CODE

start:
    mov     r1, #0          ; Sz�ml�l� t�rl�se
wait_press:  
    mov     r0, SW          ; Beolvassuk a kapcsol�k �llapot�t.
    xor     r0, #0xFF       ; �llapot ellen�rz�se, ha mindegyik 1 
    jz      wait_press      ; akkor v�runk aktiv�l�sra
    mov     r2, #0          ; Perg�smentes�t� k�sleltet� sz�ml�l�

pressed:    
    add     r2, #1          ; Perg�smentes�t� sz�ml�l� inkrement�l�sa 
    jc      prell_end1      ; Ha el�ri a 255-�t akkor stabil �rt�k
    mov     r0, SW          ; Beolvassuk a kapcsol�k �llapot�t.
    xor     r0, #0xFF       ; �llapot ellen�rz�se, ha v�letlen�l mindegyik 1 
    jz      wait_press      ; akkor nem stabil, visszaugrunk �s v�runk aktiv�l�sra
    jmp     pressed         ; Stabil �rt�k ellen�rz�se  
    
prell_end1:    
    add     r1, #1          ; Az �rv�nyes megnyom�s sz�ml�l� inkrement�l�sa
    mov     LD, r1          ; �rt�k kijelz�se
    
wait_release:
    mov     r0, SW          ; Beolvassuk a nyom�gombok �llapot�t.
    xor     r0, #0xFF       ; �llapot ellen�rz�se
    jnz     wait_release    ; V�runk elenged�sre
    mov     r2, #0          ; Perg�smentes�t� k�sleltet� sz�ml�l�

released:    
    add     r2, #1          ; Perg�smentes�t� sz�ml�l� inkrement�l�sa 
    jc      prell_end0      ; Ha el�ri a 255-�t akkor stabil �rt�k
    mov     r0, SW          ; Beolvassuk a kapcsol�k �llapot�t.
    xor     r0, #0xFF       ; �llapot ellen�rz�se, ha v�letlen�l nem mindegyik 1 
    jnz     wait_release    ; akkor nem stabil, visszaugrunk �s v�runk elenged�sre
    jmp     released        ; Stabil �rt�k ellen�rz�se    
    
prell_end0:
    jmp     wait_press       ; V�rakoz�s �jabb aktiv�l�sra
 

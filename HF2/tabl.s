DEF LD  0x80                ; LED adatregiszter (�rhat�/olvashat�)

; digit k�d: 4136275 -> 4 5 1 4 3 9 6 8 2 9 7 C 5

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
    mov r1, #0x00  ; Ciklus iter�tor, az olvasand� mem�riac�m helye
    mov r2, #0x07 ; Kil�p�si felt�tel
loop:
    cmp r2, r1    ; Kil�p�si felt�tel ellenorz�se
    jz  loop_end
    mov r0, (r1)   ; Memoria beolvas�sa
    mov r15, #0x00 ; Sz�ml�l� ciklusunk�nti null�z�sa
    ; Shiftel�s, �s ha 1-es volt shiftelve, akkor inkrement�l�s
    ; Ciklusva szervezve is lehetne, de nem lenne sokkal r�videbb
    sl0 r0
    adc r15, #0x00 ; Inkrement�l�s
    sl0 r0
    adc r15, #0x00 ; Inkrement�l�s
    sl0 r0
    adc r15, #0x00 ; Inkrement�l�s
    sl0 r0
    adc r15, #0x00 ; Inkrement�l�s
    sl0 r0
    adc r15, #0x00 ; Inkrement�l�s
    sl0 r0
    adc r15, #0x00 ; Inkrement�l�s
    sl0 r0
    adc r15, #0x00 ; Inkrement�l�s
    sl0 r0
    adc r15, #0x00 ; Inkrement�l�s
    
    mov (r1), r15 ; A
    
    add r1, #0x01 ; Ciklus iter�tor n�vel�se
    jmp loop
loop_end:
    mov LD, r15  ; Ledeken megjelen�t�s

    


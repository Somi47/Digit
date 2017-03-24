DEF LD 0x80 ; a LED Regiszter
DEF SW 0x81 ; a DIP kapcsoló

CODE
start:
    mov r0, SW    ; DIP kapcsoló beolvasása regiszterbve
    ;
        mov r1, r0
        and r0, #0x0F
        and r1, #0xF0
        swp r1
        add r0, r1    ;kityikutyi
    ;
    mov LD, r0    ; Regiszter kiírása LED-re
    jmp start     ; start cimkéhez ugrás


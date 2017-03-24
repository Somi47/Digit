DEF LD 0x80 ; a LED Regiszter
DEF SW 0x81 ; a DIP kapcsol�

CODE
start:
    mov r0, SW    ; DIP kapcsol� beolvas�sa regiszterbve
    ;
        mov r1, r0
        and r0, #0x0F
        and r1, #0xF0
        swp r1
        add r0, r1    ;kityikutyi
    ;
    mov LD, r0    ; Regiszter ki�r�sa LED-re
    jmp start     ; start cimk�hez ugr�s


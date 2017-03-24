DEF LD   0x80                ; LED adatregiszter                    (�rhat�/olvashat�)
DEF SW   0x81                ; DIP kapcsol� adatregiszter           (csak olvashat�)
DEF BT   0x84                ; Nyom�gomb adatregiszter              (csak olvashat�)

start:
    mov r0, #0x00
loop:
    mov LD, r0
    xor r0, #0xFF
    
    cnt_24:
        mov r10, #0
        mov r11, #0
        mov r12, #0
    cnt_loop:
        add r10, #24
        adc r11, #0
        adc r12, #0
        jnc cnt_loop
    
    jmp loop
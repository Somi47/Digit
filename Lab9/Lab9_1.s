DEF LD  0x80                ; LED adatregiszter          (írható/olvasható)
DEF SW  0x81                ; DIP kapcsoló adatregiszter (csak olvasható)
DEF BT  0x84

start:
    mov r0, #0
wait1:
    mov r1, BT
    cmp r1, #0x00
    jz  wait1
display:
    add r0, #1
    mov LD, r0
wait2:
    mov r1, BT
    cmp r1, #0x00
    jnz wait2
    jmp wait1
    
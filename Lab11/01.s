DEF UC  0x88                ; USRT kontroll regiszter     (csak �rhat�)
DEF US  0x89                ; USRT FIFO st�tusz regiszter (csak olvashat�)
DEF UIE 0x8A                ; USRT megszak�t�s eng. reg.  (�rhat�/olvashat�)
DEF UD  0x8B                ; USRT adatregiszter          (�rhat�/olvashat�)

    DATA
neptun:
    DB "WGGAW5\r\n", 0
longstr:   
    DB "Szeretem a kutyusokat simogatni, de ez nem el�g hosszu\r\n", 0
    
    CODE
start:
    mov r0, #0x05
    mov UC, r0
    mov r1, #longstr
loop_read:
    mov r0, (r1)
    cmp r0, #0x00
    jz end
    wait:
        mov r2, US
        and r2, #0x02
        jz wait
    
    mov UD, r0
    add r1, #0x01
    jmp loop_read
end:
    jmp end
    
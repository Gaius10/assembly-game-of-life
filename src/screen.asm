screenUpdate:
    push r1
    push r2
    push r3

    loadn r1, #1200
    loadn r2, #scenario

    ;; A ideia é desenhar de trás pra frente
    add r2, r2, r1
    inc r1

    ;; for (int i = 1200; i > 0; i--): printf(scenario[i])
    _screenUpdate_loop:
        loadi r3, r2
        outchar r3, r1

        _screenUpdate_loop_end:
            dec r2
            dec r1
            jnz _screenUpdate_loop

    ;; por conta do jump if not zero...
    outchar r3, r1

    pop r3
    pop r2
    pop r1
    rts

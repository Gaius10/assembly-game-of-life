liveUpdate:
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadn r1, #1199
    loadn r2, #2
    loadn r3, #3
    loadn r4, #' '
    loadn r5, #'#'

    ;; for (int i = 1200; i > 0; i--):
    _liveUpdate_loop:
        ;; r0 = liveCountNeighbors(r7: cell_position)
        mov r7, r1
        call liveCountNeighbors

        ;; comparison for first if's
        cmp r0, r2

        loadn r6, #scenario_tmp
        add r6, r6, r1

        ;; n_neighbors < 2 -> cell dies (underpopulation)
        ;; if (r0 < 2): scenario[i] = ' '
        _liveUpdate_loop_underpopulation:
            jeg _liveUpdate_loop_lives
            storei r6, r4
            jmp _liveUpdate_loop_end
            ;;

        ;; n_neighbors is 2 or 3 -> cell lives
        ;; if (r0 == 2 || r0 == 3): scenario[i] = scenario[i]
        _liveUpdate_loop_lives:
            jeq _liveUpdate_loop_end
            ;; no need to do anything...

        ;; comparison for the last if's
        cmp r0, r3

        ;; n_neighbors > 3 -> cell dies (overpopulation)
        ;; if (r0 > 3): scenario[i] = ' '
        _liveUpdate_loop_overpopulation:
            jel _liveUpdate_loop_reproduction
            storei r6, r4
            jmp _liveUpdate_loop_end
            ;;

        ;; n_neighbors exactly 3 -> reproduction
        ;; if (r0 == 3): scenario[i] = '#'
        _liveUpdate_loop_reproduction:
            jne _liveUpdate_loop_end
            storei r6, r5
            ;;

        _liveUpdate_loop_end:
            dec r1
            jnz _liveUpdate_loop

    ;; calc for i == 0
    mov r7, r1
    call liveCountNeighbors
    loadn r6, #scenario

    cmp r0, r2
    jeq _liveUpdate_end
    jgr _liveUpdate_last_reproduces
    jle _liveUpdate_last_dies

    _liveUpdate_last_dies:
        storei r6, r4
        jmp _liveUpdate_end
        ;;

    _liveUpdate_last_reproduces:
        storei r6, r5
        jmp _liveUpdate_end
        ;;

    _liveUpdate_end:
        ;;

    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    rts

;;
;; @param r7: cell position
;;
liveCountNeighbors:
    push r1         ;; aux
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7         ;; a.k.a.: x

    loadn r0, #0    ;; a.k.a.: counter
    loadn r1, #41
    loadn r2, #40
    loadn r3, #39
    loadn r4, #'#'
    loadn r5, #scenario
    ;; r6 <- *scenario

    ;; if (x >= 41 and scenario[x-41] == '#'): counter++
    _liveCountNeighbors_1:
        ;; if (x < 41): goto next case
        cmp r7, r1
        jle _liveCountNeighbors_2

        ;; if (scenario[x-41] == '#'): counter++
        sub r7, r7, r1
        add r6, r5, r7
        loadi r6, r6
        cmp r6, r4
        jne _liveCountNeighbors_1_reset

        inc r0

        _liveCountNeighbors_1_reset:
            pop r7
            push r7
            ;;

        ;;

    ;; if (x >= 40 and scenario[x-40] == '#'): counter++
    _liveCountNeighbors_2:
        ;; if (x < 40): goto next case
        cmp r7, r2
        jle _liveCountNeighbors_3

        ;; if (scenario[x-40] == '#'): counter++
        sub r7, r7, r2
        add r6, r5, r7
        loadi r6, r6
        cmp r6, r4
        jne _liveCountNeighbors_2_reset

        inc r0

        _liveCountNeighbors_2_reset:
            pop r7
            push r7
            ;;

        ;;

    ;; if (x >= 39 and scenario[x-39] == '#'): counter++
    _liveCountNeighbors_3:
        ;; if (x < 39): goto next case
        cmp r7, r3
        jle _liveCountNeighbors_4

        ;; if (scenario[x-39] == '#'): counter++
        sub r7, r7, r3
        add r6, r5, r7
        loadi r6, r6
        cmp r6, r4
        jne _liveCountNeighbors_3_reset

        inc r0

        _liveCountNeighbors_3_reset:
            pop r7
            push r7
            ;;

        ;;

    ;; if (x >= 1 and scenario[x-1] == '#'): counter++
    _liveCountNeighbors_4:
        ;; if (x < 1): goto next case
        inc r7
        dec r7
        jz _liveCountNeighbors_5

        ;; if (scenario[x-1] == '#'): counter++
        dec r7
        add r6, r5, r7
        loadi r6, r6
        cmp r6, r4
        jne _liveCountNeighbors_4_reset

        inc r0

        _liveCountNeighbors_4_reset:
            inc r7
            ;;

        ;;

    ;; if (x < 1199 and scenario[x+1] == '#'): counter++
    _liveCountNeighbors_5:
        ;; if (x > 1998): goto next case
        push r1
        loadn r1, #1998
        cmp r7, r1
        jgr _liveCountNeighbors_6

        ;; if (scenario[x+1] == '#'): counter++
        inc r7
        add r6, r5, r7
        loadi r6, r6
        cmp r6, r4
        jne _liveCountNeighbors_5_reset

        inc r0

        _liveCountNeighbors_5_reset:
            pop r1
            pop r7
            push r7
            push r1
            ;;

        ;;

    ;; if (x + 41 < 1200 and scenario[x + 41] == '#'): counter++
    _liveCountNeighbors_6:
        pop r1

        ;; if (x > 1158): goto next case
        push r2
        loadn r2, #1158
        cmp r7, r2
        jgr _liveCountNeighbors_7

        ;; if (scenario[x+41] == '#'): counter++
        add r7, r7, r1
        add r6, r5, r7
        loadi r6, r6
        cmp r6, r4
        jne _liveCountNeighbors_6_reset

        inc r0

        _liveCountNeighbors_6_reset:
            pop r2
            pop r7
            push r7
            push r2
            ;;

        ;;

    ;; if (x + 40 < 1200 and scenario[x + 40] == '#'): counter++
    _liveCountNeighbors_7:
        pop r2

        ;; if (x > 1159): goto next case
        push r1
        loadn r1, #1159
        cmp r7, r1
        jgr _liveCountNeighbors_8

        ;; if (scenario[x+40] == '#'): counter++
        add r7, r7, r2
        add r6, r5, r7
        loadi r6, r6
        cmp r6, r4
        jne _liveCountNeighbors_7_reset

        inc r0

        _liveCountNeighbors_7_reset:
            pop r1
            pop r7
            push r7
            push r1
            ;;

        ;;

    ;; if (x + 39 < 1200 and scenario[x + 39] == '#'): counter++
    _liveCountNeighbors_8:
        ; pop r1
        ; push r1

        ;; if (x > 1160): goto next case (end)
        loadn r1, #1160
        cmp r7, r1
        jgr _liveCountNeighbors_end

        ;; if (scenario[x+39] == '#'): counter++
        add r7, r7, r2
        add r6, r5, r7
        loadi r6, r6
        cmp r6, r4
        jne _liveCountNeighbors_8_reset

        inc r0

        _liveCountNeighbors_8_reset:
            ;;

        ;;

    _liveCountNeighbors_end:
        pop r1
        ;;

    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    rts
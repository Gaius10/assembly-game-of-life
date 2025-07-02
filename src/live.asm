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
        ;; num_of_neighbors(cell) == #2
        cmp r0, r2

        loadn r6, #scenario_buffer
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

    ; ;; calc for i == 0
    ; mov r7, r1
    ; call liveCountNeighbors
    ; loadn r6, #scenario

    ; cmp r0, r2
    ; jeq _liveUpdate_end
    ; jgr _liveUpdate_last_reproduces
    ; jle _liveUpdate_last_dies

    ; _liveUpdate_last_dies:
    ;     storei r6, r4
    ;     jmp _liveUpdate_end
    ;     ;;

    ; _liveUpdate_last_reproduces:
    ;     storei r6, r5
    ;     jmp _liveUpdate_end
    ;     ;;

    _liveUpdate_end:
        call liveFlushScenarioBuffer
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
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadn r0, #0 ;; a.k.a. counter
    loadn r1, #scenario

    ;; if (scenario[x-41] == '#'): counter++
    _liveCountNeighbors_1:
        ;; At the FIRST LINE, this neighbor doesn't exist
        ;; if (x < 40): goto next case
        loadn r2, #40
        cmp r7, r2
        jle _liveCountNeighbors_2

        ;; At the FIRST COLUMN, this neighbor doesn't exist
        ;; if (x % 40 == 0): goto next case
        loadn r2, #40
        mod r6, r7, r2

        loadn r2, #0
        cmp r2, r6
        jeq _liveCountNeighbors_2

        ;; Increment counter if scenario[x-41] is alive
        ;; if (scenario[x-41] == '#'): counter++
        loadn r2, #41
        sub r6, r7, r2
        add r6, r1, r6

        loadi r2, r6
        loadn r3, #'#'
        cmp r2, r3
        jne _liveCountNeighbors_2

        inc r0

    ;; if (scenario[x-40] == '#'): counter++
    _liveCountNeighbors_2:
        ;; At the FIRST LINE, this neighbor doesn't exist
        ;; if (x < 40): goto next case
        loadn r2, #40
        cmp r7, r2
        jle _liveCountNeighbors_3

        ;; Increment counter if scenario[x-40] is alive
        ;; if (scenario[x-40] == '#'): counter++
        loadn r2, #40
        sub r6, r7, r2
        add r6, r1, r6

        loadi r2, r6
        loadn r3, #'#'
        cmp r2, r3
        jne _liveCountNeighbors_3

        inc r0
        ;;


    _liveCountNeighbors_3:
        ;; At the FIRST LINE, this neighbor doesn't exist
        ;; if (x < 40): goto next case
        loadn r2, #40
        cmp r7, r2
        jle _liveCountNeighbors_4

        ;; At the LAST COLUMN, this neighbor doesn't exist
        ;; if (x % 40 == 39): goto next case
        loadn r2, #40
        mod r6, r7, r2

        loadn r2, #39
        cmp r2, r6
        jeq _liveCountNeighbors_4

        ;; Increment counter if scenario[x-39] is alive
        ;; if (scenario[x-39] == '#'): counter++
        loadn r2, #39
        sub r6, r7, r2
        add r6, r1, r6

        loadi r2, r6
        loadn r3, #'#'
        cmp r2, r3
        jne _liveCountNeighbors_4

        inc r0
        ;;

    _liveCountNeighbors_4:
        ;; At the FIRST COLUMN, this neighbor doesn't exist
        ;; if (x % 40 == 0): goto next case
        loadn r2, #40
        mod r6, r7, r2

        loadn r2, #0
        cmp r2, r6
        jeq _liveCountNeighbors_5

        ;; Increment counter if scenario[x-1] is alive
        ;; if (scenario[x-1] == '#'): counter++
        loadn r2, #1
        sub r6, r7, r2
        add r6, r1, r6

        loadi r2, r6
        loadn r3, #'#'
        cmp r2, r3
        jne _liveCountNeighbors_5

        inc r0
        ;;

    _liveCountNeighbors_5:
        ;; At the LAST COLUMN, this neighbor doesn't exist
        ;; if (x % 40 == 39): goto next case
        loadn r2, #40
        mod r6, r7, r2

        loadn r2, #39
        cmp r2, r6
        jeq _liveCountNeighbors_6

        ;; Increment counter if scenario[x+1] is alive
        ;; if (scenario[x+1] == '#'): counter++
        loadn r2, #1
        add r6, r7, r2
        add r6, r1, r6

        loadi r2, r6
        loadn r3, #'#'
        cmp r2, r3
        jne _liveCountNeighbors_6

        inc r0
        ;;

    _liveCountNeighbors_6:
        ;; At the LAST LINE, this neighbor doesn't exist
        ;; if (x > 1159): goto next case
        loadn r2, #1159
        cmp r7, r2
        jgr _liveCountNeighbors_7

        ;; At the FIRST COLUMN, this neighbor doesn't exist
        ;; if (x % 40 == 0): goto next case
        loadn r2, #40
        mod r6, r7, r2

        loadn r2, #0
        cmp r2, r6
        jeq _liveCountNeighbors_7

        ;; Increment counter if scenario[x+39] is alive
        ;; if (scenario[x+39] == '#'): counter++
        loadn r2, #39
        add r6, r7, r2
        add r6, r1, r6

        loadi r2, r6
        loadn r3, #'#'
        cmp r2, r3
        jne _liveCountNeighbors_7

        inc r0
        ;;

    _liveCountNeighbors_7:
        ;; At the LAST LINE, this neighbor doesn't exist
        ;; if (x > 1159): goto next case
        loadn r2, #1159
        cmp r7, r2
        jgr _liveCountNeighbors_8

        ;; Increment counter if scenario[x+40] is alive
        ;; if (scenario[x+40] == '#'): counter++
        loadn r2, #40
        add r6, r7, r2
        add r6, r1, r6

        loadi r2, r6
        loadn r3, #'#'
        cmp r2, r3
        jne _liveCountNeighbors_8

        inc r0
        ;;
        ;;

    _liveCountNeighbors_8:
        ;; At the LAST LINE, this neighbor doesn't exist
        ;; if (x > 1159): goto next case
        loadn r2, #1159
        cmp r7, r2
        jgr _liveCountNeighbors_end

        ;; At the LAST COLUMN, this neighbor doesn't exist
        ;; if (x % 40 == 39): goto next case
        loadn r2, #40
        mod r6, r7, r2

        loadn r2, #39
        cmp r2, r6
        jeq _liveCountNeighbors_end

        ;; Increment counter if scenario[x+41] is alive
        ;; if (scenario[x+41] == '#'): counter++
        loadn r2, #41
        add r6, r7, r2
        add r6, r1, r6

        loadi r2, r6
        loadn r3, #'#'
        cmp r2, r3
        jne _liveCountNeighbors_end

        inc r0
        ;;

    _liveCountNeighbors_end:
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
;; Atualiza mapa de scenario principal
;;
liveFlushScenarioBuffer:
    push r0
    push r1
    push r2
    push r3

    loadn r0, #scenario
    loadn r1, #scenario_buffer
    loadn r2, #1200

    _liveFlushScenarioBuffer_loop:
        loadi r3, r1
        storei r0, r3

        inc r0
        inc r1
        dec r2
        jnz _liveFlushScenarioBuffer_loop
        ;;

    pop r3
    pop r2
    pop r1
    pop r0
    rts

liveUpdate:
    push r1
    push r7

    loadn r1, #1200

    ;; for (int i = 1200; i > 0; i--):
    _liveUpdate_loop:
        ;; r0 = liveCountNeighbors(r7: cell_position)
        mov r7, r1
        call liveCountNeighbors

        ;; n_neighbors < 2 -> cell dies (underpopulation)
        ;; if (r0 < 2): scenario[i] = ' '

        ;; n_neighbors is 2 or 3 -> cell lives
        ;; if (r0 < 2): scenario[i] = scenario[i]

        ;; n_neighbors > 3 -> cell dies (overpopulation)
        ;; if (r0 < 2): scenario[i] = ' '

        ;; n_neighbors exactly 3 -> reproduction
        ;; if (r0 == 3): scenario[i] = '#'

        _liveUpdate_loop_end:
            dec r1
            jnz _liveUpdate_loop

    ;; calc for i == 0
    ;; ...

    pop r7
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
    loadn r1, r7
    loadn r2, #41
    loadn r3, #40
    loadn r4, #39
    loadn r5, #'#'
    loadn r6, #scenario

    ;; if (x - 41 > 0 and scenario[x - 41] == '#'): counter++
    _liveCountNeighbors_1:
        ;;

    ;; if (x - 40 > 0 and scenario[x - 40] == '#'): counter++
    _liveCountNeighbors_2:
        ;;

    ;; if (x - 39 > 0 and scenario[x - 39] == '#'): counter++
    _liveCountNeighbors_3:
        ;;

    ;; if (x - 1) > 0 and scenario[x - 1] == '#'): counter++
    _liveCountNeighbors_4:
        ;;

    ;; if (x + 1) < 1200 and scenario[x + 1] == '#'): counter++
    _liveCountNeighbors_5:
        ;;

    ;; if (x + 41 < 1200 and scenario[x + 41] == '#'): counter++
    _liveCountNeighbors_6:
        ;;

    ;; if (x + 40 < 1200 and scenario[x + 40] == '#'): counter++
    _liveCountNeighbors_7:
        ;;

    ;; if (x + 39 < 1200 and scenario[x + 39] == '#'): counter++
    _liveCountNeighbors_8:
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

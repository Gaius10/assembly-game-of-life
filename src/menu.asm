;; #requires src/screenUpdate.asm
;; #requires src/init.asm
;; #requires src/clock.asm
;; #requires config/menu.asm

menuStart:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadn r1, #13

    _menuStart_loop:
        loadn r7, #START_MENU_01_L00
        call initGameScenario
        call screenUpdate
        call clockDelay

        inchar r0
        cmp r0, r1
        jeq _menuStart_end

        loadn r7, #START_MENU_02_L00
        call initGameScenario
        call screenUpdate
        call clockDelay

        inchar r0
        cmp r0, r1
        jeq _menuStart_end

        loadn r7, #START_MENU_03_L00
        call initGameScenario
        call screenUpdate
        call clockDelay

        inchar r0
        cmp r0, r1
        jeq _menuStart_end

        loadn r7, #START_MENU_04_L00
        call initGameScenario
        call screenUpdate
        call clockDelay

        inchar r0
        cmp r0, r1
        jeq _menuStart_end

        jmp _menuStart_loop
        ;;

    _menuStart_end:
        ;;

    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

menuSelectScenarioId:
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadn r1, #482 ;; a.k.a. cursor_position
    loadn r7, #SCENARIO_SELECTION_MENU_L00
    call initGameScenario
    call screenUpdate

    _menuSelectScenario_loop:
        call menuReadChar
        _menuSelectScenario_up:
            ;; if (input != 'w') goto test down command
            loadn r3, #'w'
            cmp r0, r3
            jne _menuSelectScenario_down

            ;; if (cursor_position <= 482): goto loop
            loadn r5, #482
            cmp r1, r5
            jel _menuSelectScenario_loop

            ;; cursor_position += 40
            loadn r4, #40
            sub r1, r1, r4
            mov r7, r1
            outchar r0, r7
            call menuUpdateCursor
            jmp _menuSelectScenario_loop
            ;;

        _menuSelectScenario_down:
            ;; if (input != 's'): goto test enter command
            loadn r3, #'s'
            cmp r0, r3
            jne _menuSelectScenario_enter

            ;; if (cursor_position >= 762): goto loop
            loadn r5, #722
            cmp r1, r5
            jeg _menuSelectScenario_loop

            ;; cursor_position -= 40
            loadn r4, #40
            add r1, r1, r4
            mov r7, r1
            call menuUpdateCursor
            jmp _menuSelectScenario_loop
            ;;
        
        _menuSelectScenario_enter:
            loadn r3, #13
            cmp r0, r3
            jne _menuSelectScenario_loop
            jmp _menuSelectScenario_end
            ;;
        ;;

    _menuSelectScenario_end:
        loadn r5, #480
        sub r0, r1, r5
        loadn r5, #40
        div r0, r0, r5
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
;; @param r7: cursor position
;;
menuUpdateCursor:
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadn r1, #482
    loadn r2, #7
    loadn r3, #39
    loadn r4, #' '

    _menuUpdateCursor_clearLoop:
        outchar r4, r1
        inc r1
        outchar r4, r1
        add r1, r1, r3

        dec r2
        jnz _menuUpdateCursor_clearLoop
        ;;

    loadn r1, #'-'
    loadn r2, #'>'
    outchar r1, r7
    inc r7
    outchar r2, r7

    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    rts

menuReadChar:
    push r7
    push r6

    loadn r7, #255 ;; processador sempre retorna 255 se nenhuma tecla for lida
    loadn r6, #0   ;; processador sempre retorna 0 no instante em que alguma tecla for lida, a próxima leitura é o valor da tecla

    _menuReadChar_loop:
        inchar r0

        ;; compara com 255
        cmp r0, r7
        jeq _menuReadChar_loop

        ;; compara com 0
        cmp r0, r6
        jeq _menuReadChar_loop

    pop r6
    pop r7
    rts

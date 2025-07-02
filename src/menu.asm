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

    _menuStart_loop:
        loadn r7, #START_MENU_01_L00
        call initGameScenario
        call screenUpdate
        call clockDelay
        call clockDelay

        loadn r7, #START_MENU_02_L00
        call initGameScenario
        call screenUpdate
        call clockDelay
        call clockDelay

        loadn r7, #START_MENU_03_L00
        call initGameScenario
        call screenUpdate
        call clockDelay
        call clockDelay

        jmp _menuStart_loop
        ;;

    _menuStart_end:
        ;;

    pop r0
    pop r1
    pop r2
    pop r3
    pop r4
    pop r5
    pop r6
    pop r7
    rts
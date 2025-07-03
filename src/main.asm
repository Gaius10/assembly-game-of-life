jmp main

clock: var #1
scenario: var #1200
scenario_buffer: var #1200

main:
    call menuStart
    call menuSelectScenarioId

    mov r7, r0
    call initGame

    ;;
    ; Loop principal
    ;;
    main_loop:
        call clockDelay
        call liveUpdate
        call screenUpdate

        jmp main_loop
    halt

;; #include src/menu.asm
;; #include src/init.asm
;; #include src/clock.asm
;; #include src/screen.asm
;; #include src/live.asm

;; #include config/general.asm
;; #include config/menu.asm
;; #include config/scenario01.asm
;; #include config/scenario02.asm
;; #include config/scenario03.asm
;; #include config/scenario04.asm
;; #include config/scenario05.asm
;; #include config/scenario06.asm
;; #include config/scenario07.asm

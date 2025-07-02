jmp main

clock: var #1
scenario: var #1200
scenario_buffer: var #1200

main:
    call menuStart
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
;; #include config/scenarios.asm

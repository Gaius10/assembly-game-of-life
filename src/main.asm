jmp main

clock: var #1
scenario: var #1200
scenario_tmp: var #1200

main:

    loadn r1, #tela4Linha0 ;Endereco onde comeca a primeira linha do cenario
	loadn r2, #30720       ;cor cinza
	call ImprimeTela

    Loopmenu:
		inchar r4
		loadn r1, #13           ;tecla enter
		
		inc r2                  ;faz a soma aleatória para dar o rand

		cmp r4, r1
		jne Loopmenu

		loadn r5, #40           ;limita o valor para ficar entre 0 e 39
		mod r3, r2, r5
    
    call ApagaTela

    call initGame

    ;;
    ;; Loop principal
    ;;

    main_loop:
        call clockDelay
        call liveUpdate
        call copyScenario
        call screenUpdate
        jmp main_loop

    halt

;; #include src/init.asm
;; #include src/clock.asm
;; #include src/screen.asm
;; #include src/live.asm

;; #include config/general.asm
;; #include config/screen.asm

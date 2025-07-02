;;
;; Inicializa todas as variáveis necessárias.
;; Essa função deve ser chamada apenas uma vez, no início de cada simulação.
;;
initGame:
    push r0
    push r7

    ;; Zera clock
    loadn r0, #0
    store clock, r0

    ;; Carrega mapa de cenário
    ;; initGameScenario(r7: scenario_config)
    loadn r7, #SCENARIO4_L01
    call initGameScenario

    ;; Desenha tela inicial
    call screenUpdate

    pop r7
    pop r0
    rts

;;
;; @param r7 endereço do início da primeira linha do cenário
;;
initGameScenario:
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7 ;; a.k.a.: scenario_config

    loadn r1, #scenario
    loadn r2, #scenario_buffer
    loadn r3, #'\0'
    loadn r4, #1230 ; 1200 linhas + 30 \0

    ;; for (int i = 0; i < 1200; i++):
    _initGameScenario_loop:
        ;; if (scenario_config[i] == '\0'): continue
        loadi r5, r7
        cmp r5, r3
        jeq _initGameScenario_loop_end

        ;; else: scenario[i] = scenario_config[i]
        storei r1, r5
        storei r2, r5
        inc r1
        inc r2

        _initGameScenario_loop_end:
            inc r7
            dec r4
            jnz _initGameScenario_loop

    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    rts

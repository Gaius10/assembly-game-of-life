CENARIO1_L01: string "########################################"
CENARIO1_L02: string "########################################"
CENARIO1_L03: string "########################################"
CENARIO1_L04: string "#########                     ##########"
CENARIO1_L05: string "#########                     ##########"
CENARIO1_L06: string "#########                     ##########"
CENARIO1_L07: string "#########                     ##########"
CENARIO1_L08: string "#########                     ##########"
CENARIO1_L09: string "#########                     ##########"
CENARIO1_L10: string "#########                     ##########"
CENARIO1_L11: string "#########                     ##########"
CENARIO1_L12: string "#########                     ##########"
CENARIO1_L13: string "#########                     ##########"
CENARIO1_L14: string "#########                     ##########"
CENARIO1_L15: string "#########                     ##########"
CENARIO1_L16: string "#########                     ##########"
CENARIO1_L17: string "#########                     ##########"
CENARIO1_L18: string "#########                     ##########"
CENARIO1_L19: string "#########                     ##########"
CENARIO1_L20: string "#########                     ##########"
CENARIO1_L21: string "########################################"
CENARIO1_L22: string "########################################"
CENARIO1_L23: string "########################################"
CENARIO1_L24: string "########################################"
CENARIO1_L25: string "########################################"
CENARIO1_L26: string "########################################"
CENARIO1_L27: string "########################################"
CENARIO1_L28: string "########################################"
CENARIO1_L29: string "########################################"
CENARIO1_L30: string "########################################"

copyScenario:
    push r0
    push r1
    push r2
    loadn r0, #1200
    loadn r1, #scenario_tmp
    loadn r2, #scenario

copyScenario_loop:
    loadi r3, r1
    storei r2, r3
    inc r1
    inc r2
    dec r0
    jnz copyScenario_loop

    pop r2
    pop r1
    pop r0
    rts

ImprimeTela:
	;r1 = endereco onde comeca a primeira linha do Cenario
	;r2 = cor do Cenario para ser impresso

	push r0	
	push r1	
	push r2	
	push r3	
	push r4
	push r5

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	
   ImprimeTela_Loop:
		call ImprimeStr
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela_Loop	; Enquanto r0 < 1200

	pop r5	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

ImprimeStr:	 
    ;r0 = Posicao da tela que o primeiro caractere da mensagem será impresso 
    ;r1 = endereco onde comeca a mensagem
    ;r2 = cor da mensagem

	push r0	
	push r1	
	push r2	
	push r3	
	push r4
	
	loadn r3, #'\0'	; Criterio de parada

   ImprimeStr_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr_Sai
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		jmp ImprimeStr_Loop
	
   ImprimeStr_Sai:	
	pop r4	
	pop r3
	pop r2
	pop r1
	pop r0
	rts

ApagaTela:
	push r0
	push r1
	
	loadn r0, #1200		; apaga as 1200 posicoes da Tela
	loadn r1, #' '		; com "espaco"
	
	   ApagaTela_Loop:	;;label for(r0=1200;r3>0;r3--)
		dec r0
		outchar r1, r0
		jnz ApagaTela_Loop
 
	pop r1
	pop r0
	rts	

;Tela menu:
tela4Linha0 : string  "########################################"
tela4Linha1 : string  "#                                      #"
tela4Linha2 : string  "#  ###  #   ##  #     ##   #           #"
tela4Linha3 : string  "#   #  # # #   # #    # # # #          #"
tela4Linha4  : string "#    # # # # # # #    # # ###          #"
tela4Linha5  : string "#  # # # # # # # #    # # # #          #"     
tela4Linha6  : string "#   #   #   #   #     ##  # #          #"
tela4Linha7  : string "#                                      #"
tela4Linha8  : string "#  # # # ##   #                        #"
tela4Linha9  : string "#  # # # # # # #                       #"
tela4Linha10 : string "#  # # # # # ###                       #"
tela4Linha11 : string "#  # # # # # # #                       #"
tela4Linha12 : string "#   #  # ##  # #                       #"
tela4Linha13 : string "#                                      #"
tela4Linha14 : string "#  -> Pressione a tecla                #"
tela4Linha15 : string "#  enter para continuar                #"
tela4Linha16 : string "#                                      #"
tela4Linha17 : string "#                                      #"
tela4Linha18 : string "#                                      #"
tela4Linha19 : string "#                                      #"
tela4Linha20 : string "#                                      #"
tela4Linha21 : string "#                                      #"
tela4Linha22 : string "#                    @@    @@@  @@ @@  #"
tela4Linha23 : string "# @  @@   @@  @@@  @@@@  @@@ @@@  @ @@ #"
tela4Linha24 : string "# @@  @@@  @@@  @@@@   @@@   @ @  @@ @@#"
tela4Linha25 : string "#  @@@@ @@@@@ @ @ @@@@@@  @@@  @@  @@  #"
tela4Linha26 : string "#@@@@@  @@@@@@@@ @@@@@@@@@@@@@ @@@@@@@@#"
tela4Linha27 : string "#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#"
tela4Linha28 : string "#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#"
tela4Linha29 : string "########################################"
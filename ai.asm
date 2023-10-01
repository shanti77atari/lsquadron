//AI przeciwników
;ai_test = 1
				
.local AI
sprite_ruch		org *+MAX_SPRITES		;typ ruchu 0=brak, 1=prosta, 2=łuk
sprite_ruch_X	org *+MAX_SPRITES		;prędkość liniowa X
sprite_ruch_DX	org *+MAX_SPRITES	
sprite_ruch_Y	org *+MAX_SPRITES		;predkość liniowa Y
sprite_ruch_DY	org *+MAX_SPRITES
sprite_path_nr	org *+MAX_SPRITES		;nr wybranej ścieżki
sprite_path_licznik_rozkazow org *+MAX_SPRITES	;ile pozostało do wykonia zwykłych ruchów (prosta,łuk)
sprite_path_licznik	org *+MAX_SPRITES	;pozycja w ściezce, max=255
sprite_path_powtorz	org *+MAX_SPRITES	;ilosć powtórzeń sekcji move
sprite_path_powtorz_licznik	org *+MAX_SPRITES	;pozycja w path powtarzanego bloku

;ruch po prostej
sprite_ruch_fazaObrotu	org *+MAX_SPRITES		;jaki ksztalt wybrac
sprite_ruch_ileRamek		org *+MAX_SPRITES		;ile ramek ma trwać ruch
;ruch po łuku
sprite_ruch_zegar		org *+MAX_SPRITES		;zapamietaj kierunek ruchu =1 jak zegar,=255 odwrotnie
sprite_ruch_NRluku		org *+MAX_SPRITES		;zapamietaj numer łuku		0=+x,+y
sprite_ruch_licznik	equ sprite_ruch_ileRamek		;nr w tabeli
sprite_ruch_end		equ sprite_ruch_fazaObrotu	;kiedy koniec łuku
sprite_ruch_adm		org *+MAX_SPRITES				;mlodszy adres tablicy dla łuku
sprite_ruch_ads		org *+MAX_SPRITES				;starszy adres tablicy dla łuku


path_ad_m		dta <path0,<path1,<path2,<path3,<path4,<path5,<path6			;mlodszy bajt adresu ścieżki
				dta <path7,<path8,<path9,<path10,<path11,<path12,<path13
				dta <path14,<path15,<path16,<path17,<path18,<path19,<path20
				dta <path21,<path22,<path23,<path24,<path25,<path26,<path27,<path28
				dta <path29,<path30,<path31,<path32,<path33,<path34,<path35,<path36
				dta <path37,<path38,<path39,<path40,<path41,<path42,<path43,<path44
				dta <path45,<path46,<path47,<path48,<path49,<path50
path_ad_s		dta >path0,>path1,>path2,>path3,>path4,>path5,>path6			;starszy bajt adresu ścieżki 
				dta >path7,>path8,>path9,>path10,>path11,>path12,>path13
				dta >path14,>path15,>path16,>path17,>path18,>path19,>path20
				dta >path21,>path22,>path23,>path24,>path25,>path26,>path27,>path28
				dta >path29,>path30,>path31,>path32,>path33,>path34,>path35,>path36
				dta >path37,>path38,>path39,>path40,>path41,>path42,>path43,>path44
				dta >path45,>path46,>path47,>path48,>path49,>path50

luk_tab		dta a(luk0),a(luk1),a(luk2),a(luk3),a(luk4),a(luk5),a(luk6),a(luk7)			;tablica adresow tablic dla łuków

//speed =(94,2*r):liczba_pozycji		(94,2 odpowiada 256 prędkości liniowej)

luk0	.he 20,02,10,10,10,10,10,12,10,10,12,10,12,00,12,12,10	;male kółko  r=20,32 pozycje  ; speed=(1.57*promien)/pozycje
		.he 02,12,12,00,12,02,12,02,02,12,02,02,02,02,02,10
		
luk1	.he 1d,12,10,02,12,10,12,02,10,02,12,02,12,02,12,02,12		;fragment łuku
		.he 02,12,02,02,02,12,02,04,02,02,02,02,12
		
luk2	.he 28,12,20,10,20,20,12,20,12,20,22,10,22,12,12,22			;okrąg promien=42,40 pozycji
		.he 12,22,12,12,12,12,12,12,14,12,14,12,12,14,02,14
		.he 04,12,04,12,04,04,02,04,12

luk3	.he 3c,12,20,10,20,10,20,12,20,20,12,20,10,22,10,12		;okrąg promień=60,60 pozycji
		.he 22,10,22,12,22,10,12,12,22,12,12,12,22,12,12,12
		.he 12,14,12,12,12,14,12,12,02,14,12,14,02,14,12,02,
		.he 14,02,04,12,04,04,12,04,02,04,02,04,12
		
luk4	.he 32,12,10,10,20,10,10,20,10,12,10,20,12,10,10,22		;okrąg promień=42, 50 pozycji (wolniej niż 2)
		.he 10,12,10,12,10,12,10,12,12,10,12,12,10,12,02,12
		.he 10,12,02,12,12,02,10,02,02,12,02,02,12,02,02,02
		.he 02,02,10

luk5	.he 17,12,10,10,10,10,02,10,12,10,12,12,00,12,12,02,12	;okrąg promień=15;23 pozycje, speed~1
		.he 02,10,02,02,02,02,12
/*
luk6	.he 27,12,10,10,10,10,00,10,12,10,12,10,10,12,10,12,12,00	;okrąg promien=25;39 pozycji, speed~1
		.he 12,10,12,02,12,00,12,12,02,12,02,02,12,02,12,02,00
		.he 02,02,02,02,12
		
luk7	.he 2f,12,10,10,00,10,10,10,12,10,10,12,10,10,12,10,12,10	;okrąg promień=30;47 pozycji; speed~1
		.he 02,10,12,12,10,02,12,10,02,12,12,02,10,02,12,02,12
		.he 02,02,12,02,02,12,02,02,02,00,02,02,12   */
		
;luk5	.he 11,12,10,20,12,10,12,22,10,12,02,14,12,02,12,04,02,12 
luk6	.he 1d,12,10,20,10,10,12,20,12,10,12,22,12,10,12,12,12,02,12	;s=1.3
		.he 14,12,02,12,04,12,02,02,04,02,12
luk7	.he 23,12,10,20,10,10,12,20,10,12,20,12,12,10,12,12,12,12,12
		.he 12,12,12,12,02,12,12,04,12,02,04,12,02,02,04,02,12

tab_DX							;tablica przesuniecia X w ruchu prostym 128b
	.he 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0													;kierunek 0
	MX _S0*P1,_S1*P1,_S2*P1,_S3*P1,_S4*P1,_S5*P1,_S6*P1,_S7*P1
	MX _S0*P3,_S1*P3,_S2*P3,_S3*P3,_S4*P3,_S5*P3,_S6*P3,_S7*P3
	MX _S0*P2,_S1*P2,_S2*P2,_S3*P2,_S4*P2,_S5*P2,_S6*P2,_S7*P2
	MX _S0*P0,_S1*P0,_S2*P0,_S3*P0,_S4*P0,_S5*P0,_S6*P0,_S7*P0			;kierunek 4
	MX _S0*P2,_S1*P2,_S2*P2,_S3*P2,_S4*P2,_S5*P2,_S6*P2,_S7*P2
	MX _S0*P3,_S1*P3,_S2*P3,_S3*P3,_S4*P3,_S5*P3,_S6*P3,_S7*P3
	MX _S0*P1,_S1*P1,_S2*P1,_S3*P1,_S4*P1,_S5*P1,_S6*P1,_S7*P1
	.he 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0													;kierunek 8
	MX -_S0*P1,-_S1*P1,-_S2*P1,-_S3*P1,-_S4*P1,-_S5*P1,-_S6*P1,-_S7*P1
	MX -_S0*P3,-_S1*P3,-_S2*P3,-_S3*P3,-_S4*P3,-_S5*P3,-_S6*P3,-_S7*P3
	MX -_S0*P2,-_S1*P2,-_S2*P2,-_S3*P2,-_S4*P2,-_S5*P2,-_S6*P2,-_S7*P2
	MX -_S0*P0,-_S1*P0,-_S2*P0,-_S3*P0,-_S4*P0,-_S5*P0,-_S6*P0,-_S7*P0	;kierunek 12
	MX -_S0*P2,-_S1*P2,-_S2*P2,-_S3*P2,-_S4*P2,-_S5*P2,-_S6*P2,-_S7*P2
	MX -_S0*P3,-_S1*P3,-_S2*P3,-_S3*P3,-_S4*P3,-_S5*P3,-_S6*P3,-_S7*P3
	MX -_S0*P1,-_S1*P1,-_S2*P1,-_S3*P1,-_S4*P1,-_S5*P1,-_S6*P1,-_S7*P1
	
tab_DY							;tablica przesuniecia Y 128b
	MY -_S0*P0,-_S1*P0,-_S2*P0,-_S3*P0,-_S4*P0,-_S5*P0,-_S6*P0,-_S7*P0	;kierunek 0
	MY -_S0*P2,-_S1*P2,-_S2*P2,-_S3*P2,-_S4*P2,-_S5*P2,-_S6*P2,-_S7*P2
	MY -_S0*P3,-_S1*P3,-_S2*P3,-_S3*P3,-_S4*P3,-_S5*P3,-_S6*P3,-_S7*P3
	MY -_S0*P1,-_S1*P1,-_S2*P1,-_S3*P1,-_S4*P1,-_S5*P1,-_S6*P1,-_S7*P1
	.he 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0													;kierunek 4
	MY _S0*P1,_S1*P1,_S2*P1,_S3*P1,_S4*P1,_S5*P1,_S6*P1,_S7*P1
	MY _S0*P3,_S1*P3,_S2*P3,_S3*P3,_S4*P3,_S5*P3,_S6*P3,_S7*P3
	MY _S0*P2,_S1*P2,_S2*P2,_S3*P2,_S4*P2,_S5*P2,_S6*P2,_S7*P2
	MY _S0*P0,_S1*P0,_S2*P0,_S3*P0,_S4*P0,_S5*P0,_S6*P0,_S7*P0			;kierunek 8
	MY _S0*P2,_S1*P2,_S2*P2,_S3*P2,_S4*P2,_S5*P2,_S6*P2,_S7*P2
	MY _S0*P3,_S1*P3,_S2*P3,_S3*P3,_S4*P3,_S5*P3,_S6*P3,_S7*P3
	MY _S0*P1,_S1*P1,_S2*P1,_S3*P1,_S4*P1,_S5*P1,_S6*P1,_S7*P1
	.he 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0													;kierunek 12
	MY -_S0*P1,-_S1*P1,-_S2*P1,-_S3*P1,-_S4*P1,-_S5*P1,-_S6*P1,-_S7*P1
	MY -_S0*P3,-_S1*P3,-_S2*P3,-_S3*P3,-_S4*P3,-_S5*P3,-_S6*P3,-_S7*P3
	MY -_S0*P2,-_S1*P2,-_S2*P2,-_S3*P2,-_S4*P2,-_S5*P2,-_S6*P2,-_S7*P2
	
P0=100000		;niweluje dzielenie

P1=38268
P2=92387
P3=70710	
_S0=256		;speed0
_S1=180		;speed1
_S2=60		;speed2
_S3=100		;speed3
_S4=200		;speed4
_S5=150		;speed5
_S6=300		;speed6
_S7=350		;speed7


		icl 'ai_scripts.asm'

/*
//DIR dla LINE				PHASE dla LINE    unit dla ARC
;		0						0				3	0
;	12		4				6		2			2	1
;		8						4
//speed 0-7,phase 0-7,frame 0-31 (*8),unit 0-3 (ćwiartki), dir for LINE 0-15, dir for ARC 0-1 1=>jak zegar
		
		
		

/* EXAMPLE	
		REPEAT	2				;powtórz sekcję MOVE 2 razy
		MOVE	4				;4 basic moves
		ARC		0,0,0
		LINE	1,1,0,10			;dir,speed,phase,frame
		LINE	1,2,0,2
		ARC		0,3,3				;dir,speed,unit
		ARC		1,1,2
		BOSS0	255,1				;ile ramek(1-255),speed(0-7)
		FOLLOWX	255,$12			;ile ramek,predkosc w dół*16 || predkość w bok
		STOPTANK				;zatrzymuje czołg i zaczyna strzelać
		GOTO	2				;ustaw teraz ścieżkę 2
		NOTHING					;nic nie rób
		WAIT0	100				;czekaj 100 ramek
		SETANIM 0				;ustawia typ animacji 0-bez animacji
		SETPHASE 7				;ustawia fazę samolotu
		ENDP						;end path
*/

//path pociskow wystrzeliwanych przez bossa
boss_missile_tab	dta 45,14,43,44

;dodaje ściężkę dla obiektu, A=nr ścieżki, X=nr obiektu
add_path
		sta sprite_path_nr,x		;ustaw numer ścieżki	
		lda #0			;startowa wartość licznika
		sta sprite_path_licznik_rozkazow,x
		sta sprite_path_powtorz,x
		sta sprite_ruch,x			;brak ruchu na poczatku
		lda #255
		sta sprite_path_licznik,x	;zeruj zwykłe rozkazy
		rts
		
		
		
;ruch po prostej		
ruch_prosta		
		dec sprite_ruch_ileRamek,x
		jeq next_cmd				;jeśli <0 to pobierz następny rozkaz
ruch_prosta1
		clc
		lda sprite_DX,x
		adc sprite_ruch_DX,x
		sta sprite_DX,x
		lda sprite_X,x
		adc sprite_ruch_X,x
		sta sprite_X,x
		
		clc
		lda sprite_DY,x
		adc sprite_ruch_DY,x
		sta sprite_DY,x
		lda sprite_Y,x
		adc sprite_ruch_Y,x
		sta sprite_Y,x
		
		bne @+
		sta sprite_ai,x
		sta sprite_x,x			;usun duszka
@
		jmp _play

;ruch po łuku		
ruch_luk
		clc
		lda sprite_ruch_licznik,x
		adc sprite_ruch_zegar,x		;+/- 1  ; 1 lub 255
		cmp sprite_ruch_end,x
		jeq next_cmd

		sta sprite_ruch_licznik,x
		tay
		lda sprite_ruch_adm,x
		sta pom
		lda sprite_ruch_ads,x
		sta pom+1
		lda (pom),y
		bne @+
		jmp _play				;jeśli 0 to nie zmieniamy pozycji
		
@		and #%1111
		sta pom0a
		lda (pom),y
		:4 lsr
		
		ldy sprite_ruch_NRluku,x
		beq @+
		cpy #1
		beq @+1
		cpy #2
		beq @+2
		
		clc			;+x,-y ćwiartka 3
		adc sprite_X,x
		sta sprite_X,x
		
		sec
		lda sprite_Y,x
		sbc pom0a
		sta sprite_Y,x
		
		jmp _play	
		
@		clc			;+x,+y  , ćwiartka=0
		adc sprite_X,x
		sta sprite_X,x 
		
		;clc
		lda sprite_Y,x
		adc pom0a
		sta sprite_Y,x

		jmp _play	

@		;sec			;-x,+y ćwiartka 1
		sta pom0
		lda sprite_X,x
		sbc pom0
		sta sprite_X,x
		
		clc
		lda sprite_Y,x
		adc pom0a
		sta sprite_Y,x
		
		jmp _play	

@		;sec			;-x,-y ćwiartka 2, albo ćwiartka 0 w przeciwnym kierunku
		sta pom0
		lda sprite_X,x
		sbc pom0
		sta sprite_X,x
		
		sec
		lda sprite_Y,x
		sbc pom0a
		sta sprite_Y,x
		
		jmp _play			
		
_2polowka
		ldy sprite_ile,x
		lda sprite_x,y
		bne @+
		sta sprite_x,x
		sta sprite_ai,x
		jmp _play
@		lda sprite_ai,x		
		and #127
		clc
		adc sprite_x,y
		sta sprite_x,x
		lda sprite_dx,y
		sta sprite_dx,x
		lda sprite_y,y
		sta sprite_y,x
		lda sprite_dy,y
		sta sprite_dy,x
		jmp _play
		
;wykonaj ai dla wszystkich obiektow		
play
		;ldx #MAX_SPRITES-1
		ldx #1
@		lda sprite_ai,x
		bne @+
_play	inx
		cpx #MAX_SPRITES
		bne @-
		rts
		
@		bmi _2polowka
		lda sprite_ruch,x		;czy wykonywany jest jakis ruch?		
		beq @+					
		cmp #1
		jeq ruch_prosta
		cmp #2
		jeq ruch_luk
		cmp #3
		jeq tank_celowanie
		cmp #4
		jeq cmd_boss0
		cmp #5
		jeq cmd_followx
		jmp cmd_wait
		
;brak ruchu, czyli pobierz nowy ze ścieżki
next_cmd
@		ldy sprite_path_nr,x
		lda path_ad_m,y
		sta pom
		lda path_ad_s,y
		sta pom+1
		
		ldy sprite_path_licznik,x	;pobierz pozycję w ścieżce
		lda sprite_path_licznik_rozkazow,x	;ile wykonać zwykłych rozkazów
		bne next_rozkaz				;trwaja zwykłe rozkazy
		
		lda sprite_path_powtorz,x
		beq @+
		dec sprite_path_powtorz,x			;powtarza dany blok kilka razy
		ldy sprite_path_powtorz_licznik,x 
		
@		iny
		lda (pom),y
		bne @+
;=0 koniec scieżki
		sta sprite_X,x		;usun obiekt, koniec ścieżki
		sta sprite_AI,x
		jmp _play
		
@		jmi extra 			;extra funkcje
		sta sprite_path_licznik_rozkazow,x		;ilośc zwykłych ruchów
next_rozkaz		
		dec sprite_path_licznik_rozkazow,x		;od razu zmniejsz licznik bo jeden rozkaz pobierzemy
		
		iny
		lda (pom),y		;zwykły rozkaz, prosta czy łuk?
		bit bit3		;sprawdz bit3 =0 to prosta, =1 to łuk
		bne prepare_luk
		
;przygotuj się do wykonania prostej
		and #%111
		sta pom0
		lda sprite_anim,x
		bne @+
		lda sprite_shape,x		;tylko jesli samolot!
		and #%11111000
		ora pom0
		sta sprite_shape,x

@		lda (pom),y
		and #%11110000
		lsr
		sta pom0
		iny	

		lda (pom),y
		;lsr
		;and #%01111100
		sta sprite_ruch_ileRamek,x		;ile ramek ma trwać ruch
		iny
		tya
		sta sprite_path_licznik,x		;zapamiętaj obecną pozycję w ścieżce
								
		lda (pom),y
		;and #%111
		ora pom0
		asl
		tay							;indeks w tablicy przesunięcia X.DX,Y.DY zależnie od predkosci i kier
		
		lda #1
		sta sprite_ruch,x				;ustaw ruch po prostej
prepare_prosta		
		lda tab_DX,y
		sta sprite_ruch_DX,x
		lda tab_DX+1,y
		sta sprite_ruch_X,x
		lda tab_DY,y
		sta sprite_ruch_DY,x
		lda tab_DY+1,y
		sta sprite_ruch_Y,x		

		jmp ruch_prosta
		
prepare_luk
		and #%00000110
		lsr
		sta sprite_ruch_NRluku,x			;zapamietaj numer luku

		and #1
		sta _pluk+1						;zmien kierunek dla 1 i 3 ćwiartki
		lda (pom),y
		and #1
_pluk	eor #$ff
		bne *+4
		lda #255
		sta sprite_ruch_zegar,x			;zapamietaj kierunek ruchu =1 jak zegar, =255 przeciwnie
		
		tya
		sta sprite_path_licznik,x
		lda #2
		sta sprite_ruch,x			;ustaw ruch po łuku
		
		lda (pom),y
		and #%11110000
		:3 lsr
		tay
		lda luk_tab,y
		sta pom
		sta sprite_ruch_adm,x
		lda luk_tab+1,y
		sta pom+1
		sta sprite_ruch_ads,x		;ustaw adres tablicy wybranego luku
		
		ldy #0
		lda (pom),y
		ldy sprite_ruch_zegar,x
		bmi @+
		clc
		adc #1
		sta sprite_ruch_end,x
		lda #0
		sta sprite_ruch_licznik,x
		
		lda sprite_ruch_NRluku,x
		bit bit0
		beq @+1
		eor #%10				;zmieniamy znaki dx i dy, tylko dla 1 i 3 ćwiartki
		sta sprite_ruch_NRluku,x 
		
		jmp ruch_luk
		
@		clc
		adc #1
		sta sprite_ruch_licznik,x
		lda #0
		sta sprite_ruch_end,x
		lda sprite_ruch_NRluku,x
		bit bit0
		bne @+
		eor #%10				;zmieniamy znaki dx i dy, tylko dla 0 i 2 ćwiartki
		sta sprite_ruch_NRluku,x	
		
@		jmp ruch_luk
		
		
jump_to_path
		iny
		lda (pom),y
		jsr add_path		;przygotuj nową ścieżkę
		dex
		jmp _play			;wykonaj ai
		
repeat_move							;ustawia liczbe powtorzen dla sekcji move
		iny
		lda (pom),y
		sta sprite_path_powtorz,x
		tya
		sta sprite_path_powtorz_licznik,x
		sta sprite_path_licznik,x
		jmp next_cmd
		
;extra funkcje		
extra
		and #127
		cmp #0
		jeq prepare_stop_tank
		cmp #1
		beq jump_to_path
		cmp #2
		beq repeat_move
		cmp #3
		jeq prepare_boss0
		cmp #4
		jeq prepare_followx
		cmp #5
		jeq prepare_nothing
		cmp #6
		jeq prepare_wait
		cmp #7
		jeq prepare_setanim
		cmp #8
		jeq prepare_setphase
		jmp _play

prepare_followx
		mva #5 sprite_ruch,x
		iny
		lda (pom),y
		sta sprite_ruch_ileRamek,x
		iny
		lda (pom),y
		pha
		and #$0f
		sta sprite_ruch_fazaObrotu,x
		tya
		sta sprite_path_licznik,x	
		pla
		:4 lsr
		ora #$40
		asl
		tay
		lda tab_DY,y
		sta sprite_ruch_DY,x
		lda tab_DY+1,y
		sta sprite_ruch_Y,x
		lda #0
		sta sprite_ruch_DX,x
		sta sprite_ruch_X,x

		jmp _play
		
		
cmd_boss0
		lda frame_counter
		and #31
		cmp #1
		bne @+
		
		ldy #0
		iny
		lda sprite_x,y
		bne *-4  
		
		lda random
		and #31
		sec
		sbc #4
		clc
		adc sprite_x,x
		cmp #POSX_MIN+3
		bcs *+4
		lda #POSX_MIN+3
		cmp #POSX_MAX-3
		bcc *+4
		lda #POSX_MAX-3
				
		sta sprite_x,y
		lda sprite_y,x
		adc #62+5
		sta sprite_y,y
		lda #24
		sta sprite_shape,y
		
		
		lda random
		and #$f0
		ora #$08
		sta sprite_c1,y
		lda #252
		sta sprite_anim,y
		lda #3
		sta sprite_anim_speed,y
		lda #2
		sta sprite_shield,y
		sta sprite_score,y
		sta sprite_ai,y
		lda #0
		sta sprite_glue,y
		sta sprite_tall,y
		sta sprite_sz,y
		sta sprite_virtual,y
		sta sprite_dx,y
		sta sprite_dy,y
		sta sprite_licznik,y
		sta sprite_ile,y
		
		stx pom0
		ldx level
		lda boss_missile_tab,x
		pha
		tya
		tax
		pla
		jsr AI.add_path	
		ldx pom0

@		lda frame_counter
		and #15
		bne fl0
cmd_boss0a		
		sec
		lda sprite_x
		beq fl2
		sbc sprite_x,x
		sec
		sbc #12
		clc
		adc #6
		cmp #32
		bcc fl2
fl1		tay
		lda #$20	;w prawo
		cpy #118
		bcc *+4
		
		ora #$40	;w lewo
		ora sprite_ruch_fazaObrotu,x
		asl
		tay

		lda tab_DX,y
		sta sprite_ruch_DX,x
		lda tab_DX+1,y
		sta sprite_ruch_X,x
		
fl0		dec sprite_ruch_ileRamek,x
		bne @+
		jmp next_cmd
		
@		jmp ruch_prosta1

fl2		dec sprite_ruch_ileRamek,x
		bne @+
		jmp next_cmd
@		jmp _play

cmd_followx
		lda frame_counter
		and #31
		bne fl0
		lda sprite_x
		sec
		sbc sprite_x,x
		beq fl2
		bne fl1
		
prepare_boss0
		mva #4 sprite_ruch,x
		iny
		lda (pom),y
		sta sprite_ruch_ileRamek,x
		iny
		tya
		sta sprite_path_licznik,x		
		lda (pom),y
		sta sprite_ruch_fazaObrotu,x		
		lda #0
		sta sprite_ruch_DX,x
		sta sprite_ruch_X,x	
		sta sprite_ruch_Y,x
		sta sprite_ruch_DY,x
		jmp cmd_boss0a
		
prepare_nothing
		mva #0 sprite_ai,x
		jmp _play
		
prepare_wait
		mva #6 sprite_ruch,x
		iny
		lda (pom),y
		sta sprite_ruch_ileRamek,x
		tya
		sta sprite_path_licznik,x
ppw0	jmp _play
		
cmd_wait
		dec sprite_ruch_ileRamek,x
		bne ppw0
		jmp next_cmd
		
prepare_setanim
		iny
		lda (pom),y
		sta sprite_anim,x
pr0		tya
		sta sprite_path_licznik,x
		jmp next_cmd
		
prepare_setphase		//tylko samoloty
		iny
		lda (pom),y
		ora #8
		sta sprite_shape,x
		jmp pr0
		
prepare_stop_tank
		lda #34
		ldy sprite_shape,x
		cpy #42
		bcc *+4
		lda #38
		sta sprite_shape,x		;ustawiamy początkowy stan czołgu
		
		mva #0 sprite_anim,x
		mva #3 sprite_ruch,x
		
		mva #$22 sprite_licznik,x
		mva #$40 sprite_nxtshoot,x
		
		lda frame_counter
		and #31
		sta sprite_p0,x

tank_celowanie
		lda sprite_x		;nie celuj gdy brak gracza
		bne @+
		jmp _play
@		lda frame_counter
		and #31
		cmp sprite_p0,x		;opoznienie
		beq @+
		jmp _play
		
@		mva #0 pom0
		lda sprite_x,x
		sec
		sbc sprite_x
		bcs @+
		inc pom0
		eor #255
		adc #1
@		lsr
		lsr
		lsr
		cmp #16
		bcc *+4
		lda #15
		sta pom

		lda sprite_y,x
		sec
		sbc sprite_y
		bcs @+
		eor #255
		adc #1
		clc
		
@		rol pom0

		and #%01110000
		ora pom
		tay
		lda defend.tab_shot1,y
		tay
		lda pom0
		asl
		asl
		ora tab_kier0,y
		tay
		
		lda sprite_shape,x
		sta _old+1
		and #%11111000
		sta _cel+1
		lda sprite_shape,x
		and #7
		sec
		sbc tab_kier,y
		and #7
		sta sprite_p1,x		;zapamietaj różnicę kierunków
		beq @+1		;kierunek jest ok
		cmp #4
		bcc @+
		lda sprite_shape,x
		adc #0
		jmp e0
@		lda sprite_shape,x
		sbc #0				
e0		and #7
_cel	ora #$ff
		sta sprite_shape,x
		
		cmp #34			;czolg w prawo, poprawka pozycji
		bne *+5
		inc sprite_x,x
_old	lda #$ff
		cmp #34
		bne *+5
		dec sprite_x,x
				
@
		jmp _play

tab_kier0	dta 0,0,1,1,1,1,1,1,2
		
tab_kier	dta 4,5,6,0
			dta 0,7,6,0
			dta 4,3,2,0
			dta 0,1,2,0
			

//MAKRA
;definije blok z podstawowymi ruchami
.macro MOVE ile
	dta b(:ile)
.endm
;prosta kierunek,prędkość,faza animacji,ile ramek
.macro LINE dir,speed,phase,frame
	dta [:dir & 15]*16+[:phase & 7],:frame,:speed	;[:frame & 31]*8+[:speed & 7]
.endm
;łuk  kierunek,prędość,nr fragmentu łuku
.macro ARC dir,speed,unit
	dta [:dir & 1]+[:unit & 3]*2+[:speed & 15]*16+8
.endm

;koniec ścieżki
.macro ENDP 
	dta 0
.endm

;tank celowanie
.macro stoptank
	dta 128
.endm

;skok do scieżki
.macro goto path
	dta 128+1
	dta :path
.endm	

;powtórzenie bloku move
.macro repeat ile
	dta 128+2
	dta :ile
.endm

;Boss0
.macro boss0 ileRamek,speed
	dta 128+3
	dta :ileRamek,:speed
.endm

;śledzi gracza w osiX i powoli opada w dół
.macro followx ileRamek,speed
	dta 128+4
	dta :ileRamek
	dta :speed
.endm	

;nic nie robi
.macro nothing
	dta 128+5
.endm

.macro wait0 ileRamek
	dta 128+6
	dta :ileRamek
.endm 

//ustawia typ animacji 0=bez animacji
.macro setanim value
	dta 128+7
	dta :value
.endm

//ustaw fazę duszka
.macro setphase value
	dta 128+8
	dta :value
.endm

.macro MX value0,value1,value2,value3,value4,value5,value6,value7
	?a = :value0 / 100000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value1 / 100000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value2 / 100000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value3 / 100000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value4 / 100000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value5 / 100000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value6 / 100000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value7 / 100000
	?a = ?a & $ffff
	dta a(?a)
.endm

.macro MY value0,value1,value2,value3,value4,value5,value6,value7
	?a = :value0 / 50000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value1 / 50000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value2 / 50000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value3 / 50000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value4 / 50000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value5 / 50000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value6 / 50000
	?a = ?a & $ffff
	dta a(?a)
	
	?a = :value7 / 50000
	?a = ?a & $ffff
	dta a(?a)
.endm
	

.endl

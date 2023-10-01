//rysuje i przesuwa ekran
cannon_ad1		equ sprite_dx
cannon_ad2		equ sprite_dy
cannon_negatyw	org *+MAX_SPRITES
cannon_put			equ sprite_shape
CANNON_START	equ 64

;typy obiektów
t_cannon	equ 10		;typ obiektu
t_sciana	equ 11
t_bonus_hit	equ 12
t_bonus		equ 13
t_bonus_show	equ 14
t_cannon_w0		equ 15
t_cannon_w1		equ 16
t_cannon_w2		equ 17
t_cannon_w		equ 18
t_diament		equ 19
t_factory		equ 20

;nazwy klockow

ILE_EXTRA_KLOCEK	equ 8	;ilość rodzajów extra klocków

kl_sciana	 	equ 0		
kl_cannon	equ 1
kl_unlock	equ 2		;zestrzelenie odblokowuje  bonus
kl_cannon_w0	equ 3		;działko w wodzie
kl_bonus	equ 4		;odblokowane bonus (pozycja startowa)
kl_diament	equ 6		;element fabryki
kl_factory0	equ 7
kl_unlock0	equ 8		;zestrzelony kl_unlock
kl_water	equ 10		;woda
kl_grass	equ 87		;trawa
kl_crack	equ 9		;po zestrzeleniu działka na ziemi
kl_crack1	equ 15		;-II-                   na trawie
kl_szach	equ 16
kl_factory1	equ 11



kl_cannon_w1	equ	13		;pojawiajace sie dzialko
kl_cannon_w2	equ	14
kl_cannon_w		equ 12 

.local bg
level1e	equ level_map-10
level_map equ $c400



			
licznik_dlist	dta b(0)					
			
tab_score1	.he 00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
			.he 31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61
			.he 62,63
tab_score2	dta a($0),a($64),a($128),a($192)			


;-----  ;drugi cannon na trawie
tab_typ		dta t_sciana,t_cannon,t_bonus_hit,t_cannon_w0,t_bonus,t_cannon,t_diament,t_factory
tab_shield		dta	127,3,2,2,127,3,1,1
tab_licznik 	dta	0,82,0,30,0,82,0,0 
tab_score 		dta 0,7,5,5,3,7,8,2
tab_afterexplo	dta 0,kl_crack,kl_unlock0,kl_water,0,kl_crack1,kl_szach,kl_factory1		;co ma sie pojawic po wybuchu
tab_wybuch		dta 0,0,0,255,1,0,0,0				;>0 nie mozna trafic dla virtual =255 animacja dzialka


negatyw
		lda #3
		sta cannon_negatyw,y		;zapamietaj zmianę koloru, licznik
		lda #0						;przywróć po negatywie
		sta cannon_put,y			
		lda cannon_ad1,y
		sta pom
		lda cannon_ad2,y
		sta pom+1
		sty pom0
negatyw1		
		ldy #0
		lda (pom),y
		eor #128
		sta (pom),y
		iny
		lda (pom),y
		eor #128
		sta (pom),y
		ldy #SZER
		lda (pom),y
		eor #128
		sta (pom),y
		iny
		lda (pom),y
		eor #128
		sta (pom),y
		ldy pom0
		rts
		
negatyw_off
		ldx #MAX_SPRITES-1
@		;lda sprite_virtual,x
		;beq @+
		lda cannon_negatyw,x
		beq @+
		dec cannon_negatyw,x
		bne @+
		lda cannon_put,x
		bne @+1					;wstaw nowy klocek po wybuchu
		;lda #0						;przywróć po negatywie
		;sta cannon_put,x			
		lda cannon_ad1,x
		sta pom
		lda cannon_ad2,x
		sta pom+1
		jsr negatyw1
@		dex
		bne @-1
		rts
		
@		lda cannon_ad1,x
		sta pom
		lda cannon_ad2,x
		sta pom+1
		ldy #0
		lda sprite_p0,x
		stx _negx+1
		tax
		lda klocki,x
		sta (pom),y
		iny
		lda klocki+$80,x
		sta (pom),y
		ldy #SZER
		lda klocki+$100,x
		sta (pom),y
		iny
		lda klocki+$180,x
		sta (pom),y
_negx		
		ldx #$ff
		jmp @-1
		
//inicjuj plansze
init	
		mva #0 zestaw1		;ustaw startowy zestaw znakow
		mva #15 przesuniecie
		mva #7 vscrol
		mva #2 pozycja_bg
		sta pozycja_bg1
		mwa #obraz obr_adr
		mwa #obraz dlist1+1		
		
		lda check_row
		ora check_row+1
		beq @+1

		mwa #$c0 linia
	
it2		mva #8 pom0
it1		jsr COM.color
		inc linia
		bne it0
		inc linia+1
it0		dec pom0
		bne it1
		jsr move_colors1
		lda linia+1
		cmp check_linia+1
		bcc it2
		lda linia
		cmp check_linia
		bcc it2
		
		;mwa check_linia	linia
		mwa check_obrona obrona
		;mwa check_bgcol bgcol
				
		mwa level1s poziom_bg			;ustawienie startu na ostatni checkpoint
		ldy check_row+1
		ldx check_row
		
@		sec		
		lda poziom_bg
		sbc #10
		sta poziom_bg
		bcs *+4
		dec poziom_bg+1
		dex
		cpx #255
		bne @-
		dey
		bpl @-
		jmp @+1
		
@		;mwa #(level1s-60) poziom_bg
		sec
		lda level1s
		sbc #60
		sta poziom_bg
		lda level1s+1
		sbc #0
		sta poziom_bg+1

		mva #$C0 linia
		mva #0 linia+1
		mwa #level_enemy_tab obrona
		;mwa #level1c bgcol
@		equ *		
		
		ldx #22-1
		lda #$24+$80
@		sta dlist1+3,x		;przygotuj dlist
		dex
		bpl @-
		lda #$4
		sta dlist1+26-1
		lda #$00
		sta dlist1+27-1
		sta dlist1+28-1
		sta licznik_dlist
		rts
		
//przesuwa listę zmiany kolorów w dół		
move_colors		
		lda przesuniecie
		cmp #15
		beq *+3
		rts
move_colors1		
		ldx #23
@		lda blok_nr+4,x				;na pozycji +4 początkowy
		sta blok_nr+5,x
		lda blok_col+4,x
		sta blok_col+5,x
		dex
		bpl @-
		rts

//popraw dlist, LMS
change_dlist
		lda przesuniecie
		lsr
		sta vscrol
		sta przes1
		bcs *+3
		rts
		cmp #7
		beq *+3
		rts
@		lda vcount
		cmp #$70
		bcc @-
		mwa obr_adr dlist1+1
		
@		ldx licznik_dlist
		cpx #24-1
		bcc @+				;<24
		
		bne cd_1			;jesli >od 24
		lda #$04+$80		;=24	(ostatnia linia bez vscrola)
		sta dlist1+26-1
		lda #$00
		sta dlist1+28-1
		
cd_1		
		cpx #27			;liczba zapetlonych linii
		bne cd_2
		
		ldx #0-1	
cd_2		
		inx
		stx licznik_dlist
		rts
		
@		cpx #0
		bne @+
		
		lda #$24+$80
		sta dlist1+26-1
		sta dlist1+27-1
		lda #$04+$80
		sta dlist1+28-1
		bne cd_0		;jmp ,pomin 2 pierwsze rozkazy
		
		
@		lda #$24+$80
		sta dlist1+2,x			
		
cd_0	lda #$64+$80
		cpx #23-1
		bne @+
		lda #$44+$80
		
@		sta dlist1+3,x
		lda #0
		sta dlist1+4,x
		lda #>obraz
		sta dlist1+5,x	
		
cd_end		
		inx
		stx licznik_dlist
		rts




//przesuwa ekran o linie		
przesun
		lda przesuniecie
		and #1
		bne @+2

		ldx #MAX_SPRITES-1
@		lda sprite_x,x			;przesuwaj pozycje dzialek,czolgow wraz z planszą
		beq @+
		lda sprite_glue,x
		beq @+
		inc sprite_y,x
		lda sprite_y,x
		cmp #POSY_MAX+1
		bcc @+
		lda #0					
		sta sprite_x,x		;usun jesli poza ekranem, cannon_y=0
@		dex
		bpl @-1
				
		
@		lda przesuniecie
		and #%1000
		bne @+
		jsr change_chars
		
@		lda licznik_cannon_w
		beq @+
		lda przesuniecie
		and #%00000111
		bne @+
		jsr change_chars_w		;działko na wodzie
		
		
@		lda przesuniecie
		sec
		sbc #1
		and #15
		sta przesuniecie
		bcc nxt_wiersz
		cmp #SZER/4
		beq nxt_linia
		jcc nxt_klocek
		rts
		
nxt_linia	
		sec
		lda obr_adr
		sbc #SZER
		sta obr_adr1
		lda obr_adr+1
		sbc #0
		cmp #>obraz
		bcc @+
		sta obr_adr1+1
		rts
@		mwa #obraz+27*SZER obr_adr1
		rts
		
		
nxt_wiersz
		lda pozycja_bg
		eor #2
		sta pozycja_bg
		beq @+
		lda pozycja_bg1
		eor #2
		sta pozycja_bg1
		beq @+
		
		
		
		sec
		lda poziom_bg			
		sbc #10
		sta poziom_bg
		bcs @+
		dec poziom_bg+1
		
		
@		lda poziom_bg+1			;zapętl level
		cmp #>level1e
		bne @+
		lda poziom_bg
		cmp #<level1e
		bne @+
		mwa #level_map poziom_bg		;zapętl ostatnią linię
		
@		sec
		lda obr_adr
		sbc #SZER
		sta obr_adr
		lda obr_adr+1
		sbc #0
		sta obr_adr+1
		cmp #>obraz
		bcs @+
		mwa #obraz+27*SZER obr_adr

		
@		lda zestaw1
		eor #4
		sta zestaw1		;zmien 1 zestaw znaków 
		
		rts
		
		
nxt_klocek
		tay
		lda (poziom_bg),y
		ldx pozycja_bg1
		bne @+
		
		tax
		tya
		asl
		asl
		tay			;pozycja na ekranie
		
		lda kafel+$100,x
		pha
		lda kafel,x
		jmp @+1
		
		
@		tax
		tya
		asl
		asl
		tay			;pozycja na ekranie
		
		lda kafel+$300,x		;dół tilesa
		pha
		lda kafel+$200,x
			
@		cmp #ILE_EXTRA_KLOCEK
		bcs @+
		jsr dodaj_extra_klocek
@		
		tax		;nr kafelka
		lda pozycja_bg
		bne @+		;2 zestaw
		lda klocki,x
		sta (obr_adr1),y
		iny
		lda klocki+$80,x
		sta (obr_adr1),y
		jmp @+1
		
@		lda klocki+$100,x
		sta (obr_adr1),y
		iny
		lda klocki+$180,x
		sta (obr_adr1),y
	
@		iny	
		pla
		cmp #ILE_EXTRA_KLOCEK
		bcs @+
		jsr dodaj_extra_klocek
@		
		tax		;nr kafelka
		lda pozycja_bg
		bne @+		;2 zestaw
		lda klocki,x
		sta (obr_adr1),y
		iny
		lda klocki+$80,x
		sta (obr_adr1),y
		rts
		
@		lda klocki+$100,x
		sta (obr_adr1),y
		iny
		lda klocki+$180,x
		sta (obr_adr1),y
		rts

//dodaje blokadę lub działko		
dodaj_extra_klocek
		ldx pozycja_bg
		beq @+
		rts
		
@		
		sta pom0
		cmp #kl_cannon_w0
		bne *+4
		lda #kl_water
		sta _de1+1

		ldx #MAX_SPRITES
@		dex
		lda sprite_x,x
		bne @-
								
		tya
		:2 asl
		clc
		adc #POSX_MIN+7	;64
		sta sprite_x,x
		lda przesuniecie
		lsr
		eor #255
		sec
		adc #POSY_MIN+8-2		
		sta sprite_y,x 
		
		tya
		clc
		adc obr_adr1
		sta cannon_ad1,x
		lda obr_adr1+1
		adc #0
		sta cannon_ad2,x		;zapisz adres dzialka w pamięci
		
		sty _de2+1
		ldy pom0			;nr kafla (czyli rodzaj)
		mva #0 sprite_wybuch,x
		sta cannon_negatyw,x	;licznik zmiany koloru trafionego obiektu =0
		lda tab_typ,y
		sta sprite_typ,x	;określamy typ obiektu
		cmp #t_bonus
		bne @+
		stx bonus_sprite	;zapamietaj nr duszka
@		
		lda tab_wybuch,y
		sta sprite_wybuch,x		;>0 dla virtual= nie można go trafić
		lda tab_shield,y
		sta sprite_shield,x	;wytrzymałość
		lda tab_licznik,y
		sta sprite_licznik,x	;opoznienie strzalu
		sta sprite_nxtshoot,x	
		lda tab_score,y
		sta sprite_score,x	;punkty za zbicie obiektu =30	
		lda tab_afterexplo,y
		sta sprite_p0,x		;co ma sie pojawić po zniszczeniu klocka

		lda #1
		sta sprite_virtual,x	;obiekt virtualny, nie rysowany przez PM
		sta sprite_glue,x		;obiekt przyklejony do planszy =1
		lda #0
		sta sprite_tall,x
		sta sprite_sz,x
		sta sprite_anim,x
		sta sprite_c1,x
		sta sprite_AI,x		;wylacz ai

_de1	lda #$ff		;odtworzenie rejestrów
_de2	ldy #$ff
		
		rts
		


change_chars_w
		lda znaki+6*8+6
		eor #1
		sta znaki+6*8+6
		sta znaki+6*8+7
		sta znaki+$400+19*8
		sta znaki+$400+19*8+1
		
		lda znaki+20*8+6
		eor #$40
		sta znaki+20*8+6
		sta znaki+20*8+7
		sta znaki+$400+20*8
		sta znaki+$400+20*8+1
		rts
		

change_chars
		lda znaki+2*8+6			;migające działko
		eor #%10
		sta znaki+2*8+6
		lda znaki+2*8+7
		eor #%10
		sta znaki+2*8+7
		lda znaki+$400+2*8
		eor #%10
		sta znaki+$400+2*8
		rts
		
change_2		
		lda ch_char
		eor #1
		sta ch_char
		bne @+1
		
		lda #$cf
		sta znaki+4*8+5
		sta znaki+4*8+7
		sta znaki+$400+4*8+1
		lda #$ce
		sta znaki+$400+4*8+0
		lda #$f8
		sta znaki+5*8+5
		sta znaki+5*8+6
		sta znaki+5*8+7
		sta znaki+$400+5*8+1
		
@		lda #$b8
		sta znaki+$400+5*8+0
		lda #$ca
		sta znaki+4*8+6
		rts
		
@		lda #$c0
		sta znaki+4*8+5
		sta znaki+4*8+7
		sta znaki+$400+4*8+1	
		lda #$c2
		sta znaki+$400+4*8+0
		lda #$38
		sta znaki+5*8+5
		sta znaki+5*8+6
		sta znaki+5*8+7
		sta znaki+$400+5*8+1
		rts
		
		
change_bonus
		lda frame_counter
		and #7
		beq *+3
		rts
		
		lda bonus_nr
		beq change_1
		cmp #1
		beq change_2
		cmp #2
		beq change_3
		rts
		
change_1		
ch_char	equ *+1		
		lda #0
		eor #1
		sta ch_char
		bne @+1
		
		lda #$cb
		sta znaki+4*8+5
		sta znaki+4*8+7
		sta znaki+$400+4*8+0		;wlaczona cyfra
		lda #$cf
		sta znaki+4*8+6
		sta znaki+$400+4*8+1
		lda #$f8
		sta znaki+$400+5*8+1
		
@		lda #$b8
		sta znaki+5*8+5
		sta znaki+5*8+6
		sta znaki+5*8+7
		sta znaki+$400+5*8+0
		rts
		
@		lda #$c8					;wylaczona cyfra
		sta znaki+4*8+5
		sta znaki+4*8+7
		sta znaki+$400+4*8+0
		lda #$c0
		sta znaki+4*8+6
		sta znaki+$400+4*8+1
		lda #$38
		sta znaki+$400+5*8+1
		rts

change_3
		lda ch_char
		eor #1
		sta ch_char
		bne @+
		
		lda #$cf
		sta znaki+4*8+5
		sta znaki+$400+4*8+1
		lda #$cb
		sta znaki+4*8+7
		lda #$f8
		sta znaki+5*8+6
		sta znaki+5*8+7
		sta znaki+$400+5*8
		lda #$ca
		sta znaki+4*8+6
		sta znaki+$400+4*8
		lda #$b8
		sta znaki+5*8+5
		sta znaki+$400+5*8+1
		rts
		
@		lda #$c0
		sta znaki+4*8+5
		sta znaki+$400+4*8+1
		lda #$c8
		sta znaki+4*8+7
		lda #$38
		sta znaki+5*8+6
		sta znaki+5*8+7
		sta znaki+$400+5*8
		rts		
		
score_dodaj
		lda score_add
		bne *+3
		rts
		and #%00111111
		tax
		beq @+

		lda tab_score1,x
		clc
		
		sed
		adc score
		sta score
		lda score+1
		adc #0
		sta score+1
		lda score+2
		adc #0
		sta score+2
		cld
		
@		lda score_add
		lsr
		ror
		ror
		asl
		and #6
		tax
		lda tab_score2,x
		clc
		
		sed
		adc score
		sta score
		lda score+1
		adc tab_score2+1,x
		sta score+1
		lda score+2
		adc #0
		sta score+2
		cld
		
		
		lda score+1			;obsluga extra life
		and #$f0
		cmp extra_lives
		bcc @+
		beq @+

		sta extra_lives
		inc lives
		lda lives
		cmp #10
		bcc *+4
		lda #9
		ora #$10
		sta panel+$11	
		lda #1
		ldy #13*2	;spy_hit
		jsr add_fx
		
@		equ *		

score_print		
		mva #0 score_add

		ldx #6
		lda score+2
		jsr score_print1
		lda score+1
		jsr score_print1
		lda score
		;jmp score_print1
		
score_print1	
		pha
		:4 lsr
		sta panel,x
		inx
		pla
		and #$0f
		sta panel,x
		inx
		rts
		
czy_hscore
		sec
		lda hscore
		sbc score
		lda hscore+1
		sbc score+1
		lda hscore+2
		sbc score+2
		bcc @+
		
		rts
		
@		mva score hscore
		mva score+1 hscore+1
		mva score+2 hscore+2
		
hscore_print
		ldx #SZER-7
		lda hscore+2
		jsr score_print1
		lda hscore+1
		jsr score_print1
		lda hscore
		jmp score_print1
		
efekt_init
		clc
		lda poziom_bg
		adc #10
		sta _pc2+1
		lda poziom_bg+1
		adc #0
		sta _pc3+1 
		mva #<obraz _pc0+1
		mva #>obraz _pc1+1
		mva #5 _ef3+1
		rts

ef_tab	dta 1,2,2,1,0,0,0,1,2,3,3,3,3,2,1,0
		dta 2,2,1,1,1,2,3,3,3,3,2,1,0,0,0,0
		
ef_tab1	dta 0,1,2,3,3,3,3,2,1,0,0,0,1,2,2,1
		dta 0,0,0,0,1,2,3,3,3,3,2,1,1,1,2,2
		

efekt2
		mva obr_adr _pc0+1
		mva obr_adr+1 _pc1+1
		mva #$ff _pc4+1		

		lda #0
		sta pom0c
		sta pom0a
		lda #39
		sta pom0d

@		lda #27
		sta pom0b
@		lda pom0c
		sta pom0a
		jsr clear_char
		ldy pom0d
		lda #$ff
		jsr _pc4
		dec pom0b
		bpl @-
		:2 jsr wait_vbl
		inc pom0c
		dec pom0d
		lda pom0c
		cmp #20
		bcc @-1
		rts
		
efekt1
		mva obr_adr _pc0+1
		mva obr_adr+1 _pc1+1
		mva #$ff _pc4+1
		mwa #clear_char _ef0+1
		mwa #(ef_tab1) _ef1+1
		mwa #(ef_tab1+16) _ef2+1
		mva #6 _ef3+1
		jsr efekt
		mwa #print_char _ef0+1
		mwa #(ef_tab) _ef1+1
		mwa #(ef_tab+16) _ef2+1
		rts	
efekt
		mva #15 pom0		
@		mva #0 frame_counter
		ldx #9
_ef3
@		ldy #6
@		
		stx pom0c
		sty pom0d
		
		txa
		asl
		asl
		ldx pom0
_ef1	adc ef_tab,x
		sta pom0a
		tya
		asl
		asl
_ef2	adc ef_tab+16,x
		sta pom0b
_ef0	jsr print_char
		
		
		ldy pom0d
		ldx pom0c
		dey
		bpl @-
		dex
		bpl @-1
		lda frame_counter
		cmp #2
		bne *-4
		dec pom0
		bpl @-2
		rts
				
print_char
		lda pom0a
		lsr
		lsr
		clc
_pc2	adc #$ff
		sta pom1			
_pc3	lda #$ff
		adc #0
		sta pom1+1
		
		ldy pom0b 
		tya
		lsr
		lsr
		tay
		beq @+1
		
@		clc
		lda pom1
		adc #10
		sta pom1		;adres w mapie
		bcc *+4
		inc pom1+1
		dey
		bne @-

@		ldy #0
		lda (pom1),y
		tax
		
		lda pom0b
		and #%10
		bne @+1
		
		lda pom0a
		and #%10
		bne @+
		
		lda kafel,x
		jmp dj0
@		lda kafel+$100,x
		jmp dj0
		
@		lda pom0a
		and #%10
		bne @+
		
		lda kafel+$200,x
		jmp dj0
		
@		lda kafel+$300,x
		
dj0		tax
		lda pom0b
		and #1
		bne @+1
		
		lda pom0a
		and #1
		bne @+
		
		lda klocki,x
		jmp dl1

@		lda klocki+$80,x
		jmp dl1
		
@		lda pom0a
		and #1
		bne @+
		
		lda klocki+$100,x
		jmp dl1
		
@		lda klocki+$180,x
dl1		sta _pc4+1
		
clear_char
		lda pom0b
		mvy #0 pom+1
		asl
		asl
		asl
		sta _cl0+1
		asl
		rol pom+1
		asl
		rol pom+1
		
		clc
_cl0	adc #$ff
		bcc *+5
		inc pom+1
		clc
		
_pc0	adc #$ff
		sta pom
		lda pom+1
_pc1	adc #$ff
		sta pom+1
		bcs @+			;przekrecona pamiec
		
		lda #<(obraz-1+28*SZER)
		cmp pom
		lda #>(obraz-1+28*SZER)
		sbc pom+1
		bcs @+1
		sec
@		lda pom
		sbc #<(28*SZER)
		sta pom
		lda pom+1
		sbc #>(28*SZER)
		sta pom+1		
		

@		ldy pom0a
_pc4	lda #$ff
		sta (pom),y
		
		rts
			
.endl
		
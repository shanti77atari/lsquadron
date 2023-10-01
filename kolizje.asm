//kolizje
.local cl
pvm_tab dta 	5,6,15,17


set_licznik_dead
		lda przesuniecie
		clc
		adc #96-1
		sta licznik_dead
		rts


player_vs_missile
		lda cheat		;niesmiertelnosc
		beq *+3
		rts

		lda frame_counter
		lsr
		bcc *+3
		rts

		ldx #MAX_MISSILES-1
@		lda missile_x,x
		bne @+
nxmiss	dex
		bpl @-
		rts

@		ldy missile_typ,x
		cpy #1			;dla dużego c=1, dla malego c=0 czyli dodatkowo -1
		sbc sprite_x
		cpy #1			;dla dużego c=1 czyli dodatkowo +1
		adc #0
		cmp pvm_tab,y
		bcs nxmiss
		
		lda missile_typ,x
		asl
		adc missile_y,x				;c=0
		sec
		sbc sprite_y
		cmp pvm_tab+2,y
		bcs nxmiss
		
		lda #0
		sta missile_x,x		;usun missile
		
		lda kolor_samolotu
		clc
		adc #$10
		ora #$f
		sta sprite_c1
		
		mwa energy_licznik_start energy_licznik		;odmierzamy czas od ostatniego trafienia
		
		clc
		lda energy
		sbc missile_typ,x	;zmniejszamy energię
		sta energy
		beq nx0
		bcs nxmiss
nx0
kill_gracz		
		mva #4*5-1 sprite_wybuch
		mva kolor_sprite_tab sprite_c1	;kolor wybuchu
		mva #1 sprite_sz
		mva #32 sprite_tall
		jsr set_licznik_dead
		sec
		lda sprite_x
		sbc #4
		sta sprite_x
		lda sprite_y
		sbc #8
		sta sprite_y
		
		lda #2
		ldy #1*2		;bomba
		jsr add_fx	
		
clear_energy
		lda #0
		sta energy
		mva #128 _sb1+1
		jmp print_energy

kill_enemy
		mva kolor_sprite_tab+1 sprite_c1,y	;kolor wybuchu
		mva #4*5-1 sprite_wybuch,y
kill_enemy1		
		mva #1 sprite_sz,y
		mva #32 sprite_tall,y
		clc
		lda score_add
		adc sprite_score,y
		sta score_add
		lda sprite_x,y
		sbc #4-1			;c=0
		sta sprite_x,y
		lda sprite_y,y
		sbc #8
		sta sprite_y,y
		
		mva #0 sprite_AI,y	;wyłącz AI
		
		rts
				
speed_shot_tab	dta 6,7,7			;0=6
delay_shot_tab	dta 10,9,8			;0=10


kolor_samolotu_tab	.he  b0,10,90
big_shoot_tab 	dta a(680),a(816),a(928)		;czas speialnego strzału 
tab_recovery	dta a(680),a(544),a(440)	

kolor_sprite_tab
		.he cf,ff,7f,5f,4f,8f		

shield_tab	dta 6,8,10
max_shield=2
MAX_samolot_speed=2
MAX_shot_speed=2
		
bonus_add
		mva #0 sprite_x,y		;co dzieje sie po zlapaniu bonus, tylko wymaz duszka bonus
		sta sprite_ai,y
		lda special
		cmp #3
		bcs @+
		inc special
@		sty pom0
		lda #1
		ldy #13*2		;extra life
		jsr add_fx
		
		lda bonus_nr
		bne @+
//prędkość		
		lda samolot_speed
		cmp #MAX_samolot_speed
		jcs bon1
		inc samolot_speed	;szybszy samolot
		ldy samolot_speed
		lda kolor_samolotu_tab,y
		sta kolor_samolotu
		ora #$08
		sta sprite_c1			;zmiana koloru
		jmp bon1

@		cmp #1
		bne @+
//tarcza	
		lda shield
		cmp #MAX_shield
		bcs bont0
		inc shield
		ldy shield
		
		lda shield_tab,y	;nowa poziom energii
		sta energy_max
		sta energy
		
		tya
		asl	;x2
		tay
		lda tab_recovery,y							
		sta energy_licznik_start	;szybsze odradzanie energii
		sta energy_licznik
		lda tab_recovery+1,y
		sta energy_licznik_start+1
		sta energy_licznik
		jmp bon1

bont0		
		lda shield_tab+2			;przy maksymalnym poziomie odnów tylko enregię
		sta energy
		jmp bon1
		
@		cmp #2
		bne @+
//strzal		
		lda shot_speed					;ulepsza strzał
		cmp #MAX_shot_speed
		bcs bon1
		inc shot_speed
		ldx shot_speed
		lda kolor_samolotu_tab,x	;kolor miniaturki
		ora #08
		sta _mini_c+1
		
		lda speed_shot_tab,x		;szybkosc strzalu
		sta multi._mvs+1
		lda delay_shot_tab,x		;opoznienie pomiedzy strzalami
		sta _frd+1
		txa
		asl		;x2
		tax
		lda big_shoot_tab,x		;czas trwania specialnego strzalu
		sta big_shoot_start
		lda big_shoot_tab+1,x
		sta big_shoot_start+1

bon1		
@		ldy pom0	
		jmp nx1

player_vs_enemy
		lda frame_counter
		lsr
		bcc *+3
		rts

		ldy #MAX_SPRITES-1
		
@		lda sprite_wybuch,y
		ora sprite_glue,y
		bne nx1
		lda sprite_x,y
		beq nx1
		
		ldx sprite_sz,y
		bne @+					;duży duszek

		clc
		adc #6+1
		;sec		;c=0 ale było +1
		sbc sprite_x
		cmp #12
		bcs nx1
		
		ldx sprite_tall,y
		jne @+1					;wysoki duszek
		
		lda sprite_y,y
		;clc			;c=0 bo bcs nie skoczyl
		adc #13+1		;+1 bo sbc bez sec odejmi o 1 wiecej
		;sec
		sbc sprite_y
		cmp #27
		bcs nx1
		
		lda sprite_typ,y
		cmp #t_bonus_show
		bne nx1a
		jmp bonus_add		;profit z bonus
		
nx1a		
		lda cheat			;nieśmiertelność
		bne nx1
		
		jsr kill_enemy
		jmp kill_gracz
		
nx1		dey
		bne @-
		rts

//duży duszek	, szeroki i wysoki	
@		
		sec
		sbc sprite_x
		clc
		adc #14
		cmp #21
		bcs nx1	
		
		sec
		lda sprite_y,y
		sbc sprite_y
		clc
		adc #62
		cmp #77
		bcs nx1
		
		lda cheat   ;niesmiertelnosc
		bne nx1
		
		jmp kill_gracz
		
//wysoki duszek		
@		
		txa
		ora #%1011
		sta _bdy+1
		txa
		sec
		sbc #3+1		;po adc doda +1
		adc sprite_y,y
		sec
		sbc sprite_y
_bdy	cmp #$ff			;43 dla 32 i 75 dla 64
		bcs nx1
		
		lda cheat
		bne nx1			;niesmiertelnosc
		
		jmp kill_gracz
		
		
show_bonus
		ldx bonus_sprite
		lda #0
		sta sprite_tall,x
		sta sprite_sz,x
		sta sprite_virtual,x
		sta sprite_wybuch,x
		sta sprite_glue,x
		sta sprite_licznik,x
		mva #255 sprite_anim_speed,x
		lda #t_bonus_show
		sta sprite_typ,x
		clc
		lda bonus_nr
		adc #44
		sta sprite_shape,x
		mva #1 sprite_anim,x
		mva #1 sprite_ai,x
		mva #$8f sprite_c1,x
		clc
		lda sprite_x,x		;przesun na środek 
		adc #4
		sta sprite_x,x
		lda sprite_y,x
		sbc #15
		sta sprite_y,x

		lda #12
		jmp AI.add_path

//trafiony Virtual		
ms2		
		jsr bg.negatyw			;trafiony element błyśnie
		lda sprite_shield,y
		bmi @+			;blokady nie da sie usunac
		sec
		sbc shot_power
		sta sprite_shield,y
		bcs @+
		lda #4*4-1	;15
		sta sprite_wybuch,y
		
		lda #14					;opoznienie musi byc mniejsze od sprite_wybuch
		sta cannon_negatyw,y	;opoznienie
		sta cannon_put,y		;wstaw krater
		mva #0 sprite_virtual,y

		jsr kill_enemy1
		
		lda sprite_typ,y
		cmp #t_bonus_hit
		bne ms2a
		
		mva kolor_sprite_tab+2 sprite_c1,y	;kolor wybuchu
		stx pom0
		jsr zmaz_dzialko
		
		lda bonus_ile
		beq ms2c
		dec bonus_ile
		bne ms2c
		jsr show_bonus
		
ms2c 		
		ldy #1*2		;bomba
		jmp ms2b		
		
ms2a	
		cmp #t_cannon_w
		bne ms2aa
		lda kolor_sprite_tab+3
		sta sprite_c1,y
		mva #1 cannon_negatyw,y
		dec licznik_cannon_w
		jmp ms2ab
ms2aa		
		lda kolor_sprite_tab+4			;kolor wybuchu
		sta sprite_c1,y
		jsr zmaz_dzialko
ms2ab		
		ldy #8*2		;wybuch
		stx pom0
ms2b		lda #1
		jsr add_fx
		
		ldx pom0
@		jmp nx2		

	
shot_vs_enemy
		lda frame_counter
		lsr
		bcs *+3
		rts

		ldx #5
@		lda shot_y,x
		beq nx2
		clc
		adc #3		;wysokosc enemy
		sta pom0
		
;maly strzal
		ldy #MAX_SPRITES-1
@		equ *
		lda sprite_x,y
		beq nx3
		lda sprite_wybuch,y		;pomin dla wybuchu
		bne nx3
		
		lda sprite_tall,y
		bne big0
		
		
		lda pom0	
		sec
		sbc sprite_y,y
		cmp #19		
		bcs nx3
		
		lda shot_t1,x
		bne szeroki
		
		lda shot_x,x
		clc
		adc #4	
		sec
		sbc sprite_x,y
		cmp #12
		bcs nx3
		
ms1
		lda sprite_typ,y
		cmp #t_bonus_show
		beq nx2				;strzaly nie trafiaja w bonus
		
		mva #0 shot_y,x		;skasuj strzal
		lda sprite_virtual,y
		beq ms3
		jmp ms2		

szeroki		
		lda shot_x,x
		clc
		adc #6		
		sec
		sbc sprite_x,y
		cmp #14
		bcc ms1			;trafienie
			
nx3	dey
		bne @-	
		
nx2	dex
		bpl @-1
		
		rts

;maly strzal, duzy duszek		
big0	
		ora #3
		sta _big0a+1		;35 dla 32 i 67 dla 64
		lda pom0	
		sec
		sbc sprite_y,y
_big0a	cmp #35		
		bcs nx3
		
		lda shot_t1,x
		bne szeroki1
		
		lda shot_x,x
		clc
		adc #4	
		sec
		sbc sprite_x,y
		cmp #20
		bcc ms1
		bcs nx3
szeroki1		
		lda shot_x,x
		clc
		adc #6		
		sec
		sbc sprite_x,y
		cmp #22
		bcc ms1
		bcs nx3

//trafiono zwykly obiekt
ms3								
		lda sprite_c1,y
		ora #7
		sta sprite_c1,y
		sec
		lda sprite_shield,y
		bmi nx2
		sbc shot_power
		sta sprite_shield,y
		bcs nx2
		
		stx pom0
		lda sprite_ile,y
		beq ms3a
		pha
		mva #$06 sprite_c1,y		;zbita polowa duszka
		sty pom0a
		pla
		tay

		lda sprite_shield,y
		bmi @+
		ldy pom0a
		jmp nx2			;drugi człon jeszcze cały
;zestrzelono oba człony		
@		
		lda sprite_sz,y
		beq @+
		mva kolor_sprite_tab+1 sprite_c1,y			
		mva #4*5-1 sprite_wybuch,y
		jsr add_explo
		mva #200 licznik_level			;wlacz licznik konca poziomu
		jmp ms3aa
@		
		mva #0 sprite_AI,y
		sta sprite_x,y
		lda sprite_shape,y
		lsr
		bcc ms3aa
		ldy pom0a
		lda sprite_x,y
		adc #8-1
		sta sprite_x,y	

ms3aa	ldy pom0a		
ms3a	
		mva kolor_sprite_tab+1 sprite_c1,y	;kolor wybuchu
		
		lda sprite_glue,y
		;cmp #czolg
		beq @+
		mva kolor_sprite_tab+5 sprite_c1,y			;kolor wybuchu czołgu
		lda #4*4-1
		bne *+4		;jmp
@		equ *
		lda #4*5-1
		sta sprite_wybuch,y
		
		clc
		lda score_add
		adc sprite_score,y
		sta score_add
		
		jsr add_explo

		lda #1
		ldy #5*2	;enemy_hit
		jsr add_fx
		ldx pom0
			
		jmp nx2		

add_explo	
		lda sprite_tall,y
		lsr
		lsr
		cmp #16
		bcs *+4
		sbc #8-1
		clc
		adc sprite_y,y
		sta sprite_y,y
		lda sprite_sz,y
		bne @+
		lda #-4
		ldx sprite_ile,y
		beq *+3
		asl
		clc
		adc sprite_x,y
		sta sprite_x,y
	
@		mva #0 sprite_AI,y
		mva #1 sprite_sz,y
		mva #32 sprite_tall,y
		rts		
		
zmaz_dzialko
		lda cannon_ad1,y
		sta pom
		lda cannon_ad2,y
		sta pom+1
		ldy #0
		tya
		sta (pom),y			;usun dzialko z ekranu
		iny
		sta (pom),y
		ldy #SZER
		sta (pom),y
		iny
		sta (pom),y
		rts		
		
		
.endl		
		
		
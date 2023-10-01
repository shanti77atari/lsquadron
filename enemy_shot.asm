//ostrzal przeciwnikow
MISX_MIN	equ POSX_MIN+7
MISX_MAX	equ POSX_MAX-1
MISY_MIN	equ POSY_MIN+15
MISY_MAX	equ POSY_MAX-2


.local defend

tab_poz_x	dta 0,8		;0,4
tab_poz_y	dta 0,16	;0,8

		
		
tab_shot2		
		dta 4,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
		dta 0,5,7,7,7,7,7,7,8,8,8,8,8,8,8,8
		dta 0,4,5,6,6,6,7,7,7,7,7,7,7,8,8,8
		dta 0,2,3,4,5,5,6,6,6,7,7,7,7,7,8,8
		dta 0,2,3,4,4,5,5,6,6,6,6,6,7,7,7,8
		dta 0,2,2,4,4,4,5,5,6,6,6,6,6,7,7,7
		dta 0,2,2,3,4,4,4,5,5,6,6,6,6,6,6,6
		dta 0,1,2,3,3,4,4,4,5,5,6,6,6,6,6,6
		dta 0,1,2,2,3,3,4,4,4,5,5,5,6,6,6,6
		dta 0,1,2,2,3,3,3,4,4,4,5,5,5,6,6,6
		dta 0,1,1,2,2,3,3,3,4,4,4,5,5,5,5,5
		dta 0,1,1,2,2,2,3,3,3,4,4,4,5,5,5,5
		dta 0,1,1,2,2,2,2,3,3,3,4,4,4,5,5,5
		dta 0,1,1,1,2,2,2,3,3,3,3,4,4,4,4,4
		dta 0,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4
		dta 0,0,1,1,2,2,2,2,3,3,3,3,4,4,4,4
		
tab_shot1		
		dta 4,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
		dta 0,4,5,7,7,7,7,7,7,8,8,8,8,8,8,8
		dta 0,3,4,5,6,6,6,7,7,7,7,7,7,7,7,8
		dta 0,2,3,4,5,5,5,6,6,7,7,7,7,7,7,7
		dta 0,1,3,4,4,4,5,5,6,6,6,6,6,7,7,7
		dta 0,1,2,3,4,4,4,5,5,6,6,6,6,6,7,7
		dta 0,1,2,3,3,4,4,4,5,5,6,6,6,6,6,6
		dta 0,1,1,2,3,3,4,4,4,5,5,6,6,6,6,6
		dta 0,1,1,2,2,3,3,4,4,4,5,5,5,6,6,6
		dta 0,0,1,2,2,3,3,3,4,4,4,5,5,5,6,6
		dta 0,0,1,1,2,2,3,3,3,4,4,4,5,5,5,5
		dta 0,0,1,1,2,2,2,3,3,3,4,4,4,5,5,5
		dta 0,0,1,1,2,2,2,2,3,3,3,4,4,4,5,5
		dta 0,0,1,1,1,2,2,2,3,3,3,3,4,4,4,4
		dta 0,0,1,1,1,2,2,2,2,3,3,3,3,4,4,4
		dta 0,0,0,1,1,2,2,2,2,3,3,3,3,4,4,4		
		
MX0 = 0 
MX15 = 258819
MX27 = 453990
MX37 = 601815
MX45 = 707106
MX54 = 809016
MX64 = 898794
MX76 = 970295
MX90 = 1000000
MY0 = 1000000
MY15 = 965926
MY27 = 891006
MY37 = 798635
MY45 = MX45
MY54 = 587785
MY64 = 438871
MY76 = 241921
MY90 = 0
speed = 256*120/100
speed1 = 256*90/100

//dla enemy
speed_x_m	
		dta <(speed*MX0/1000000),<(speed*MX15/1000000),<(speed*MX27/1000000),<(speed*MX37/1000000),<(speed*MX45/1000000),<(speed*MX54/1000000),<(speed*MX64/1000000),<(speed*MX76/1000000),<(speed*MX90/1000000)
		
speed_x_s
		dta >(speed*MX0/1000000),>(speed*MX15/1000000),>(speed*MX27/1000000),>(speed*MX37/1000000),>(speed*MX45/1000000),>(speed*MX54/1000000),>(speed*MX64/1000000),>(speed*MX76/1000000),>(speed*MX90/1000000)
		
speed_y_m
		dta <(speed*MY0/500000),<(speed*MY15/500000),<(speed*MY27/500000),<(speed*MY37/500000),<(speed*MY45/500000),<(speed*MY54/500000),<(speed*MY64/500000),<(speed*MY76/500000),<(speed*MY90/500000)
		
speed_y_s
		dta >(speed*MY0/500000),>(speed*MY15/500000),>(speed*MY27/500000),>(speed*MY37/500000),>(speed*MY45/500000),>(speed*MY54/500000),>(speed*MY64/500000),>(speed*MY76/500000),>(speed*MY90/500000)
		
//dla działek		
speed_x_m1	
		dta <(speed1*MX0/1000000),<(speed1*MX15/1000000),<(speed1*MX27/1000000),<(speed1*MX37/1000000),<(speed1*MX45/1000000),<(speed1*MX54/1000000),<(speed1*MX64/1000000),<(speed1*MX76/1000000),<(speed1*MX90/1000000)
		
speed_x_s1
		dta >(speed1*MX0/1000000),>(speed1*MX15/1000000),>(speed1*MX27/1000000),>(speed1*MX37/1000000),>(speed1*MX45/1000000),>(speed1*MX54/1000000),>(speed1*MX64/1000000),>(speed1*MX76/1000000),>(speed1*MX90/1000000)
		
speed_y_m1
		dta <(speed1*MY0/500000),<(speed1*MY15/500000),<(speed1*MY27/500000),<(speed1*MY37/500000),<(speed1*MY45/500000),<(speed1*MY54/500000),<(speed1*MY64/500000),<(speed1*MY76/500000),<(speed1*MY90/500000)
		
speed_y_s1
		dta >(speed1*MY0/500000),>(speed1*MY15/500000),>(speed1*MY27/500000),>(speed1*MY37/500000),>(speed1*MY45/500000),>(speed1*MY54/500000),>(speed1*MY64/500000),>(speed1*MY76/500000),>(speed1*MY90/500000)
				
START_LICZNIK	equ %10000000

tabcw_typ	dta t_cannon_w1,t_cannon_w2,t_cannon_w
tabcw_klocek	dta kl_cannon_w1,kl_cannon_w2,kl_cannon_w

zmien_klocek	
		lda cannon_ad1,x
		sta pom
		lda cannon_ad2,x
		sta pom+1
		stx pom0
		ldx tabcw_klocek-15,y
		ldy #0
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
		ldx pom0
		rts			

ustaw_cannon_w	
		jsr zmien_klocek
		mva #0 sprite_wybuch,x
		mva #60 sprite_nxtshoot,x
		lda #8
		sta sprite_licznik,x
		inc licznik_cannon_w
		jmp add_shot_nxt

animuj_cannon_w
		dec sprite_licznik,x
		bne @+1
		ldy sprite_typ,x
		lda tabcw_typ-15,y
		sta sprite_typ,x
		cmp #t_cannon_w
		beq ustaw_cannon_w
		cmp #t_cannon_w1
		bne anc0
		lda random
		cmp #120
		bcc anc1
		sbc #140
		bcs anc1	;jmp 
anc0		
		lda #6
anc1		
		sta sprite_licznik,x
		jsr zmien_klocek
		jmp add_shot_nxt	
		
add_shot
		lda sprite_x
		bne *+3
		rts
		ldx #MAX_SPRITES-1
@		lda sprite_x,x
		beq @+
		cmp #POSX_MIN+4
		bcc @+
		cmp #POSX_MAX-4
		bcs @+
		lda sprite_y,x
		cmp #POSY_MIN+8
		bcc @+
		cmp #POSY_MAX-8
		bcs @+
		
		lda sprite_wybuch,x
		bmi animuj_cannon_w					;<0 to pojawia się działko (odliczamy czas)
		bne @+
		lda sprite_virtual,x
		bne @+1
		lda sprite_licznik,x
		beq @+							;=0 nie strzela
		dec sprite_licznik,x
		bne @+
		lda sprite_nxtshoot,x
		sta sprite_licznik,x
		stx pom0c
		ldy pom0c
		jsr enemy_shot
		ldx pom0c
add_shot_nxt		
@		dex
		bne @-1
		rts
		
@		lda sprite_typ,x
		cmp #t_cannon
		beq *+6				
		cmp #t_cannon_w
		bne @-1				;jeśli nie działko
		dec sprite_licznik,x
		bne @-1
		;ldy sprite_typ,x
		lda sprite_nxtshoot,x
		sta sprite_licznik,x
		stx pom0c
		ldy pom0c
		jsr cannon_shot
		ldx pom0c
		jmp @-1
		
		
cannon_shot
		ldx #MAX_MISSILES-1
@		lda missile_x,x			;szukaj nieuzywanego pocisku
		beq @+
		dex
		bpl @-
		pla
		pla
		rts		;brak wolnych pociskow

		
@		clc
		lda #4
		adc sprite_x,y
		sta missile_x,x			;ustal pozycje poczatkowa pocisku
		
		clc
		lda #8
		adc sprite_y,y
		sta missile_y,x
		lda #0
		sta missile_dx,x
		sta missile_dy,x
		
		lda #1
		sta missile_typ,x	
		stx pom0b			;zapamietaj nr pocisku

		mva #0 pom0		;nr cwiartki
		lda sprite_x,y
		sec
		sbc sprite_x
		bcs @+
		eor #255		;zmieniamy znak
		adc #1
		inc pom0
		
@		lsr
		lsr
		lsr		;dodane
		cmp #16
		bcc *+4
		lda #15		;jeśli poza zakresem to wstaw max
		sta pom0a
		
		lda sprite_y,y
		sec
		sbc sprite_y
		bcs @+
		eor #255		;zmiana znaku
		adc #1
		clc

@		rol pom0
		
		and #%11110000
		ora pom0a
		
		tax
		lda tab_shot2,x
		tax				;nr predkosci	
		
		ldy pom0b
		lda pom0
		bit bit1
		beq @+
		
		lda speed_x_m1,x			
		sta missile_dx_m,y
		lda speed_x_s1,x
		sta missile_dx_s,y
		jmp esy1
		
@		clc						;zmien znak X
		lda speed_x_m1,x
		eor #255
		adc #1
		sta missile_dx_m,y
		lda speed_x_s1,x
		eor #255
		adc #0
		sta missile_dx_s,y
		
		
esy1	lda pom0
		bit bit0
		bne @+
		
		lda speed_y_m1,x		
		sta missile_dy_m,y
		lda speed_y_s1,x
		sta missile_dy_s,y
		rts
		
@		clc
		lda speed_y_m1,x			;zmien znak Y
		eor #255
		adc #1
		sta missile_dy_m,y
		lda speed_y_s1,x
		eor #255
		adc #0
		sta missile_dy_s,y
		rts
		
czolg_tabx	dta 4,7,7,7,4,0,0,0
czolg_taby	dta 0,5,8,10,15,10,7,4		
		
prep_czolg
		lda sprite_p1,y
		beq @+
		;cmp #7				;czy czolg prawidlowo celuje?
		;beq @+
		;cmp #2
		;bcc @+
		
		mva #$20 sprite_licznik,y	;nastepna proba po lepszym wycelowaniu
		rts
		
@		lda sprite_shape,y
		and #%111
		tax
		lda czolg_tabx,x
		sta _sdx+1
		lda czolg_taby,x
		sta _sdy+1
	
		jmp ens1
		

czaszka_shoot
		ldx #MAX_MISSILES-1
@		lda missile_x,x			;szukaj nieuzywanego pocisku
		beq @+
		dex
		bpl @-
@		stx pom0b

		lda #0
		sta missile_dx,x
		sta missile_dy,x
		
		mva #1 missile_typ,x

		lda sprite_sz,y
		asl
		asl
		ora #3
		clc
		adc sprite_x,y
		sta missile_x,x
		
		lda sprite_y,y
		clc
		adc sprite_tall,y
		sta missile_y,x
		stx pom0b
		
		lda random
		and #3
		tax
		lda random
		and #%10
		sta pom0
		
		jmp ens2
		
enemy_shot
		lda sprite_typ,y
		cmp #czolg
		beq prep_czolg
		cmp #big_plane
		beq czaszka_shoot
		cmp #big_plane1
		beq czaszka_shoot
		lda #4
		ldx sprite_sz,y
		beq *+3
		asl						;poprawka pozycji dla roznych wielkosci duszka
		sta _sdx+1
		lda #8
		ldx sprite_tall,y
		beq *+4
		txa
		lsr
		sta _sdy+1
ens1
		ldx #MAX_MISSILES-1
@		lda missile_x,x			;szukaj nieuzywanego pocisku
		beq @+
		dex
		bpl @-
		rts		;brak wolnych pociskow

		
@		clc
_sdx	lda #4
		adc sprite_x,y
		sta missile_x,x			;ustal pozycje poczatkowa pocisku
		
		clc
_sdy	lda #8
		adc sprite_y,y
		sta missile_y,x
		lda #0
		sta missile_dx,x
		sta missile_dy,x
		
		lda sprite_tall,y		;wielkosc pocisku
		sta missile_typ,x	
		stx pom0b			;zapamietaj nr pocisku
		

		mva #0 pom0		;nr cwiartki
		ldx sprite_sz,y
		lda sprite_x,y
		clc
		adc tab_poz_x,x	;poprawka zalezna od szerokosci duszka
		sec
		sbc sprite_x
		bcs @+
		eor #255		;zmieniamy znak
		adc #1
		inc pom0
		
@		lsr
		lsr
		lsr
		cmp #16
		bcc *+4
		lda #15		;jeśli poza zakresem to wstaw max
		sta pom0a
		
		ldx sprite_tall,y
		lda sprite_y,y
		clc
		adc tab_poz_y,x		;poprawka zalezna od wysokosci duszka
		sec
		sbc sprite_y
		bcs @+
		eor #255		;zmiana znaku
		adc #1
		clc

@		rol pom0
		
		and #%11110000
		ora pom0a

		tax
		lda tab_shot2,x
		tax				;nr predkosci
ens2		
		ldy pom0b
		lda pom0
		bit bit1
		beq @+
		
		lda speed_x_m,x			
		sta missile_dx_m,y
		lda speed_x_s,x
		sta missile_dx_s,y
		jmp esy0
		
@		clc						;zmien znak X
		lda speed_x_m,x
		eor #255
		adc #1
		sta missile_dx_m,y
		lda speed_x_s,x
		eor #255
		adc #0
		sta missile_dx_s,y
		
		
esy0	lda pom0
		bit bit0
		bne @+
		
		lda speed_y_m,x		
		sta missile_dy_m,y
		lda speed_y_s,x
		sta missile_dy_s,y
		rts
		
@		clc
		lda speed_y_m,x			;zmien znak Y
		eor #255
		adc #1
		sta missile_dy_m,y
		lda speed_y_s,x
		eor #255
		adc #0
		sta missile_dy_s,y
		rts
		


//porusza pociskami przeciwnikow		
move_missiles
		ldx #MAX_MISSILES-1
@		lda missile_x,x
		bne @+
		dex
		bpl @-
		rts
		
@		clc
		lda missile_dx,x
		adc missile_dx_m,x
		sta missile_dx,x
		lda missile_x,x
		adc missile_dx_s,x
		cmp #MISX_MIN
		bcc poza
		cmp #MISX_MAX
		bcs poza
		sta missile_x,x
		
		clc
		lda missile_dy,x
		adc missile_dy_m,x
		sta missile_dy,x
		lda missile_y,x
		adc missile_dy_s,x
		cmp #MISY_MIN
		bcc poza
		cmp #MISY_MAX
		bcs poza
		sta missile_y,x
		
		dex
		bpl @-1
		rts
		
poza	lda #0
		sta missile_x,x
		dex
		bpl @-1
		rts
		
.endl

		
		



		
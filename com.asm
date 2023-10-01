

.local COM
//przygotowuje początkowe dla planszy
start_colors
		ldx #23+1						;początkowa lista zmiany kolorów w DLI 
@		lda #$1e
		sta blok_nr+4,x
		lda #0
		sta blok_col+4,x
		dex
		bpl @-
		
		ldx #3
@		lda def_kolor0,x
		sta kolor0,x
		dex
		bpl @-



		mwa #level_color_tab bgcol
move0		
		ldy #0
		lda (bgcol),y
		bmi @+		;=255 koniec tabeli	
		bne @+		;>0 to koniec ekranu
		iny
		lda (bgcol),y
		and #%11111000
		cmp #24*8
		bcc @+1
@		rts

@		lsr
		lsr
		lsr
		eor #255
		clc
		adc #23+1
		tax		
		lda (bgcol),y
		and #%111
		clc
		adc #$16
		sta blok_nr+6,x
		sta pom0
		iny
		lda (bgcol),y
		pha
		ldy pom0
		lda kolor0-$16,y
		sta blok_col+6,x
		pla
		sta kolor0-$16,y
		jsr color0
		jmp move0

//zmiana kolorów planszy za pomocą pliku
color
		ldy #0
		lda (bgcol),y
		bmi @+			;jeśli ostatni bit ustawiony to koniec
		cmp linia+1
		bne @+
		iny
		lda (bgcol),y
		and #%11111000		;mlodszy bajt numeru linii
		cmp linia
		beq @+1				;ta linia
@		rts

@		lda (bgcol),y
		and #%111			;trzy najmlodsze bity to nr koloru 0=colpf0,...,4=colbak
		clc
		adc #$16
		tax
		lda kolor0-$16,x
		sta blok_col+5		;zapamietaj stary kolor
		stx blok_nr+5		;zapamietaj nr starego koloru
		iny
		lda (bgcol),y		;nowy kolor
		sta blok_col+4
		stx blok_nr+4
		sta kolor0-$16,x
color0		
		clc
		lda bgcol
		adc #3
		sta bgcol
		bcc @+
		inc bgcol+1
@		rts
		

init		
		stx linia
		sty linia+1
		
		lda #0
		sta check_row
		sta check_row+1
		mwa #level_enemy_tab obrona
		mwa #level_color_tab bgcol
		rts

next	
		ldy #0
		lda (obrona),y
		beq @+
		cmp linia
		beq @+1
@		rts		;nic nie rob
		
@		ldx #0
@		inx
		lda sprite_x,x
		bne @-		
		
@		iny
		lda (obrona),y		;typ obiektow ?
		jpl @+
		cmp #$fe
		bne *+7
		lda #2
		jmp next_end		;komenda wait
		
		cmp #$fc
		bne nx0
		iny
		lda (obrona),y
		:3 lsr
		and #%11111110
		sta depack.start+1
		lda (obrona),y
		asl
		and #%00001110
		sta depack.start+3
		iny
		lda (obrona),y
		sta depack.stop+1
		lda #4
		sta _unpack
		jmp next_end
		
		
nx0		cmp #$fd
		bne nx1
		
		
		lda linia+1
		lsr
		sta check_row+1
		lda linia
		ror		
		lsr check_row+1
		ror
		lsr check_row+1		;linia/32
		ror
		lsr check_row+1
		ror
		lsr check_row+1
		ror
		sta check_row
		
		lda #2
		jsr next_end
		
		
		clc
		lda linia
		adc #32
		and #%11111000
		sta check_linia
		lda linia+1
		adc #0
		sta check_linia+1
		
		
		mwa obrona check_obrona		;przeciwnicy

		rts
		
nx1		iny
		lda (obrona),y
		sta bonus_nr
		iny
		lda (obrona),y
		sta bonus_ile		;ile do zbicia
		lda #4
		jmp next_end
	
//dekodujemy
@		sta sprite_typ,x	;zapamietaj typ obiektu
		tay
		lda typ_anim,y
		sta sprite_anim,x
		lda typ_tall,y
		sta sprite_tall,x
		lda typ_sz,y
		sta sprite_sz,x
		lda typ_glue,y
		sta sprite_glue,x
		lda typ_ile_sprite,y		;czy obiekt jest zlozony z 4 duszkow? >0
		sta sprite_ile,x
		lda typ_anim_speed,y
		sta sprite_anim_speed,x

		lda typ_shield,y
		sta sprite_shield,x
		lda typ_score,y
		sta sprite_score,x

		lda typ_shape,y
		sta _shp1+1
		
		ldy #2
		lda (obrona),y		;kolor
		and #$f0
		ora #$08
		sta sprite_c1,x
		lda #1
		sta sprite_ai,x	;wlaczamy AI
		
		lda (obrona),y
		and #$0f		;poczatkowy kierunek lotu, potrzebny przy łukach
_shp1	ora #$ff		;dodaj ksztalt
		sta sprite_shape,x
		
		lda #0
		sta sprite_virtual,x
		sta sprite_y1,x
		
		iny 
		lda (obrona),y
		sta pom0
		jsr AI.add_path		

		iny
		lda (obrona),y
		sta sprite_x,x
		iny
		lda (obrona),y
		sta sprite_y,x
		lda #0
		sta sprite_dx,x
		sta sprite_dy,x
		iny
		lda (obrona),y
		:4 asl
		cmp #$10
		bne *+4
		lda #$16
		sta sprite_licznik,x
		lda (obrona),y
		and #%11110000
		cmp #$10
		bne *+4
		lda #$16
		sta sprite_nxtshoot,x
		
		lda sprite_ile,x
		jeq next_end-2
		
		ldy #0
@		iny
		lda sprite_x,y		;szukaj wolnego duszka
		bne @-
		
		tya
		sta sprite_ile,x		;zapamietaj numer dodatkowego duszka
		txa
		sta sprite_ile,y		;zaznacz, że to dodatkowy duszek
		
		
		lda #8
		sta _addx+1
		lda sprite_sz,x
		beq *+5
		asl _addx+1
		lda sprite_x,x
		clc
_addx	adc #8				;przesun dodatkowego duszka w prawo
		sta sprite_x,y
		lda sprite_y,x
		sta sprite_y,y
		lda sprite_anim,x
		sta sprite_anim,y
		lda sprite_tall,x
		sta sprite_tall,y		
		lda sprite_glue,x
		sta sprite_glue,y
		sec
		lda sprite_licznik,x
		sbc #$10
		bne *+4
		lda #$0c
		sta sprite_licznik,y
		lda sprite_nxtshoot,x
		sta sprite_nxtshoot,y
		lda sprite_c1,x
		sta sprite_c1,y
		lda sprite_shape,x
		clc
		adc #1
		sta sprite_shape,y		;ksztalt +1
		
		lda #8			;kopiuj ruchy 1 polowki
		sta sprite_ai,y
		lda sprite_sz,x
		sta sprite_sz,y
		beq *+9
		lda sprite_ai,y
		asl 
		sta sprite_ai,y
		lda sprite_ai,y
		ora #128
		sta sprite_ai,y			;kopiuj ruchy pierwszej polowki+ przesuniecie
				
		lda sprite_shield,x
		sta sprite_shield,y
		lda sprite_score,x
		sta sprite_score,y
		lda sprite_typ,x
		sta sprite_typ,y
				
		lda #0
		sta sprite_virtual,y
		sta sprite_dx,y
		sta sprite_dy,y
		sta sprite_y1,y
		
		tya
		tax
		lda pom0
		jsr AI.add_path		;to samo ai
		
		lda #7
next_end		
		clc
		adc obrona
		sta obrona
		bcc @+
		inc obrona+1
@		rts			
	
//wartości
typ_anim	dta	0,252,252,252,254,255,255,252,248,0,248		;maska
typ_tall	dta	0,0,0,0,0,32,64,0,0,0,0
typ_sz		dta	0,0,0,0,0,0,1,0,0,0,0	
typ_glue	dta	0,0,0,0,1,0,0,0,0,1,0
typ_shield	dta	1,2,2,1,3,30,100,2,2,1,1
typ_score	dta	2,5,5,2,7,50,120,5,5,2,2
typ_shape	dta	8,20,24,20,40,48,50,24,56,14,8	
typ_ile_sprite dta 0,0,0,0,0,1,1,0,0,0,0
typ_anim_speed dta 0,7,3,7,7,0,0,3,3,0,7
	
.endl

samolot	equ 0	;pozycja
it			equ 1	;coś ;)
kolko		equ 2	;kółko
it1			equ 3	;slabsze it
czolg		equ 4	;czołg
big_plane	equ 5
big_plane1	equ 6	
gwiazda		equ 7
rakieta		equ 7
moneta		equ 8
samolot1	equ 9
samolot2	equ 10

nshape		equ $fc	; rozpakuj nowy kształt
checkpoint	equ $fd	; checkpoint
wait		equ $fe	;opoznienie
ch_bonus	equ $ff	;zmiana nr bonusa +1 , ile do zbicia
			



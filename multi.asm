//multiplekser
MAX_ENEMY		equ 8		;ile nie virtualnych duszkow
MAX_SPRITES	equ 16+8
POSY_MIN		equ 24+2
POSY_MAX		equ 224
.if SZER=32	
POSX_MIN		equ 57
POSX_MAX		equ 192
.endif
.if SZER=40
POSX_MIN		equ 41
POSX_MAX		equ 208
.endif
MAX_MISSILES	equ 24

		
//16 spritow, 8x16, 3kolory						
				.align
sprite_x		org *+MAX_SPRITES
sprite_dx		org *+MAX_SPRITES		;pozycja po przecinku
sprite_y		org *+MAX_SPRITES
sprite_dy		org *+MAX_SPRITES
sprite_c1		org *+MAX_SPRITES		;kolor duszka
sprite_sz		org *+MAX_SPRITES		;szerkokść duszka
sprite_shape org *+MAX_SPRITES		;nr kształtu
sprite_tall	org *+MAX_SPRITES		;>0 = wysokie duszki
sprite_glue	org *+MAX_SPRITES		;=255 duszek przyklejony do tla, =254 duszek swobodny
sprite_wybuch	org *+MAX_SPRITES		;faza wybuchu
sprite_score	org *+MAX_SPRITES		;punktacja za zestrzelenie
sprite_anim		org *+MAX_SPRITES		;typ animacji 0=8kierunkow 1=4fazy
sprite_shield	org *+MAX_SPRITES			;pole siłowe obiektu
sprite_licznik	org *+MAX_SPRITES		;opoznienie strzalu
sprite_nxtshoot	org	*+MAX_SPRITES		;odstępy pomiędzy strzałami
sprite_typ		org *+MAX_SPRITES		;typ obiektu
sprite_virtual org *+MAX_SPRITES		;czy duszek bedzie rysowany na PM
sprite_AI		org *+MAX_SPRITES
sprite_p0		org *+MAX_SPRITES		;dodatkowy parametr
sprite_p1		org *+MAX_SPRITES
sprite_ile		org *+MAX_SPRITES
sprite_anim_speed	org *+MAX_SPRITES
sprite_y1		org *+MAX_SPRITES
sprite_polowka	org *+MAX_SPRITES

shot_x			org *+8		;pozycja strzalu gracza
shot_y			org *+8 
shot_t1			org *+8		;typ danego strzału	
missile_x		org *+MAX_MISSILES	
missile_dx		org *+MAX_MISSILES	
missile_y		org *+MAX_MISSILES
missile_dy		org *+MAX_MISSILES
missile_dx_m	org *+MAX_MISSILES
missile_dx_s	org *+MAX_MISSILES
missile_dy_m	org *+MAX_MISSILES
missile_dy_s	org *+MAX_MISSILES
missile_typ 	org *+MAX_MISSILES	
	
shot_t0		org *+1		;typ strzału wybrany przez gracza	

wait_vbl
			lda frame_counter
@			cmp frame_counter
			beq @-
			
			rts	
	
//obsluguje cala procedure	
E_multi	

			jsr multi.show_sprites
			
	
			jsr multi.print_shots
			jmp multi.show_missiles



.local multi
spr_flag	equ pom0a
nr_duszka	equ pom0b
poz_y		equ pom0c
duch_dy		equ pom0d
poz_y1		equ pom0e
		
shp_tab1	dta %00100000,%00010000,%00110000,%00110000
			dta %00110000,%00110000,%00010000,%00100000
			
			dta %10000000,%01000000,%11000000,%11000000
			dta %11000000,%11000000,%01000000,%10000000


animuj	
		lda frame_counter
		and #7
		sta _em2+1
		
		ldx #MAX_SPRITES-1					;mryganie trafionych duszkow
@		sec
@		lda sprite_x,x
		beq @+
		
		lda sprite_virtual,x
		bne em2
_em2	lda #$ff
		and sprite_anim_speed,x
		bne em2a
		lda sprite_anim,x
		beq em2a
		bpl em3			;mrygające bonus
		eor #255
		sta _em1-1
		eor #255

		and sprite_shape,x
		sta _em1+1
		inc sprite_shape,x		;animacja przeciwnikow	
		lda sprite_shape,x
		and #$ff				;odwrotnosc maski
_em1	ora #$ff
		sta sprite_shape,x 
		
		
em2a	lda sprite_wybuch,x		;animacja wybuchu
		beq em2
		dec sprite_wybuch,x
		bne em2
		lda #0
		sta sprite_x,x		
		
em2		lda sprite_c1,x
		bit bit012
		beq @+
		sbc #1
		sta sprite_c1,x

@		dex
		bpl @-1
		
		rts
		
em3		sec
		lda sprite_c1,x
		sbc #$14
		sta sprite_c1,x
		dex 
		bpl @-2
		rts

		
//pokaz wszystkie strzaly przeciwnikow
show_missiles
		mva #255 spr_flag
		ldy startm
@		lda missile_x,y
		beq *+5
		jsr print_missiles
		dey
		bpl *+4
		ldy #MAX_MISSILES-1
startm	equ *+1		
		cpy #MAX_MISSILES-1
		bne @-
		
		lda spr_flag
		bmi @+
		sta startm
		
@		lda frame_counter			;obracajacy sie pocisk
		and #%110
		lsr
		tax
		lda shp_tab1,x
		sta _mi0
		lda shp_tab1+4,x
		sta _mi1
		lda shp_tab1+8,x
		sta _mi2
		lda shp_tab1+12,x
		sta _mi3
		
//end_sprite		
		lda #0
		sta sprites+$327
		sta sprites+$427
		sta sprites+$527
		sta sprites+$627
		sta sprites+$727
		sta sprites+$326
		sta sprites+$426
		sta sprites+$526
		sta sprites+$626
		sta sprites+$726

		:7 sta blok_status+#
		:4 sta blok_status+29+#
		
		rts
		
//rysuje strzały przeciwników
print_missiles	
		lda missile_y,y
		sta poz_y1
		clc
		adc przes1
		sta poz_y
		:3 lsr
		tax				;nr pierwszego bloku
		lda missile_typ,y
		beq @+
		
		jmp pr_mis1		;duży pocisk

//maly pocisk 1x2		
@		
		lda poz_y
		and #%111
		cmp #2
		bcc @+1
		cmp #7
		bcc @+
		
		lda blok_status,x		;na samym dole,zachodzi na następny znak
		ora blok_status+1,x
		bpl miss1
		asl
		bpl miss0
		
		lda spr_flag
		bpl _rt1
		sty spr_flag
_rt1	rts	
		
		
		
@		lda blok_status,x		;środek
		bpl miss1
		asl
		bpl	miss0
		
		lda spr_flag
		bpl _rt1
		sty spr_flag
		rts	
		
			
@		lda blok_status-1,x		;na samej górze
		ora blok_status,x
		bpl miss1
		asl
		bpl miss0
		
		lda spr_flag
		bpl _rt1
		sty spr_flag
		rts	
		
//zajmuje missile 0
miss0	lda poz_y
		and #%111
		cmp #2
		bcc @+			;gora lub +1
		cmp #7
		bcc @+1		;srodek
		inx			;na samym dole
@		lda blok_status-1,x	;zajmij missile0
		ora #64
		sta blok_status-1,x
		lda missile_x,y
		sta blok_m2-1,x
@				
		lda blok_status,x
		ora #64
		sta blok_status,x
		lda missile_x,y		;ustaw pozycję missile0
		sta blok_m2,x

//narysuj missile
		ldx poz_y1
		lda sprites+$300,x
		ora #%00100000
		sta sprites+$300,x
		lda sprites+$301,x
		ora #%00100000
		sta sprites+$301,x	
		rts
		
//zajmij missile 1		
miss1		
		lda poz_y
		and #%111
		cmp #2
		bcc @+			;gora
		cmp #7
		bcc @+1		;srodek
		inx			;na samym dole
		
@		lda blok_status-1,x	;zajmij missile1
		ora #128
		sta blok_status-1,x
		lda missile_x,y		;ustaw pozycję missile1
		sta blok_m3-1,x
@				
		lda blok_status,x
		ora #128
		sta blok_status,x
		lda missile_x,y
		sta blok_m3,x
		
//narysuj missile
		ldx poz_y1
		lda sprites+$300,x
		ora #%10000000
		sta sprites+$300,x
		lda sprites+$301,x
		ora #%10000000
		sta sprites+$301,x		
		rts

//duże missile 2x4		
pr_mis1	
		lda poz_y
		and #%111
		cmp #2
		bcs @+
		
//=0, na gorze znaku lub +1
		lda blok_status-1,x
		ora blok_status,x
		jmp bmiss
		
@		cmp #5
		bcc @+
//=%110 ,na samym dole	, przechodzi do nastepnego znaku	
		lda blok_status,x
		ora blok_status+1,x
		jmp bmiss
		
@		lda blok_status,x		;srodek
bmiss
		bpl bmiss1
		asl
		bpl bmiss0
		
		lda spr_flag
		bpl _rt2
		sty spr_flag
		
_rt2	rts			;zajęte

bmiss0	
		lda poz_y
		and #%111
		cmp #2
		bcc @+			;na samej gorze lub +1
		cmp #5
		bcc @+1		;srodek
		inx			;na dole, przechodzi do nastepnego znaku
		
@		lda blok_status-1,x	;zajmij missile0
		ora #64
		sta blok_status-1,x
		lda missile_x,y
		sta blok_m2-1,x
@			
		lda blok_status,x	
		ora #64
		sta blok_status,x
		lda missile_x,y		;ustaw pozycję missile0
		sta blok_m2,x
		
//narysuj missile
		ldx poz_y1
		lda sprites+$300,x
_mi0	equ *+1		
		ora #%00110000
		sta sprites+$300,x
		lda sprites+$301,x	
		ora #%00110000
		sta sprites+$301,x	
		lda sprites+$302,x		
		ora #%00110000
		sta sprites+$302,x
		lda sprites+$303,x	
_mi1	equ *+1		
		ora #%00110000
		sta sprites+$303,x	
		
		rts

bmiss1	
		lda poz_y
		and #%111
		cmp #2
		bcc @+			;na samej gorze lub +1
		cmp #5
		bcc @+1		;srodek
		inx			;na dole, przechodzi do nastepnego znaku
		
@		lda blok_status-1,x	;zajmij missile0
		ora #128
		sta blok_status-1,x
		lda missile_x,y
		sta blok_m3-1,x
@		
		lda blok_status,x	
		ora #128
		sta blok_status,x
		lda missile_x,y		;ustaw pozycję missile0
		sta blok_m3,x
		
//narysuj missile
		ldx poz_y1
		lda sprites+$300,x	
_mi2	equ *+1		
		ora #%11000000
		sta sprites+$300,x
		lda sprites+$301,x	
		ora #%11000000
		sta sprites+$301,x	
		lda sprites+$302,x
		ora #%11000000
		sta sprites+$302,x
		lda sprites+$303,x	
_mi3	equ *+1		
		ora #%11000000
		sta sprites+$303,x	
		
		rts
		

//dodaj nowy strzał na pozycji A,Y
add_shot
		sty _adds1+1
_adds2		
		ldx #6
		
@		dex
		bpl *+4
		ldx #5			;-1 to 5
		
		ldy shot_y,x
		bne @-					;shot_y=0 nie używany strzał
		stx _adds2+1	;zapamietaj 
		
		;cpx #6		;>max
		;bcs @+
		
		sta shot_x,x
_adds1		
		lda #$ff
		sta shot_y,x
		lda shot_t0
		sta shot_t1,x
		
		rts
		
//przesuwa strzały do góry		
move_shots
		ldx #5
		sec
@		lda shot_y,x
		beq @+	
_mvs	sbc #7		;szybkosc strzalu
		cmp #31+8
		bcs *+5
		lda #0			;poza ekranem
		sec
		sta shot_y,x
		lda shot_t1,x
		beq @+
		lda frame_counter
		and #3
		bne @+
		lda shot_x,x
		clc
		adc tabs,x
		sta shot_x,x
		sec
		
@		dex
		bpl @-1
		rts
		
tabs	dta 1,0,255,1,0,255		
		
//rysuje strzaly
print_shots
		ldy #5
@		lda shot_y,y
		bne @+
prs0	dey
		bpl @-
		rts
		
@		clc
		adc przes1
		:3 lsr
		tax
		lda shot_y,y
		clc
		adc przes1

		and #%111
		cmp #2
		bcs @+
		lda shot_x,y			;=0, gora
		;sta blok_m01,x
		sta blok_m01-1,x
		
		lda blok_m01+1,x
		bne *+5
		inc blok_m01+1,x
		
		lda shot_t1,y
		;sta shot_t,x
		sta shot_t-1,x
		jmp prs1
		
@		cmp #5
		bcc @+				;srodek
		lda shot_x,y		;dol, przechodzi do nastepnego znaku	
		sta blok_m01,x
		;sta blok_m01+1,x
		lda blok_m01+2,x
		bne *+5
		inc blok_m01+2,x
		
		lda shot_t1,y
		sta shot_t,x
		;sta shot_t+1,x
		jmp prs1
		
@		lda shot_x,y
		sta blok_m01,x
		lda shot_t1,y
		sta shot_t,x
		
		lda blok_m01+1,x
		bne *+5
		inc blok_m01+1,x

prs1
		ldx shot_y,y
		
		lda shot_t1,y		;typ strzalu
		bne @+
		
		lda #%1001
		sta sprites+$300,x
		sta sprites+$301,x
		;lda #%1111
		sta sprites+$302,x
		;lda #%1001
		sta sprites+$303,x
		sta sprites+$304,x
		sta sprites+$305,x
		jmp prs0 
		
@		lda #%0110
		sta sprites+$300,x
		lda #%1111
		sta sprites+$301,x
		lda #%1111
		;lda #%1001
		sta sprites+$302,x
		lda #%1001
		;lda #0
		sta sprites+$303,x
		jmp prs0

		
//inicjalizacja spritów
init_sprite
		lda #1
		tax
@		sta bit0-1,x
		inx
		asl
		bne @-
		mva #%111 bit012
		mva #5-1 licznik_irq
		
init_sprite1	
		lda #0
		tax
@		sta sprite_x,x
		sta sprite_x+$100,x
		sta sprite_x+$200,x
		dex
		bne @-
		
		ldx #wait_vbl-$300-sprite_x
@		sta sprite_x+$300-1,x
		dex
		bne @-

		ldx #31
		;lda #0
@		sta blok_size01,x
		sta blok_size23,x
		sta blok_m01,x	
		dex
		bpl @- 
		
		
		tax
@		sta sprites+$300,x			;wyczysc duszki
		sta sprites+$400,x
		sta sprites+$500,x
		sta sprites+$600,x
		sta sprites+$700,x
		dex
		bne @-	
		
		mva #MAX_SPRITES-1 start
		mva #MAX_MISSILES-1 startm
		
		mva #$04 colpm0			;zbedne!
		sta colpm2
			
		rts



//narysuj wszystkie duszki
show_sprites		
		ldy #0
		sty blok_size23+5
		sty blok_size01+5
		lda #1
		sta sprite_p0+1
		sta sprite_p0+2
		
		sty spr_flag 
		lda sprite_x
		beq *+5	
		jsr print_sprite			;gracz
		ldy start
		
@		lda sprite_x,y
		beq @+
		ldx sprite_virtual,y
		bne @+
		cmp #POSX_MAX
		bcs @+
		ldx sprite_sz,y
		bne shsprx
		cmp #POSX_MIN
		bcc @+
chy		lda sprite_y,y	
		cmp #POSY_MAX
		bcs @+
		ldx sprite_tall,y
		bne shspry
		cmp #POSY_MIN
		bcc @+
psp		
		jsr print_sprite1
.if .DEF NTSC		
		ldx vcount
		cpx #$8
		bcc *+6
		cpx #$40
		bcc shntsc
.endif		
@		dey
		bne *+4
		ldy #MAX_SPRITES-1
start	equ *+1		
		cpy #$ff
		bne @-1
		
		
		lda spr_flag
		beq @+
		sta start
		
@		rts

.if .DEF NTSC
shntsc	
		lda sprite_p0+1
		beq *+5
		sta sprite_polowka+1
		lda sprite_p0+2
		beq *+5
		sta sprite_polowka+2
		lda spr_flag
		beq *+5
		tay
		bne	*+7
		dey
		bne *+4
		ldy #MAX_SPRITES-1
		sty start
		rts
.endif
shsprx	cmp #POSX_MIN-8
		bcc @-1
		jmp chy			;sprawdz Y
		
shspry	
		cpx #33
		bcs psp				;dla najwyższych duszkiow tall=64, zawsze rysuje, trzeba uważać przy rysowaniu
		cmp #POSY_MIN-16
		bcc @-1
		jmp psp

//narysuj sprite nr w Y
print_sprite
		lda sprite_y,y		;juz odczytane
print_sprite1
		clc
		sta poz_y1
		adc przes1
		sta poz_y
		:3 lsr
		tax				;nr pierwszego bloku
		lda poz_y
		and #%111
		sta duch_dy

		bne *+3
		dex				;jesli dy=0 to zmniejsz nr pierwszego bloku
		
		lda sprite_tall,y
		jne tall_spr			;wysokie sprity

		lda blok_status,x
		ora blok_status+1,x
		ora blok_status+2,x
		lsr
		bcc @+
		lsr
		jcc @+1
		
		lda spr_flag
		bne *+4
		sty spr_flag
		rts			;nie można narysować duszka
		
		
@		inc blok_status,x
		;inc blok_status+1,x
		inc blok_status+2,x
		
//ustawienie pozycji i koloru duszków w bloku	
		lda blok_x01+3,x	
		bne *+5
		inc blok_x01+3,x

		;lda #0
		;sta blok_x01+1,x
		;sta blok_x01+2,x
		cpx #5
		bcs *+4
		ldx #5
				
		lda sprite_x,y		;sprite 0 i 1
		sta blok_x01,x


		lda sprite_c1,y
		sta blok_c1,x
		;sta blok_c1+1,x
		;sta blok_c1+2,x
		
		lda sprite_sz,y
		sta blok_size01,x
		;sta blok_size01+1,x
		;sta blok_size01+2,x
		
			
		lda sprite_wybuch,y
		beq psp1a
		ldx sprite_glue,y
		beq *+4
		ora #64		;drugi wybuch
		
		lsr
		lsr
		tax
		bpl psp1b
	
psp1a	ldx sprite_shape,y		;ustalamy adres procedury kształtu	
psp1b	lda shape_tab01,x
		sta _psp1+1
		lda shape_tab01+128,x
		sta _psp1+2
		
		sty nr_duszka
		ldx poz_y1
_psp1	equ *		
		jsr $ffff
		ldy nr_duszka
		
.if .def BORDER
		lda sprite_x,y
		cmp #POSX_MIN+7
		bcs e3
		jsr czyscL01
		jmp e2
e3		cmp #POSX_MAX-7
		bcc e2
		jsr czyscR01
e2		equ * 
		ldx poz_y1
.endif 

		ldy duch_dy
		lda tab_skok01,y
		ldy nr_duszka
		
		sta l01
		lda #0
l01	equ *+1		
		jmp dy0 
		

@		lda #2
		ora blok_status,x			;zajmij wybranego duszka w statusie
		sta blok_status,x
		;lda #2
		;ora blok_status+1,x			
		;sta blok_status+1,x
		lda #2
		ora blok_status+2,x		
		sta blok_status+2,x


		lda blok_x23+3,x
		bne *+5
		inc blok_x23+3,x
		
		;lda #0
		;sta blok_x23+1,x
		;sta blok_x23+2,x
		
		cpx #5
		bcs *+4
		ldx #5
						
		lda sprite_x,y			;sprite 2 i 3
		sta blok_x23,x

		lda sprite_c1,y
		sta blok_c3,x	
		;sta blok_c3+1,x
		;sta blok_c3+2,x
		
		lda sprite_sz,y
		sta blok_size23,x
		;sta blok_size23+1,x
		;sta blok_size23+2,x
		

		lda sprite_wybuch,y
		beq psp2a
		ldx sprite_glue,y
		beq *+4
		ora #64		;drugi wybuch
		
		lsr
		lsr
		tax
		bpl psp2b
		
psp2a	ldx sprite_shape,y		;ustalamy adres procedury kształtu		
psp2b	lda shape_tab23,x
		sta _psp2+1
		lda shape_tab23+128,x
		sta _psp2+2
			
		sty nr_duszka
		ldx poz_y1
_psp2	equ *		
		jsr $ffff
		ldy nr_duszka

.if .def BORDER		
		lda sprite_x,y
		cmp #POSX_MIN+7
		bcs e1
		jsr czyscL23
		jmp e0
e1		cmp #POSX_MAX-7
		bcc e0
		jsr czyscR23
e0		equ *
		ldx poz_y1
.endif		 
		
		ldy duch_dy
		lda tab_skok23,y
		ldy nr_duszka
		
		sta l23
		lda #0
l23	equ *+1		
		jmp dy0b

//wysokie sprity		
tall_spr	equ *
		cmp #64
		bne tall_spr32

//64 wysokosci!
		lda blok_status,x
		ora blok_status+1,x
		ora blok_status+4,x
		ora blok_status+5,x
		ora blok_status+7,x
		ora blok_status+8,x
		lsr 
		bcc @+
		lsr
		bcc @+1
		
		lda spr_flag
		bne *+4
		sty spr_flag
		lda #1
		;sta sprite_y1,y
		;sta sprite_shape1,y
		sta sprite_polowka+1
		sta sprite_polowka+2
		rts			;nie można narysować duszka		
		
@		inc blok_status,x
		inc blok_status+1,x
		inc blok_status+4,x
		inc blok_status+5,x
		inc blok_status+7,x
		inc blok_status+8,x
		
		lda blok_x01+9,x
		bne *+5
		inc blok_x01+9,x
		
		jmp tall_spr01
		
@		lda #2
		ora blok_status,x
		sta blok_status,x
		lda #2
		ora blok_status+1,x
		sta blok_status+1,x
		lda #2
		ora blok_status+4,x
		sta blok_status+4,x
		lda #2
		ora blok_status+5,x
		sta blok_status+5,x
		lda #2
		ora blok_status+7,x
		sta blok_status+7,x
		lda #2
		ora blok_status+8,x
		sta blok_status+8,x
		
		lda blok_x23+9,x
		bne *+5
		inc blok_x23+9,x
		
		jmp tall_spr23		
		
tall_spr32		
		lda blok_status,x
		ora blok_status+1,x
		;ora blok_status+2,x
		ora blok_status+3,x
		ora blok_status+4,x
		lsr
		bcc @+
		lsr
		jcc @+1
		lda spr_flag
		bne *+4
		sty spr_flag
		rts			;nie można narysować duszka
		
		
@		inc blok_status,x
		;inc blok_status+1,x
		inc blok_status+2,x
		;inc blok_status+3,x
		inc blok_status+4,x
		
//ustawienie pozycji i koloru duszków w bloku	
		lda blok_x01+5,x
		bne *+5
		inc blok_x01+5,x

		;lda #0
		;sta blok_x01+1,x
		;sta blok_x01+2,x
		;sta blok_x01+3,x
		;sta blok_x01+4,x
tall_spr01		
		cpx #5
		bcs *+4
		ldx #5
				
		lda sprite_x,y		;sprite 0 i 1
		sta blok_x01,x


		lda sprite_c1,y
		sta blok_c1,x
		;sta blok_c1+1,x
		;sta blok_c1+2,x
		;sta blok_c1+3,x
		;sta blok_c1+4,x
		
		lda sprite_sz,y
		sta blok_size01,x
		;sta blok_size01+1,x
		;sta blok_size01+2,x
		;sta blok_size01+3,x
		;sta blok_size01+4,x
		
		lda sprite_wybuch,y
		beq psp3a
		ldx sprite_glue,y
		beq *+4
		ora #64		;drugi wybuch		
		lsr
		lsr
		tax
		bpl psp3b
		
		
psp3a	ldx sprite_shape,y		;ustalamy adres procedury kształtu
psp3b	lda shape_tab01,x
		sta _psp3+1
		lda shape_tab01+128,x
		sta _psp3+2
		
		ldx poz_y1
		sty nr_duszka
_psp3	equ *		
		jsr $ffff
		ldy nr_duszka
		
.if .def BORDER
		lda sprite_tall,y
		asl
		bmi e2t				;pomin dla tall=64
		lda sprite_sz,y
		bne e3t0
		lda sprite_x,y
		cmp #POSX_MIN+7
		bcs *+10
		;sec
		sbc #POSX_MIN-1
		jsr czyscLR01t
		jmp e2t
		cmp #POSX_MAX-7
		bcc e2t
		;sec
		sbc #POSX_MAX-14
		jsr czyscLR01t
		jmp e2t
e3t0
		lda sprite_x,y
		cmp #POSX_MIN+7
		bcs e3t
		jsr czyscL01t
		jmp e2t
e3t		cmp #POSX_MAX-12
		bcc e2t
		jsr czyscR01t
e2t		equ * 	
		;ldx poz_y1
.endif 		
		ldx duch_dy
		ldy nr_duszka
		lda sprite_tall,y
		asl
		bmi l01c
		
		lda tab_skok01b,x
		ldx poz_y1
		
		sta l01b
		lda #0
l01b	equ *+1		
		jmp dy0c
		
l01c
		lda tab_skok01c,x
		ldx poz_y1
		sta l01d
		lda #0
l01d	equ *+1		
		jmp dy0e
		

@		lda #2
		ora blok_status,x			;zajmij wybranego duszka w statusie
		sta blok_status,x
		;lda #2
		;ora blok_status+1,x			
		;sta blok_status+1,x
		lda #2
		ora blok_status+2,x		
		sta blok_status+2,x
		;lda #2
		;ora blok_status+3,x		
		;sta blok_status+3,x
		lda #2
		ora blok_status+4,x		
		sta blok_status+4,x

		
		lda blok_x23+5,x
		bne *+5
		inc blok_x23+5,x
		
		;lda #0
		;sta blok_x23+1,x
		;sta blok_x23+2,x
		;sta blok_x23+3,x
		;sta blok_x23+4,x
tall_spr23		
		cpx #5
		bcs *+4
		ldx #5
		
		lda sprite_x,y			;sprite 2 i 3
		sta blok_x23,x
		

		lda sprite_c1,y
		sta blok_c3,x	
		;sta blok_c3+1,x
		;sta blok_c3+2,x
		;sta blok_c3+3,x
		;sta blok_c3+4,x
		
		lda sprite_sz,y
		sta blok_size23,x
		;sta blok_size23+1,x
		;sta blok_size23+2,x
		;sta blok_size23+3,x
		;sta blok_size23+4,x

		lda sprite_wybuch,y
		beq psp4a
		ldx sprite_glue,y
		beq *+4
		ora #64		;drugi wybuch
		
		lsr
		lsr
		tax
		bpl psp4b		
		
psp4a	ldx sprite_shape,y		;ustalamy adres procedury kształtu
psp4b	lda shape_tab23,x
		sta _psp4+1
		lda shape_tab23+128,x
		sta _psp4+2
			
		ldx poz_y1
		sty nr_duszka
_psp4	equ *		
		jsr $ffff
		ldy nr_duszka
		
.if .def BORDER
		lda sprite_tall,y
		asl
		bmi e0t				;dla tall=64 pomin
		lda sprite_sz,y
		bne e1t0
		lda sprite_x,y
		cmp #POSX_MIN+7
		bcs *+10
		;sec
		sbc #POSX_MIN-1
		jsr czyscLR23t
		jmp e0t
		cmp #POSX_MAX-7
		bcc e0t
		;sec
		sbc #POSX_MAX-14
		jsr czyscLR23t
		jmp e0t
e1t0
		lda sprite_x,y
		cmp #POSX_MIN+7
		bcs e1t
		jsr czyscL23t
		jmp e0t
e1t		cmp #POSX_MAX-12
		bcc e0t
		jsr czyscR23t
e0t		equ *
		;ldx poz_y1
.endif			
	
		ldx duch_dy
		ldy nr_duszka
		lda sprite_tall,y
		asl
		bmi l23c
		
		lda tab_skok23b,x
		ldx poz_y1
		
		sta l23b
		lda #0
l23b	equ *+1		
		jmp dy0d
		
l23c	
		lda tab_skok23c,x
		ldx poz_y1
		
		sta l23d
		lda #0
l23d	equ *+1		
		jmp dy0f			
		
.if .def BORDER		
tab01	dta %00000001,%00000011,%00000111,%00001111,%00011111,%00111111,%01111111	
		dta %11111110,%11111100,%11111000,%11110000,%11100000,%11000000,%10000000


czyscR01t
		sec
		sbc #POSX_MAX-12
		lsr
		ora #8
		jmp @+
		
czyscL01t
		sec
		sbc #POSX_MIN-8
		lsr
czyscLR01t		
@		ldx sprite_tall,y
		tay
		lda tab01,y
		sta pom0
czysc01		
		ldy poz_y1
@		lda sprites+$400,y
		and pom0
		sta sprites+$400,y
		lda sprites+$500,y
		and pom0
		sta sprites+$500,y
		iny
		dex
		bne @-
		rts
		
czyscR01	
		sec
		sbc #POSX_MAX-14
		jmp @+
czyscL01
		sec
		sbc #POSX_MIN
@		tay
		lda tab01,y
		sta pom0
		ldx #16
		jmp czysc01


czyscR23t
		sec
		sbc #POSX_MAX-12
		lsr
		ora #8
		jmp @+
czyscL23t
		sec
		sbc #POSX_MIN-8
		lsr
czyscLR23t		
@		ldx sprite_tall,y
		tay
		lda tab01,y
		sta pom0
czysc23		
		ldy poz_y1
@		lda sprites+$600,y
		and pom0
		sta sprites+$600,y
		lda sprites+$700,y
		and pom0
		sta sprites+$700,y
		iny
		dex
		bne @-
		rts	

czyscR23
		sec
		sbc #POSX_MAX-14
		jmp @+
czyscL23
		sec
		sbc #POSX_MIN
@		tay
		lda tab01,y
		sta pom0
		ldx #16
		jmp czysc23
		
.endif		

		icl 'sprites.asm'

		
		.align
		
shape_tab01
		dta <wybuch0a,<wybuch1a,<wybuch2a,<wybuch3a,<wybuch4a,0,<samolot8a,<samolot9a		;#0
		dta <samolot0a,<samolot1a,<samolot2a,<samolot3a		;#8
		dta <samolot4a,<samolot5a,<samolot6a,<samolot7a
		dta <explo3a,<explo2a,<explo1a,<explo0a					;#16
		dta <it0a,<it1a,<it2a,<it3a						;#20		cos
		dta <it4a,<it5a,<it6a,<it7a							;#24	kolko,gwiazda
		dta <ksztalt1a,<ksztalt1a,<ksztalt1a,<ksztalt1a		;#28
		dta <tank0a,<tank1a,<tank2a,<tank3a		;32		tank obrót
		dta <tank4a,<tank5a,<tank6a,<tank7a
		dta <tank2a,<tank9a,<tank6a,<tank8a		;40,42  tankL,tankP
		dta <speed_bonus0a,<zbroja_bonus0a,<arrow_bonus0a,0				;44	bonusy
		dta <big_plane0a,<big_plane1a,<test0a,<test1a					;48 sredni i duzy samolot
		dta 0,0,0,0
		dta <it0a,<it1a,<it2a,<it3a,<it4a,<it5a,<it0a,<it0a			;moneta	56
_ad0	equ *		
		:128-(_ad0-shape_tab01) dta 0
		
		dta >wybuch0a,>wybuch1a,>wybuch2a,>wybuch3a,>wybuch4a,0,>samolot8a,>samolot9a
		dta >samolot0a,>samolot1a,>samolot2a,>samolot3a
		dta >samolot4a,>samolot5a,>samolot6a,>samolot7a
		dta >explo3a,>explo2a,>explo1a,>explo0a
		dta >it0a,>it1a,>it2a,>it3a
		dta >it4a,>it5a,>it6a,>it7a
		dta >ksztalt1a,>ksztalt1a,>ksztalt1a,>ksztalt1a
		dta >tank0a,>tank1a,>tank2a,>tank3a
		dta >tank4a,>tank5a,>tank6a,>tank7a
		dta >tank2a,>tank9a,>tank6a,>tank8a	
		dta >speed_bonus0a,>zbroja_bonus0a,>arrow_bonus0a,0	
		dta >big_plane0a,>big_plane1a,>test0a,>test1a
		dta 0,0,0,0
		dta >it0a,>it1a,>it2a,>it3a,>it4a,>it5a,>it0a,>it0a
_ad1	equ *		
		:256-(_ad1-shape_tab01) dta 0		

shape_tab23
		dta <wybuch0b,<wybuch1b,<wybuch2b,<wybuch3b,<wybuch4b,0,0,0
		dta <samolot0b,<samolot1b,<samolot2b,<samolot3b
		dta <samolot4b,<samolot5b,<samolot6b,<samolot7b
		dta <explo3b,<explo2b,<explo1b,<explo0b
		dta <it0b,<it1b,<it2b,<it3b
		dta <it4b,<it5b,<it6b,<it7b
		dta <ksztalt1b,<ksztalt1b,<ksztalt1b,<ksztalt1b
		dta <tank0b,<tank1b,<tank2b,<tank3b
		dta <tank4b,<tank5b,<tank6b,<tank7b
		dta <tank2b,<tank9b,<tank6b,<tank8b
		dta <speed_bonus0b,<zbroja_bonus0b,<arrow_bonus0b,0
		dta <big_plane0b,<big_plane1b,<test0b,<test1b
		dta 0,0,0,0
		dta <it0b,<it1b,<it2b,<it3b,<it4b,<it5b,<it0b,<it0b
_ad2	equ *		
		:128-(_ad2-shape_tab23) dta 0		

		dta >wybuch0b,>wybuch1b,>wybuch2b,>wybuch3b,>wybuch4b,0,0,0
		dta >samolot0b,>samolot1b,>samolot2b,>samolot3b
		dta >samolot4b,>samolot5b,>samolot6b,>samolot7b
		dta >explo3b,>explo2b,>explo1b,>explo0b
		dta >it0b,>it1b,>it2b,>it3b
		dta >it4b,>it5b,>it6b,>it7b
		dta >ksztalt1b,>ksztalt1b,>ksztalt1b,>ksztalt1b
		dta >tank0b,>tank1b,>tank2b,>tank3b
		dta >tank4b,>tank5b,>tank6b,>tank7b
		dta >tank2b,>tank9b,>tank6b,>tank8b
		dta >speed_bonus0b,>zbroja_bonus0b,>arrow_bonus0b,0
		dta >big_plane0b,>big_plane1b,>test0b,>test1b
		dta 0,0,0,0
		dta >it0b,>it1b,>it2b,>it3b,>it4b,>it5b,>it0b,>it0b
_ad3	equ *		
		:256-(_ad3-shape_tab23) dta 0			
		
tab_skok01	dta <dy0,<dy1,<dy2,<dy3,<dy4,<dy5,<dy6,<dy7		

		
dy0		
		sta sprites+$400+$10,x
		sta sprites+$500+$10,x
			
		sta sprites+$400-8,x
		sta sprites+$400-7,x
		sta sprites+$400-6,x
		sta sprites+$400-5,x
		sta sprites+$400-4,x
		sta sprites+$400-3,x
		sta sprites+$400-2,x
		sta sprites+$400-1,x
		
		sta sprites+$500-8,x		
		sta sprites+$500-7,x
		sta sprites+$500-6,x
		sta sprites+$500-5,x
		sta sprites+$500-4,x
		sta sprites+$500-3,x
		sta sprites+$500-2,x
		sta sprites+$500-1,x
		
		rts
		
dy1
		sta sprites+$400+$13,x
		sta sprites+$500+$13,x
		sta sprites+$400+$14,x
		sta sprites+$500+$14,x
		sta sprites+$400+$15,x
		sta sprites+$500+$15,x
		sta sprites+$400+$16,x
		sta sprites+$500+$16,x
		sta sprites+$400+$17,x
		sta sprites+$500+$17,x
		sta sprites+$400+$18,x
		sta sprites+$500+$18,x
		jmp dy7+36
		
		
dy2	
		sta sprites+$400+$13,x
		sta sprites+$500+$13,x
		sta sprites+$400+$14,x
		sta sprites+$500+$14,x
		sta sprites+$400+$15,x
		sta sprites+$500+$15,x
		sta sprites+$400+$16,x
		sta sprites+$500+$16,x
		sta sprites+$400+$17,x
		sta sprites+$500+$17,x
		jmp dy7+30
		
dy3	
		sta sprites+$400+$13,x
		sta sprites+$500+$13,x
		sta sprites+$400+$14,x
		sta sprites+$500+$14,x
		sta sprites+$400+$15,x
		sta sprites+$500+$15,x
		sta sprites+$400+$16,x
		sta sprites+$500+$16,x
		jmp dy7+24
		
dy4
		sta sprites+$400+$13,x
		sta sprites+$500+$13,x
		sta sprites+$400+$14,x
		sta sprites+$500+$14,x
		sta sprites+$400+$15,x
		sta sprites+$500+$15,x
		jmp dy7+18		
		
		
dy5	
		cpx #POSY_MAX-32
		bcs dy7+12
		sta sprites+$400+$13,x
		sta sprites+$500+$13,x
		sta sprites+$400+$14,x
		sta sprites+$500+$14,x
		jmp dy7+12		
		
dy6		
		sta sprites+$400+$13,x
		sta sprites+$500+$13,x
		jmp dy7+6
		
dy7
		sta sprites+$400-7,x
		sta sprites+$500-7,x
		sta sprites+$400-6,x
		sta sprites+$500-6,x
		sta sprites+$400-5,x
		sta sprites+$500-5,x
		sta sprites+$400-4,x
		sta sprites+$500-4,x		
		sta sprites+$400-3,x
		sta sprites+$500-3,x
		sta sprites+$400-2,x
		sta sprites+$500-2,x
		sta sprites+$400-1,x		
		sta sprites+$500-1,x
		
		sta sprites+$400+$10,x		
		sta sprites+$400+$11,x
		sta sprites+$400+$12,x
		sta sprites+$500+$10,x		
		sta sprites+$500+$11,x
		sta sprites+$500+$12,x
		rts

		
		.align
		
tab_skok23	dta <dy0b,<dy1b,<dy2b,<dy3b,<dy4b,<dy5b,<dy6b,<dy7b		

		
dy0b	
		sta sprites+$600+$11,x
		sta sprites+$700+$11,x 
	
		sta sprites+$600+$10,x
		sta sprites+$700+$10,x
		
		sta sprites+$600-8,x
		sta sprites+$600-7,x
		sta sprites+$600-6,x
		sta sprites+$600-5,x
		sta sprites+$600-4,x
		sta sprites+$600-3,x
		sta sprites+$600-2,x
		sta sprites+$600-1,x
		
		sta sprites+$700-8,x		
		sta sprites+$700-7,x
		sta sprites+$700-6,x
		sta sprites+$700-5,x
		sta sprites+$700-4,x
		sta sprites+$700-3,x
		sta sprites+$700-2,x
		sta sprites+$700-1,x
		
		rts
		
dy1b
		sta sprites+$600+$13,x
		sta sprites+$700+$13,x
		sta sprites+$600+$14,x
		sta sprites+$700+$14,x
		sta sprites+$600+$15,x
		sta sprites+$700+$15,x
		sta sprites+$600+$16,x
		sta sprites+$700+$16,x
		sta sprites+$600+$17,x
		sta sprites+$700+$17,x
		sta sprites+$600+$18,x
		sta sprites+$700+$18,x
		jmp dy7b+36
		
		
dy2b	
		sta sprites+$600+$13,x
		sta sprites+$700+$13,x
		sta sprites+$600+$14,x
		sta sprites+$700+$14,x
		sta sprites+$600+$15,x
		sta sprites+$700+$15,x
		sta sprites+$600+$16,x
		sta sprites+$700+$16,x
		sta sprites+$600+$17,x
		sta sprites+$700+$17,x
		jmp dy7b+30
		
dy3b	
		sta sprites+$600+$13,x
		sta sprites+$700+$13,x
		sta sprites+$600+$14,x
		sta sprites+$700+$14,x
		sta sprites+$600+$15,x
		sta sprites+$700+$15,x
		sta sprites+$600+$16,x
		sta sprites+$700+$16,x
		jmp dy7b+24
		
dy4b
		sta sprites+$600+$13,x
		sta sprites+$700+$13,x
		sta sprites+$600+$14,x
		sta sprites+$700+$14,x
		sta sprites+$600+$15,x
		sta sprites+$700+$15,x
		jmp dy7b+18
		
dy5b	
		sta sprites+$600+$13,x
		sta sprites+$700+$13,x
		sta sprites+$600+$14,x
		sta sprites+$700+$14,x
		jmp dy7b+12		
		
		
dy6b		
		sta sprites+$600+$13,x
		sta sprites+$700+$13,x
		jmp dy7b+6

dy7b
		sta sprites+$600-7,x
		sta sprites+$700-7,x
		sta sprites+$600-6,x
		sta sprites+$700-6,x
		sta sprites+$600-5,x
		sta sprites+$700-5,x
		sta sprites+$600-4,x
		sta sprites+$700-4,x		
		sta sprites+$600-3,x
		sta sprites+$700-3,x
		sta sprites+$600-2,x
		sta sprites+$700-2,x
		sta sprites+$600-1,x		
		sta sprites+$700-1,x
		
		sta sprites+$600+$10,x		
		sta sprites+$600+$11,x
		sta sprites+$600+$12,x
		sta sprites+$700+$10,x		
		sta sprites+$700+$11,x
		sta sprites+$700+$12,x
		rts	
		
		
		.align
//wymazywanie przy wysokich duszkach		
tab_skok01b	dta <dy0c,<dy1c,<dy2c,<dy3c,<dy4c,<dy5c,<dy6c,<dy7c		

		
dy0c	
		cpx #POSY_MAX-32
		bcs @+
		
		sta sprites+$400+$20,x
		sta sprites+$500+$20,x
			
@		sta sprites+$400-8,x
		sta sprites+$400-7,x
		sta sprites+$400-6,x
		sta sprites+$400-5,x
		sta sprites+$400-4,x
		sta sprites+$400-3,x
		sta sprites+$400-2,x
		sta sprites+$400-1,x
		
		sta sprites+$500-8,x		
		sta sprites+$500-7,x
		sta sprites+$500-6,x
		sta sprites+$500-5,x
		sta sprites+$500-4,x
		sta sprites+$500-3,x
		sta sprites+$500-2,x
		sta sprites+$500-1,x
		
		rts
		
dy1c
		cpx #POSY_MAX-32
		bcs @+
		sta sprites+$400+$23,x
		sta sprites+$500+$23,x
		sta sprites+$400+$24,x
		sta sprites+$500+$24,x
		sta sprites+$400+$25,x
		sta sprites+$500+$25,x
		sta sprites+$400+$26,x
		sta sprites+$500+$26,x
		sta sprites+$400+$27,x
		sta sprites+$500+$27,x
		sta sprites+$400+$28,x
		sta sprites+$500+$28,x
@		jmp dy7c+36
		
		
dy2c	
		cpx #POSY_MAX-32
		bcs @+
		sta sprites+$400+$23,x
		sta sprites+$500+$23,x
		sta sprites+$400+$24,x
		sta sprites+$500+$24,x
		sta sprites+$400+$25,x
		sta sprites+$500+$25,x
		sta sprites+$400+$26,x
		sta sprites+$500+$26,x
		sta sprites+$400+$27,x
		sta sprites+$500+$27,x
@		jmp dy7c+30
		
dy3c	
		cpx #POSY_MAX-32
		bcs dy7c+24
		sta sprites+$400+$23,x
		sta sprites+$500+$23,x
		sta sprites+$400+$24,x
		sta sprites+$500+$24,x
		sta sprites+$400+$25,x
		sta sprites+$500+$25,x
		sta sprites+$400+$26,x
		sta sprites+$500+$26,x
		jmp dy7c+24
		
dy4c
		cpx #POSY_MAX-32
		bcs dy7c+18
		sta sprites+$400+$23,x
		sta sprites+$500+$23,x
		sta sprites+$400+$24,x
		sta sprites+$500+$24,x
		sta sprites+$400+$25,x
		sta sprites+$500+$25,x
		jmp dy7c+18
		
	
		
dy5c	
		cpx #POSY_MAX-32
		bcs dy7c+12
		sta sprites+$400+$23,x
		sta sprites+$500+$23,x
		sta sprites+$400+$24,x
		sta sprites+$500+$24,x
		jmp dy7c+12		
		
		
dy6c	
		cpx #POSY_MAX-32
		bcs dy7c+6
		sta sprites+$400+$23,x
		sta sprites+$500+$23,x
		jmp dy7c+6
		
dy7c
		sta sprites+$400-7,x
		sta sprites+$500-7,x
		sta sprites+$400-6,x
		sta sprites+$500-6,x
		sta sprites+$400-5,x
		sta sprites+$500-5,x
		sta sprites+$400-4,x
		sta sprites+$500-4,x		
		sta sprites+$400-3,x
		sta sprites+$500-3,x
		sta sprites+$400-2,x
		sta sprites+$500-2,x
		sta sprites+$400-1,x		
		sta sprites+$500-1,x
		
		cpx #POSY_MAX-32
		bcs @+
		sta sprites+$400+$20,x		
		sta sprites+$400+$21,x
		sta sprites+$400+$22,x
		sta sprites+$500+$20,x		
		sta sprites+$500+$21,x
		sta sprites+$500+$22,x
@		rts	


		.align
		
tab_skok23b	dta <dy0d,<dy1d,<dy2d,<dy3d,<dy4d,<dy5d,<dy6d,<dy7d		

		
dy0d	
		cpx #POSY_MAX-32
		bcs @+
		
		sta sprites+$600+$21,x
		sta sprites+$700+$21,x
		
		sta sprites+$600+$20,x
		sta sprites+$700+$20,x
		
@		sta sprites+$600-8,x
		sta sprites+$600-7,x
		sta sprites+$600-6,x
		sta sprites+$600-5,x
		sta sprites+$600-4,x
		sta sprites+$600-3,x
		sta sprites+$600-2,x
		sta sprites+$600-1,x
		
		sta sprites+$700-8,x		
		sta sprites+$700-7,x
		sta sprites+$700-6,x
		sta sprites+$700-5,x
		sta sprites+$700-4,x
		sta sprites+$700-3,x
		sta sprites+$700-2,x
		sta sprites+$700-1,x
		
		rts
		
dy1d
		cpx #POSY_MAX-32
		bcs @+
		sta sprites+$600+$23,x
		sta sprites+$700+$23,x
		sta sprites+$600+$24,x
		sta sprites+$700+$24,x
		sta sprites+$600+$25,x
		sta sprites+$700+$25,x
		sta sprites+$600+$26,x
		sta sprites+$700+$26,x
		sta sprites+$600+$27,x
		sta sprites+$700+$27,x
		sta sprites+$600+$28,x
		sta sprites+$700+$28,x
@		jmp dy7d+36
		
dy2d	
		cpx #POSY_MAX-32
		bcs @+
		sta sprites+$600+$23,x
		sta sprites+$700+$23,x
		sta sprites+$600+$24,x
		sta sprites+$700+$24,x
		sta sprites+$600+$25,x
		sta sprites+$700+$25,x
		sta sprites+$600+$26,x
		sta sprites+$700+$26,x
		sta sprites+$600+$27,x
		sta sprites+$700+$27,x
@		jmp dy7d+30
		
dy3d	
		cpx #POSY_MAX-32
		bcs dy7d+24
		sta sprites+$600+$23,x
		sta sprites+$700+$23,x
		sta sprites+$600+$24,x
		sta sprites+$700+$24,x
		sta sprites+$600+$25,x
		sta sprites+$700+$25,x
		sta sprites+$600+$26,x
		sta sprites+$700+$26,x
		jmp dy7d+24
		
dy4d
		cpx #POSY_MAX-32
		bcs dy7d+18
		sta sprites+$600+$23,x
		sta sprites+$700+$23,x
		sta sprites+$600+$24,x
		sta sprites+$700+$24,x
		sta sprites+$600+$25,x
		sta sprites+$700+$25,x
		jmp dy7d+18
		
		
		
dy5d	
		cpx #POSY_MAX-32
		bcs dy7d+12
		sta sprites+$600+$23,x
		sta sprites+$700+$23,x
		sta sprites+$600+$24,x
		sta sprites+$700+$24,x
		jmp dy7d+12		
		
		
dy6d	
		cpx #POSY_MAX-32
		bcs dy7d+6
		sta sprites+$600+$23,x
		sta sprites+$700+$23,x
		jmp dy7d+6

dy7d
		sta sprites+$600-7,x
		sta sprites+$700-7,x
		sta sprites+$600-6,x
		sta sprites+$700-6,x
		sta sprites+$600-5,x
		sta sprites+$700-5,x
		sta sprites+$600-4,x
		sta sprites+$700-4,x		
		sta sprites+$600-3,x
		sta sprites+$700-3,x
		sta sprites+$600-2,x
		sta sprites+$700-2,x
		sta sprites+$600-1,x		
		sta sprites+$700-1,x
		
		cpx #POSY_MAX-32
		bcs @+
		sta sprites+$600+$20,x		
		sta sprites+$600+$21,x
		sta sprites+$600+$22,x
		sta sprites+$700+$20,x		
		sta sprites+$700+$21,x
		sta sprites+$700+$22,x
@		rts	
	


////BIG
		.align
//wymazywanie przy wysokich duszkach		
tab_skok01c	dta <dy0e,<dy1e,<dy2e,<dy3e,<dy4e,<dy5e,<dy6e,<dy7e		

		
dy0e	
		cpx #POSY_MAX-64
		bcs @+
		
		sta sprites+$400+$40,x
		sta sprites+$500+$40,x
			
@		sta sprites+$400-8,x
		sta sprites+$400-7,x
		sta sprites+$400-6,x
		sta sprites+$400-5,x
		sta sprites+$400-4,x
		sta sprites+$400-3,x
		sta sprites+$400-2,x
		sta sprites+$400-1,x
		
		sta sprites+$500-8,x		
		sta sprites+$500-7,x
		sta sprites+$500-6,x
		sta sprites+$500-5,x
		sta sprites+$500-4,x
		sta sprites+$500-3,x
		sta sprites+$500-2,x
		sta sprites+$500-1,x
		
		rts
		
dy1e
		cpx #POSY_MAX-64
		bcs @+
		sta sprites+$400+$43,x
		sta sprites+$500+$43,x
		sta sprites+$400+$44,x
		sta sprites+$500+$44,x
		sta sprites+$400+$45,x
		sta sprites+$500+$45,x
		sta sprites+$400+$46,x
		sta sprites+$500+$46,x
		sta sprites+$400+$47,x
		sta sprites+$500+$47,x
		sta sprites+$400+$48,x
		sta sprites+$500+$48,x
@		jmp dy7e+36
		
		
dy2e	
		cpx #POSY_MAX-64
		bcs @+
		sta sprites+$400+$43,x
		sta sprites+$500+$43,x
		sta sprites+$400+$44,x
		sta sprites+$500+$44,x
		sta sprites+$400+$45,x
		sta sprites+$500+$45,x
		sta sprites+$400+$46,x
		sta sprites+$500+$46,x
		sta sprites+$400+$47,x
		sta sprites+$500+$47,x
@		jmp dy7e+30
		
dy3e	
		cpx #POSY_MAX-64
		bcs dy7e+24
		sta sprites+$400+$43,x
		sta sprites+$500+$43,x
		sta sprites+$400+$44,x
		sta sprites+$500+$44,x
		sta sprites+$400+$45,x
		sta sprites+$500+$45,x
		sta sprites+$400+$46,x
		sta sprites+$500+$46,x
		jmp dy7e+24
		
dy4e
		cpx #POSY_MAX-64
		bcs dy7e+18
		sta sprites+$400+$43,x
		sta sprites+$500+$43,x
		sta sprites+$400+$44,x
		sta sprites+$500+$44,x
		sta sprites+$400+$45,x
		sta sprites+$500+$45,x
		jmp dy7e+18
		
	
		
dy5e	
		cpx #POSY_MAX-64
		bcs dy7e+12
		sta sprites+$400+$43,x
		sta sprites+$500+$43,x
		sta sprites+$400+$44,x
		sta sprites+$500+$44,x
		jmp dy7e+12		
		
		
dy6e	
		cpx #POSY_MAX-64
		bcs dy7e+6
		sta sprites+$400+$43,x
		sta sprites+$500+$43,x
		jmp dy7e+6
		
dy7e
		sta sprites+$400-7,x
		sta sprites+$500-7,x
		sta sprites+$400-6,x
		sta sprites+$500-6,x
		sta sprites+$400-5,x
		sta sprites+$500-5,x
		sta sprites+$400-4,x
		sta sprites+$500-4,x		
		sta sprites+$400-3,x
		sta sprites+$500-3,x
		sta sprites+$400-2,x
		sta sprites+$500-2,x
		sta sprites+$400-1,x		
		sta sprites+$500-1,x
		
		cpx #POSY_MAX-64
		bcs @+
		sta sprites+$400+$40,x		
		sta sprites+$400+$41,x
		sta sprites+$400+$42,x
		sta sprites+$500+$40,x		
		sta sprites+$500+$41,x
		sta sprites+$500+$42,x
@		rts	


		.align
		
tab_skok23c	dta <dy0f,<dy1f,<dy2f,<dy3f,<dy4f,<dy5f,<dy6f,<dy7f		

		
dy0f	
		cpx #POSY_MAX-64
		bcs @+
		
		sta sprites+$600+$41,x
		sta sprites+$700+$41,x
		
		sta sprites+$600+$40,x
		sta sprites+$700+$40,x
		
@		sta sprites+$600-8,x
		sta sprites+$600-7,x
		sta sprites+$600-6,x
		sta sprites+$600-5,x
		sta sprites+$600-4,x
		sta sprites+$600-3,x
		sta sprites+$600-2,x
		sta sprites+$600-1,x
		
		sta sprites+$700-8,x		
		sta sprites+$700-7,x
		sta sprites+$700-6,x
		sta sprites+$700-5,x
		sta sprites+$700-4,x
		sta sprites+$700-3,x
		sta sprites+$700-2,x
		sta sprites+$700-1,x
		
		rts
		
dy1f
		cpx #POSY_MAX-64
		bcs @+
		sta sprites+$600+$43,x
		sta sprites+$700+$43,x
		sta sprites+$600+$44,x
		sta sprites+$700+$44,x
		sta sprites+$600+$45,x
		sta sprites+$700+$45,x
		sta sprites+$600+$46,x
		sta sprites+$700+$46,x
		sta sprites+$600+$47,x
		sta sprites+$700+$47,x
		sta sprites+$600+$48,x
		sta sprites+$700+$48,x
@		jmp dy7f+36
		
dy2f	
		cpx #POSY_MAX-64
		bcs @+
		sta sprites+$600+$43,x
		sta sprites+$700+$43,x
		sta sprites+$600+$44,x
		sta sprites+$700+$44,x
		sta sprites+$600+$45,x
		sta sprites+$700+$45,x
		sta sprites+$600+$46,x
		sta sprites+$700+$46,x
		sta sprites+$600+$47,x
		sta sprites+$700+$47,x
@		jmp dy7f+30
		
dy3f	
		cpx #POSY_MAX-64
		bcs dy7f+24
		sta sprites+$600+$43,x
		sta sprites+$700+$43,x
		sta sprites+$600+$44,x
		sta sprites+$700+$44,x
		sta sprites+$600+$45,x
		sta sprites+$700+$45,x
		sta sprites+$600+$46,x
		sta sprites+$700+$46,x
		jmp dy7f+24
		
dy4f
		cpx #POSY_MAX-64
		bcs dy7f+18
		sta sprites+$600+$43,x
		sta sprites+$700+$43,x
		sta sprites+$600+$44,x
		sta sprites+$700+$44,x
		sta sprites+$600+$45,x
		sta sprites+$700+$45,x
		jmp dy7f+18
		
dy5f	
		cpx #POSY_MAX-64
		bcs dy7f+12
		sta sprites+$600+$43,x
		sta sprites+$700+$43,x
		sta sprites+$600+$44,x
		sta sprites+$700+$44,x
		jmp dy7f+12		
		
		
dy6f	
		cpx #POSY_MAX-64
		bcs dy7f+6
		sta sprites+$600+$43,x
		sta sprites+$700+$43,x
		jmp dy7f+6

dy7f
		sta sprites+$600-7,x
		sta sprites+$700-7,x
		sta sprites+$600-6,x
		sta sprites+$700-6,x
		sta sprites+$600-5,x
		sta sprites+$700-5,x
		sta sprites+$600-4,x
		sta sprites+$700-4,x		
		sta sprites+$600-3,x
		sta sprites+$700-3,x
		sta sprites+$600-2,x
		sta sprites+$700-2,x
		sta sprites+$600-1,x		
		sta sprites+$700-1,x
		
		cpx #POSY_MAX-64
		bcs @+
		sta sprites+$600+$40,x		
		sta sprites+$600+$41,x
		sta sprites+$600+$42,x
		sta sprites+$700+$40,x		
		sta sprites+$700+$41,x
		sta sprites+$700+$42,x
@		rts	
	
		
.endl
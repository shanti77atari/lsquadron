				.align

//32 bloki o wys 8px
blok_status	equ $fd30 	;$101	;org *+32		;=0 zajete 4 duszki,=2 wszystkie duszki wolne,=1 duszki 0 i 1 zajete
blok_x01	equ $fd50	;$121	;org *+32		;pozycja pary duszkow 0 i 1
blok_x23	equ $fd70	;$141	;org *+32		;pozycja pary duszkow 2 i 3 */

blok_m01	equ $fd90	;org *+32		;pozycja pary pocisków 0 i 1
blok_m2		equ $fdb0	;org *+32			;pozycja missile 0
blok_m3		equ $fdd0	;org *+32			;pozycja missile 1
shot_t		org *+32
blok_size01		org *+32		;szerkość duszkow 0 i 1
blok_size23		org *+32		;szerkośc duszków 2 i 3
		
blok_c1		org *+32		;kolory duszków
blok_c3		org *+32
blok_nr		org	*+32
blok_col	org *+32

			dta b(0)		;zabezpieczenie przed nadpisaniem procedur dli

dli00a		
			lda blok_c1+5
			sta colpm1
			lda blok_c3+5
			sta colpm3
			lda blok_x01+5
			sta hposp0
			sta hposp1
			lda blok_x23+5
			sta hposp2
			sta hposp3
			lda blok_m01+5
			sta hposm1
			adc #3
			sta hposm0
			lda blok_m2+5
			sta hposm2
			lda blok_m3+5
			sta hposm3 
			
			mva #dli-_dli-1 _dli
			
			lda blok_nr+5		;zmiana koloru
			sta _kol0+1
			lda blok_col+5
_kol0		sta colpf0

.if SZER=40			
			lda przes1
			cmp #7
			jeq dli00d
.endif			
			lda blok_nr+6
			sta _kol2+1
			lda blok_col+6
			sta _kol3+1

			lda #0
			jmp dliend1

.if SZER=40
dli00d		mva #64 nmien		;wylacz nxt dli
			inc licznik_irq
			
			mva #$04 colpm2
			
			lda zestaw
			eor #4
			sta zestaw
			sta wsync
			clc 
			
			lda blok_m01+6
			sta hposm1
			;clc
			adc #2			;+1 bo c=1
			sta hposm0
			
			lda zestaw
			sta chbase
			
			lda blok_nr+6		;zmiana koloru
			sta _kol1+1
			lda blok_col+6
_kol1		sta colpf0
			
			lda blok_x01+6
			beq @+
			sta hposp0
			sta hposp1
			lda blok_c1+6
			sta colpm1
			lda blok_size01+6
			sta sizep0
			sta sizep1
			
@			lda blok_x23+6
			beq @+
			sta hposp2
			sta hposp3
			lda blok_c3+6
			sta colpm3
			lda blok_size23+6
			sta sizep2
			sta sizep3
			
			
			

@			lda shot_t+6
			sta sizem
			lda blok_m2+6
			sta hposm2
			lda blok_m3+6
			sta hposm3		
			
			lda blok_nr+6+1		;zmiana koloru
			sta _kol2+1
			lda blok_col+6+1
			sta _kol3+1
			
			mva #192 nmien		;wlacz przerwania dli
	
			lda #0
			sta blok_x01+6
			sta blok_x23+6
			sta blok_m01+6
			sta blok_m2+6
			sta blok_m3+6
.endif
			
dliend1		
			
			
			sta blok_m01+5
			sta blok_m2+5
			sta blok_m3+5
			sta blok_x01+5
			sta blok_x23+5
			
			mva #$04 colpm2
			
			pla
			rti			

dli00
			pha
		
			mva #>sprites pmbase
			mva shot_t+5 sizem
			lda blok_size01+5
			sta sizep0
			sta sizep1
			
			lda blok_size23+5
			sta sizep2
			sta sizep3
			
			clc
			
			mva kolor0 colpf0
			mva kolor1 colpf1		;przywracamy kolory tła gry
			mva kolor2 colpf2
			mva kolor3 colpf3
			lda zestaw
			sta chbase
			
			jmp dli00a



						
nmi		bit nmist
_dli		equ *+1
			bmi dli
			
			sta dli_A
	
			mva #6 licznik_irq		;zeruj licznik		
			inc frame_counter			

			mva #dli00-_dli-1 _dli
_blk0		mva #$4f colpf2		;kolor napisow na belce (NTSC)
			mva #$04 colpf1		;odcien tla
			
			mva #192 nmien
			
			
			mva #>sprites chbase
			jsr set_belka
			
			lda #>znaki
			ora zestaw1
			sta zestaw
			
			mva #2 _adc
			
			lda dli_A
irq			rti

dli1		pha

			lda #0
			sta hposp0
			sta hposp1
			sta hposp2
			sta hposp3
			sta hposm0
			sta hposm1
			sta hposm2
			sta hposm3

			pla
			rti	
	
dli			
			sta dli_A	
			stx dli_X
licznik_irq equ *+1			
			ldx #$ff
			cpx #28		
			bcc @+1
			mva #dli1-_dli-1	 _dli
			lda przes1
			cmp #2		
			bcs @+2
			
			lda #64
			sta nmien
			lda zestaw
			eor #4
			sta chbase
			
			lda blok_col,x	;zmiana koloru
_kol2b		sta hitclr
			
			lda #$6f
@			cmp vcount
			bcs @-

			lda #0
			sta hposp0
			sta hposp1
			sta hposp2
			sta hposp3
			sta hposm0
			sta hposm1
			sta hposm2
			sta hposm3

			jmp dliend0
			
			
@			sec
@			lda zestaw
			eor #4
			sta zestaw
			sta chbase
			
_kol3		lda #$ff
_kol2		sta hitclr
	
			lda blok_x01,x
			beq @+
			sta hposp1
			sta hposp0
			cmp #1
			beq @+
			lda blok_size01,x
			sta sizep0
			sta sizep1
			lda blok_c1,x
			sta colpm1			
						
@			lda blok_x23,x
			beq @+
			sta hposp3
			sta hposp2
			cmp #1
			beq @+
			lda blok_size23,x
			sta sizep2
			sta sizep3
			lda blok_c3,x
			sta colpm3	
						
@			lda blok_m01,x
			beq @+
			sta hposm1
			;clc
_adc		equ *+1			
			adc #2			;+1 bo c=1
			sta hposm0
			lda shot_t,x
			sta sizem
			
@			lda blok_m2,x
			sta hposm2
			lda blok_m3,x
			sta hposm3
			
			lda blok_nr+1,x		;zmiana koloru
			sta _kol2+1
			sta _kol2b+1
			lda blok_col+1,x
			sta _kol3+1
			inx
			stx licznik_irq
			
			
			cpx #27
			bne @+
			dec _adc
			
@			
			lda #0	
			sta blok_x01-1,x
			sta blok_x23-1,x
			sta blok_m01-1,x
			sta blok_m2-1,x
			sta blok_m3-1,x
			sta blok_status-1,x
			
			ldx dli_X
			lda dli_A
			rti
			
dliend0
			
			sta blok_m01+28
			sta blok_m2+28
			sta blok_m3+28
			sta blok_status+28
			sta blok_x01+28
			sta blok_x23+28
			
			ldx dli_X
			lda dli_A
			rti
			
set_belka
			mva #>sprites1 pmbase
			mva #108 hposp1
_mini_c		mva #$a8 colpm1
			mva #0 sizep1
			mva #128 hposp3			
			mva #1 sizep3
			sta sizep2
_shield_c	lda #$88
			sta colpm2
			ora #$04
			sta colpm3
			
			lda energy
			cmp #1
			bne @+
			lda frame_counter
			and #15
			bne @+
			
			lda _sb1+1			;migotanie energy
			eor #124
			sta _sb1+1
			lda panel+$13
			eor #%111
			sta panel+$13
@			equ *			
_sb1		mva #124 hposp2	

			lda sprite_wybuch
			bne @+
			lda sprite_c1
			and #$f0
			cmp kolor_samolotu
			beq @+
			lda sprite_c1
			clc
			adc #$10
			sta sprite_c1
@			equ *	


			lda energy
			beq @+
			cmp energy_max
			bcs @+
			dec energy_licznik
			bne @+
			dec energy_licznik+1
			bne @+
			inc energy
			mwa energy_licznik_start energy_licznik
@			equ *
			
			
			lda #0
			sta hposp0
			sta hposm0
			sta hposm1
			sta hposm2
			sta hposm3
			
			rts
			
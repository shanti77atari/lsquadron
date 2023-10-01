//sterowanie joystickiem	


SSPEED0	equ 250-20
SSPEED1	equ SSPEED0*120/100
SSPEED2	equ SSPEED0*125/100
SSPEED0x	equ SSPEED0*90/100
SSPEED1x	equ SSPEED1*91/100
SSPEED2x	equ SSPEED2*94/100
tab_joyx dta a(SSPEED0x),a(SSPEED0x),a(SSPEED0x),a(0),a(-SSPEED0x),a(-SSPEED0x),a(-SSPEED0x),a(0),a(0),a(0)
		 dta a(SSPEED1x),a(SSPEED1x),a(SSPEED1x),a(0),a(-SSPEED1x),a(-SSPEED1x),a(-SSPEED1x),a(0),a(0),a(0)
		 dta a(SSPEED2x),a(SSPEED2x),a(SSPEED2x),a(0),a(-SSPEED2x),a(-SSPEED2x),a(-SSPEED2x),a(0),a(0),a(0)
		
tab_joyy dta a(2*SSPEED0),a(-2*SSPEED0),a(0),a(0),a(2*SSPEED0),a(-2*SSPEED0),a(0),a(0),a(2*SSPEED0),a(-2*SSPEED0)
		 dta a(2*SSPEED1),a(-2*SSPEED1),a(0),a(0),a(2*SSPEED1),a(-2*SSPEED1),a(0),a(0),a(2*SSPEED1),a(-2*SSPEED1)
		 dta a(2*SSPEED2),a(-2*SSPEED2),a(0),a(0),a(2*SSPEED2),a(-2*SSPEED2),a(0),a(0),a(2*SSPEED2),a(-2*SSPEED2)

speed_tab	equ *-1
		dta 10-1,20-1	;,30-1

joy1	lda porta
		and #$0f
		cmp #15
		bne @+
		mva #8 sprite_shape
		rts
		
@		
		sbc #5-1
		bcc @+3		;zabezpieczenie (zepsuty joystick)
		ldx samolot_speed
		beq *+5
		adc speed_tab,x
		asl
		tax
		lda tab_joyx,x
		beq @+1
		adc sprite_dx
		sta sprite_dx
		lda tab_joyx+1,x
		tay
		adc sprite_x
		cmp #50					;czy za daleko?
		bcs *+4
		lda #50
		cmp #200
		bcc *+4
		lda #199
		sta sprite_x
		
		tya
		bpl @+
		ldy sprite_shape
		lda tab_left-6,y
		sta sprite_shape
		jmp @+2
@		ldy sprite_shape
		lda tab_right-6,y
		sta sprite_shape
		jmp @+1
		
@		mva #8 sprite_shape		
@		clc
		lda tab_joyy,x
		beq @+
		adc sprite_dy
		sta sprite_dy
		lda sprite_y
		adc tab_joyy+1,x
		cmp #48
		bcs *+4
		lda #48
		cmp #208
		bcc *+4
		lda #207
		sta sprite_y
@		rts
		
		

tab_left	dta 6,8,6
tab_right	dta 8,7,7

ILE_ZMIAN=6
MAX_CZAS=40


fire2a	
		lda licznik_czas
		beq @+
		inc licznik_czas
		lda licznik_czas
		cmp #MAX_CZAS
		bcs fire2b			;przekroczono czas	
		
@		lda trig0
		cmp trig0s
		sta trig0s
		bne @+
		rts
@		inc licznik_zmian
		lda licznik_zmian
		cmp #ILE_ZMIAN
		bne @+
		lda licznik_czas
		cmp #MAX_CZAS
		jsr fire1_end		;wlacz special
fire2b
		lda #0
		sta licznik_zmian	;wyczysc liczniki
		sta licznik_czas			
		rts	
		
@		cmp #1
		bne @+
		inc licznik_czas
@		rts
		

//2 przycisk SEGA i autofire
fire2
		ldx pot0

		lda special
		
		bne *+3
@		rts
		lda shot_t0
		bne @-
		
		jsr fire2a
		lda shot_t0
		bne @-			;jeśli nie włączono special to sprawdz 2 przycisk
		
@		ldx pot0
		cpx #20
		bcs *+3
@		rts
		lda pot0s
		cmp #50
		bcs @-
		
		jmp fire1_end
		
//obsługa strzału

fire1	
		lda shot_t0
		beq @+
		dec big_shoot			;czas do przywrocenia podstawowego strzalu
		bne @+
		dec big_shoot+1
		bpl @+
		mva #$00 shot_t0		;przywróć zwykly strzal
		mva #1 shot_power		
		
@		lda fire_delay
		beq @+
		dec fire_delay
		
@		lda trig0
		beq fire_add_shot
		rts
		
fire_add_shot		
		lda fire_delay
		beq *+3
		rts
_frd	mva #7 fire_delay
		
fra0	lda sprite_y			;dodanie strzalu
		sec
		sbc #4
		and #%11111110
		tay
		lda sprite_x
		ldx shot_t0
		bne @+
		adc #0				;c=1 waski strzal +1
		
@		jsr multi.add_shot
		lda #6*2
		ldy shot_t0
		beq *+3
		asl
		tay
		lda #0
		jmp add_fx			;dzwiek strzalu

fire1_end		
		dec special
		mva #$05 shot_t0		;szeroki strzal
		mva #2 shot_power
		
		lda cl.big_shoot_tab+4
		sta big_shoot_start
		sta big_shoot
		lda cl.big_shoot_tab+5
		sta big_shoot_start+1
		sta big_shoot+1

		rts
		
//korygowanie kolorów w tablicach pod NTSC

.local NTSC_colors

convert
		lsr NTSCGTIA
		beq @+
		jsr convert_enemy_tab		;konwertuje kolory przeciwników do NTSC
		jsr convert_bgc				;konwertuje kolory tła do NTSC
@		rts

tab0	equ *-$fc
		dta 4,2,2,4
		
tab_color	.he 00,20,30,40,50,60,70,80,90,a0,b0,c0,d0,10,f0,20		

conv0	clc
		adc pom
		sta pom
		bcc *+4
		inc pom+1
		rts
		
conv1		
		lda (pom),y
		and #$0f
		sta _c0+1		
		lda (pom),y
		:4 lsr
		tax
		lda tab_color,x
_c0		ora #$ff
		sta (pom),y
		rts

convert_enemy_tab
		mwa #level_enemy_tab pom
cv0		ldy #0
		lda (pom),y
		bne *+3
		rts
		iny
		lda (pom),y
		bpl @+
		tax
		lda tab0,x
		jsr conv0
		jmp cv0
		
@		iny
		jsr conv1
		lda #7
		jsr conv0
		jmp cv0
		
convert_bgc
		mwa #level_color_tab pom
cv1		ldy #0
		lda (pom),y
		bpl *+3
		rts
		ldy #2
		jsr conv1
		lda #3
		jsr conv0
		jmp cv1		
		
		
.endl

		
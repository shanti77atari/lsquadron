//operacje dyskowe
ciov	equ $e456

level_color_tab_name
		dta c'D:LEVEL0.BGC',b(155)
kafel_klocki_name
		dta c'D:LEVEL0.TB',b(155)
level_map_name
		dta c'D:LEVEL0.MAP',b(155)
font_name
		dta c'D:LEVEL0.FNT',b(155)
enemy_tab_name
		dta c'D:LEVEL0.CM',b(155)	
title_mus_name
		dta c'D:TITLE.MUS',b(155)
congrat_mus_name
		dta c'D:CONGRAT.MUS',b(155)
over_mus_name
		dta c'D:OVER.MUS',b(155)
level_mus_name
		dta c'D:LEVEL0.MUS',b(155)
config_name
		dta c'D:CONFIG.DAT',b(155)
		
					
//load
.local dos

tab0	equ sprite_x

load_level
	jsr oblicz_level	
	jsr load_enemy_tab
	jsr load_bgc
	jsr load_tb
	jsr load_map
	jsr load_mus
	jmp dos.load_font

load_config
	ldx #<config_name
	ldy #>config_name
	mwa #config_ad pom1
	jmp load

load_title_mus
	ldx #<title_mus_name
	ldy #>title_mus_name
	mwa #MODUL1	pom1
	jsr load
	ldx #<congrat_mus_name
	ldy #>congrat_mus_name
	mwa #MODUL2	pom1
	jsr load
	ldx #<over_mus_name
	ldy #>over_mus_name
	mwa #MODUL3	pom1
	jmp load

load_mus
	ldx #<level_mus_name
	ldy #>level_mus_name
	mwa #MODUL pom1
	jmp load

load_enemy_tab
	ldx #<enemy_tab_name		;wczytaj enemyTab
	ldy #>enemy_tab_name
	mwa #level_enemy_tab pom1
	jmp load

load_font
	ldx #<font_name
	ldy #>font_name
	mwa #znaki pom1
	jmp load
	
load_map
	ldx #<level_map_name
	ldy #>level_map_name
	mwa #bg.level_map pom1
	jsr load
	
	lda pom1
	sec
	sbc #10
	sta level1s
	lda pom1+1
	sbc #0
	sta level1s+1
	rts

load_tb
	ldx #<kafel_klocki_name
	ldy #>Kafel_klocki_name
	mwa #kafel pom1
	jmp load

load_bgc

	ldx #<level_color_tab_name
	ldy #>level_color_tab_name
	
	mwa #level_color_tab-4 pom1
	jsr load
	
	ldy #3						;ustaw startowe kolory mapy
@	lda level_color_tab-4,y
	sta def_kolor0,y
	dey
	bpl @-

	lsr NTSCGTIA			;popraw startowe kolory jeśli NTSC
	beq @+	
	ldy #3
@	lda def_kolor0,y
	and #$0f
	sta _lg+1
	lda def_kolor0,y
	:4 lsr
	tax
	lda NTSC_colors.tab_color,x
_lg	ora #$ff
	sta def_kolor0,y
	dey
	bpl @-

@	rts
	


;poprawia nawzwe pliku
oblicz_level
	clc
	lda #'0'
	adc level
	sta level_color_tab_name+7
	sta kafel_klocki_name+7
	sta level_map_name+7
	sta font_name+7
	sta enemy_tab_name+7
	sta level_mus_name+7
	rts
		
load
	jsr open
	mwa #tab0 pom
	mwa #128 $358 	;czytaj po 128 bajtów
@	jsr get
	bmi @+
	jsr copy1		
	jmp @-
@	jsr copy1
	jmp close

copy1						;kopiuje dane z bufora w miejsce docelowe , również pod OS
	mvy #$fe portb
	ldy $358
	beq @+1
	dey
@	lda tab0,y
	sta (pom1),y
	dey
	bpl @-
	lda $358
	jsr add_pom1
@	mvy #$ff portb
	rts
	
add_pom1
	clc
	adc pom1
	sta pom1
	lda pom1+1
	adc #0
	sta pom1+1
	rts


;open
open
	stx $354	;nazwa pliku w x,y
	sty $355
	mwa #$80 $359		;maksymalna dlugosc pliku 

	jsr wait_vbl
	mva #0 nmien
	
	mva #$ff portb
	cli

	ldx #$10		;kanał
	lda #3			;open
	sta $340+2,x
	
	lda #4			;odczyt
	sta $340+10,x
	jmp ciov

;wczytaj
get	
	ldx #$10
	lda #7			;load binary
	sta $340+2,x
	lda pom			;adres docelowy w (pom)
	sta $340+4,x
	lda pom+1
	sta $340+5,x
	jmp ciov
 
;close 
close
	ldx #$10
	lda #12
	sta $340+2,x
	jsr ciov
;off OS
@	lda vcount
	bne @-
	sei
	
	mva #$fe portb
	mva #192 nmien
	
	mva #0 audctl			;inicjalizacja dźwięku
	mva #3 skctl
	rts
.endl
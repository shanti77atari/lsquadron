//test duszkow
			opt h-
			org $80
		
NTSC=1				
SZER=40			

//modyfikacje kodu
BORDER=1

//stałe


//system
NTSCGTIA	equ $D014

//strona zerowa
kanal_audf1			org *+2	
kanal_audf2			org *+2	
kanal_audf3			org *+2	
kanal_audf4			org *+2
kanal_audc1			org *+2	
kanal_audc2			org *+2	
kanal_audc3			org *+2					
kanal_audc4			org *+2

		
		
		
bit012				org *+1
bit0				org *+1		
bit1				org *+1		
bit2				org *+1		
bit3				org *+1		
bit4				org *+1		
bit5				org *+1		
bit6				org *+1		
bit7				org *+1		
linia 				org *+2		
kolor0				org *+1
kolor1				org *+1
kolor2				org *+1
kolor3				org *+1

fire_delay			org *+1		
strzal_typ			org *+1		
trig0s				org *+1		

//przerwania
frame_counter		equ $14		;systemowy zegar
dli_A				org *+1		
dli_X				org *+1		

//obsługa obrony computera
obrona				org *+2		
bgcol				org *+2

//plansza
poziom_bg			org *+2		
obr_adr				org *+2		
obr_adr1			org *+2		
przesuniecie		org *+1		
pozycja_bg			org *+1		
pozycja_bg1			org *+1		

//siła strzału
shot_power			org *+1		

//punkty
score_add			org *+1		
score				org *+3		
hscore				org *+3		

//tymczasowe
pom					org *+2		
pom1				org *+2
pom0				org *+1		
pom0a				org	*+1		
pom0b				org *+1		
pom0c				org *+1		
pom0d				org *+1		
pom0e				org *+1	

przes1				org *+1
zestaw				org *+1		;obecny zestaw znakow

ntscAntic			org *+1
music				org *+1
pot0s				org *+1

kolor_samolotu		org *+1
shield				org *+1

level				org *+1
level1s				org *+2
extra_lives			org *+1



obraz		equ $f800
znaki 		equ $e800		;2 zestawy znakow
sprites	equ $e000
sprites1	equ obraz		;wykorzystuje 3 ostatnie strony, tylko górę	

kafel	equ $d800			;1024b

klocki	equ $dc00			;512b

level_color_tab	equ $de00+4	;512b-4 max

		
level_enemy_tab	equ $f000	;2048b max

panel		equ $cfd0			;48 bajtów
komunikat	equ $cfa0
config_ad	equ $cf00
max_level	equ config_ad

	
MODUL1	equ $B000			;title,endLevel
MODUL	equ $B800			;level_music
MODUL2	equ $A100			;congratulation A$5D
MODUL3	equ $A45E			;game over A6D2


		org $ff27			;pamięć nie wykorzystywana przez belkę (duszki)
def_kolor0	org *+4	
bonus_nr	org *+1	
bonus_ile	org *+1	
bonus_sprite	org *+1
energy_max		org *+1
shot_speed		org *+1
samolot_speed	org *+1
licznik_cannon_w	org *+1
check_row		org *+2
check_obrona	org *+2
check_linia		org *+2
licznik_bufor	org *+1
licznik_nuta	org *+1
licznik_nuta1	org *+1
prio			org *+1
big_shoot_start org *+2
shot_power0		org *+1
special_power	org *+1
licznik_zmian	org *+1
licznik_czas	org *+1
consol_2		org *+1
licznik_level	org *+1
cheat1			org *+1



		opt h+

		
		org $980
load_name
		dta c'Loading game...',b(155)	
antic_pal_name
		dta c'ANTIC=PAL',b(155)
antic_ntsc_name
		dta c'ANTIC=NTSC',b(155)
gtia_pal_name
		dta c'GTIA=PAL',b(155)
gtia_ntsc_name
		dta c'GTIA=NTSC',b(155)
		
		
tab1	.he 36,63,63,63,63,63,63,36	;0
		.he 0c,1c,3c,0c,0c,0c,0c,3f	;1
		.he 3e,63,03,06,18,70,73,7f	;2
		.he 3e,63,03,0e,03,03,63,3e	;3
		.he 06,0e,16,26,7f,06,06,0f	;4
		.he 7f,03,60,7e,03,03,63,3e	;5
		.he 3e,73,60,7e,63,63,63,3e	;6
		.he 7f,63,06,06,0c,0c,0c,0c	;7
		.he 3e,63,63,3e,63,63,63,3e	;8
		.he 3e,63,63,3f,03,03,63,3e	;9
		
		.he 63,63,63,7f,63,63,63,63	;H
		.he 3e,63,60,3e,03,03,63,3e	;S
		.he 1e,33,60,60,60,61,33,1e	;C
		.he 3e,73,63,63,63,63,67,3e	;O
		.he 7e,63,63,7e,6c,66,63,63	;R
		.he 7f,63,60,7c,60,60,63,7f	;E
		
		dta 0,60,102,110,118,102,60,0	;0 małe
		dta 0,24,56,24,24,24,126,0
		dta 0,60,102,12,24,48,126,0
		dta 0,126,12,24,12,102,60,0
		dta 0,12,28,60,108,126,12,0
		dta 0,126,96,124,6,102,60,0
		dta 0,60,96,124,102,102,60,0
		dta 0,126,6,12,24,48,48,0
		dta 0,60,102,60,102,102,60,0
		dta 0,60,102,62,6,12,56,0		;9
		
		.he 00,00,00,00,00,00,00,00	;spacja
		.he 00,18,ff,7e,18,18,3c,00	;samolocik
		.he 00,00,00,14,08,14,00,00	;x
		
		.he 00,f0,fc,7f,7f,fc,f0,00	;energia
		
		
tab3	.he 60,f0,f0,f0,60,60,60

		
		
		
tab2	.he 0b,0c,0d,0e,0f,1a,00,00,00,00,00,00,00,1a,1a,1b,1c,13
.if SZER=40
		.he 1a,1a,1d,1d,1d,1a,1a,1a
.endif		
		.he 0a,0b,0c,0d,0e,0f,1a,00,00,05,00,00,00,00			
		
print_load
		mwa #load_name pom
		jmp print


print
		ldx #0
		lda #9			;print
		sta $340+2,x
		lda pom			;adres docelowy w (pom)
		sta $340+4,x
		lda pom+1
		sta $340+5,x
		sta $340+9,x
		jsr ciov
	
		rts		
		
ini
		lda 20
@		cmp 20
		beq @-
		
		sei
		lda #0
		sta nmien	; disable interrupts
		
		ldx #0
@		mvy #$ff portb			;kopiowanie systemowych znaków pod ROM
		lda $e000,x
		pha
		lda $e100,x
		pha
		lda $e200,x
		pha
		mvy #$fe portb
		pla
		;eor #$ff
		sta sprites+$200,x
		pla
		;eor #$ff
		sta sprites+$100,x
		pla
		;eor #$ff
		sta sprites,x
		dex
		bne @- 		

		ldx #30*8			;znaki na panelu
@		lda tab1-1,x
		eor #255
		sta sprites-1,x
		dex
		bne @-
		
		lda #0
		ldx #$26
@		sta sprites1+$500,x			;czyszczenie góry duszka
		sta sprites1+$600,x
		sta sprites1+$700,x
		dex
		bpl @-
		
		
		ldx #6
@		lda tab3,x				;podkolorowanie belki
		sta sprites1+$51e,x
		dex
		bpl @-
		
		ldx #SZER-1			;przygotuj panel
@		lda tab2,x
		sta panel,x
		dex
		bpl @-
		
		jsr logo

	
		mva #$ff portb			;wlacz OS
		mva #64 nmien
		cli
		
		ldx #0
		lda vcount
		beq *-3
@		tay
		lda vcount
		bne @-
		cpy #$84
		bcs *+4
		ldx #4
		stx ntscAntic	;=0 ->PAL,=4 -> NTSC	
		
		mwa #antic_pal_name pom
		txa
		beq @+
		mwa #antic_ntsc_name pom
@		jsr print
		
		mwa #gtia_pal_name pom
		lsr NTSCGTIA
		beq @+
		mwa #gtia_ntsc_name pom
@		jsr print
		
		mwa #load_name pom
		jmp print

logo
		ldx #$d0
		lda #0
;@		sta $600,x
@		sta $fe30-1,x
		dex
		bne @-

		ldy #13
@		lda nap_title0,y
		beq @+
		asl
		asl
		asl
		tax
.rept 8		
		lda $e100+#,x
		;sta $604+20*#,y
		sta $fe34+20*#,y
.endr		
@		dey
		bpl @-1
		rts
		
nap_title0
		.he 0c,01,13,14,00,00
		.he 13,11,15,01,04,12,0f,0e
	
		ini ini

		org $980
		
dlist dta $70,$70,$50,$42+$80,a(panel),$00,$00
dlist1	equ *
		dta b($44+$80+$20),a(obraz)
		:22 dta b($24+$80)
		dta b(4+$80)
		dta $00,$00			;2x po jednej pustej linii
		dta b($41),a(dlist)
		
		
title_dlist
		.he 70,70,70
		dta b($42),a(tit0a)
		dta b($70)
		:8 dta b($4b+$10),a($fe30+#*20),b($10)
		.he 70,70,70
		dta b($42),a(tit0)
		dta b($40)
		dta b($46),a(tit1)
		dta b($70),b($70)
		dta b($42),a(tit2)
		dta b($40)
		dta b($46),a(tit3)
		.he 70,70,70,70,70,70
		dta b($42),a(tit4)
		dta b($41),a(title_dlist)
		
info_dlist
		:13 .he 70
		dta b($42),a(komunikat)
		.he 70,70
		dta b($42),a(tit0c-10)		;pusta linia
		dta b($41),a(info_dlist)
		
info_dlist1
		:13 .he 70
		dta b($42),a(komunikat)
		.he 70,70
		dta b($42),a(tit0b)
		dta b($41),a(info_dlist1)		

tit0a
		:10 dta b(26)
		dta d'HIGH'*,b(26),d'SCORE'*,b(26),b(26),b(26),0,0,0,0,0,0,0
		:10 dta b(26)

tit0c	:20 dta b(26)
		
tit0b	:10 dta b(26)
		dta d'YOUR'*,b(26),d'SCORE'*,b(26),b(26),b(26),0,0,0,0,0,0,0
		:10 dta b(26)
tit0	
		:15 dta b(26)
		dta d'CODE'*,b(26),b(27),b(26),d'GFX'*
		:15 dta b(26)
		
tit1	
		dta b(26),b(26)
		dta c'janusz'*,b(26),c'chabowski'*
		dta b(26),b(26)
		
tit2
		:14 dta b(26)
		dta d'MUSIC'*,b(26),b(27),b(26),d'SFX'*
		:15 dta b(26)
		
tit3
		dta b(26)
		dta c'michal'*,b(26),b(26),c'szpilowski'*
		dta b(26)
		
tit4
		:5 dta b(26)
		dta d'ABBUC'*,b(26),b(26),d'SOFTWARE'*,b(26),b(26),d'CONTEST'*,b(26),b(26),d'2020'
		:5 dta b(26)
		
		

napis	
		:3 dta b(26)
		dta c'last'*,b(26),b(26),'squadron'*
		:3 dta b(26)		
	

nap_end_level
		dta d';',b(26),d'LEVEL'*,b(26),d'COMPLETE'*,b(26),d';'			;17
nap_nr_level
		dta d'LEVEL'*,b(26),b(26),d'1'	;7
nap_game_over
		dta d'GAME'*,b(26),b(26),d'OVER'*	;9
nap_congrat
		dta c'>>>'*,b(26),b(26),d'CONGRATULATIONS'*,b(26),b(26),b(26),c'>>>'*	;25

tab4	.he aa,aa,ff,ff,ff,ff,aa

//zmienne
zestaw1	org *+1
lives	org *+1
energy	org *+1
energy1	org *+1
energy_licznik	org *+2
energy_licznik_start	org *+2
special	org *+1
licznik_dead	org *+1
licznik_trig	org *+1
big_shoot		org *+2
cheat		org *+1
frame_counter1	org *+1
		


		icl 'atari.hea'	
		
		icl 'dos.asm'
		icl 'joystick.asm'
		icl 'przerwania.asm'
		icl 'multi.asm'
		icl 'ai.asm'
		icl 'com.asm'
		icl 'plansza.asm'
		icl 'kolizje.asm'
		icl 'enemy_shot'
		icl 'sfx.asm'
		icl 'depack.asm'
		icl 'colors.asm'
		
		
run		mva #0 audctl			;inicjalizacja dźwięku
		mva #3 skctl
		
		jsr wait_vbl

		sei
		lda #0
		sta nmien	; disable interrupts
		sta irqen
		sta dmactl
		sta pmcntl
		mwa #title_dlist dlptr
		
	
		mva #$fe portb
		
		mwa #nmi $fffa
		mwa #irq $fffe
		mwa #irq $fffc

		
		lda #1+32+16	
		sta gtiactl		

		mva #$00 colbak		;czarne tlo

		jsr multi.init_sprite			;inicjalizacja duszków
@		
		mva #%01000000 nmien
		;sei
		
//wczytuje przeciwników, pal albo ntsc		
		
		mva #$ff level		;wymusza wczytanie 1 levelu przy starcie

			
		lda #0
		sta cheat1
		sta zestaw1
		:3 sta hscore+#				;wyzeruj score i hscore
		:3 sta score+#
		jsr bg.hscore_print

		jsr dos.load_config
		jsr dos.load_title_mus
		jsr wait_vbl
		
poczatek	
		jsr title					;strona tytułowa
		jsr init_game				;inicjalizacja gry
		jsr init_level1				;inicjalizacja poziomu
		
l0		lda sprite_x
		bne @+
		dec licznik_dead				;opóźnienie po zestrzeleniu naszego samolotu
		bne @+
		jmp dead		
@		equ *

		lda licznik_level
		beq @+
		dec licznik_level
		bne @+
		jmp next_level	
@		equ *		

		lda cheat1
		beq @+1
		lda consol
		and #1
		bne @+
		mva #1 cheat		;niesmiertelnosc, START=on, OPTION=off
@		equ *
		lda consol
		and #4
		bne @+
		mva #0 cheat

@		lda frame_counter			;zabezpieczenie przed zbyt szybkim wykonaniem petli
		cmp frame_counter1
		beq @-
		sta frame_counter1
		
		jsr bg.przesun					;przesun tlo
		jsr bg.change_bonus					;migaj 1,2,3
		jsr bg.negatyw_off				;obsługa błyśnięć trafionych obiektów (na znakach)
		
		lda licznik_level
		bne @+
		lda sprite_wybuch
		bne @+
		lda sprite_x
		beq @+
		jsr cl.player_vs_enemy			;kolizje gracza z wrogami
		lda sprite_wybuch
		bne @+
		jsr cl.player_vs_missile		;kolizje gracza z pociskami wrogów
		jsr print_energy
@		equ *		
		jsr cl.shot_vs_enemy			;kolizje strzałów gracza z przeciwnikami
		
		lda licznik_level
		bne @+
		jsr defend.add_shot
@		equ *
		
		jsr defend.move_missiles
		jsr multi.move_shots

		jsr AI.play			;wykonaj AI
		jsr COM.next		;dodaj nowy obiekt
		jsr COM.color

		lda sprite_wybuch
		bne @+
		lda sprite_x
		beq @+
		jsr joy1
		
		lda licznik_level
		bne @+	
		jsr fire1

		jsr fire2
		
		stx pot0s
		sta potg0

@		equ *		
		jsr graj_bufor
		jsr multi.animuj	;animuj duszki, błyśnięcie po trafieniu

		jsr wait_se			;wyczyść pociski, zacznij przed końcem ekranu
		jsr play_fx			;odtwórz dźwięki z gry
		jsr graj_nute

		jsr bg.score_dodaj	;dodaj punkty
		jsr bg.move_colors
		jsr bg.change_dlist	;modyfikuj DLIST (LMS)

_unpack	equ *+1
		lda #$ff
		beq *+5
		jsr depack.start	;rozpakuj nowy ksztalt
		jsr E_multi			;rysuj duszki w nowych pozycjach
		
		mva #50 blok_m01+27	;cyfra lewy dolny rog
		sta blok_m01+28
		mva #0 shot_t+27
		
_time	lda #$00			;co drugi takt zegara 
		eor #1
		sta _time+1 
		jne l0	
		
		inc linia					;linia tla, używana do wstawiania nowych obiektów
		bne @+
		inc linia+1
		
@		jmp l0


wait_se
		lda vcount
		bmi wait_se
		cmp #$66
		bcc wait_se
		
		lda #0	
		:200-8 sta sprites+$300+$20+#		;rysuje cyfrę w lewym dolnym rogu ekranu, na dwóch pociskach
		:3 sta sprites+$3df+#
		lda special
		:3 asl
		tax
		ldy #0
@		lda tab_special,x
		sta sprites+$3da,y
		inx
		iny
		cpy #5
		bne @-

		rts

tab_special
		dta %1110		;0
		dta %1010
		dta %1010
		dta %1010
		dta %1110
		dta 0,0,0
		
		dta %0100		;1
		dta %1100
		dta %0100
		dta %0100
		dta %1110
		dta 0,0,0
		
		dta %1110		;2
		dta %0010
		dta %1110
		dta %1000
		dta %1110
		dta 0,0,0
		
		dta %1110		;3
		dta %0010
		dta %0110
		dta %0010
		dta %1110
		

//wyświetla poziom osłony samolotu
print_energy
		lda energy
		bmi @+
		cmp energy1
		bne *+3
@		rts
		
		sta energy1
print_energy1
		lsr
		bne *+3
		rol				;dla 1 przywroc 1
		tax
		tay
		lda tab_p0,x
		sta pom
		lda tab_p1,x
		sta pom+1
		
		ldx #6
@		lda tab4,x
		and pom
		sta sprites1+$71e,x
		lda tab4,x
		and pom+1
		sta sprites1+$61e,x
		dex
		bpl @-
		
		lda #$1a
		sta panel+$13
		sta panel+$14
		sta panel+$15
		sta panel+$16
		sta panel+$17
		lda #$1d
		cpy #0
		beq @+
		mvx #124 _sb1+1
		sta panel+$13
		cpy #1
		beq @+
		sta panel+$14
		cpy #2
		beq @+
		sta panel+$15
		cpy #3
		beq @+
		sta panel+$16
		cpy #4
		beq @+
		sta panel+$17
@		equ *
		
		rts
		
tab_p0	.he 00,00,c0,f0,fc,ff
tab_p1	.he	00,c0,c0,c0,c0,c0

//zestrzelono nasz samolot
dead	
		jsr rmt_silence
		dec lives
		bpl @+1	
		jsr bg.efekt1
		ldx #8
@		jsr wait_vbl
		dex
		bne @-
		
		lda #0
		sta pmcntl
		sta grafp1
		sta grafp2
		sta grafp3 
		sta dmactl
		mwa #info_dlist1 dlptr
		ldx #<nap_game_over
		ldy #>nap_game_over
		lda #9
		jsr pisz_text
		
		ldx #7+60
		lda score+2
		jsr hscore_title
		lda score+1
		jsr hscore_title
		lda score
		jsr hscore_title
		
		
		mva #0 _mig+1		
		mva #190 licznik_level
		lda #0
		ldx #<MODUL3
		ldy #>MODUL3
		jsr migotaj1
		jmp poczatek
				
@		jsr dec_upgrades
		jsr init_game1
		jsr init_level
		jmp l0

dec_upgrades
		mvx #0 samolot_speed
		lda cl.kolor_samolotu_tab,x
		sta kolor_samolotu
		ora #$08
		sta sprite_c1

		stx shield
		lda cl.shield_tab
		sta energy_max
		sta energy
		lda cl.tab_recovery
		sta energy_licznik
		sta energy_licznik_start
		lda cl.tab_recovery+1
		sta energy_licznik+1
		sta energy_licznik_start+1
		
		stx shot_speed
		lda cl.kolor_samolotu_tab
		sta _mini_c+1
		lda cl.speed_shot_tab
		sta multi._mvs+1
		lda cl.delay_shot_tab
		sta _frd+1
		lda cl.big_shoot_tab
		sta big_shoot_start
		lda cl.big_shoot_tab+1
		sta big_shoot_start+1
		
		rts		

//
pisz_text
		stx pom
		sty pom+1
		tay
		sta _psz+1
		
		ldx #39
		lda #$1a	
@		sta komunikat,x		;wyczyść linię
		dex
		bpl @-
		
		lda #40
		sec
_psz	sbc #$ff
		lsr
		clc
		adc _psz+1
		tax

@		lda (pom),y
		sta komunikat,x
		dex
		dey
		bpl @-
		rts
		
//nastepny poziom
next_level
		jsr rmt_silence
		jsr bg.efekt2
		
	
		
		jsr wait_vbl
		lda #0
		sta pmcntl
		sta grafp1
		sta grafp2
		sta grafp3 
		sta dmactl
		
		lda level
		cmp max_level
		bcc nl0
		
		mwa #info_dlist1 dlptr
		ldx #<nap_congrat
		ldy #>nap_congrat
		lda #25
		jsr pisz_text
		
@		dec lives
		beq @+
		mva #100 score_add			;+1000 za każde zachowane życie
		jsr bg.score_dodaj
		jmp @-
@		equ *		
		
		ldx #7+60
		lda score+2
		jsr hscore_title
		lda score+1
		jsr hscore_title
		lda score
		jsr hscore_title		
		 
		mva #1 _mig+1				;>0 spowoduje sprawdzanie fire
		lda #0
		ldx #<MODUL2
		ldy #>MODUL2
		jsr migotaj1			;czekaj na fire
		
		jmp poczatek
		
nl0
@		mwa #info_dlist dlptr
		ldx #<nap_end_level
		ldy #>nap_end_level
		lda #17
		jsr pisz_text
		
		lda #130
		ldx #7
		jsr migotaj
		
		inc level
		jsr dos.load_level
		jsr NTSC_colors.convert	
		
		lda level
		clc
		adc #17
		sta nap_nr_level+7
		ldx #<nap_nr_level
		ldy #>nap_nr_level
		lda #7
		jsr pisz_text

		
		lda #80
		ldx #$0a		;muzyczka
		jsr migotaj	
	
		jsr init_game0
		jsr init_level
		jmp l0			


licz_tit	org *+8
licz_tit0	dta 0,0,1,1,2,2,3,4,5,6,7,7,8,8,9,9,9,9,8,8,7,7,6,5,4,3,2,2,1,1,0,0
		
//migotanie
migotaj		
		ldy #0 
		sty _mig+1				;>0 spowoduje sprawdzanie fire
		sta licznik_level
		txa
		
		ldx #<MODUL1
		ldy #>MODUL1
migotaj1		
		jsr RASTERMUSICTRACKER
		
		jsr wait_vbl
		mva #$3a dmactl

mig3
@		mva #$40 pom0a
		mva #$48 pom0b
		mva #$50 pom0c
		
		lda trig0
mig2		
@		sta trig0s		
		lda vcount
		cmp #$10
		bcs *-5
		
		asl music
		bcc *+9
		mva ntscAntic music
		jmp *+6
		jsr rmt_play		

		mva #8 colpf2
		mva #0 colpf1
		mva pom0a hposp0
		mva pom0b hposp1
		mva pom0c hposp2
		mva #$0a colpm0
		sta colpm2
		mva #$0e colpm1	
				
@		lda vcount
		cmp #$38
		bne @-
		
		mva #255 grafp0
		sta grafp1
		sta grafp2

		
@		lda vcount
		cmp #$3c
		bcc @-
		mva #0 grafp0
		sta grafp1
		sta grafp2

		
@		lda vcount
		cmp #$44
		bne @-
		
		mva #255 grafp0
		sta grafp1
		sta grafp2		 

		
@		lda vcount
		cmp #$48
		bcc @-
		mva #0 grafp0
		sta grafp1
		sta grafp2  
		
		lda pom0a
		;clc
		adc #4-1
		sta pom0a
		cmp #170
		jcs mig3
		adc #8
		sta pom0b
		adc #8
		sta pom0c
		
_mig	lda #0
		jeq mig0
		lda trig0
		jne mig2
		ora trig0s
		jeq mig2
		jmp mig1
		
		
mig0	lda frame_counter
		lsr
		jcc mig2
		dec licznik_level
		jne mig2
		
mig1	jsr wait_vbl
		mva #0 dmactl
		
		rts
		
wait_vcount
		sta pom0
@		lda vcount
		cmp pom0
		bcc @-
		rts
		
ef0
		mva #$08 colpf2
		ldx #$0f
		:1 sta wsync
		stx colpf2
		:4 sta wsync
		sta colpf2	
		rts
		
ef1
		tay
		mva #$0c colpf3
		sta wsync
		tya
		and #$f0
		ora #8
		sta colpf3
		:4 sta wsync
		sty colpf3
		rts	

screen0
@		lda vcount
		cmp #10
		bcs @-
		
		
		mva #10 colpf2	;kolor hiscore
		mva #0 colpf1
		
		mva #3 sizep0
		mva #$fe grafp0
		mva #$0f colpm0
		
		lda #16
		jsr wait_vcount

		mva #$8c hposp0
		ldx #0
		lda #20
		jsr wait_vcount
		stx hposp0		;koniec hscore
		

		mva #$28 colpf0	;tytuł
		
		
		ldy pom0a
		
		ldx #7
		lda #25
		jsr wait_vcount
		
		sta wsync
	
@		sty colpf0
		lda licz_tit,x
		sta wsync
		sta hscrol

		:3 sta wsync
		iny
		iny
		dex
		bpl @-
		
		lda frame_counter
		lsr
		bcc @+1
		inc pom0a
		ldx #6
@		lda licz_tit,x
		sta licz_tit+1,x
		dex
		bpl @-
		lda frame_counter
		lsr
		and #31
		tax
		lda licz_tit0,x
		sta licz_tit		
@		equ *
		
		mva #$80 grafp0
		
		lda #$b8
		sta colpm0
	
		lda #52
		jsr wait_vcount		;code & gfx
		
		mva #0 colpf0
		mva #$80 hposp0
		jsr ef0
		
		lda #56
		jsr wait_vcount
		mva #0 hposp0		;end code & gfx
		
		lda #58
		jsr wait_vcount		;janusz
		:2 sta wsync
_jan	lda #$44
		jsr ef1
		
		
		lda #71
		jsr wait_vcount		;music & sfx
		
		mva #$80 hposp0
		jsr ef0
		
		lda #74
		jsr wait_vcount		;end music & sfx
		mva #0 hposp0
		
		lda #77
		jsr wait_vcount		;michal
		sta wsync
_mich	lda #$f4
		jsr ef1		
		
		lda #105
		jsr wait_vcount		;stopka
		mva #$82 colpf1
		mva #$8f colpf2
		lda #$84
		sta wsync
		sta colpf1
		:5 sta wsync
		lda #$82
		sta colpf1	
		
		rts
		
hscore_title	
		pha
		:4 lsr
		sta tit0a+16,x
		inx
		pla
		and #$0f
		sta tit0a+16,x
		inx
		rts	
		

//tymczasowa strona tytułowa		
title	
		jsr wait_vbl
		mva #0 dmactl
		lda level
		beq @+
		mva #0 level
		;lda #0
		sta dmactl
		sta grafp0
		sta grafp1
		sta grafp2
		jsr dos.load_level
		jsr NTSC_colors.convert
@		equ *
		
		sta potg0		;sega2button
		mva #0 colpf0
		sta pmcntl
		sta grafp1
		sta grafp2
		sta grafp3
		mwa #title_dlist dlptr
		mva #%11000000 nmien
		mva #0 colpf0
		mva #$0f colpf3

		ldx #<MODUL1					;reset music
		ldy #>MODUL1					
		lda #0						
		jsr RASTERMUSICTRACKER
		mva ntscAntic music
		jsr bg.czy_hscore
		
		ldx #7
		lda hscore+2
		jsr hscore_title
		lda hscore+1
		jsr hscore_title
		lda hscore
		jsr hscore_title
		
		ldx #7
		lda #0 
@		sta licz_tit,x	;wartosc startowa
		dex
		bpl @-
		
		jsr wait_vbl
		mva #$3a dmactl
		
		lda trig0
@		sta trig0s		

		jsr screen0
		
		lda kbcode
		cmp #82
		bne ch1
		sta cheat1
ch1		equ *	

		asl music
		bcc *+9
		mva ntscAntic music
		jmp *+6
		jsr rmt_play


		lda trig0
		bne @-
		ora trig0s
		beq @-
		
		jsr rmt_silence		;wylacz muzyke
		mva #0 dmactl
		
		
		ldx #<MODUL					;reset music
		ldy #>MODUL					
		lda #0
		jmp RASTERMUSICTRACKER
		;mva ntscAntic music
		
//inicjalizacja gry		
init_game
		mva #2 lives
		lda #0
		sta score
		sta score+1
		sta score+2
		sta extra_lives
		sta samolot_speed
		sta shield
		sta shot_speed

		lda cl.kolor_samolotu_tab
		ora #8
		sta _mini_c+1
		
		lda cl.tab_recovery
		sta energy_licznik_start
		sta energy_licznik
		lda cl.tab_recovery+1
		sta energy_licznik_start+1
		sta energy_licznik
		
		mva cl.big_shoot_tab big_shoot_start
		
		lda #6
		sta energy_max
		sta energy
		
init_game0		
		mva #0 sprite_tall
		sta sprite_glue
		
		mva #4 fire_delay
		
		lda #0
		sta licznik_level
		sta score_add
		sta check_row
		sta check_row+1
		jsr bg.score_print
		jsr clr_scr 

init_game1		
		jsr multi.init_sprite1
		mva #1 shot_power	;poczatkowa sila strzalu
		mva #0 shot_t0
		sta sprite_anim
		mva #8 sprite_shape

		mva #120 sprite_x
		mva #200 sprite_y
		
		ldx samolot_speed
		lda cl.kolor_samolotu_tab,x
		ora #8
		sta sprite_c1
		sta _mini_c+1
		and #$f0
		sta kolor_samolotu

			
		
		lda pot0
		sta pot0s
		sta potg0
		jsr wait_vbl
		mwa #dlist dlptr
		mva #3 pmcntl
		mva #$3a dmactl

		mva #$16 colpf0

		lda #0
		sta _unpack
		sta licznik_cannon_w
		sta bonus_ile
		sta licznik_trig
		sta licznik_bufor
		sta licznik_czas
		sta licznik_zmian
		
	
		mva #3 special
		mva #128 _sb1+1
		lda lives
		cmp #10
		bcc *+4
		lda #9
		ora #$10
		sta panel+$11
		lda #MUSIC_BUFOR_LENGTH-1
		sta licznik_nuta
		sta licznik_nuta1
	
		lda energy
		sta energy1
		jmp print_energy1

clr_scr
		lda #$ff
		ldx #0
@		sta obraz,x
		sta obraz+$100,x
		sta obraz+$200,x
		sta obraz+$300,x
		dex
		bne @- 
		rts
		
//inicjalizacja poziomu		
init_level
		ldx #<MODUL					;reset music
		ldy #>MODUL					
		lda #0
		jsr RASTERMUSICTRACKER
		
		jsr bg.efekt1
		
init_level1
		mva #0 cheat
		mva #$00 shot_t0		;START = zwykly strzal
		lda #1
		sta shot_power
		ldx shot_speed
		mva cl.delay_shot_tab,x _frd+1			;poczatkowe opoźnienie strzalu
		mva cl.speed_shot_tab,x multi._mvs+1		;poczatkowa predkosc strzalu

		jsr COM.start_colors
		jsr bg.init
		
		ldx #15
@		jsr wait_vbl
		dex
		bne @-
		
		jsr bg.efekt_init
		mva #7 przes1
		jsr bg.efekt
		
		jsr wait_vbl
		
		mva #1 frame_counter
		mva #0 _time+1
		sta frame_counter1
			
		rts
		
		icl 'ntsc2pal.asm'
		

;channel0=2	;dla muzyki0
;channel1=3	

channel0=0	;dla muzyki1
;channel1=1	
		
		icl	'rmt_feat.asm'
		icl 'rmtplayr.asm'

		

		
		
		run run

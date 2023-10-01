//Przerabia tablice z NTSC do PAL
		org $b000
.local FIT
//joy		
SSPEED0	equ :SSPEED0*6/5
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

//shot
speed_shot_tab	dta 7,8,8			;0=6
delay_shot_tab	dta 8,7,6			;0=10	

kolor_samolotu_tab	.he a0,d0,80
big_shoot_tab 	dta a(680*5/6),a(816*5/6),a(928*5/6)		;czas specjalnego strzału (PAL)
tab_recovery	dta a(680*5/6),a(544*5/6),a(440*5/6)		;czas odnowienia osłony (PAL)
kolor_sprite_tab
		.he	bf,ef,6f,4f,3f,7f	

///ai
tab_DX							;tablica przesuniecia X w ruchu prostym 128b
	.he 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0													;kierunek 0
	AI.MX _S0*P1,_S1*P1,_S2*P1,_S3*P1,_S4*P1,_S5*P1,_S6*P1,_S7*P1
	AI.MX _S0*P3,_S1*P3,_S2*P3,_S3*P3,_S4*P3,_S5*P3,_S6*P3,_S7*P3
	AI.MX _S0*P2,_S1*P2,_S2*P2,_S3*P2,_S4*P2,_S5*P2,_S6*P2,_S7*P2
	AI.MX _S0*P0,_S1*P0,_S2*P0,_S3*P0,_S4*P0,_S5*P0,_S6*P0,_S7*P0			;kierunek 4
	AI.MX _S0*P2,_S1*P2,_S2*P2,_S3*P2,_S4*P2,_S5*P2,_S6*P2,_S7*P2
	AI.MX _S0*P3,_S1*P3,_S2*P3,_S3*P3,_S4*P3,_S5*P3,_S6*P3,_S7*P3
	AI.MX _S0*P1,_S1*P1,_S2*P1,_S3*P1,_S4*P1,_S5*P1,_S6*P1,_S7*P1
	.he 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0													;kierunek 8
	AI.MX -_S0*P1,-_S1*P1,-_S2*P1,-_S3*P1,-_S4*P1,-_S5*P1,-_S6*P1,-_S7*P1
	AI.MX -_S0*P3,-_S1*P3,-_S2*P3,-_S3*P3,-_S4*P3,-_S5*P3,-_S6*P3,-_S7*P3
	AI.MX -_S0*P2,-_S1*P2,-_S2*P2,-_S3*P2,-_S4*P2,-_S5*P2,-_S6*P2,-_S7*P2
	AI.MX -_S0*P0,-_S1*P0,-_S2*P0,-_S3*P0,-_S4*P0,-_S5*P0,-_S6*P0,-_S7*P0	;kierunek 12
	AI.MX -_S0*P2,-_S1*P2,-_S2*P2,-_S3*P2,-_S4*P2,-_S5*P2,-_S6*P2,-_S7*P2
	AI.MX -_S0*P3,-_S1*P3,-_S2*P3,-_S3*P3,-_S4*P3,-_S5*P3,-_S6*P3,-_S7*P3
	AI.MX -_S0*P1,-_S1*P1,-_S2*P1,-_S3*P1,-_S4*P1,-_S5*P1,-_S6*P1,-_S7*P1
	
tab_DY							;tablica przesuniecia Y 128b
	AI.MY -_S0*P0,-_S1*P0,-_S2*P0,-_S3*P0,-_S4*P0,-_S5*P0,-_S6*P0,-_S7*P0	;kierunek 0
	AI.MY -_S0*P2,-_S1*P2,-_S2*P2,-_S3*P2,-_S4*P2,-_S5*P2,-_S6*P2,-_S7*P2
	AI.MY -_S0*P3,-_S1*P3,-_S2*P3,-_S3*P3,-_S4*P3,-_S5*P3,-_S6*P3,-_S7*P3
	AI.MY -_S0*P1,-_S1*P1,-_S2*P1,-_S3*P1,-_S4*P1,-_S5*P1,-_S6*P1,-_S7*P1
	.he 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0													;kierunek 4
	AI.MY _S0*P1,_S1*P1,_S2*P1,_S3*P1,_S4*P1,_S5*P1,_S6*P1,_S7*P1
	AI.MY _S0*P3,_S1*P3,_S2*P3,_S3*P3,_S4*P3,_S5*P3,_S6*P3,_S7*P3
	AI.MY _S0*P2,_S1*P2,_S2*P2,_S3*P2,_S4*P2,_S5*P2,_S6*P2,_S7*P2
	AI.MY _S0*P0,_S1*P0,_S2*P0,_S3*P0,_S4*P0,_S5*P0,_S6*P0,_S7*P0			;kierunek 8
	AI.MY _S0*P2,_S1*P2,_S2*P2,_S3*P2,_S4*P2,_S5*P2,_S6*P2,_S7*P2
	AI.MY _S0*P3,_S1*P3,_S2*P3,_S3*P3,_S4*P3,_S5*P3,_S6*P3,_S7*P3
	AI.MY _S0*P1,_S1*P1,_S2*P1,_S3*P1,_S4*P1,_S5*P1,_S6*P1,_S7*P1
	.he 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0													;kierunek 12
	AI.MY -_S0*P1,-_S1*P1,-_S2*P1,-_S3*P1,-_S4*P1,-_S5*P1,-_S6*P1,-_S7*P1
	AI.MY -_S0*P3,-_S1*P3,-_S2*P3,-_S3*P3,-_S4*P3,-_S5*P3,-_S6*P3,-_S7*P3
	AI.MY -_S0*P2,-_S1*P2,-_S2*P2,-_S3*P2,-_S4*P2,-_S5*P2,-_S6*P2,-_S7*P2
	
P0=100000		;niweluje dzielenie

P1=38268
P2=92387
P3=70710	
_S0=AI._S0*6/5		;speed0
_S1=AI._S1*6/5		;speed1
_S2=AI._S2*6/5		;speed2
_S3=AI._S3*6/5		;speed3
_S4=AI._S4*6/5		;speed4
_S5=AI._S5*6/5		;speed5
_S6=AI._S6*6/5		;speed6
_S7=AI._S7*6/5		;speed7

luk0	.he 1B,12,10,10,10,10,12,10,12,20,02,10,12,12		;okrąg promien=20, 32 pozycje
		.he 12,12,12,02,10,04,12,02,12,02,02,02,02,12
;luk0	.he 1B,12,10,10,10,10,22,10,02,10,10,12,22,12		;okrąg promien=20, 32 pozycje
;		.he 02,10,12,14,12,02,02,10,02,14,02,02,02,02
		
luk1	.he 18,12,12,12,10,12,02,12,12,02,12,14,02,12		;fragment łuku
		.he 02,12,02,02,14,02,04,02,02,04,12		
		
luk2	.he 21,32,10,20,20,12,32,20,22,10,22,24,22			;okrąg promien=42,40 pozycji
		.he 12,22,12,24,12,12,12,14,26,12,12,14,02
		.he 18,12,04,12,04,04,06,12

luk3	.he 32,12,20,20,20,20,12,20,20,12,30,22,22		;okrąg promień=60,60 pozycji
		.he 22,10,22,12,22,22,12,22,12,12,12,22,24
		.he 12,12,14,24,12,14,12,14,14,12,14,02,14
		.he 14,14,04,14,04,04,12,04,04,04,04,12
		
luk4	.he 29,12,20,10,20,10,20,22,10,20,12,20,12,20
		.he 12,10,22,12,10,12,22,12,12,10,12,12,12,12
		.he 02,12,12,02,12,12,04,02,12,02,02,02,02,12
		
luk5	.he 13,12,10,10,10,22,10,12,12,10,12,02,12,12,02
		.he 14,02,02,02,12
/*		
luk6	.he 20,12,10,10,10,20,12,10,10,12,10,12,12,10,12,12
		.he 12,12,12,12,02,12,12,02,12,02,02,12,04,02,02
		.he 02,12
		
luk7	.he 27,12,10,10,10,20,10,12,10,10,12,10,12,22,10,12,12
		.he 00,12,12,12,12,12,00,12,12,02,14,12,02,12,02,02
		.he 12,02,04,02,02,02,12 */
		
;luk5	.he 0e,12,20,10,22,12,22,12,12,14,12,14,02,04,12
luk6	.he 18,12,20,10,20,22,10,22,12,12,22,12,12,12,12,14
		.he 12,12,14,02,14,04,02,04,12
luk7	.he 1d,12,20,10,20,22,10,22,10,22,12,12,22,12,12,12
		.he 12,12,14,12,12,14,02,14,02,14,04,02,04,12
		
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
speed = (256*12*6)/50
speed1 = (256*9*6)/50

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
						

		icl 'ai_scripts.asm'
		
start		
		lda ntscAntic
		beq *+3
		rts
		jsr joystick
		jsr shoot
		jsr ai
		jsr other

		rts
		
ai	

ILE=path_end-path0
ILEs=ILE/256
ILEb=ILE-(ILEs*256)

		ldx #0
		.rept ILEs
@		lda path0+#*256,x
		sta ai.path0+#*256,x
		dex
		bne @-
		.endr
		
		ldx #ILEb
@		lda path0-1+ILES*256,x
		sta ai.path0-1+ILES*256,x
		dex
		bne @-

		ldx #0
@		lda tab_dx,x
		sta AI.tab_dx,x
		lda tab_dy,x
		sta AI.tab_dy,x
		dex
		bne @-
		
		ldx luk0
@		lda luk0,x
		sta AI.luk0,x
		dex
		bpl @-
		
		ldx luk1
@		lda luk1,x
		sta AI.luk1,x
		dex
		bpl @-
		
		ldx luk2
@		lda luk2,x
		sta AI.luk2,x
		dex
		bpl @-
		
		ldx luk3
@		lda luk3,x
		sta AI.luk3,x
		dex
		bpl @-	

		ldx luk4
@		lda luk4,x
		sta AI.luk4,x
		dex
		bpl @-	

		ldx luk5
@		lda luk5,x
		sta AI.luk5,x
		dex
		bpl @-

		ldx luk6
@		lda luk6,x
		sta AI.luk6,x
		dex
		bpl @-

		ldx luk7
@		lda luk7,x
		sta AI.luk7,x
		dex
		bpl @-		
		
		rts
		
joystick
		ldx #6*20-1
@		lda tab_joyx,x
		sta :tab_joyx,x
		dex
		bpl @-
		rts
		
shoot
		ldx #27-1	;9*3
@		lda speed_shot_tab,x
		sta cl.speed_shot_tab,x
		dex
		bpl @-
		
		ldx #8*9-1
@		lda speed_x_m,x
		sta defend.speed_x_m,x
		dex
		bpl @-
		
		rts
		
other
		mva #$78 _shield_c+1	;kolor shield  
		mva #$3f _blk0+1		;kolor napisów na belce
		
		mva #$34 _jan+1
		mva #$e4 _mich+1
		
		rts

		ini start
		
		
//MAKRA
;definije blok z podstawowymi ruchami
.macro MOVE ile
	dta b(:ile)
.endm
;prosta kierunek,prędkość,faza animacji,ile ramek
.macro LINE dir,speed,phase,frame
	dta [:dir & 15]*16+[:phase & 7],[:frame*5]/6,:speed	;[:frame & 31]*8+[:speed & 7]
.endm
;łuk  kierunek,prędość,nr fragmentu łuku
.macro ARC dir,speed,unit
	dta [:dir & 1]+[:unit & 3]*2+[:speed & 15]*16+8
.endm

;koniec ścieżki
.macro ENDP 
	dta 0
.endm

;tank celowanie
.macro stoptank
	dta 128
.endm

;skok do scieżki
.macro goto path
	dta 128+1
	dta :path
.endm	

;powtórzenie bloku move
.macro repeat ile
	dta 128+2
	dta :ile
.endm

;Boss0
.macro boss0 ileRamek,speed
	dta 128+3
	dta [:ileRamek*5]/6,:speed
.endm

;śledzi gracza w osiX i powoli opada w dół
.macro followx ileRamek,speed
	dta 128+4
	dta [:ileRamek*5]/6
	dta :speed
.endm	

;nic nie robi
.macro nothing
	dta 128+5
.endm

.macro wait0 ileRamek
	dta 128+6
	dta [:ileRamek*5]/6
.endm		

//ustawia typ animacji 0=bez animacji
.macro setanim value
	dta 128+7
	dta :value
.endm

//ustaw fazę duszka
.macro setphase value
	dta 128+8
	dta :value
.endm

.endl	
		
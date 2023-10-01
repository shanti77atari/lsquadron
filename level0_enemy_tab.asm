//level_enemy_tab	;nr linii(mlodszy bajt),typ obiektu,kolor*16+poczatkowa_faza_ksztaltu,path,X,Y,nxtshoot*16+firstshoot(*16)
samolot	equ 0	;pozycja
it			equ 1	;coś ;)
kolko		equ 2	;kółko
it1			equ 3	;slabsza wersja "it"
czolg		equ 4	;czołg
big_plane	equ 5
big_plane1	equ 6	
gwiazda		equ 7
rakieta		equ 7
moneta		equ 8
samolot1	equ 9

nshape		equ $fc	; rozpakuj nowy kształt
checkpoint	equ $fd	; checkpoint
wait		equ $fe	;opoznienie
ch_bonus	equ $ff	;zmiana nr bonusa +1 , ile do zbicia


		opt h-

		;dta 248,nshape,$00,128					;nr ksztaltu*16, nr obiektu,ile bajtow
		
		;dta 224,checkpoint				;5 najmlodszych bitów =0 , 32 linie odstępu
		dta 251,ch_bonus,0,3
		dta 252,samolot,$00,4,165,15,0		;prosto w dol, po prawo
		dta 4,samolot,$50,4,145,15,0
		
		dta 60,samolot,$00,4,100,15,0		;prosto w dol, po lewo
		dta 66,samolot,$40,4,80,15,0
		
		dta 135,nshape,$44,128				;ustaw rakiete
		dta 140,rakieta,$30,16,160,15,0			;prosto w dol, potem lekko do srodka
		dta 160,rakieta,$70,17,80,15,0
		dta 170,rakieta,$b0,16,200,15,0
		dta 180,rakieta,$60,16,130,15,0
		dta 200,rakieta,$90,17,100,15,0
		dta 220,rakieta,$c0,16,170,15,0
		dta 240,rakieta,$70,17,110,15,0
		dta 250,rakieta,$a0,17,50,15,0
		
		dta 30,samolot,$00,18,70,15,$c3		;w dol , pozniej nawrot i prawo gora
		dta 70,samolot,$90,18,170,15,$c3
		dta 110,samolot,$a0,18,100,15,$c3
		dta 150,samolot,$d0,18,130,15,0
		dta 190,samolot,$30,18,90,15,$84
		
		dta 192,checkpoint
		
		
		dta 230,czolg,$80,10,35,24,0		;czolg z lewej
		dta 243,czolg,$A0,10,20,16,0
		
		
		dta 65,nshape,$14,128			;ustaw kolko
		dta 116,kolko,$a0,0,80,19,$c2				
		dta 146,kolko,$c0,1,75,19,$c3
		
		dta 46,samolot,$50,5,80,19,0
		dta 66,samolot,$00,5,90,10,$c3
		
		
		dta 121,samolot,$a4,2,100,19,0				;() wstążka w dół	
		dta 125,samolot,$a4,3,100,19,$cf			;)(
		dta 129,samolot,$a4,2,100,19,$c4	
		dta 133,samolot,$84,3,100,19,0
		dta 137,samolot,$a4,2,100,19,$cf
		dta 141,samolot,$84,3,100,19,$c6
		
		
		dta 151,czolg,$02,11,220,34,0	;czolg z prawej -> kolor ora $02
		dta 161,czolg,$b2,11,230,19,0
		
		
		dta 79,nshape,$00,128					;nr ksztaltu*2*16, nr obiektu*2,ile bajtow
		dta 80,nshape,$24,128
		
		dta 101,it,$a0,0,80,19,0
		dta 173,czolg,$00,10,20,18,0
		dta 206,gwiazda,$00,4,130,19,$c2
		dta 246,it,$30,1,75,19,$b1

		dta 247,ch_bonus,1,4		
		dta 90,czolg,$a2,11,225,10,0
				
		dta 6,samolot,$80,5,70,19,0			;w dol , przed koncem ekranu skret w bok
		dta 16,samolot,$00,4,150,15,$c2
		dta 26,samolot,$50,6,170,19,0
		dta 36,samolot,$00,4,120,15,$c3
		
		dta 150,gwiazda,$50,19,40,90,$c8
		dta 160,gwiazda,$80,19,40,110,$47
		dta 170,gwiazda,$d0,19,40,110,0
		dta 180,gwiazda,$00,19,40,110,$b8
		
		dta 224,checkpoint
		
		dta 1,czolg,$c2,11,180,30,0		;czolg z prawej
		
		dta 119,nshape,$30,192
		dta 120,moneta,$00,8,100,230,0			;kolka w moneta :)
		dta	128,moneta,$30,8,100,230,$b6
		dta	136,moneta,$60,8,100,230,$c9
		dta	144,moneta,$a0,8,100,230,0
		dta	152,moneta,$00,8,100,230,$df
		dta	160,moneta,$d0,8,100,230,$c2
		dta	168,moneta,$70,8,100,230,0
		dta	176,moneta,$f0,8,100,230,0
		
		dta 120,moneta,$30,20,140,230,0			;wężyk po prawo
		dta 130,moneta,$00,20,140,230,$36
		dta 140,moneta,$a0,20,140,230,0
		dta 150,moneta,$d0,20,140,230,$45
		dta 160,moneta,$70,20,140,230,0
		dta 170,moneta,$00,20,140,230,$c6
		dta 180,moneta,$30,20,140,230,0
	
		
		dta 20,czolg,$80,10,35,24,0		;czolg z lewej
		
		
		dta 90,ch_bonus,2,3				;strzal
		
		
		
		dta 166,nshape,$24,128				;ustaw gwiazdke
		dta 167,gwiazda,$00,9,140,230,0		;kółeczko
		dta 177,gwiazda,$30,9,140,230,$b6
		dta 187,gwiazda,$70,9,140,230,0
		dta 197,gwiazda,$a0,9,140,230,$ee
		dta 207,gwiazda,$40,9,140,230,0
		
		dta 50,wait
		
		dta 60,czolg,$e2,11,220,34,0	;czolg z prawej -> kolor ora $02
		dta 224,checkpoint
		
		dta 1,nshape,$24,128		;powtórzenie z powodu checkpointa
		dta 2,gwiazda,$00,21,30,80,0		;koleczko z lewej
		dta 10,czolg,$02,11,220,34,0	;czolg z prawej -> kolor ora $02
		dta 12,gwiazda,$30,21,30,80,$b6
		dta 20,czolg,$b2,11,230,19,0
		dta 22,gwiazda,$70,21,30,80,0
		dta 32,gwiazda,$a0,21,30,80,$43
		dta 42,gwiazda,$00,21,30,80,0
				
		
		
		dta 146,big_plane,$00,7,220,204,$34
		dta 150,nshape,$44,128				;ustaw rakiete
		
		dta 200,rakieta,$30,17,60,15,0		;rakieta w dol i skret w prawo	
		dta 30,rakieta,$70,16,90,15,0		;rakieta w dol i skret w lewo	
		dta 110,rakieta,$40,17,60,15,0	
		dta 190,rakieta,$90,16,90,15,0		
		dta 20,rakieta,$00,17,60,15,0
		
		dta 32,ch_bonus,0,2
		dta 100,rakieta,$d0,16,90,15,0
		
		dta 114,samolot1,$30,15,165,20,$00
		dta 178,samolot1,$80,15,190,20,$00
		
		
		dta 200,rakieta,$90,17,60,15,0
		dta 220,rakieta,$c0,17,120,15,0
		
		
		dta 1,czolg,$80,10,35,24,0		;czolg z lewej
		dta 14,czolg,$A0,10,20,16,0
		
		dta 128,checkpoint
		
		dta 160,samolot,$30,22,90,15,0		;czworka w dół
		dta 169,samolot,$00,23,80,15,$57
		dta 169,samolot,$70,23,100,16,0
		dta 178,samolot,$a0,24,90,15,$48
		
		dta 230,samolot,$30,22,140,15,$48
		dta 239,samolot,$00,23,130,15,0
		dta 239,samolot,$70,23,150,16,$57
		dta 248,samolot,$a0,24,140,15,0
		
		dta 50,nshape,$14,128			;ustaw kolko
		dta 60,kolko,$70,25,140,15,0

		dta 70,kolko,$a0,25,140,15,0
		dta 75,kolko,$00,26,100,15,$c5
		dta 80,kolko,$d0,25,140,15,0
		dta 85,kolko,$60,26,100,15,0
		dta 90,kolko,$d0,25,140,15,$35
		dta 95,kolko,$60,26,100,15,0
		dta 105,kolko,$30,26,100,15,0
		
		dta 1,samolot,$60,27,200,30,$38		;samoloty z prawej i w lewo
		dta 2,samolot,$30,27,220,54,$08
		dta 3,samolot,$a0,27,240,78,0
		
		dta 21,samolot,$00,28,50,30,$38		;samoloty z lewej i w prawo
		dta 22,samolot,$70,28,30,54,$00
		dta 23,samolot,$e0,28,10,78,$c8
		
		dta 1,samolot,$30,29,110,15,$00
		dta 8,samolot,$70,30,140,15,$00
		dta 13,samolot,$40,29,110,15,$00
		dta 20,samolot,$80,30,140,15,$c8
		dta 25,samolot,$50,29,110,15,$00
		dta 32,samolot,$90,30,140,15,$00
		dta 37,samolot,$00,29,110,15,$00
		dta 44,samolot,$a0,30,140,15,$00
		dta 49,samolot,$20,29,110,15,$39
		dta 56,samolot,$b0,30,140,15,$00
		dta 61,samolot,$e0,29,110,15,$00
		dta 68,samolot,$c0,30,140,15,$00
		
		dta 100,ch_bonus,1,3
		
		dta 29,nshape,$00,128					;nr ksztaltu*2*16, nr obiektu*2,ile bajtow
		dta 30,it1,$a4,2,160,19,0				;() wstążka w dół	
		dta 34,it1,$a4,3,160,19,$cf			;)(
		dta 38,it1,$a4,2,160,19,$c4	
		dta 42,it1,$84,3,160,19,0
		dta 46,it1,$a4,2,160,19,0
		dta 50,it1,$84,3,160,19,$c6
		
		
		
		dta 90,czolg,$90,10,35,24,0		;czolg z lewej		
		dta 190,kolko,$80,31,80,20,0
		dta 200,kolko,$80,31,80,20,0
		dta 210,kolko,$80,31,80,20,0
		dta 220,kolko,$80,31,80,20,0
		dta 230,kolko,$80,31,80,20,0
		dta 240,kolko,$80,31,80,20,0
		
		dta 96,checkpoint
		
		dta 200,samolot,$00,4,165,15,0		;prosto w dol, po prawo
		dta 206,samolot,$50,4,145,15,0
		dta 212,samolot,$70,4,185,15,0
		dta 220,samolot,$70,4,125,15,0
		
		dta 24,samolot,$00,4,100,15,0		;prosto w dol, po lewo
		dta 30,samolot,$40,4,80,15,0
		dta 36,samolot,$d0,4,120,15,0
		dta 42,samolot,$d0,4,60,15,0
		
		dta 106,nshape,$24,128				;ustaw gwiazdke
		dta 107,gwiazda,$00,9,130,230,0		;kółeczko
		dta 117,gwiazda,$30,9,130,230,$b6
		dta 127,gwiazda,$70,9,130,230,0
		dta 137,gwiazda,$a0,9,130,230,$ee
		dta 147,gwiazda,$40,9,130,230,$eb
		
		dta 255,nshape,$30,192				;ustaw monety
		dta 1,moneta,$30,20,140,230,0			;wężyk po prawo
		dta 11,moneta,$00,20,140,230,$36
		dta 21,moneta,$a0,20,140,230,0
		dta 31,moneta,$d0,20,140,230,$45
		dta 41,moneta,$70,20,140,230,0
		dta 51,moneta,$00,20,140,230,$c6
		dta 61,moneta,$30,20,140,230,0
		
		dta 180,ch_bonus,2,3
		dta 199,nshape,$44,128				;ustaw rakiete	
		dta 200,rakieta,$30,17,60,15,0		;rakieta w dol i skret w prawo
		dta 220,rakieta,$80,17,180,15,0
		dta 240,rakieta,$d0,17,120,15,0
		dta 14,rakieta,$50,17,100,15,0
		dta 30,rakieta,$70,16,90,15,0		;rakieta w dol i skret w lewo
		dta 50,rakieta,$c0,17,60,15,0
		dta 70,rakieta,$90,17,160,15,0
		dta 90,rakieta,$a0,17,120,15,0
		dta 110,rakieta,$00,16,70,15,0
		dta 130,rakieta,$20,17,150,15,0
		dta 150,rakieta,$70,17,90,15,0
		dta 170,rakieta,$40,17,60,15,0
		dta 190,rakieta,$a0,16,200,15,0
		dta 210,rakieta,$e0,17,130,15,0
		dta 230,rakieta,$d0,17,100,15,0
		dta 250,rakieta,$50,17,150,15,0
		dta 20,rakieta,$00,17,60,15,0		
		
		
		
		dta 179,nshape,$44,128				;ustaw rakiete
		dta 180,big_plane1,$00,13,220,204,$33
		
			
			
			dta 0			;koniec
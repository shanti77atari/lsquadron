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
samolot2	equ 10

nshape		equ $fc	; rozpakuj nowy kształt
checkpoint	equ $fd	; checkpoint
wait		equ $fe	;opoznienie
ch_bonus	equ $ff	;zmiana nr bonusa +1 , ile do zbicia


		opt h-
		
		dta 251,ch_bonus,0,3
		dta 252,samolot,$30,41,90,15,0
		dta 4,samolot,$70,41,90,15,$a3
		dta 12,samolot,$a0,41,90,15,0
		dta 20,samolot,$d0,41,90,15,$a2
		dta 28,samolot,$e0,41,90,15,0		
		dta 36,samolot,$00,41,90,15,$a4	
		
		dta 130,samolot,$30,42,150,15,$a3
		dta 138,samolot,$70,42,150,15,0
		dta 146,samolot,$a0,42,150,15,0
		dta 154,samolot,$d0,42,150,15,$82
		dta 162,samolot,$e0,42,150,15,0		
		dta 170,samolot,$00,42,150,15,$c4	

		dta 230,samolot,$30,41,120,5,0
		dta 238,samolot,$70,42,120,5,$42
		dta 246,samolot,$a0,41,120,5,0
		dta 254,samolot,$d0,42,120,5,$84
		dta 6,samolot,$e0,41,120,5,0		
		dta 14,samolot,$00,42,120,5,$53

		dta 100,czolg,$80,10,35,24,0		;czolg z lewej
		dta 113,czolg,$A0,10,20,16,0

		dta 241,nshape,$00,128					;nr ksztaltu*2*16, nr obiektu*2,ile bajtow
		dta 242,it1,$a4,2,120,19,0
		dta 246,it1,$84,3,120,19,$92
		dta 250,it1,$b4,2,120,19,0				;() wstążka w dół	
		dta 254,it1,$34,3,120,19,$a1			;)(
		dta 2,it1,$a4,2,120,19,$c3	
		dta 6,it1,$84,3,120,19,0
		dta 10,it1,$a4,2,120,19,0
		dta 14,it1,$84,3,120,19,$a4	

		dta 90,samolot2,$b0,34,100,15,0		;spadajace samoloty, pozniej góra
		dta 100,samolot2,$c0,34,70,15,$a6
		dta 110,samolot2,$d0,34,150,15,0
		dta 120,samolot2,$e0,34,90,15,$a3
		dta 130,samolot2,$30,34,120,15,0
		dta 140,samolot2,$00,34,170,15,$85

		dta 50,nshape,$14,128			;ustaw kolko
		dta 60,kolko,$70,25,140,15,$a2			;dwie linie w dol, kolko i dalej w dol
		dta 70,kolko,$a0,25,140,15,0
		dta 75,kolko,$00,26,100,15,$a3
		dta 80,kolko,$d0,25,140,15,0
		dta 85,kolko,$60,26,100,15,0
		dta 90,kolko,$d0,25,140,15,$84
		dta 95,kolko,$60,26,100,15,0
		dta 105,kolko,$30,26,100,15,0

		dta 237,nshape,$30,192			;MONETA
		dta 238,moneta,$30,33,80,15,0			;kolko w dol, pozniej w gracza
		dta 246,moneta,$a0,33,90,5,$c4
		dta 2,moneta,$70,33,110,15,0
		dta 10,moneta,$d0,33,120,5,$b3
		dta 22,moneta,$a0,33,160,15,0
		dta 30,moneta,$e0,33,170,5,$a4		
		
		dta 111,nshape,$24,128		;gwiazda
		dta 112,gwiazda,$00,21,30,80,0		;koleczko z lewej
		dta 122,gwiazda,$30,21,30,80,$55
		dta 132,gwiazda,$70,21,30,80,0
		dta 142,gwiazda,$a0,21,30,80,$43
		dta 152,gwiazda,$00,21,30,80,0	
		
		dta 10,ch_bonus,1,3		

		dta 11,samolot,$60,27,200,30,$34		;samoloty z prawej i w lewo
		dta 12,samolot,$30,27,220,54,$a5
		dta 13,samolot,$a0,27,240,78,0
		
		dta 31,samolot,$00,28,50,30,$53		;samoloty z lewej i w prawo
		dta 32,samolot,$70,28,30,54,$00
		dta 33,samolot,$e0,28,10,78,$35	
		
		dta 210,czolg,$80,10,35,24,0		;czolg z lewej
		dta 250,czolg,$02,11,220,34,0	;czolg z prawej -> kolor ora $02		
		
		dta 64,checkpoint		
		
		dta 96,ch_bonus,2,3		
		dta 119,nshape,$30,192		
		dta 120,moneta,$30,20,140,230,0			;wężyk po prawo '&'
		dta 130,moneta,$00,20,140,230,$36
		dta 140,moneta,$a0,20,140,230,0
		dta 150,moneta,$d0,20,140,230,$45
		dta 160,moneta,$70,20,140,230,0
		dta 170,moneta,$00,20,140,230,$c6
		dta 180,moneta,$30,20,140,230,0	

		dta 80,samolot,$30,22,170,15,$45
		dta 89,samolot,$00,23,160,15,0
		dta 89,samolot,$70,23,180,16,$56
		dta 98,samolot,$a0,24,170,15,0

		dta 150,samolot,$30,22,90,15,0		;czworka w dół
		dta 159,samolot,$00,23,80,15,$54
		dta 159,samolot,$70,23,100,16,0
		dta 168,samolot,$a0,24,90,15,$43
		
		dta 220,samolot,$30,22,140,15,$45
		dta 229,samolot,$00,23,130,15,0
		dta 229,samolot,$70,23,150,16,$54
		dta 238,samolot,$a0,24,140,15,0		
		
		dta 50,samolot,$30,22,120,15,0		;czworka w dół
		dta 59,samolot,$00,23,110,15,$54
		dta 59,samolot,$70,23,130,16,0
		dta 68,samolot,$a0,24,120,15,$45

		dta 159,nshape,$24,128				;weżyk z lewej do prawej
		dta 160,gwiazda,$50,37,210,90,$a4	;wężyk z prawej do lewej
		dta 170,gwiazda,$80,37,210,110,$45
		dta 180,gwiazda,$d0,37,210,110,0
		dta 190,gwiazda,$00,37,210,110,$74	
		dta 200,gwiazda,$30,37,210,110,0
		dta 210,gwiazda,$60,37,210,110,$83	

		dta 100,gwiazda,$50,19,40,90,$93
		dta 110,gwiazda,$80,19,40,110,$54
		dta 120,gwiazda,$d0,19,40,110,0
		dta 130,gwiazda,$00,19,40,110,$a5	
		dta 140,gwiazda,$30,19,40,110,0
		dta 150,gwiazda,$60,19,40,110,$85

		dta 28,nshape,$00,128					;nr ksztaltu*2*16, nr obiektu*2,ile bajtow
		dta 29,nshape,$24,128
		dta 30,it,$a0,0,80,19,0
		dta 31,ch_bonus,2,3
		dta 60,czolg,$00,10,20,18,0
		dta 110,gwiazda,$00,4,130,19,$c2
		dta 136,it,$30,1,75,19,$b1
		
		dta 1,checkpoint
		dta 32,ch_bonus,0,3	
		
		dta 40,samolot,$80,35,150,230,0			;z dolu do gory pozniej nawrot lewo/prawo  i w dol
		;dta 60,samolot,$a0,36,80,230,0
		dta 80,samolot,$80,35,170,230,$c4
		dta 100,samolot,$a0,36,60,230,0
		dta 120,samolot,$80,35,190,230,0
		dta 140,samolot,$a0,36,100,230,$b3
		;dta 160,samolot,$80,35,140,230,0
		dta 180,samolot,$a0,36,90,230,0
		dta 200,samolot,$80,35,160,230,$a5
		dta 220,samolot,$a0,36,110,230,0
		dta 245,samolot,$80,35,150,230,$a4
		dta 255,samolot,$a0,36,80,230,0		
		


	
		dta 139,nshape,$44,128				;ustaw rakiete		
		dta 140,big_plane,$e0,7,220,204,$34
		dta 190,rakieta,$30,17,60,15,0		;rakieta w dol i skret w prawo	
		dta 14,rakieta,$70,16,90,15,0		;rakieta w dol i skret w lewo	
		dta 94,rakieta,$40,17,60,15,0	
		dta 174,rakieta,$90,16,90,15,0		
		dta 254,rakieta,$00,17,60,15,0	
		
		
		dta 130,czolg,$80,10,35,24,0		;czolg z lewej
		dta 143,czolg,$A0,10,20,16,0		
		
		dta 32,checkpoint
		dta 64,ch_bonus,1,3		
		
		dta 79,nshape,$00,128					;z góry prawo-dół, kolko i lewo-dół
		dta 80,it,$70,40,90,15,$c6
		dta 90,it,$a0,40,90,15,0
		dta 100,it,$30,40,90,15,$d5
		dta 110,it,$a0,40,90,15,0
		dta 120,it,$00,40,90,15,$c7
		dta 130,it,$80,40,90,15,0	

		dta 50,nshape,$14,128			;ustaw kolko
		dta 60,kolko,$70,25,140,15,0			;dwie linie w dol, kolko i dalej w dol
		dta 70,kolko,$a0,25,140,15,0
		dta 75,kolko,$00,26,100,15,$c5
		dta 80,kolko,$d0,25,140,15,0
		dta 85,kolko,$60,26,100,15,0
		dta 90,kolko,$d0,25,140,15,$35
		dta 95,kolko,$60,26,100,15,0
		dta 105,kolko,$30,26,100,15,0		
		
		dta 239,nshape,$30,192
		dta 241,moneta,$00,8,100,230,0			;kolka w moneta :)
		dta	249,moneta,$30,8,100,230,$b5
		dta	1,moneta,$60,8,100,230,$c3
		dta	9,moneta,$a0,8,100,230,0
		dta	17,moneta,$00,8,100,230,$a4
		dta	25,moneta,$d0,8,100,230,$a2
		dta	33,moneta,$70,8,100,230,0
		dta	41,moneta,$f0,8,100,230,0

		dta 150,czolg,$02,11,220,34,0	;czolg z prawej -> kolor ora $02		

		dta 169,nshape,$30,192		
		dta 170,moneta,$80,38,120,230,0			;wężyk po lewo '&' odwrocony
		dta 180,moneta,$00,38,120,230,$33
		dta 190,moneta,$a0,38,120,230,0
		dta 200,moneta,$d0,38,120,230,$45
		dta 210,moneta,$70,38,120,230,0
		dta 220,moneta,$e0,38,120,230,$a6
		dta 230,moneta,$30,38,120,230,0	

		dta 100,czolg,$80,10,35,24,0		;czolg z lewej
		dta 113,czolg,$A0,10,20,16,0	

		dta 224,checkpoint
		dta 1,ch_bonus,2,3	

		dta 26,nshape,$24,128				;ustaw gwiazdke
		dta 27,gwiazda,$00,9,130,230,0		;z dolu do góry, póżniej małe kółeczko i góra
		dta 37,gwiazda,$30,9,130,230,$a5
		dta 47,gwiazda,$70,9,130,230,0
		dta 57,gwiazda,$a0,9,130,230,$84
		dta 67,gwiazda,$40,9,130,230,0


		dta 10,czolg,$a0,10,35,24,0		;czolg z lewej		
		dta 90,czolg,$32,11,220,34,0	;czolg z prawej -> kolor ora $02	

		dta 147,samolot1,$80,15,190,20,$00
		dta 19,samolot1,$30,15,165,20,$00
		
		dta 21,nshape,$00,128					;nr ksztaltu*2*16, nr obiektu*2,ile bajtow
		dta 22,it1,$a4,2,120,19,0
		dta 26,it1,$84,3,120,19,$96
		dta 30,it1,$b4,2,120,19,0				;() wstążka w dół	
		dta 34,it1,$34,3,120,19,$c3			;)(
		dta 38,it1,$a4,2,120,19,$a4	
		dta 42,it1,$84,3,120,19,0
		dta 46,it1,$a4,2,120,19,0
		dta 50,it1,$84,3,120,19,$a5		


		dta 170,samolot,$80,35,150,230,0			;z dolu do gory pozniej nawrot lewo/prawo  i w dol
		dta 190,samolot,$a0,36,80,230,0
		dta 210,samolot,$80,35,170,230,$c4
		;dta 230,samolot,$a0,36,60,230,0
		dta 250,samolot,$80,35,190,230,0
		dta 14,samolot,$a0,36,100,230,$b3
		dta 34,samolot,$80,35,140,230,0
		dta 54,samolot,$a0,36,90,230,0
		dta 74,samolot,$80,35,160,230,$a5
		;dta 94,samolot,$a0,36,110,230,0
		dta 114,samolot,$80,35,150,230,$a4
		dta 134,samolot,$a0,36,80,230,0		
		
		dta 239,nshape,$44,128				;ustaw rakiete	
		dta 240,rakieta,$d0,17,120,15,0
		dta 14,rakieta,$50,17,100,15,0
		dta 30,rakieta,$70,16,90,15,0		;rakieta w dol i skret w gracza
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

		dta 79,nshape,$04,128
		dta 80,big_plane1,$c0,13,220,204,$33		;BOSS		
		
		dta 0
		
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
		
		dta 252,samolot,$30,33,80,15,0			;samoloty w dol, pozniej w gracza
		dta 254,samolot,$50,33,90,10,$65
		dta 14,samolot,$a0,33,110,15,0
		dta 16,samolot,$70,33,120,10,0
		dta 34,samolot,$a0,33,160,15,$75
		dta 36,samolot,$e0,33,170,10,$64	

		dta 36,czolg,$80,10,55,24,0		;czolg z lewej
		dta 49,czolg,$A0,10,40,16,0	

		;dta 90,samolot,$30,41,120,5,0
		;dta 98,samolot,$70,42,120,5,$42
		;dta 106,samolot,$a0,41,120,5,0
		;dta 114,samolot,$d0,42,120,5,$84
		;dta 122,samolot,$e0,41,120,5,0		
		;dta 130,samolot,$00,42,120,5,$53		
		
		dta 140,czolg,$32,11,220,34,0	;czolg z prawej -> kolor ora $02		
		dta 153,czolg,$e2,11,230,34,0	;czolg z prawej -> kolor ora $02		
			
		dta 189,nshape,$30,192		
		dta 190,moneta,$30,38,90,230,0			;wężyk po lewo 8
		dta 200,moneta,$00,38,90,230,$36
		dta 210,moneta,$a0,38,90,230,0
		dta 220,moneta,$d0,38,90,230,$45
		dta 230,moneta,$70,38,90,230,0
		dta 240,moneta,$00,38,90,230,$c6			

		dta 80,czolg,$e0,10,35,24,0		;czolg z lewej
		dta 95,czolg,$30,10,20,16,0	

		dta 120,samolot,$30,41,90,15,0			;samoloty w dół i lewo
		dta 128,samolot,$70,41,90,15,$53
		dta 136,samolot,$a0,41,90,15,0
		dta 144,samolot,$d0,41,90,15,$a2
		dta 152,samolot,$e0,41,90,15,0		
		dta 160,samolot,$00,41,90,15,$a4

		;dta 191,samolot,$04,2,150,19,0				;() wstążka w dół	
		;dta 195,samolot,$34,3,150,19,$c3			;)(
		;dta 199,samolot,$a4,2,150,19,$c4	
		;dta 203,samolot,$84,3,150,19,0
		;dta 207,samolot,$a4,2,150,19,$c5
		;dta 211,samolot,$44,3,150,19,$c6

		;dta 10,samolot,$80,35,150,230,$65			;z dolu do gory pozniej nawrot lewo/prawo  i w dol
		dta 50,samolot,$80,35,100,230,$74		
		;dta 70,samolot,$80,35,190,230,0
		dta 130,samolot,$a0,36,90,230,0
		dta 150,samolot,$80,35,160,230,$65
		dta 170,samolot,$a0,36,170,230,0
		;dta 210,samolot,$a0,36,80,230,0			
		dta 220,samolot,$a0,36,60,230,0
		
		dta 76,nshape,$24,128				;ustaw gwiazdke
		dta 77,gwiazda,$00,46,130,230,0		;z dolu do góry, póżniej małe kółeczko i góra
		dta 87,gwiazda,$30,46,130,230,$65
		dta 97,gwiazda,$70,46,130,230,0
		dta 107,gwiazda,$a0,46,130,230,$54
		dta 117,gwiazda,$40,46,130,230,0

		dta 207,gwiazda,$00,47,150,10,0		;z dolu do góry, póżniej małe kółeczko i góra
		dta 217,gwiazda,$30,47,150,10,$65
		dta 227,gwiazda,$70,47,150,10,0
		dta 237,gwiazda,$a0,47,150,10,$54
		dta 247,gwiazda,$40,47,150,10,0	

		dta 119,nshape,$30,192
		dta 120,moneta,$00,8,100,230,0			;kolka w moneta :)
		dta	128,moneta,$30,8,100,230,$b5
		dta	136,moneta,$60,8,100,230,0
		dta	144,moneta,$a0,8,100,230,0
		dta	152,moneta,$00,8,100,230,$a4
		dta	160,moneta,$d0,8,100,230,$a2
		dta	168,moneta,$70,8,100,230,0
		dta	176,moneta,$f0,8,100,230,0	

		dta 79,nshape,$14,128			;ustaw kolko
		dta 80,kolko,$70,25,140,15,$53			;dwie linie w dol, kolko i dalej w dol
		dta 90,kolko,$a0,25,140,15,0
		dta 95,kolko,$00,26,100,15,$65
		dta 100,kolko,$d0,25,140,15,0
		dta 105,kolko,$60,26,100,15,0
		dta 110,kolko,$d0,25,140,15,$35
		dta 115,kolko,$60,26,100,15,0
		dta 125,kolko,$30,26,100,15,0	

		dta 131,czolg,$e2,11,220,34,0	;czolg z prawej -> kolor ora $02		
		dta 144,czolg,$72,11,230,34,0	;czolg z prawej -> kolor ora $02	

		dta 238,nshape,$00,128					;nr ksztaltu*2*16, nr obiektu*2,ile bajtow
		dta 239,nshape,$24,128
		dta 240,it,$a0,0,80,19,0
		dta 10,czolg,$00,10,20,18,0
		dta 80,gwiazda,$00,4,130,19,$c2
		dta 96,it,$30,1,75,19,$b1	

		dta 169,nshape,$24,128				;weżyk z lewej do prawej
		dta 170,gwiazda,$50,37,210,90,0	;wężyk z prawej do lewej
		dta 180,gwiazda,$80,37,210,110,$45
		dta 190,gwiazda,$d0,37,210,110,0
		dta 200,gwiazda,$00,37,210,110,$74	
		dta 210,gwiazda,$30,37,210,110,0
		dta 220,gwiazda,$60,37,210,110,$63	
		
		dta 70,ch_bonus,1,3

		dta 80,samolot,$30,22,170,15,$45
		dta 89,samolot,$00,23,160,15,0
		dta 89,samolot,$70,23,180,16,0
		dta 98,samolot,$a0,24,170,15,0

		dta 150,samolot,$30,22,90,15,0		;czworka w dół
		dta 159,samolot,$00,23,80,15,$54
		dta 159,samolot,$70,23,100,16,0
		dta 168,samolot,$a0,24,90,15,$43
		
		dta 220,samolot,$30,22,140,15,$45
		dta 229,samolot,$00,23,130,15,0
		dta 229,samolot,$70,23,150,16,$64
		dta 238,samolot,$a0,24,140,15,0	

		dta 50,samolot,$30,42,150,25,$a3
		dta 58,samolot,$70,42,150,25,0
		dta 66,samolot,$a0,42,150,25,0
		dta 74,samolot,$d0,42,150,25,$82
		dta 82,samolot,$e0,42,150,25,0		
		dta 90,samolot,$00,42,150,25,$c4

		dta 121,czolg,$e2,11,220,34,0	;czolg z prawej -> kolor ora $02		

		dta 137,nshape,$30,192			;MONETA
		dta 168,moneta,$30,33,80,15,0			;kolko w dol, pozniej w gracza
		dta 176,moneta,$a0,33,90,5,$c4
		dta 184,moneta,$70,33,110,15,0
		dta 192,moneta,$d0,33,120,5,$b3
		dta 200,moneta,$a0,33,160,15,0
		dta 208,moneta,$e0,33,170,5,$a4	

		dta 51,samolot,$60,27,200,30,$34		;samoloty z prawej i w lewo
		dta 52,samolot,$30,27,220,54,$a5
		dta 53,samolot,$a0,27,240,78,0
		
		dta 71,samolot,$00,28,50,30,$53		;samoloty z lewej i w prawo
		dta 72,samolot,$70,28,30,54,$00
		dta 73,samolot,$e0,28,10,78,$85		

		dta 9,nshape,$00,128					;z góry prawo-dół, kolko i lewo-dół
		dta 10,it,$70,40,90,15,$c6
		dta 20,it,$a0,40,90,15,0
		dta 30,it,$30,40,90,15,$d5
		dta 40,it,$a0,40,90,15,0
		dta 50,it,$00,40,90,15,$c7
		dta 60,it,$80,40,90,15,0

		dta 221,nshape,$00,128					;nr ksztaltu*2*16, nr obiektu*2,ile bajtow
		dta 222,it1,$a4,2,120,19,0
		dta 226,it1,$84,3,120,19,$96
		dta 230,it1,$b4,2,120,19,0				;() wstążka w dół	
		dta 234,it1,$34,3,120,19,$c3			;)(
		dta 238,it1,$a4,2,120,19,$a4	
		dta 242,it1,$84,3,120,19,0
		dta 246,it1,$a4,2,120,19,0
		dta 250,it1,$84,3,120,19,$a5			
		
		dta 79,nshape,$24,128		;powtórzenie z powodu checkpointa		
		dta 80,gwiazda,$c0,39,160,230,00		;z dolu do gory i dwa kolka wieksze i mniejsze, pozniej gora
		dta 90,gwiazda,$a0,39,160,230,$c5
		dta 100,gwiazda,$30,39,160,230,00
		dta 110,gwiazda,$70,39,160,230,00
		dta 120,gwiazda,$e0,39,160,230,$c6
		dta 130,gwiazda,$60,39,160,230,00
		dta 140,gwiazda,$00,39,160,230,00
		
		dta 60,ch_bonus,2,3
		
		dta 69,nshape,$30,192		
		dta 70,moneta,$30,38,80,230,0			;wężyk po lewo 8
		dta 80,moneta,$00,38,80,230,$66
		dta 90,moneta,$a0,38,80,230,0
		dta 100,moneta,$d0,38,80,230,$55
		dta 110,moneta,$70,38,80,230,0
		dta 120,moneta,$00,38,80,230,$c6
		dta 130,moneta,$30,38,80,230,0			
				
		dta 40,moneta,$00,48,90,225,0			;kolka w moneta :)
		dta	48,moneta,$30,48,90,225,$b5
		dta	56,moneta,$60,48,90,225,$c3
		dta	64,moneta,$a0,48,90,225,0
		dta	72,moneta,$00,48,90,225,$a4
		dta	80,moneta,$d0,48,90,225,$a2
		dta	88,moneta,$70,48,90,225,0
		dta	96,moneta,$f0,48,90,225,0	

		dta 128,checkpoint
		dta 160,ch_bonus,0,4

		dta 9,nshape,$24,128		;gwiazda		
		dta 10,gwiazda,$50,19,40,110,$93		;sinusoida w prawo
		dta 20,gwiazda,$80,19,40,110,0
		dta 30,gwiazda,$d0,19,40,110,0
		dta 40,gwiazda,$00,19,40,110,$a5	
		dta 50,gwiazda,$30,19,40,110,0
		dta 60,gwiazda,$60,19,40,110,$85		
		
		dta 161,samolot,$30,29,110,15,$00			; 2 linie nawrot w lewo/prawo
		dta 168,samolot,$70,30,140,15,$00
		dta 173,samolot,$40,29,110,15,$00
		dta 180,samolot,$80,30,140,15,$c8
		dta 185,samolot,$50,29,110,15,$00
		dta 192,samolot,$90,30,140,15,$00
		dta 197,samolot,$00,29,110,15,$00
		dta 204,samolot,$a0,30,140,15,$00
		dta 209,samolot,$20,29,110,15,$39
		dta 216,samolot,$b0,30,140,15,$00
		dta 221,samolot,$e0,29,110,15,$00
		dta 228,samolot,$c0,30,140,15,$00

		
		dta 136,czolg,$80,10,55,24,0		;czolg z lewej
		dta 149,czolg,$A0,10,40,16,0

		dta 159,nshape,$44,128				;ustaw rakiete		
		dta 160,big_plane,$b0,7,220,204,$34
		dta 210,rakieta,$30,17,60,15,0		;rakieta w dol i skret w prawo	
		dta 34,rakieta,$70,16,90,15,0		;rakieta w dol i skret w lewo	
		dta 114,rakieta,$40,17,60,15,0	
		dta 194,rakieta,$90,16,90,15,0		
		dta 20,rakieta,$00,17,60,15,0	

		dta 150,samolot2,$b0,34,100,15,0		;spadajace samoloty, pozniej góra
		dta 160,samolot2,$c0,34,70,15,$86
		dta 170,samolot2,$d0,34,150,15,0
		dta 180,samolot2,$e0,34,90,15,$43
		dta 190,samolot2,$30,34,120,15,0
		dta 200,samolot2,$00,34,170,15,$85	

		dta 100,samolot,$30,41,130,2,0			;w dol , potem lewo i prawo
		dta 108,samolot,$70,42,130,2,$44
		dta 116,samolot,$a0,41,130,2,0
		dta 124,samolot,$d0,42,130,2,$84
		dta 132,samolot,$e0,41,130,2,0		
		dta 140,samolot,$00,42,130,2,$53			

		dta 199,nshape,$30,192			;MONETA
		dta 200,moneta,$30,33,80,15,0			;kolko w dol, pozniej w gracza
		dta 208,moneta,$a0,33,90,5,$64
		dta 216,moneta,$70,33,110,15,0
		dta 224,moneta,$d0,33,120,5,$53
		dta 232,moneta,$a0,33,160,15,0
		dta 240,moneta,$e0,33,170,5,$84	
		
		dta 79,nshape,$24,128				;ustaw gwiazdke
		dta 80,gwiazda,$00,47,130,5,0		;z góry na dół , póżniej małe kółeczko i dół
		dta 90,gwiazda,$30,47,130,5,$65
		dta 100,gwiazda,$70,47,130,5,0
		dta 110,gwiazda,$a0,47,130,5,$54
		dta 120,gwiazda,$40,47,130,5,0			
	
		dta 1,samolot,$30,22,90,15,0		;czworka w dół
		dta 10,samolot,$00,23,80,15,$54
		dta 10,samolot,$70,23,100,16,0
		dta 19,samolot,$a0,24,90,15,$43
		
		dta 71,samolot,$30,22,140,15,$45
		dta 80,samolot,$00,23,130,15,0
		dta 80,samolot,$70,23,150,16,$84
		dta 89,samolot,$a0,24,140,15,0

		dta 90,ch_bonus,1,3
		
		dta 169,nshape,$14,128			;ustaw kolko	
		dta 170,kolko,$30,38,90,230,0			;wężyk po lewo 8
		dta 180,kolko,$00,38,90,230,$56
		dta 190,kolko,$a0,38,90,230,0
		dta 200,kolko,$d0,38,90,230,$45
		dta 210,kolko,$70,38,90,230,0
		dta 220,kolko,$00,38,90,230,$c6
		dta 230,kolko,$30,38,90,230,0	
		
		dta 99,nshape,$24,128				;ustaw gwiazdke
		dta 100,gwiazda,$30,49,170,20,0			;w dol , przy okazji robi kolka
		dta 120,gwiazda,$70,49,170,20,0
		dta 140,gwiazda,$a0,49,170,20,0
		dta 160,gwiazda,$d0,49,170,20,0
		
		dta 200,wait
		
		dta 179,nshape,$30,192			;MONETA		
		dta 180,moneta,$00,50,30,110,0			;kolka w moneta :)
		dta	188,moneta,$30,50,30,110,$65
		dta	196,moneta,$60,50,30,110,$54
		dta	204,moneta,$a0,50,30,110,0
		dta	212,moneta,$00,50,30,110,$64
		dta	220,moneta,$d0,50,30,110,$54
		dta	228,moneta,$70,50,30,110,0
		dta	236,moneta,$f0,50,30,110,$44

		dta 240,ch_bonus,2,3

		dta 189,nshape,$14,128			;ustaw kolko
		dta 190,kolko,$80,31,80,20,0
		dta 200,kolko,$a0,31,80,20,0
		dta 210,kolko,$e0,31,80,20,0
		dta 220,kolko,$30,31,80,20,0
		dta 230,kolko,$70,31,80,20,0
		dta 240,kolko,$c0,31,80,20,0

		dta 116,czolg,$e0,10,55,24,0		;czolg z lewej
		dta 129,czolg,$A0,10,40,16,0		
	
		dta 190,samolot2,$b0,34,100,15,0		;spadajace samoloty, pozniej góra
		dta 200,samolot2,$c0,34,70,15,$56
		dta 210,samolot2,$d0,34,150,15,0
		dta 220,samolot2,$e0,34,90,15,$84
		dta 230,samolot2,$30,34,120,15,0
		dta 240,samolot2,$00,34,170,15,$55	

		dta 90,nshape,$24,128				;ustaw gwiazdke
		dta 104,gwiazda,$30,33,80,15,0			;samoloty w dol, pozniej w gracza
		dta 106,gwiazda,$50,33,90,10,$65
		dta 124,gwiazda,$a0,33,110,15,0
		dta 126,gwiazda,$70,33,120,10,0
		dta 144,gwiazda,$a0,33,160,15,$75
		dta 146,gwiazda,$e0,33,170,10,$64

		dta 1,samolot,$30,29,110,15,$00			; 2 linie nawrot w lewo/prawo
		dta 8,samolot,$70,30,140,15,$00
		dta 13,samolot,$40,29,110,15,$00
		dta 20,samolot,$80,30,140,15,$c8
		dta 25,samolot,$50,29,110,15,$00
		dta 32,samolot,$90,30,140,15,$00
		dta 37,samolot,$00,29,110,15,$00
		dta 44,samolot,$a0,30,140,15,$00
		dta 49,samolot,$20,29,110,15,$69
		dta 56,samolot,$b0,30,140,15,$00
		dta 61,samolot,$e0,29,110,15,$00
		dta 68,samolot,$c0,30,140,15,$00


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

		dta 80,big_plane1,$30,13,220,204,$33		
	
		dta 0
		
		
		
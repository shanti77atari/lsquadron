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
		dta 254,samolot,$30,33,90,5,0
		dta 14,samolot,$70,33,110,15,0
		dta 16,samolot,$70,33,120,5,0
		dta 34,samolot,$a0,33,160,15,0
		dta 36,samolot,$a0,33,170,5,0
		
		dta 100,samolot2,$b0,34,100,15,0		;spadajace samoloty, pozniej góra
		dta 110,samolot2,$c0,34,90,15,0
		dta 120,samolot2,$d0,34,110,15,0
		dta 130,samolot2,$e0,34,80,15,$c6
		dta 140,samolot2,$30,34,120,15,0
		dta 150,samolot2,$00,34,130,15,0
		
		dta 230,czolg,$80,10,35,24,0		;czolg z lewej
		dta 243,czolg,$A0,10,20,16,0
		
		dta 119,nshape,$30,192		
		dta 120,moneta,$30,20,140,230,0			;wężyk po prawo '&'
		dta 130,moneta,$00,20,140,230,$36
		dta 140,moneta,$a0,20,140,230,0
		dta 150,moneta,$d0,20,140,230,$45
		dta 160,moneta,$70,20,140,230,0
		dta 170,moneta,$00,20,140,230,$c6
		dta 180,moneta,$30,20,140,230,0
		
		dta 106,nshape,$24,128				;ustaw gwiazdke
		dta 107,gwiazda,$00,9,110,230,0		;z dolu do góry, póżniej małe kółeczko i góra
		dta 117,gwiazda,$30,9,110,230,$b6
		dta 127,gwiazda,$70,9,110,230,0
		dta 137,gwiazda,$a0,9,110,230,$ee
		dta 147,gwiazda,$40,9,110,230,0	

		dta 10,samolot,$80,35,150,230,0			;z dolu do gory pozniej nawrot lewo/prawo  i w dol
		dta 30,samolot,$a0,36,80,230,0
		dta 50,samolot,$80,35,170,230,$c6
		dta 70,samolot,$a0,36,60,230,0
		dta 90,samolot,$80,35,190,230,0
		;dta 110,samolot,$a0,36,100,230,$b7
		dta 130,samolot,$80,35,140,230,0
		dta 150,samolot,$a0,36,90,230,0
		dta 170,samolot,$80,35,160,230,$a8
		;dta 190,samolot,$a0,36,110,230,0
		dta 215,samolot,$80,35,150,230,$a8
		dta 225,samolot,$a0,36,80,230,0
		
		dta 32,checkpoint
		dta 65,ch_bonus,1,3
		
		
		dta 75,czolg,$02,11,220,34,0	;czolg z prawej -> kolor ora $02

		dta 221,nshape,$00,128					;nr ksztaltu*2*16, nr obiektu*2,ile bajtow
		dta 222,it1,$a4,2,120,19,0
		dta 226,it1,$84,3,120,19,$c6
		dta 230,it1,$b4,2,120,19,0				;() wstążka w dół	
		dta 234,it1,$34,3,120,19,$cf			;)(
		dta 238,it1,$a4,2,120,19,$c4	
		dta 242,it1,$84,3,120,19,0
		dta 246,it1,$a4,2,120,19,0
		dta 250,it1,$84,3,120,19,$c6

		dta 49,nshape,$24,128				;weżyk z lewej do prawej
		dta 50,gwiazda,$50,19,40,90,$c8
		dta 60,gwiazda,$80,19,40,110,$47
		dta 70,gwiazda,$d0,19,40,110,0
		dta 80,gwiazda,$00,19,40,110,$b8	
		dta 90,gwiazda,$30,19,40,110,0
		dta 100,gwiazda,$60,19,40,110,$b8
		
		dta 240,gwiazda,$50,37,210,90,$c8	;wężyk z prawej do lewej
		dta 250,gwiazda,$80,37,210,110,$47
		dta 4,gwiazda,$d0,37,210,110,0
		dta 14,gwiazda,$00,37,210,110,$b8	
		dta 24,gwiazda,$30,37,210,110,0
		dta 34,gwiazda,$60,37,210,110,$b8		
		
		dta 130,czolg,$80,10,35,24,0		;czolg z lewej
		dta 150,czolg,$02,11,220,34,0	;czolg z prawej -> kolor ora $02
		
		dta 50,nshape,$14,128			;ustaw kolko
		dta 60,kolko,$70,25,140,15,0			;dwie linie w dol, kolko i dalej w dol
		dta 70,kolko,$a0,25,140,15,0
		dta 75,kolko,$00,26,100,15,$c5
		dta 80,kolko,$d0,25,140,15,0
		dta 85,kolko,$60,26,100,15,0
		dta 90,kolko,$d0,25,140,15,$35
		dta 95,kolko,$60,26,100,15,0
		dta 105,kolko,$30,26,100,15,0		
		
			
		dta 240,samolot,$90,18,170,15,$c3	;w dol , pozniej nawrot i prawo gora
		dta 30,samolot,$a0,18,100,15,$c3
		dta 70,samolot,$d0,18,130,15,0
		dta 110,samolot,$30,18,90,15,$84
		dta 150,samolot,$70,18,130,15,0
		dta 190,samolot,$50,18,90,15,$84
		dta 230,samolot,$00,18,70,15,$c3	

		dta 96,checkpoint
		
		
		dta 128,nshape,$00,128					;nr ksztaltu*2*16, nr obiektu*2,ile bajtow
		dta 129,nshape,$24,128
		
		
		dta 130,it,$a0,0,80,19,0
		dta 131,ch_bonus,2,3
		dta 160,czolg,$00,10,20,18,0
		dta 210,gwiazda,$00,4,130,19,$c2
		dta 236,it,$30,1,75,19,$b1		
		
		dta 139,nshape,$30,192
		dta 140,moneta,$00,8,100,230,0			;kolka w moneta :)
		dta	148,moneta,$30,8,100,230,$b6
		dta	156,moneta,$60,8,100,230,$c9
		dta	164,moneta,$a0,8,100,230,0
		dta	172,moneta,$00,8,100,230,$df
		dta	180,moneta,$d0,8,100,230,$c2
		dta	188,moneta,$70,8,100,230,0
		dta	196,moneta,$f0,8,100,230,0	

		dta 90,samolot,$30,22,170,15,$48
		dta 99,samolot,$00,23,160,15,0
		dta 99,samolot,$70,23,180,16,$57
		dta 108,samolot,$a0,24,170,15,0

		dta 160,samolot,$30,22,90,15,0		;czworka w dół
		dta 169,samolot,$00,23,80,15,$57
		dta 169,samolot,$70,23,100,16,0
		dta 178,samolot,$a0,24,90,15,$48
		
		dta 230,samolot,$30,22,140,15,$48
		dta 239,samolot,$00,23,130,15,0
		dta 239,samolot,$70,23,150,16,$57
		dta 248,samolot,$a0,24,140,15,0		
		
		dta 60,samolot,$30,22,120,15,0		;czworka w dół
		dta 69,samolot,$00,23,110,15,$57
		dta 69,samolot,$70,23,130,16,0
		dta 78,samolot,$a0,24,120,15,$48
		
		dta 179,samolot1,$30,15,165,20,$00

		
		dta 229,nshape,$14,128			;ustaw kolko		
		dta 230,kolko,$80,31,70,20,0
		dta 240,kolko,$70,31,70,20,$c6
		
		dta 243,samolot1,$80,15,190,20,$00
		
		dta 250,kolko,$a0,31,70,20,0
		dta 4,kolko,$d0,31,70,20,$d7
		dta 14,kolko,$00,31,70,20,0
		dta 24,kolko,$80,31,70,20,$c6	
		

		
		dta 192,checkpoint		
		dta 225,ch_bonus,0,4
		
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
		
		dta 80,big_plane,$30,7,220,204,$34	
		dta 130,rakieta,$30,17,60,15,0		;rakieta w dol i skret w prawo	
		dta 210,rakieta,$70,16,90,15,0		;rakieta w dol i skret w lewo	
		dta 30,rakieta,$40,17,60,15,0	
		dta 110,rakieta,$90,16,90,15,0		
		dta 190,rakieta,$00,17,60,15,0	
		
		dta 131,samolot,$04,2,100,19,0				;() wstążka w dół	
		dta 135,samolot,$34,3,100,19,$cf			;)(
		dta 139,samolot,$a4,2,100,19,$c4	
		dta 143,samolot,$84,3,100,19,0
		dta 147,samolot,$a4,2,100,19,$cf
		dta 151,samolot,$44,3,100,19,$c6	

		dta 10,czolg,$80,10,35,24,0		;czolg z lewej
		;dta 50,czolg,$02,11,220,34,0	;czolg z prawej -> kolor ora $02		
		
		dta 128,checkpoint	
		dta 160,ch_bonus,1,3
		
		dta 169,nshape,$30,192		
		dta 170,moneta,$80,20,130,230,0			;wężyk po lewo '&' odwrocony
		dta 180,moneta,$00,20,130,230,$36
		dta 190,moneta,$a0,20,130,230,0
		dta 200,moneta,$d0,20,130,230,$45
		dta 210,moneta,$70,20,130,230,0
		dta 220,moneta,$e0,20,130,230,$c6
		dta 230,moneta,$30,20,130,230,0		
		
		dta 120,samolot,$00,18,140,15,$c5		;w dol , pozniej nawrot i prawo gora
		dta 130,samolot,$90,18,140,15,$c3
		dta 140,samolot,$a0,18,140,15,$c6
		dta 150,samolot,$d0,18,140,15,0
		dta 160,samolot,$30,18,140,15,$b4
		dta 170,samolot,$20,18,140,15,$c6
		dta 180,samolot,$e0,18,140,15,0		
		
		dta 1,samolot,$60,27,200,30,$38		;samoloty z prawej i w lewo
		dta 2,samolot,$30,27,220,54,$08
		dta 3,samolot,$a0,27,240,78,0
		
		dta 21,samolot,$00,28,50,30,$38		;samoloty z lewej i w prawo
		dta 22,samolot,$70,28,30,54,$00
		dta 23,samolot,$e0,28,10,78,$c8	

		dta 211,nshape,$24,128		;powtórzenie z powodu checkpointa
		dta 212,gwiazda,$00,21,30,80,0		;koleczko z lewej
		dta 222,gwiazda,$30,21,30,80,$b6
		dta 232,gwiazda,$70,21,30,80,0
		dta 242,gwiazda,$a0,21,30,80,$43
		dta 252,gwiazda,$00,21,30,80,0	

		dta 105,czolg,$80,10,35,24,0		;czolg z lewej
		dta 117,czolg,$A0,10,20,16,0		

		dta 199,nshape,$24,128		;powtórzenie z powodu checkpointa		
		dta 200,gwiazda,$c0,39,150,230,00
		dta 210,gwiazda,$a0,39,150,230,$c5
		dta 220,gwiazda,$30,39,150,230,00
		dta 230,gwiazda,$70,39,150,230,00
		dta 240,gwiazda,$e0,39,150,230,$c6
		dta 250,gwiazda,$60,39,150,230,00
		
		dta 192,checkpoint	
		dta 224,ch_bonus,2,3

		dta 230,samolot2,$b0,34,100,15,0		;spadajace samoloty, pozniej góra
		dta 240,samolot2,$c0,34,70,15,0
		dta 250,samolot2,$d0,34,150,15,0
		dta 4,samolot2,$e0,34,90,15,$c6
		dta 14,samolot2,$30,34,120,15,0
		dta 24,samolot2,$00,34,170,15,0	

		dta 179,nshape,$00,128					;z góry prawo-dół, kolko i lewo-dół
		dta 180,it,$70,40,90,15,$c6
		dta 190,it,$a0,40,90,15,0
		dta 200,it,$30,40,90,15,$d5
		dta 210,it,$a0,40,90,15,0
		dta 220,it,$00,40,90,15,$c7
		dta 230,it,$80,40,90,15,0
		
		dta 149,nshape,$24,128		;powtórzenie z powodu checkpointa	
		dta 150,gwiazda,$70,25,140,15,0		
		dta 160,gwiazda,$a0,25,140,15,0			;2 linie w dol po drodze male kolka
		dta 165,gwiazda,$00,26,100,15,$c5
		dta 170,gwiazda,$d0,25,140,15,0
		dta 175,gwiazda,$60,26,100,15,0
		dta 180,gwiazda,$d0,25,140,15,$35
		dta 185,gwiazda,$60,26,100,15,0
		dta 195,gwiazda,$30,26,100,15,0	

		dta 69,nshape,$14,128			;ustaw kolko
		dta 80,kolko,$30,33,80,15,0			;kolko w dol, pozniej w gracza
		dta 88,kolko,$a0,33,90,5,$c6
		dta 100,kolko,$70,33,110,15,0
		dta 108,kolko,$d0,33,120,5,$b7
		dta 120,kolko,$a0,33,160,15,0
		dta 128,kolko,$e0,33,170,5,$d6
		
		dta 180,czolg,$80,10,35,24,0		;czolg z lewej
		;dta 220,czolg,$02,11,220,34,0	;czolg z prawej -> kolor ora $02		
		

		dta 19,nshape,$30,192		
		dta 20,moneta,$30,20,140,230,0			;wężyk po prawo '&'
		dta 30,moneta,$00,20,140,230,$36
		dta 40,moneta,$a0,20,140,230,0
		dta 50,moneta,$d0,20,140,230,$45
		dta 60,moneta,$70,20,140,230,0
		dta 70,moneta,$00,20,140,230,$c6
		dta 80,moneta,$30,20,140,230,0	
		
		dta 1,samolot,$34,2,100,19,0				;() wstążka w dół	
		dta 5,samolot,$74,3,100,19,$cf			;)(
		dta 9,samolot,$a4,2,100,19,$c4	
		dta 13,samolot,$84,3,100,19,0
		dta 17,samolot,$a4,2,100,19,$cf
		dta 21,samolot,$e4,3,100,19,$c6	

		dta 99,nshape,$44,128				;ustaw rakiete	
		dta 100,rakieta,$30,17,60,15,0		;rakieta w dol i skret w prawo
		dta 120,rakieta,$80,17,180,15,0
		dta 140,rakieta,$d0,17,120,15,0
		dta 150,rakieta,$50,17,100,15,0
		dta 160,rakieta,$70,16,90,15,0		;rakieta w dol i skret w lewo
		dta 170,rakieta,$c0,17,60,15,0
		dta 180,rakieta,$90,17,160,15,0
		dta 190,rakieta,$a0,17,120,15,0
		dta 200,rakieta,$00,16,70,15,0
		dta 210,rakieta,$20,17,150,15,0
		dta 220,rakieta,$70,17,90,15,0
		dta 230,rakieta,$40,17,60,15,0
		dta 240,rakieta,$a0,16,200,15,0
		dta 250,rakieta,$e0,17,130,15,0
		
		dta 79,nshape,$24,128				;gwiazdy
		dta 80,big_plane1,$e0,13,220,204,$33		;BOSS
		
		
		dta 0		;end
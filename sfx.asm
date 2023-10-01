//efekty dzwiekowe

kanal1				org *+1
petla1				org *+1
kanal2				org *+1
petla2				org *+1
kanal3				org *+1
petla3				org *+1
kanal4				org *+1
petla4				org *+1

kanal1s				org *+2		;2 bajty , uzywamy tylko 1
kanal2s				org *+2
kanal3s				org *+2
kanal4s				org *+2	
sfx					org *+1

asteroid_dat	dta a(0)
				;ins '/sfx/asteroid_audf'
bomba_dat		dta a(0)
				ins '/sfx/bomba_audf'
spyHit_dat	dta b(0)
				;ins '/sfx/spyHit_audf'
enemyHit_dat dta a(0)
				ins '/sfx/enemyHit_audf'
strzal_dat	dta a(0)
				ins '/sfx/strzal_audf'	
dzialko_dat	dta a(0)
				;ins '/sfx/dzialko_audf'
wybuch_dat	dta a(0)
				ins '/sfx/wybuch_audf'	
dead_dat		dta a(0)
				;ins '/sfx/dead_audf'		
antyair_dat	dta a(0)
				ins '/sfx/antyair_audf'		
extraLife_dat dta a(0)
				ins '/sfx/extraLife_audf'
alarm_dat		dta b(0)
				;ins '/sfx/alarm_audf'	
rakieta_dat	dta a(0)
				;ins '/sfx/rakieta_audf'	
silnik_dat	dta b(0)
				;ins '/sfx/silnik_audf'					

	
asteroid1_dat	dta a(0)
				;ins '/sfx/asteroid_audc'
bomba1_dat		dta a(0)
				ins '/sfx/bomba_audc'
spyHit1_dat	dta a(0)
				;ins '/sfx/spyHit_audc'
enemyHit1_dat dta a(0)
				ins '/sfx/enemyHit_audc'
strzal1_dat	dta a(0)
				ins '/sfx/strzal_audc'	
dzialko1_dat	dta a(0)
				;ins '/sfx/dzialko_audc'
wybuch1_dat	dta a(0)
				ins '/sfx/wybuch_audc'	
dead1_dat		dta a(0)
				;ins '/sfx/dead_audc'		
antyair1_dat	dta a(0)
				ins '/sfx/antyair_audc'		
extraLife1_dat dta a(0)
				ins '/sfx/extraLife_audc'
alarm1_dat		dta b(0)
				;ins '/sfx/alarm_audc'	
rakieta1_dat	dta a(0)
				;ins '/sfx/rakieta_audc'	
silnik1_dat	dta b(0)
				;ins '/sfx/silnik_audc'


MUSIC_BUFOR_LENGTH=64
buf_audf1		org *+MUSIC_BUFOR_LENGTH
buf_audc1		org *+MUSIC_BUFOR_LENGTH
buf_audf2		org *+MUSIC_BUFOR_LENGTH
buf_audc2		org *+MUSIC_BUFOR_LENGTH
buf_audf3		org *+MUSIC_BUFOR_LENGTH
buf_audc3		org *+MUSIC_BUFOR_LENGTH
buf_audf4		org *+MUSIC_BUFOR_LENGTH
buf_audc4		org *+MUSIC_BUFOR_LENGTH
buf_audctl		org *+MUSIC_BUFOR_LENGTH


//zapisuje nuty do bufora, ile zdąży w ramce
graj_bufor
		lda licznik_bufor
		beq @+				;jesli 0 to musi wykonac
		cmp #MUSIC_BUFOR_LENGTH-1
		bcc *+3
		rts
		lda vcount
		bmi @+
		cmp #$5f
		bcc @+
		rts
@		jsr rmt_p1
		inc licznik_bufor
		ldy licznik_nuta1

		lda trackn_audf+0
		sta buf_audf1,y
		lda trackn_audc+0
		sta buf_audc1,y
		
		lda trackn_audf+1
		sta buf_audf2,y
		lda trackn_audc+1
		sta buf_audc2,y
		
		lda trackn_audf+2
		sta buf_audf3,y
		lda trackn_audc+2
		sta buf_audc3,y
		
		lda trackn_audf+3
		sta buf_audf4,y
		lda trackn_audc+3
		sta buf_audc4,y

		lda v_audctl
		sta buf_audctl,y
		dey
		tya
		and #MUSIC_BUFOR_LENGTH-1
		sta licznik_nuta1
		jmp graj_bufor

//odgrywa muzykę z bufora		
graj_nute
		asl music
		bcc @+
		mva ntscAntic music
		rts

@		dec	licznik_bufor
		
		ldy licznik_nuta
		lda buf_audf1,y
		ldx buf_audc1,y
		sta audf1
		stx audc1
		lda buf_audf2,y
		ldx buf_audc2,y
		sta audf2
		stx audc2
		lda buf_audf3,y
		ldx buf_audc3,y
		sta audf3
		stx audc3
		ldx kanal4
		bne @+
		lda buf_audf4,y
		ldx buf_audc4,y
		sta audf4
		stx audc4
@		lda buf_audctl,y
		sta audctl
		dey
		tya
		and #MUSIC_BUFOR_LENGTH-1
		sta licznik_nuta
		rts

				
channel=3	
add_fx
		ldx kanal4
		beq @+
		cmp prio
		bcs @+
		rts
@		;ldx #3*2		;nr kanalu
		sta prio
		lda audf_table,y
		sta kanal_audf1+channel*2
		lda audf_table+1,y
		sta kanal_audf1+1+channel*2
		
		lda audc_table,y
		sta kanal_audc1+channel*2
		lda audc_table+1,y
		sta kanal_audc1++1+channel*2
		
		lda len_table,y
		sta kanal1+channel*2				;dlugosc
		sta kanal1s,x
		lda len_table+1,y
		sta petla1+channel*2			;petla
		rts
		

play_fx
/*		ldy kanal1
		beq pfx2
		lda (kanal_audf1),y
		sta audf1
		lda (kanal_audc1),y
		sta audc1
		dey
		bne @+					;jeszcze nie koniec
		lda petla1			;czy zapetlony 0=nie
		beq @+
		ldy kanal1s
@		sty kanal1

pfx2   ldy kanal2
		beq pfx3
		lda (kanal_audf2),y
		sta audf2
		lda (kanal_audc2),y
		sta audc2
		dey
		bne @+					;jeszcze nie koniec
		lda petla2			;czy zapetlony 0=nie
		beq @+
		ldy kanal2s
@		sty kanal2
		
pfx3	ldy kanal3
		beq pfx4
		lda (kanal_audf3),y
		sta audf3
		lda (kanal_audc3),y
		sta audc3
		dey
		bne @+					;jeszcze nie koniec
		lda petla3			;czy zapetlony 0=nie
		beq @+
		ldy kanal3s
@		sty kanal3		
*/
pfx4	ldy kanal4
		beq pfx0
		lda (kanal_audf4),y
		sta audf4
		lda (kanal_audc4),y
		sta audc4
		dey
		bne @+					;jeszcze nie koniec
		lda petla4			;czy zapetlony 0=nie
		beq @+
		ldy kanal4s
@		sty kanal4	

pfx0	rts		
		
	
audf_table
		dta a(asteroid_dat),a(bomba_dat),a(spyHit_dat),a(0),a(0)
		dta a(enemyHit_dat),a(strzal_dat),a(dzialko_dat),a(wybuch_dat),a(dead_dat)
		dta a(0),a(0),a(antyair_dat),a(extraLife_dat),a(alarm_dat)
		dta a(rakieta_dat),a(silnik_dat)

audc_table
		dta a(asteroid1_dat),a(bomba1_dat),a(spyHit1_dat),a(0),a(0)
		dta a(enemyHit1_dat),a(strzal1_dat),a(dzialko1_dat),a(wybuch1_dat),a(dead1_dat)
		dta a(0),a(0),a(antyair1_dat),a(extraLife1_dat),a(alarm1_dat)
		dta a(rakieta1_dat),a(silnik1_dat)
		
len_table
		dta b(9+1,0),b(56+1,0),b(34+1,0),a(0),a(0)					;+1 bo dodajemy ciszę
		dta b(27+1,0),b(19+1,0),b(20+1,0),b(62+1,0),b(70+1,0)
		dta a(0),a(0),b(13+1,0),b(49+1,0),b(60,1)
		dta b(46+1,0),b(144,1)
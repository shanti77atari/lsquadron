
.local AI
//zmienne duszkow
sprite_komenda			org *+MAX_SPRITES
sprite_komenda_pozycja	org *+MAX_SPRITES
sprite_komenda_ile		org *+MAX_SPRITES
sprite_komenda_cwiartka	org *+MAX_SPRITES
sprite_komenda_m		org *+MAX_SPRITES
sprite_komenda_s		org *+MAX_SPRITES
sprite_path_m			org *+MAX_SPRITES
sprite_path_s			org *+MAX_SPRITES
sprite_move				org *+MAX_SPRITES


//nazwy komend
k_prosto	equ 1
k_luk		equ 2

//kiedy znak ma zniknac z ekranu
max_y_znak	equ 200

move_sprites	
		ldx #8		;MAX_SPRITES-1
@		lda sprite_x,x
		beq @+
		lda sprite_wybuch,x
		bne @+
		jsr move_sprites_0
@		dex
		bne @-1
		
		rts
	
		
//x=nr duszka		
move_sprites_0
		lda sprite_komenda,x
		bne @+			;>0 jest już jakaś komenda	
	
		lda #0
		sta sprite_komenda_pozycja,x
move_sprites_01			
		jsr get_next_command
		
@		cmp #k_prosto	
		bne @+
		jmp go_prosto
@		rts		

//pobierz nastepna komende wraz z parametrami
get_next_command
		lda sprite_komenda_m,x
		sta pom
		lda sprite_komenda_s,x
		sta pom+1
		ldy sprite_komenda_pozycja,x
		lda (pom),y
		sta sprite_komenda,x
		bpl @+ 
		lda #0
		sta sprite_x,x	;jesli <0 to koniec , usun duszka
		pla
		pla				;przejdz do nastepnego duszka
		rts
		
@		cmp #k_prosto		;czy komenda=prosto?
		bne @+
		jmp prepare_prosto		
@		rts	


//wykonaj ruch prosto
go_prosto
		lda sprite_komenda_ile,x				
		beq move_sprites_01			;czy koniec tablicy?,pobierz nastepna komende
		
		ldy sprite_move,x
		clc
		lda sprite_dx,x
		adc _prosto,y
		sta sprite_dx,x
		lda sprite_x,x
		adc _prosto+1,y
		sta sprite_x,x
		
		clc
		lda sprite_dy,x
		adc _prosto+2,y
		sta sprite_dy,x
		lda sprite_y,x
		adc _prosto+3,y
		sta sprite_y,x
		
		dec sprite_komenda_ile,x
		rts
		


//przygotuj dane dla prostego ruchu
prepare_prosto
		iny
		lda (pom),y
		sta sprite_komenda_ile,x
		iny
		lda (pom),y
		and #%111
		sta _ppr0
		lda (pom),y
		asl
		asl
		sta sprite_move,x
		lda sprite_shape,x
		and #%11111000
_ppr0	equ *+1		
		ora #$ff
		sta sprite_shape,x
		
		iny
		tya
		sta sprite_komenda_pozycja,x
		
		lda sprite_komenda,x		;przywroc nr komendy w Accu
		rts

//sciezki komend		
;k_prosto,ile_ramek,predkosc(3bity)+kat(3bity)
s		equ 1*8

path1	dta k_prosto,65,4+s,k_prosto,16,3+s,k_prosto,120-40,2+s,k_prosto,16+30,1+s,k_prosto,50-25,0+s,k_prosto,16,7+s,k_prosto,120-30,6+s,k_prosto,16+50,5+s,-1		

//tablica predkosci dla ruchu po linii prostej		
_prosto	
;speed0		1,000
		dta a(0),a($fe00)
		dta a($00b5),a($fe96)
		dta a($0100),a(0)
		dta a($00b5),a($016a)
		dta a(0),a($0200)
		dta a($ff4b),a($016a)
		dta a($ff00),a(0)
		dta a($ff4b),a($fe96)
		
;speed1		0,875
		dta a(0),a($fe40)
		dta a($009e),a($fec4)
		dta a($00e0),a(0)
		dta a($009e),a($013c)
		dta a(0),a($01c0)
		dta a($ff62),a($013c)
		dta a($ff20),a(0)
		dta a($ff62),a($fec4)
		
	
		

.endl

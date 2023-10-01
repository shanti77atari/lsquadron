		org $600
		
pom		equ 203

liczba	equ $00e0		
		
.rept 2,#
.rept 9,#
		dta b(:1*10+:2)
.endr
.endr
		
run		
		dta 2
		
		
		run run
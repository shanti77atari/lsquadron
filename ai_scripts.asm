//skrypty AI

//DIR dla LINE				PHASE dla LINE    unit dla ARC
;		0						0				3	0
;	12		4				6		2			2	1
;		8						4
//speed 0-7,phase 0-7,frame 0-31 (*8),unit 0-3 (ćwiartki), dir for LINE 0-15, dir for ARC 0-1 1=>jak zegar
path0
		MOVE 	6
		LINE	7,0,4,10*4		;+2			;kolko i prosto w bok
		ARC		0,0,3
		ARC		0,0,2
		ARC		0,0,1
		ARC		0,0,0
		LINE	3,0,2,24*4		;+8
		ENDP
path1
		MOVE	7
		LINE	6,0,3,11*4		;+2		; prosto ,male koloko i w bok
		LINE 	8,0,4,1*4		;+5
		ARC		1,0,0
		ARC		1,0,1
		ARC		1,0,2
		ARC		1,0,3
		LINE	11,0,6,17*4		;+12
		ENDP
path2
		MOVE	4				; (		
		ARC		1,1,0			;  )
		ARC 	1,1,1
		ARC		0,1,3
		ARC		0,1,2
		ENDP
		
path3
		move	4				; )
		arc		0,1,3			; (
		arc		0,1,2
		arc		1,1,0
		arc		1,1,1
		endp
		
path4
		move	1
		line	8,0,4,26*4		;+2		;w dol
		endp
		
path5
		move	2
		line 	8,0,4,19*4		;+2		;w dol pozniej prawo-lekko_dol 
		line	5,0,2,20*4		;+5
		endp
		
path6
		move	2
		line	8,0,4,19*4		;+2		;w dol pozniej lewo-lekko_dol
		line	11,0,6,20*4		;+5
		endp
		
path7								;boss
		move	2
		line	15,1,0,31*4		;+2
		line	12,1,0,31*4		;+5
		repeat	3			
		move	2	
		line 	5,1,0,31*4		;+11
		line	13,1,0,31*4		;+14
		move	1
		line 	0,1,0,10*4		;+18
		endp

		
path8								;duże kolko
		repeat	2
		move	4
		arc		1,2,2
		arc		1,2,3
		arc		1,2,0
		arc		1,2,1
		endp
		
path9		
		move	6
		arc		1,3,2		;polokrąg duży
		arc		1,0,3
		arc		1,0,0		;male kolko
		arc		1,0,1
		arc		1,0,2
		arc		1,3,3
		endp
		
path10			//czolg jedzie w prawo
		move	2
		line	4,2,2,30*4	;+2
		line	4,2,2,10*4	;+5
		stoptank				;czolg przechodzi w tryb strzelania
		endp
		
path11		//czolg jedzie w lewo
		move	2
		line	12,2,6,30*4	;+2
		line	12,2,6,10*4	;+5
		stoptank
		endp
		
path12		//bonus
		move	2
		line	8,3,0,31*4	;+2
		line	8,3,0,31*4	;+5
		endp
		
path13					//2 boss
		move	1
		line	14,0,0,29*4	;+2
		goto 32
		
/*		boss0	255,4		;+5
		boss0	255,4
		boss0	255,4
		boss0	255,4
		boss0	255,4
		
		move	1
		line 	0,1,0,10*4	;+21
		endp  */
		
path14
		followx 80,$12	;+1		;bomby które wystrzeliwuje boss
		endp
		
path15	NOTHING		;nic nie robi

path16
		move 1
		line 	8,0,4,15*4		;w dol
		followx 50,$03
		endp
		
path17
		move 1
		line 	8,0,4,15*3		;w dol
		followx 65,$03
		endp	

path18
		move 2
		line	8,0,4,65		;w dol i nawrot
		line	2,6,1,70
		endp
		
path19
		repeat 2
		move 4
		arc	1,0,3		;sinusoida w prawo
		arc 1,0,0
		arc 0,0,2
		arc 0,0,1
		move 1
		arc 1,0,3
		endp
		
path20	
		move 8
		arc	0,2,1		;duze polkole prawe, w góre
		arc 0,2,0
		arc 1,0,2		;male polkole lewe, w góre
		arc 1,0,3
		arc 1,0,0
		arc 1,0,1
		arc 0,3,3
		arc 0,2,2
		endp
		
path21
		move 6
		arc	0,2,2
		arc 0,2,1
		arc 0,0,0
		arc 0,0,3
		arc 0,0,2
		arc 0,2,1
		endp	
		
		
path22
		move 6				;czworka w dol cz1
		line 8,4,4,49
		line 6,4,4,6*4
		line 8,4,4,6*4
		line 10,4,4,6*4
		line 8,4,4,6*4
		line 6,4,4,6*4
		endp		
		
path23
		move 6			;czworka w dol cz2
		line 8,4,4,30
		line 6,4,4,6*4
		line 8,4,4,6*4
		line 10,4,4,6*4
		line 8,4,4,6*4
		line 6,4,4,54
		endp		
		
path24	
		move 6			;czworka w dol cz3
		line 8,1,4,12
		line 6,1,4,6*4
		line 8,1,4,6*4
		line 10,1,4,6*4
		line 8,1,4,6*4
		line 6,1,4,80
		endp		

path25
		move 4
		line 8,4,4,80		;w dol , male kolko i dalej w dol
		arc 0,0,1
		arc 0,0,0
		line 8,4,4,110
		endp
		
path26
		move 4			;w dol , male kolko i dalej w dol
		line 8,4,4,80
		arc 1,0,2
		arc 1,0,3
		line 8,4,4,110
		endp		
		
path27
		move 1					;lewo dol, wait, pozniej lewo
		line 11,4,4,80
		wait0 170
		move 1
		line 12,4,6,200
		endp
		
path28
		move 1					;prawo dol, wait, pozniej prawo
		line 5,4,4,80
		wait0 150
		move 1
		line 4,4,2,200
		endp	

path29
		move 6					;w dol , pozniej lukiem w lewo
		line 8,4,4,50
		arc	1,4,1
		arc 1,4,2
		line 6,4,3,10
		arc 1,4,3
		line 6,0,3,200
		endp
		
path30		
		move 6					;w dol, pozniej lukiem w prawo
		line 8,4,4,70
		arc 0,4,2
		arc 0,4,1
		line 8,4,7,12			;przesun lekko w dol
		arc 0,4,0
		line 13,0,7,100
		endp
		
path31
		move 6
		line 7,4,4,50		;wężyk
		arc 0,4,2
		arc 0,4,1
		line 1,4,0,60
		line 12,4,4,80
		line 9,0,4,150
		endp
		
path32
		boss0	255,1
		goto 32				;petla bez konca
		
path33
		move 1
		line 8,4,4,40
		followx 100,$45
		endp
		
path34
		followx 150,$42		;spadajace samoloty
		setanim	0
		move 1
		line 0,0,0,120
		endp
		
path35
		move 1
		line 0,1,0,105		;z dolu do gory, nawrot w lewo i w dół
		setphase 7

		move 1
		arc 0,0,0
		setphase 5

		move 2
		arc 0,0,3
		line 8,1,4,100
		endp
		
path36		
		move 1
		line 0,1,0,105		;z dolu do gory, nawrot w prawo i w dół
		setphase 1

		move 1
		arc 1,0,3
		setphase 3

		move 2
		arc 1,0,0
		line 8,1,4,100
		endp
		
path37
		repeat 2
		move 4
		arc	0,0,0		;sinusoida w prawo
		arc 0,0,3
		arc 1,0,1
		arc 1,0,2
		move 1
		arc 0,0,0
		endp

path38	
		move 8
		arc	1,2,2		;duze polkole prawe, w góre  8
		arc 1,2,3
		arc 0,0,1		;male polkole lewe, w góre
		arc 0,0,0
		arc 0,0,3
		arc 0,0,2
		arc 1,3,0
		arc 1,2,1
		endp		
		
path39
		move 10
		line 0,6,0,60
		arc 0,6,0
		arc	0,6,3
		arc 0,6,2
		arc 0,6,1
		arc 0,5,0
		arc 0,5,3
		arc 0,5,2
		arc 0,5,1
		line 15,6,0,30
		endp
		
path40
		move 8
		line 5,0,3,40
		arc 1,7,0
		arc 1,7,1
		arc 1,7,2
		arc 1,7,3
		arc 1,7,0
		arc 1,7,1
		line 11,0,5,75
		endp
		
path41
		move 2
		line 8,0,4,70		;w dol pozniej lewo-dol
		line 10,0,5,60
		endp
		
path42
		move 2
		line 8,0,4,70		;w dol pozniej prawo-dol
		line 6,0,3,60
		endp
		
path43
		followx 80,$13	;+1		;bomby które wystrzeliwuje boss , trochę szybsze
		endp	

path44
		followx 80,$43	;+1		;bomby które wystrzeliwuje boss , trochę szybsze
		endp	

path45
		followx 90,$52	;+1		;bomby które wystrzeliwuje boss , trochę szybsze
		endp

path46		
		move	6
		arc		0,3,1		;polokrąg duży
		arc		0,0,0
		arc		0,0,3		;male kolko,(z dolu, po prawo)
		arc		0,0,2
		arc		0,0,1
		arc		0,3,0
		endp

path47
		move 6
		arc		0,3,3		;polokrąg duży
		arc		0,0,2
		arc		0,0,1		;male kolko  (z gory , po lewo)
		arc		0,0,0
		arc		0,0,3
		arc		0,3,2
		endp
		
path48			
		move 1
		arc 0,0,0
		repeat	2
		move	4
		arc		1,2,2			;duże kolko
		arc		1,2,3
		arc		1,2,0
		arc		1,2,1
		move 1
		arc 0,0,3
		endp

path49
		repeat 4		;kolkami z góry w dół
		move 4
		arc 1,7,1
		arc 1,0,2
		arc 1,0,3
		arc 1,7,0
		move 1
		arc 1,7,1
		endp

path50
		move 1
		arc 0,0,1
		repeat	2
		move	4
		arc		1,2,3			;duże kolko, po lewo
		arc		1,2,0
		arc		1,2,1
		arc		1,2,2
		move 1
		arc 0,0,3
		endp		
		
		
path_end	dta 0		

/* EXAMPLE	
		REPEAT	2				;powtórz sekcję MOVE 2 razy
		MOVE	4				;4 basic moves
		ARC		0,0,0
		LINE	1,1,0,10			;dir,speed,phase,frame
		LINE	1,2,0,2
		ARC		0,3,3				;dir,speed,unit
		ARC		1,1,2
		BOSS0	255,1				;ile ramek(1-255),speed(0-7)
		FOLLOWX	255,$12			;ile ramek,predkosc w dół*16 || predkość w bok
		STOPTANK				;zatrzymuje czołg i zaczyna strzelać
		GOTO	2				;ustaw teraz ścieżkę 2
		NOTHING					;nic nie rób
		WAIT0	100				;czekaj 100 ramek
		SETANIM 0				;ustawia typ animacji 0-bez animacji
		SETPHASE 7				;ustawia fazę samolotu
		ENDP						;end path
*/

//DIR dla LINE				PHASE dla LINE    unit dla ARC
;		0						0				3	0
;	12		4				6		2			2	1
;		8						4
//speed 0-7,phase 0-7,frame 0-31 (*8),unit 0-3 (ćwiartki), dir for LINE 0-15, dir for ARC 0-1 1=>jak zegar


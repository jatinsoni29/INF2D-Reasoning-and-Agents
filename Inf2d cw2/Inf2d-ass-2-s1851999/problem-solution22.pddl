(define (problem secondscenario-22)
    (:domain modellingworld)
    (:objects
    	A - chamber
    	B - chamber
    	C - chamber
    	D - chamber
    	E - chamber
    	F - chamber
        L - chamber

        M - minobot
        S - sword
    )
    
    (:init
    	(ConnectedChambers L A)
        (ConnectedChambers A B)
        (ConnectedChambers B C)
        (ConnectedChambers C D)
        (ConnectedChambers B E)
        (ConnectedChambers E F)

        (ConnectedChambers A L)
        (ConnectedChambers B A)
        (ConnectedChambers C B)
        (ConnectedChambers D C)
        (ConnectedChambers E B)
        (ConnectedChambers F E)
		
		;; Agent starts at Enterance E
		(BoTheseusAt E)

		;; Sword is at Chamber D
		(SwordAt D)

        (MinobotAt L)
    )
    
    (:goal (and

     (DefeatedMinobot M)
     (BoTheseusAt E)

    )
    )
)

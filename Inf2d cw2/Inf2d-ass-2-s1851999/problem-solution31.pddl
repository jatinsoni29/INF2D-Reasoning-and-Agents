(define (problem thirdscenario-31)
    (:domain modellingthirdtaskone)
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
        K - key
        W - whetstone
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

        ;(not (GateBetween A B))
        ;(not (GateBetween B C))
        ;(not (GateBetween C D))
        ;(not (GateBetween B E))
        ;(not (GateBetween E F))

        ;(not (GateBetween B A))
        ;(not (GateBetween C B))
        ;(not (GateBetween D C))
        ;(not (GateBetween E B))
        ;(not (GateBetween F B))
		
		;; Agent starts at Enterance E
		(BoTheseusAt E)

		;; Sword is at Chamber D
		;(ObjectAt S D)
        (SwordAt D)

        (KeyAt F)

        (WhetstoneAt E)

        ;(ObjectAt K F)

        ;(ObjectAt W E)

        (GateBetween A L)

        ;(not (GateOpened K))

        ;(GateBetween L A)

        (MinobotAt L)

    )
    
    (:goal 

     (DefeatedMinobot M)
     
    )
)

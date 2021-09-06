(define (problem thirdscenario-33)
    (:domain modellingthirdtaskthree)
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
        YARNBALL1 - yarn 
        YARNBALL2 - yarn

        ;BOTHESEUS - botheseus
        ;AUTOADNE - autoadne

        

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

        (= (yarn-amount YARNBALL1) 3)
        (= (yarn-amount YARNBALL2) 3)

        ;(GateOpened K)

        (YarnMarked E)
		
		;; Agent starts at Enterance E
		(AgentAt E BOTHESEUS)
        (AgentAt E AUTOADNE)
        ;(AgentAt E)
        ;(AutoadneAt E)
        ;(BotheseusAt E)

		;; Sword is at Chamber D
		(SwordAt D)

        (MinobotAt L)

        (WhetstoneAt E)

        (KeyAt F)

        (GateBetween A L)

        (YarnBallAt YARNBALL1 E)

        (YarnBallAt YARNBALL2 C)
    )
    
    (:goal (and

     (DefeatedMinobot M)
    )
    )
)

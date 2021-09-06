(define (domain modellingthirdtasktwo)
    (:requirements :adl)

    (:types
        chamber
        botheseus
        minobot
        sword
        agent - botheseus
        whetstone
        key
        yarn
    )

    (:constants
        ;; You should not need to add any additional constants
        Agent - botheseus
    )

    (:functions (yarn-amount ?y - yarn))


    (:predicates
	(ConnectedChambers ?x - chamber ?y - chamber)
    (BoTheseusAt ?c - chamber)
    (SwordAt ?c - chamber)
    (MinobotAt ?c - chamber)
    (DefeatedMinobot ?d - minobot)
    (HoldingSword ?s - sword)
    (GateBetween ?x - chamber ?y - chamber)
    (GateOpened ?x - key)
    (SharpSword ?x - sword)
    (WhetstoneAt ?c - chamber)
    (KeyAt ?c - chamber)
    (HoldingKey ?k - key)
    (YarnBallAt ?y - yarn ?c - chamber)
    (HoldingYarn ?y - yarn)
    (YarnMarked ?c - chamber)
    
    )

    (:action PICK-UP-SWORD 
      :parameters (?s - sword ?at - chamber ?k - key)
      :precondition (and 
      (not(HoldingSword ?s))
      (not(HoldingKey ?k))
      (forall (?y - yarn) 
      (not(HoldingYarn ?y))
      )
      (SwordAt ?at)
      (BoTheseusAt ?at)
      )
      :effect (and 
      (HoldingSword ?s)   
      (not (SwordAt ?at))
      )  
    )

    (:action PICK-UP-YARN 
      :parameters (?s - sword ?at - chamber ?k - key ?y - yarn);?x - yarn)
      :precondition (and 
      (not(HoldingSword ?s))
      (not(HoldingKey ?k))
      ;(not (= ?x ?y))
      (forall (?x - yarn) 
      (not (HoldingYarn ?x))
      )
      ;(HoldingYarn ?x)
      ;(YarnLeft ?y)
      ;(YarnLeft ?x)
      ;(> (yarn-amount ?y) (yarn-amount ?x))

      (YarnBallAt ?y ?at)
      (BoTheseusAt ?at)
      )
      :effect (and
      (not (YarnBallAt ?y ?at))
      (HoldingYarn ?y)   
      ) 
    )

    ; asking on piazza with regards to if conditions and conditionals
    ; run out of yarn so if yarn = 0 does holding yarn = false

    (:action PUT-DOWN-YARN
        :parameters (?at - chamber ?s - sword ?k - key ?y - yarn)
        :precondition (and
            (HoldingYarn ?y)
            (BoTheseusAt ?at)
            ;(not (YarnLeft ?y))
            (YarnMarked ?at)
        )
        :effect (and
            ;(not (HoldingKey ?k))
            ;(not (HoldingSword ?s))
            (not (HoldingYarn ?y))
            (YarnBallAt ?y ?at)
        )
    )

     (:action PUT-DOWN-SWORD
        :parameters (?at - chamber ?s - sword ?k - key)
        :precondition (and
            (HoldingSword ?s)
            (BoTheseusAt ?at)
        )
        :effect (and
            ;(not (HoldingKey ?k))
            (not (HoldingSword ?s))
            ;(not (HoldingYarn ?y))
            (SwordAt ?at)
        )
    )

     (:action PUT-DOWN-KEY
        :parameters (?s - sword ?k - key ?at - chamber)
        :precondition (and
            (HoldingKey ?k)
            (BoTheseusAt ?at)
        )
        :effect (and
            (not (HoldingKey ?k))
            ;(not (HoldingSword ?s))
            ;(not (HoldingYarn ?y))
            (KeyAt ?at)
        )
    )

    (:action PICK-UP-KEY 
      :parameters (?k - key ?at - chamber ?s - sword)
      :precondition (and 
      (not(HoldingSword ?s))
      (not(HoldingKey ?k))
      (forall (?y - yarn) 
      (not(HoldingYarn ?y))
      )
      (KeyAt ?at)
      (BoTheseusAt ?at)
      )
      :effect (and 
      (HoldingKey ?k)
      (not (KeyAt ?at))    
      ) 
    )

    (:action SHARPEN-SWORD 
      :parameters (?s - sword ?at - chamber)
      :precondition (and 
      (HoldingSword ?s)
      (BoTheseusAt ?at)
      (WhetstoneAt ?at)
      (not (SharpSword ?s))
      )
      :effect (SharpSword ?s)     
    )

     (:action OPEN-GATE 
      :parameters (?k - key ?from - chamber ?to - chamber)
      :precondition (and 
      (HoldingKey ?k)
      (ConnectedChambers ?from ?to)
      (not (GateOpened ?k))
      (GateBetween ?from ?to)
      (BoTheseusAt ?from)
      )
      :effect (GateOpened ?k)     
    )

    (:action MARK-LOCATION-WITH-YARN
      :parameters (?y - yarn ?at - chamber );?s - sword ?k - key)
      :precondition (and 
      (HoldingYarn ?y)
      (not (YarnMarked ?at))

      (> (yarn-amount ?y) 0)

      ;(YarnLeft ?y)
      ;(not (YarnMarked ?at))
      (BoTheseusAt ?at)
      )
      :effect (and 
      (YarnMarked ?at) (decrease (yarn-amount ?y) 1)
    )
    )
    
    (:action SLAY 
      :parameters (?m - minobot ?s - sword ?at - chamber)
      :precondition (and 
      (HoldingSword ?s)
      (BoTheseusAt ?at)
      (MinobotAt ?at)
      (SharpSword ?s)
      (not (DefeatedMinobot ?m))
      )

      :effect (DefeatedMinobot ?m)
    )

    (:action MOVE 
      :parameters (?from - chamber ?to - chamber ?k - key)
      :precondition (and 
      (ConnectedChambers ?from ?to)
      (not (= ?from ?to))
        (or
        (exists (?y - yarn) 
        
          (and
            (HoldingYarn ?y)
            (> (yarn-amount ?y) 0)
          )
        )
        (YarnMarked ?to)
        )
        (YarnMarked ?from)
      (or
        (GateOpened ?k)
        (not (GateBetween ?from ?to))
      )
      (BoTheseusAt ?from)
      )
      :effect (and
	  (not(BoTheseusAt ?from))
      (BoTheseusAt ?to)
      ;()
      ;(when (not (YarnMarked ?to)) 
      ;(and
      ;(YarnMarked ?to)
      ;(decrease (yarn-amount ?y) 1)
      ;))
          )
    )
)

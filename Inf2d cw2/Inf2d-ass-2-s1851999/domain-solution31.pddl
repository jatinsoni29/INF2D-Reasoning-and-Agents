(define (domain modellingthirdtaskone)
    (:requirements :adl)

    (:types
        chamber
        botheseus
        minobot
        sword
        agent - botheseus
        whetstone
        key
    )

    (:constants
        ;; You should not need to add any additional constants
        Agent - botheseus
    )

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
    )

    (:action PICK-UP-SWORD 
      :parameters (?s - sword ?at - chamber ?k - key)
      :precondition (and 
      (not(HoldingSword ?s))
      (not(HoldingKey ?k))
      (SwordAt ?at)
      (BoTheseusAt ?at)
      )
      :effect (and 
      (HoldingSword ?s) 
      (not (SwordAt ?at))    
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
            (KeyAt ?at)
        )
    )

    (:action PICK-UP-KEY 
      :parameters (?k - key ?at - chamber ?s - sword)
      :precondition (and 
      (not(HoldingSword ?s))
      (not(HoldingKey ?k))
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
      (not(SharpSword ?s))
      )
      :effect (SharpSword ?s)     
    )

     (:action OPEN-GATE 
      :parameters (?k - key ?from - chamber ?to - chamber)
      :precondition (and 
      (HoldingKey ?k)
      (ConnectedChambers ?from ?to)
      (GateBetween ?from ?to)
      (not (GateOpened ?k))
      (BoTheseusAt ?from)
      )
      :effect (GateOpened ?k)     
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
      (or
      (GateOpened ?k)
      (not (GateBetween ?from ?to))
      )
      ;(not (GateBetween ?from ?to))
      (not (= ?from ?to))
      (BoTheseusAt ?from)
      )
      :effect (and
	  (not(BoTheseusAt ?from))
      (BoTheseusAt ?to)
          )
    )
)

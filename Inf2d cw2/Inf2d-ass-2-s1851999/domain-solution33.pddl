(define (domain modellingthirdtaskthree)
    (:requirements :adl :fluents)

    (:types

        botheseus 
        autoadne - agent

        chamber
        minobot
        sword
        whetstone
        key
        yarn

        agent
        
    )

    (:constants
        ;; You should not need to add any additional constants
        Botheseus - botheseus
        Autoadne - autoadne
    )

    (:functions (yarn-amount ?y - yarn))


    (:predicates
	(ConnectedChambers ?x - chamber ?y - chamber)
    ;(BoTheseusAt ?c - chamber)
    (SwordAt ?c - chamber)
    (MinobotAt ?c - chamber)
    (DefeatedMinobot ?d - minobot)
    (HoldingSword ?s - sword ?a - agent)
    (GateBetween ?x - chamber ?y - chamber)
    (GateOpened ?x - key)
    (SharpSword ?x - sword)
    (WhetstoneAt ?c - chamber)
    (KeyAt ?c - chamber)
    ;(AutoadneAt ?c - chamber)
    (HoldingKey ?k - key ?a - agent)
    (YarnBallAt ?y - yarn ?c - chamber)
    (HoldingYarn ?y - yarn ?a - agent)
    (YarnMarked ?c - chamber)
    (AgentAt ?c - chamber ?a - agent)
    
    ;(AgentAt ?a - agent)
    )

    (:action PICK-UP-SWORD 
      :parameters (?s - sword ?at - chamber ?k - key ?a - agent)
      :precondition (and 
      (not(HoldingSword ?s ?a))
      (not(HoldingKey ?k ?a))

      (forall (?y - yarn) 
      (not (HoldingYarn ?y ?a))
      )

    (SwordAt ?at)

     (AgentAt ?at ?a)

      )
      :effect (and 
      (HoldingSword ?s ?a)   
      (not (SwordAt ?at))
      )  
    )

    (:action PICK-UP-YARN 
      :parameters (?s - sword ?at - chamber ?k - key ?y - yarn ?a - autoadne) 
      :precondition (and 
      (not(HoldingSword ?s ?a))
      (not(HoldingKey ?k ?a))
    
      (forall (?x - yarn) 
      (and
      (not (HoldingYarn ?y ?a))
      )
      )

      (YarnBallAt ?y ?at)

      (AgentAt ?at ?a)
      ;(AutoadneAt ?at)
      
      )
      :effect (and
      (not (YarnBallAt ?y ?at))
      (HoldingYarn ?y ?a)   
      ) 
    )


    (:action PUT-DOWN-YARN
        :parameters (?at - chamber ?s - sword ?k - key ?y - yarn ?a - autoadne)
        :precondition (and
            (HoldingYarn ?y ?a)
            (AgentAt ?at ?a)
            ;(AutoadneAt ?at)
  
            ;(not (YarnLeft ?y))
            (YarnMarked ?at)
        )
        :effect (and
            (not (HoldingYarn ?y ?a))
            (YarnBallAt ?y ?at)
        )
    )

     (:action PUT-DOWN-SWORD
        :parameters (?at - chamber ?s - sword ?k - key ?a - agent)
        :precondition (and
            (HoldingSword ?s ?a)

            (AgentAt ?at ?a)


        )
        :effect (and
            ;(not (HoldingKey ?k))
            (not (HoldingSword ?s ?a))
            ;(not (HoldingYarn ?y))
            (SwordAt ?at)
        )
    )

     (:action PUT-DOWN-KEY
        :parameters (?s - sword ?k - key ?at - chamber ?a - agent)
        :precondition (and
            (HoldingKey ?k ?a)

            (AgentAt ?at ?a)
        )
        :effect (and
            (not (HoldingKey ?k ?a))
            ;(not (HoldingSword ?s))
            ;(not (HoldingYarn ?y))
            (KeyAt ?at)
        )
    )

    (:action PICK-UP-KEY 
      :parameters (?k - key ?at - chamber ?s - sword ?a - agent)
      :precondition (and 
      (not(HoldingSword ?s ?a))
      (not(HoldingKey ?k ?a))
      (forall (?y - yarn) 
      (not (HoldingYarn ?y ?a))
      )
      (KeyAt ?at)
       
      (AgentAt ?at ?a)

      )
      :effect (and 
      (HoldingKey ?k ?a)
      (not (KeyAt ?at))    
      ) 
    )

    (:action SHARPEN-SWORD 
      :parameters (?s - sword ?at - chamber ?a - agent)
      :precondition (and 
      (HoldingSword ?s ?a)

      (AgentAt ?at ?a)

      (WhetstoneAt ?at)
      (not (SharpSword ?s))
      )
      :effect (SharpSword ?s)     
    )

     (:action OPEN-GATE 
      :parameters (?k - key ?from - chamber ?to - chamber ?a - agent)
      :precondition (and 
      (HoldingKey ?k ?a)
      (ConnectedChambers ?from ?to)
      (not (GateOpened ?k))
      (GateBetween ?from ?to)

      (AgentAt ?from ?a)

      )
      :effect (GateOpened ?k)     
    )

    (:action MARK-LOCATION-WITH-YARN
      :parameters (?y - yarn ?at - chamber ?a - autoadne)
      :precondition (and 
      (HoldingYarn ?y ?a)
      (not (YarnMarked ?at))

      (> (yarn-amount ?y) 0)

      ;(YarnLeft ?y)
      ;(not (YarnMarked ?at))
    
      (AgentAt ?at ?a)
      ;(AutoadneAt ?at)
      )
      :effect (and 
      (YarnMarked ?at) (decrease (yarn-amount ?y) 1)
    )
    )
    
    (:action SLAY 
      :parameters (?m - minobot ?s - sword ?at - chamber ?b - botheseus)
      :precondition (and 
      (HoldingSword ?s ?b)
      (AgentAt ?at ?b)
      ;(BoTheseusAt ?at)
      (MinobotAt ?at)
      (SharpSword ?s)
      (not (DefeatedMinobot ?m))
      )

      :effect (DefeatedMinobot ?m)
    )

     (:action MOVE-AUTOADNE 
      :parameters (?from - chamber ?to - chamber ?k - key ?a - autoadne)
      :precondition (and 
      (ConnectedChambers ?from ?to)
      (not (= ?from ?to))
        (or
        (exists (?y - yarn) 
        
          (and
            (HoldingYarn ?y ?a)
            (> (yarn-amount ?y) 0)
          )
        )
        (YarnMarked ?to)
        )
         ;(YarnMarked ?from)

      (or
        (GateOpened ?k)
        (not (GateBetween ?from ?to))
      )
      (YarnMarked ?from)
      (AgentAt ?from ?a)
      ;(AutoadneAt ?from)
      )
      :effect (and
        (not(AgentAt ?from ?a))
        ;(not (AutoadneAt ?from))
        (AgentAt ?to ?a)
        ;(AutoadneAt ?to)
        )
    )

    (:action MOVE-BOTHESEUS 
      :parameters (?from - chamber ?to - chamber ?k - key ?b - botheseus)
      :precondition (and 
      (ConnectedChambers ?from ?to)
      (not (= ?from ?to))
        
        (YarnMarked ?to)
        ;(YarnMarked ?from)
      
      (or
        (GateOpened ?k)
        (not (GateBetween ?from ?to))
      )
    
      (AgentAt ?from ?b)
      ;(BoTheseusAt ?from)
      )
      :effect (and
	      (not(AgentAt ?from ?b))
        ;(not (BoTheseusAt ?from))
        (AgentAt ?to ?b)
        ;(BoTheseusAt ?to)

        )
    )
)

(define (domain modellingworld)
    (:requirements :adl)

    (:types
        chamber
        botheseus
        minobot
        sword
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

    )

    (:action PICK-UP-SWORD 
      :parameters (?s - sword ?at - chamber)
      :precondition (and 
      (not(HoldingSword ?s))
      (SwordAt ?at)
      (BoTheseusAt ?at)
      )
      :effect (and
      (HoldingSword ?s)
      (not (SwordAt ?at))
      )     
    )

    (:action SLAY 
      :parameters (?m - minobot ?s - sword ?at - chamber)
      :precondition (and 
      (HoldingSword ?s)
      (BoTheseusAt ?at)
      (MinobotAt ?at)
      (not (DefeatedMinobot ?m))
      )

      :effect (DefeatedMinobot ?m)
    )

    (:action MOVE 
      :parameters (?from - chamber ?to - chamber)
      :precondition (and 
      (ConnectedChambers ?from ?to)
      (not (= ?from ?to))
      (BoTheseusAt ?from)
      )
      :effect (and
	  (not(BoTheseusAt ?from))
      (BoTheseusAt ?to)
          )
    )
)

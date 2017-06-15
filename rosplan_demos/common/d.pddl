(define (domain robocupathome)
	(:requirements :strips :typing :disjunctive-preconditions)

	(:types room)

	(:predicates

		(inapt)
		(outdoor)

		(entrance ?r - room)	
		(pos ?r - room)
		(wasRoom ?r - room)

		(Kperson ?r - room)
		(enabledpd)
		(enabledph)
		(cancallperson)

		(persondetected)
		(personhere)
		(personwillcome)
		(personfollowed)

		(Kdrink)
		(drinkserved)
	)
	
	(:constants
		entrance - room
	)

	;; goto_maindoor - pre: not inapt  post: outdoor
	(:action goto_maindoor
		:parameters ( )
		:precondition (not (inapt))
		:effect (and
			(outdoor)
			))

	;; enter_maindoor - pre: outdoor  post: inapt
	(:action enter_maindoor
		:parameters ( )
		:precondition (and
			(outdoor)
			(not (inapt))
			)
		:effect (and
			(not (outdoor))
			(inapt)
			(pos entrance)
			))

	;; exit_maindoor - pre: inapt  post: not inapt
	(:action enter_maindoor
		:parameters ( )
		:precondition (and
			(inapt)
			(not (outdoor))
			)
		:effect (and
			(not (inapt))
			(outdoor)
			))

	;; goto_roomX - pre: inapt  post: inapt and pos=RoomX and wasRoomX
	(:action goto
		:parameters (?from ?to - room)
		:precondition (and
			(inapt)
			(pos ?from)
			)
		:effect (and
			(not (pos ?from))
			(pos ?to)
			(wasRoom ?to)
			))

	;; lookforperson - pre: pos=RoomX and Kperson=RoomX  post: enabledpd
	(:action lookforperson
		:parameters (?r - room)
		:precondition (and
			(pos ?r)
			(Kperson ?r)
			)
		:effect (and
			(enabledpd)
			))

	;; approachperson - pre: persondetected  post: enabledph
	(:action approachperson
		:parameters (?r - room)
		:precondition (persondetected)
		:effect (and
			(enabledpd)
			))

	;; say_comehere - pre: inapt and not persondetected and cancallperson  post: enabledph
	(:action say_comehere
		:parameters ()
		:precondition (and
			(not (persondetected))
			(inapt)
			(cancallperson)
			)
		:effect (and
			(enabledpd)
			))

	;; sense_persondetected - pre: enabledpd  post: observe[persondetected]
	(:action sense_persondetected
		:parameters ()
		:precondition (enabledpd)
		:observe (persondetected)
	)

	;; sense_personhere - pre: enabledph  post: observe[persondhere]
	(:action sense_personhere
		:parameters ()
		:precondition (enabledpd)
		:observe (personhere)
	)

	;; sense_inapt - pre:    post: observe[inapt]
	(:action sense_personhere
		:parameters ()
		:precondition (outdoor)
		:observe (inapt)
	)

	;; waitfor_personhere1 - pre: enabledph  post: persondhere
	(:action waitfor_personhere
		:parameters ()
		:precondition (and
			(enabledph)
			)
		:effect (and
			(personhere)
			))

	;; waitfor_personhere2 - pre: (pos=RoomX and Kperson=RoomX and personwillcome)  post: persondhere
	(:action waitfor_personhere
		:parameters (?r - room)
		:precondition (and
				(pos ?r)
				(Kperson ?r)
				(personwillcome)
			)
		:effect (and
			(personhere)
			))

	;; ask_drink@X - pre: personhere   post: Kdrink
	(:action ask_drink
		:parameters ( )
		:precondition (and
			(personhere)
			)
		:effect (and
			(Kdrink)
			))

	;; serve_drink@X - pre: Kdrink  post: drinkserved
	(:action serve_drink
		:parameters ( )
		:precondition (and
			(Kdrink)
			)
		:effect (and
			(drinkserved)
			))

	;; followperson - pre: personhere   post: personfollowed and ???forget[inapt]???
	(:action followperson
		:parameters ( )
		:precondition (and
			(personhere)
			)
		:effect (and
			(personfollowed)
			))

	;; waitpersonroom2 - pre: pos=Room2 and Kpersonroom2 post: enabledph
	(:action waitperson
		:parameters (?r - room)
		:precondition (and
			(pos ?r)
			(Kperson ?r)
			)
		:effect (and
			(enabledph)
			))
)




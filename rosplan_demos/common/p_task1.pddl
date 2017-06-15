(define (problem task1) 
(:domain robocupathome) 
	(:objects room1 room2 - room)

	(:init 
		(cancallperson)
		(Kperson room1)
	)

	(:goal (and
		(drinkserved)
	)
))

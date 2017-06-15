(define (problem task2) 
(:domain robocupathome) 
	(:objects room1 room2 room3 - room)

	(:init 
		(Kperson room2)
		(personwillcome)
	)

	(:goal (and
		(wasRoom room1)
		(wasRoom room2)
		(personfollowed)
		(pos room3)
	)
))

extends Node



func add_shrek(origin: Vector3 = Vector3.ZERO):
	var s = preload("res://src/Characters/Shrek/Shrek.tscn").instance()
	add_child(s)
	s.transform.origin = origin
	return s

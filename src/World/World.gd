extends Node


func _ready():
	add_shrek().add_brain_local()
	add_shrek(Vector3(10, 0, 10))


func add_shrek(origin: Vector3 = Vector3.ZERO):
	var s = preload("res://src/Characters/Shrek/Shrek.tscn").instance()
	s.transform.origin = origin
	add_child(s)
	return s

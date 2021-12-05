extends KinematicBody


var velocity: Vector3
onready var brain = $BrainLocal


func _physics_process(delta):
	move_and_slide(velocity)

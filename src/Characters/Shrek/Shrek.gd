extends KinematicBody


var velocity: Vector3

onready var model = $Model
onready var scope = $Scope

func _physics_process(delta):
	move_and_slide(velocity)



func add_camera():
	var c = preload("res://src/Player/Gimbal/Gimbal.tscn").instance()
	c.global_transform.origin = scope.global_transform.origin
	add_child(c)
	model.visible = false
	return c


func add_brain_local():
	var b = Node.new()
	b.set_script(preload("res://src/Player/Brains/Local/BrainLocal.gd"))
	b.camera = add_camera()
	add_child(b)

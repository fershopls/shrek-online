extends Node

var camera
onready var body = get_parent()


func _process(delta):
	var input = get_input()
	
	body.velocity = input * 8
	
	body.model.look_at(body.global_transform.origin - camera.global_transform.basis.z, Vector3.UP)


func get_input() -> Vector3:
	var input: Vector3
	var cam_xform = camera.global_transform
	if Input.is_action_pressed("ui_up"):
		input -= cam_xform.basis[2]
	if Input.is_action_pressed("ui_down"):
		input += cam_xform.basis[2]
	if Input.is_action_pressed("ui_right"):
		input += cam_xform.basis[0]
	if Input.is_action_pressed("ui_left"):
		input -= cam_xform.basis[0]
	input.y = 0
	return input.normalized()

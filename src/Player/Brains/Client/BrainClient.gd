extends Node

signal set_input

var camera
onready var body = get_parent()

func _process(delta):
	if not is_network_master():
		return
	
	var input = get_input()
	
	emit_signal("set_input", {
		"input": input,
		"basis": camera.global_transform.basis.z,
	})


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

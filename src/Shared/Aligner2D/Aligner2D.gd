class_name Aligner2D
extends Position3D

func _process(delta):
	var camera = get_viewport().get_camera()
	
	if not camera:
		return
	
	var position = camera.unproject_position(global_transform.origin)
	
	for c in get_children():
		c.position = position

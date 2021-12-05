extends Spatial


# Fortnite 360.0 / 648.08
var pix2deg = 360.0 / 648.08
var sens = 0.1

var dpi = 1000
var cms_for_360_degrees = 12
var joystick_deadzone = 0.1

var recoil := Vector2.ZERO


onready var spatial_x_axis = $Y
onready var spatial_y_axis = self
onready var camera = $Y/Camera
onready var scope = $Y/Camera


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _input(event):
	if event is InputEventMouseMotion:
		_input_mouse_motion(event)


func rotate_axis_y(rotation):
	spatial_y_axis.rotate_object_local(Vector3.UP, rotation)


func rotate_axis_x(rotation):
	if abs(spatial_x_axis.rotation_degrees.x) <= 90:
		spatial_x_axis.rotate_object_local(Vector3.RIGHT, rotation)
	
	clamp_axis_x()


func clamp_axis_x():
	var max_x_axis_degrees = 90
	var min_x_axis_degrees = -90
	
	if spatial_x_axis.rotation_degrees.x > max_x_axis_degrees:
		spatial_x_axis.rotation_degrees.x = max_x_axis_degrees
	if spatial_x_axis.rotation_degrees.x < min_x_axis_degrees:
		spatial_x_axis.rotation_degrees.x = min_x_axis_degrees


func _input_mouse_motion(event):
	var input_scale = get_input_scale()
	
	var relative_x = event.relative.x * input_scale
	rotate_axis_y(deg2rad(relative_x))
	
	var relative_y = event.relative.y * input_scale
	rotate_axis_x(deg2rad(relative_y))


func get_input_scale():
	var inch = 2.54
	var dpc = dpi / inch
	
	var cmsens = 360 / dpc / cms_for_360_degrees * -1
	#pix2deg * sens * -1
	
	return cmsens


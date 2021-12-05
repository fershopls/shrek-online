extends Spatial


onready var body = get_parent()
onready var anim = $AnimationTree

func _ready():
	anim.active = true
	anim = anim.get('parameters/playback')


func _process(delta):
	if body.velocity.length():
		anim.travel("run-loop")
	else:
		anim.travel("idle-loop")


func rotate_to_smooth(direction: Vector3, up = Vector3.UP):
	var speed = 20
	var delta = get_process_delta_time()
	var new_transform = transform.looking_at(transform.origin + direction, up)
	transform  = transform.interpolate_with(new_transform, speed * delta)

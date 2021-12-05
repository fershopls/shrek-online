extends Spatial


onready var body = get_parent()
onready var anim = $AnimationTree

func _ready():
	anim.active = true
	anim = anim.get('parameters/playback')


func _process(delta):
	
	if body.velocity.length():
		look_at(body.global_transform.origin + body.velocity, Vector3.UP)
		anim.travel("run-loop")
	else:
		anim.travel("idle-loop")

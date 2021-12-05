extends Aligner2D

var text setget set_text

func set_text(value):
	text = value
	$Node2D/Username.text = str(value)



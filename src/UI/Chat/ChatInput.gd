extends LineEdit

signal say

func _input(event):
	if event is InputEventKey and !event.pressed and event.scancode == KEY_ENTER:
		grab_focus()


func _process(delta):
	if Input.is_action_just_pressed("enter"):
		if text != "":
			emit_signal("say", text)
			text = ""
			release_focus()

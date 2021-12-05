extends LineEdit

signal say

func _input(event):
	if event is InputEventKey and !event.pressed and event.scancode == KEY_ENTER:
		if has_focus():
			send()
		else:
			grab_focus()


func send():
	if text != "":
		emit_signal("say", text)
		text = ""
		release_focus()

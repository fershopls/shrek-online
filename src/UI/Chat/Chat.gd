extends VBoxContainer

var max_messages = 20

func add(text):
	var l = Label.new()
	l.text = str(text)
	add_child(l)
	cap()


func cap():
	if get_child_count() > max_messages:
		get_child(0).call_deferred("free")

extends Node


func _ready():
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	
	if not get_tree().is_network_server() or 1:
		var id = get_tree().get_network_unique_id()
		add_shrek(id)


func add_shrek(id):
	var shrek = spawn_shrek(id)
	var brain = shrek.add_brain_client(id)
	brain.connect('set_input', self, '_on_Shrek_set_input')


func spawn_shrek(id, origin: Vector3 = Vector3.ZERO):
	var s = preload("res://src/Characters/Shrek/Shrek.tscn").instance()
	add_child(s)
	s.name = str(id)
	s.username.text = id
	s.transform.origin = origin
	return s


func get_shrek(id):
	return get_node_or_null(id)


func _on_network_peer_connected(id):
	add_shrek(id)



func _on_Shrek_set_input(data):
	rpc('_rpc_shrek_set_input', data)


remotesync func _rpc_shrek_set_input(data):
	var id = str(get_tree().get_rpc_sender_id())
	var body = get_shrek(id)
	
	body.velocity = data.input * 8
	
	body.model.look_at(body.global_transform.origin - data.basis, Vector3.UP)




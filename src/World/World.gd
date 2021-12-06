extends Node


onready var peers = $Peers


func _ready():
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_network_peer_disconnected")
	
	$UI/ChatInput.connect("say", self, "_on_Peer_say")
	
	if not get_tree().is_network_server():
		var id = get_tree().get_network_unique_id()
		add_shrek(id)

func _process(delta):
	if get_tree().is_network_server():
		for peer in peers.get_children():
			var pos = peer.global_transform.origin
			rpc_unreliable('set_shrek_pos', peer.name, pos)


remote func set_shrek_pos(id, pos):
	var shrek = get_shrek(id)
	shrek.global_transform.origin = lerp(shrek.global_transform.origin, pos, 0.3)


func add_shrek(id):
	var shrek = spawn_shrek(id)
	var brain = shrek.add_brain_client(id)
	brain.connect('set_input', self, '_on_Shrek_set_input')


func spawn_shrek(id, origin: Vector3 = Vector3.ZERO):
	var s = preload("res://src/Characters/Shrek/Shrek.tscn").instance()
	peers.add_child(s)
	s.name = str(id)
	s.username.text = id
	s.transform.origin = origin
	return s


func get_shrek(id):
	return peers.get_node_or_null(str(id))


func _on_network_peer_connected(id):
	if id == 1:
		print("Connected to server")
	else:
		add_shrek(id)
	
	if not get_tree().is_network_server():
		rpc('_rpc_send_info', Multiplayer.info)

func _on_network_peer_disconnected(id):
	get_shrek(id).call_deferred("free")



func _on_Shrek_set_input(data):
	rpc_unreliable('_rpc_shrek_set_input', data)


func _on_Peer_say(text):
	rpc('_rpc_peer_say', text)


remotesync func _rpc_send_info(info):
	var id = str(get_tree().get_rpc_sender_id())
	var body = get_shrek(id)
	body.username.text = info.username


remotesync func _rpc_peer_say(text):
	var id = str(get_tree().get_rpc_sender_id())
	var user = get_shrek(id).username.text
	$UI/Chat.add("[%s]: %s" % [user, text])


remotesync func _rpc_shrek_set_input(data):
	var id = str(get_tree().get_rpc_sender_id())
	var body = get_shrek(id)
	
	body.velocity = data.input * 8
	
	body.model.look_at(body.global_transform.origin - data.basis, Vector3.UP)




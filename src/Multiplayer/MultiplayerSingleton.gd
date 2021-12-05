extends Node


func _ready():
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	get_tree().connect("connection_failed", self, "_connection_failed")

func play():
	get_tree().change_scene("res://src/World/World.tscn")
	yield(get_tree(), "idle_frame")
	var id = get_tree().get_network_unique_id()
	get_tree().current_scene.add_shrek(id).add_brain_local()

func _connection_failed():
	print ('Connection failed.')


func _on_network_peer_connected(id):
	print("Peer %s connected." % id)
	get_tree().current_scene.add_shrek(id)


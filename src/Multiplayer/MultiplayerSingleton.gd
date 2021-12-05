extends Node

var info = {}


func _ready():
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_network_peer_disconnected")
	get_tree().connect("connection_failed", self, "_connection_failed")

func play():
	get_tree().change_scene("res://src/World/World.tscn")

func _connection_failed():
	print ('Connection failed.')


func _on_network_peer_connected(id):
	print("Peer %s connected." % id)

func _on_network_peer_disconnected(id):
	print("Disconnected %s peer." % id)


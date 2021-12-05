extends Node

func _ready():
	var args = OS.get_cmdline_args()
	
	if args.size() >= 2 and args[1] == "server":
		create_server(6969, 5)

func _on_Server_button_up():
	create_server(6969, 5)


func _on_Client_button_up():
	create_client('127.0.0.1', 6969)


func create_server(port, max_players):
	print("Server listening on port %s" % port)
	var peer = NetworkedMultiplayerENet.new()
	peer.set_bind_ip('0.0.0.0')
	peer.create_server(int(port), max_players)
	get_tree().network_peer = peer
	Multiplayer.play()


func create_client(server, port):
	print("Connecting to ", server, ":", port)
	var peer = NetworkedMultiplayerENet.new()
	var result = peer.create_client(server, int(port))
	get_tree().network_peer = peer
	Multiplayer.play()

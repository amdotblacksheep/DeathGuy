extends Node


func save_game():
	var save_game = File.new()
	save_game.open_encrypted_with_pass("user://savegame.bin", File.WRITE, OS.get_unique_id())
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
	
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
	
		var node_data = node.call("save")
		save_game.store_line(to_json(node_data))
	save_game.close()


func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.bin"):
		return
	save_game.open_encrypted_with_pass("user://savegame.bin", File.READ, OS.get_unique_id())
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())
		var object = get_node(node_data["node"])
		
		for i in node_data.keys():
			if i == "node":
				continue
			object.set(i, node_data[i])
	save_game.close()

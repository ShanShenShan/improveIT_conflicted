extends Node

func save_game():
	var save_data = {
		"players_health": PlayerStats.health,
		"save_button_click": Global.save_button_click,
		"map": Global.get_map(),
		"current_level": Global.get_current_level(),
		
		#save trigger to know ifthere is already save game
		"save_triggered": Global.save_triggered,
		
		#from level map that the player belong last position
		"from_level": Global.from_level,
		
		"player_current_position": Global.get_player_current_position(),
		"player_initial_position": Global.player_initial_position,
		"player_position_engaged": Global.player_position_engaged,
		"player_position_retain": Global.player_position_retain,
		"player_after_door_position":Global.player_after_door_position,
		"load_position": Global.load_game_position,
		# ENEMY
		"enemy_current_position": Global.enemy_current_position,
		"enemy_initial_position": Global.enemy_initial_position,
		"enemy_engaged_position": Global.enemy_engaged_position,
		"enemy_state": Global.enemy_state,
		"enemy_defeated": Global.enemy_defeated,
		#dialogue
		"dialogue_start_tutorial": Global.dialogue_start_tutorial,
		#Merrick
		#"stage1": Global.stage1,
		"badge1": Global2.badge1,
		"badge2": Global2.badge2,
		"stage1_complete": Global2.stage1_complete,
		"stage2_complete": Global2.stage2_complete,
		"stage2_trigger": Global2.stage2_trigger,
		"stage3_trigger": Global2.stage3_trigger,
		#quest
		"explore_town": Global2.explore_town,
		"manor_guard": Global2.manor_guard,
		"lady_on_townsquare": Global2.lady_on_townsquare,
		"paladin_mage_guild": Global2.paladin_mage_guild
		
		
	}
	
	# Convert Vector2 to array for JSON serialization
	save_data["player_current_position"] = [save_data["player_current_position"].x, save_data["player_current_position"].y]
	save_data["player_initial_position"] = [save_data["player_initial_position"].x, save_data["player_initial_position"].y]
	save_data["player_position_engaged"] = [save_data["player_position_engaged"].x, save_data["player_position_engaged"].y]
	save_data["player_after_door_position"] = [save_data["player_after_door_position"].x, save_data["player_after_door_position"].y]
	
	# Convert enemy positions to arrays
	var enemy_current_position = {}
	for enemy in Global.enemy_current_position:
		enemy_current_position[enemy] = [Global.enemy_current_position[enemy].x, Global.enemy_current_position[enemy].y]
	save_data["enemy_current_position"] = enemy_current_position
	
	var enemy_initial_position = {}
	for enemy in Global.enemy_initial_position:
		enemy_initial_position[enemy] = [Global.enemy_initial_position[enemy].x, Global.enemy_initial_position[enemy].y]
	save_data["enemy_initial_position"] = enemy_initial_position
	
	var enemy_engaged_position = {}
	for enemy in Global.enemy_engaged_position:
		enemy_engaged_position[enemy] = [Global.enemy_engaged_position[enemy].x, Global.enemy_engaged_position[enemy].y]
	save_data["enemy_engaged_position"] = enemy_engaged_position
	
	# Save to file
	var file = File.new()
	var error = file.open("user://file.txt", File.WRITE)
	if error == OK:
		var save_string = JSON.print(save_data)
		file.store_string(save_string)
		file.close()
	else:
		print("Failed to open file for writing")


func load_game() -> void:
	var file = File.new()
	var error = file.open("user://file.txt", File.READ)
	if error == OK:
		var content = file.get_as_text()
		file.close()
		var loaded_data = JSON.parse(content).result

		#stages
		#Global.stage1 = loaded_data["stage1"]
		Global2.badge1 = loaded_data["badge1"]
		Global2.badge2 = loaded_data["badge2"]
		Global2.stage1_complete = loaded_data["stage1_complete"]
		Global2.stage2_complete = loaded_data["stage2_complete"]
		Global2.stage2_trigger = loaded_data["stage2_trigger"]
		Global2.stage3_trigger = loaded_data["stage3_trigger"]
		
		#saving trigger to know wethear there is already save game
		Global.save_triggered = loaded_data["save_triggered"]
		
		#Quest
		Global2.explore_town = int(loaded_data["explore_town"])
		Global2.paladin_mage_guild = int(loaded_data["paladin_mage_guild"])
		Global2.lady_on_townsquare = int(loaded_data["lady_on_townsquare"])
		Global2.manor_guard = int(loaded_data["manor_guard"])
		Dialogic.set_variable("explore_town", Global2.explore_town)
		Dialogic.set_variable("paladin", Global2.paladin_mage_guild)
		Dialogic.set_variable("citizen", Global2.lady_on_townsquare)
		Dialogic.set_variable("manor_guard", Global2.manor_guard)
		
		#last level of map the player belong
		Global.from_level = loaded_data["from_level"]
		
		# player positions
		Global.set_player_current_position(Vector2(loaded_data["player_current_position"][0], loaded_data["player_current_position"][1]))
		Global.set_player_initial_position(Vector2(loaded_data["player_initial_position"][0], loaded_data["player_initial_position"][1]))
		Global.set_player_position_engaged(Vector2(loaded_data["player_position_engaged"][0], loaded_data["player_position_engaged"][1]))
		Global.set_player_after_door_position(Vector2(loaded_data["player_after_door_position"][0], loaded_data["player_after_door_position"][1]))
		Global.player_position_retain = loaded_data["player_position_retain"]
		Global.load_game_position = loaded_data["load_position"]
		# enemy positions
		for enemy in loaded_data["enemy_current_position"]:
			Global.set_enemy_current_position(enemy, Vector2(loaded_data["enemy_current_position"][enemy][0], loaded_data["enemy_current_position"][enemy][1]))
		
		for enemy in loaded_data["enemy_initial_position"]:
			Global.set_enemy_initial_position(enemy, Vector2(loaded_data["enemy_initial_position"][enemy][0], loaded_data["enemy_initial_position"][enemy][1]))
		
		for enemy in loaded_data["enemy_engaged_position"]:
			Global.set_enemy_engaged_position(enemy, Vector2(loaded_data["enemy_engaged_position"][enemy][0], loaded_data["enemy_engaged_position"][enemy][1]))
		
		# enemy state and defeated status
		Global.enemy_state = loaded_data["enemy_state"]
		Global.enemy_defeated = loaded_data["enemy_defeated"]
		
		# other data
		Global.set_map(loaded_data["map"])
		Global.set_current_level(loaded_data["current_level"])
		Global.save_button_click = loaded_data["save_button_click"]
		PlayerStats.health = loaded_data["players_health"]
	else:
		print("Failed to open file for reading")


func load_game_button() -> void:
	var file = File.new()
	var error = file.open("user://file.txt", File.READ)
	if error == OK:
		var content = file.get_as_text()
		file.close()
		var loaded_data = JSON.parse(content).result

		# Fetch and set the save_button_click value
		Global.save_button_click = loaded_data["save_button_click"]
		Global.set_current_level(loaded_data["current_level"]) 
	else:
		print("Failed to open file for reading")

func check_if_loaded_data():
	var file = File.new()
	var error = file.open("user://file.txt", File.READ)
	if error == OK:
		var content = file.get_as_text()
		file.close()
		var loaded_data = JSON.parse(content).result

		# Fetch and set the save_button_click value
		Global.save_triggered = loaded_data["save_triggered"]
	else:
		print("Failed to open file for reading")

class_name FileManager
extends Node

const SAVE_PATH = "user://savegame.data"

func save() -> Dictionary:
	print("call save")
	var save_dict = {
		"total_coin": Event.total_coin,
		"level_data": Event.level_data
	}
	return save_dict

func save_game() -> void:
	print("call save_game")
	var save_data = save()
	print("Saving:", save_data)  # ✅ See what’s being saved
	
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if save_file:
		save_file.store_var(save_data)
		print("Game saved.")
	else:
		print("Failed to open file for saving.")

func load_game() -> void:
	print("call load_game")
	
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found. Creating new save...")
		
		# ✅ Ensure level 1 is unlocked before first save
		Event.level_data = {}
		Event.level_data[1] = true
		Event.total_coin = 0
		
		save_game()
		return
	else:
		print("file ok")
	
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if save_file:
		var saved_data = save_file.get_var()
		
		Event.total_coin = saved_data.get("total_coin", 0)
		Event.level_data = saved_data.get("level_data", {})
		
		print("Game loaded.")
		print(Event.total_coin)
		print(Event.level_data)
	else:
		print("Failed to open file for loading.")

extends Control

@onready var scene_tree = get_tree()
@onready var moneyLabel = %Label

func _ready() -> void:
	connect_level_selected_to_lavel_box()
	%FileManager.load_game()
	
	if Event.level_data.is_empty():
		setup_level_box()
	
	for box in %LevelGrid.get_children():
		var level = box.get_index() + 1
		box.level_num = level
		box.locked = not Event.level_data.get(level, false)  # ✅ safe access
	
	print(Event.total_coin)
	moneyLabel.text = str(Event.total_coin)

	
	

func setup_level_box() -> void:
	for box in %LevelGrid.get_children():
		box.level_num = box.get_index() + 1
		box.locked = true
		
	%LevelGrid.get_child(0).locked = false
	
func change_to_scene(level_num: int) -> void:
	Event.curr_level = level_num
	%fader.fade_screen(true, 1.0, func(): scene_tree.change_scene_to_file("res://Levels/level_" + str(level_num)+".tscn"))

func connect_level_selected_to_lavel_box() -> void:
	for box in %LevelGrid.get_children(): box.connect("level_selected", change_to_scene)


func _on_home_button_down() -> void:
	scene_tree.change_scene_to_file("res://MainScreen/main_screen.tscn")

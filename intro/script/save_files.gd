extends Node

onready var panel = $Panel
onready var saving_file = $saving_file
onready var auto = $Panel/MarginContainer/VBoxContainer/Auto as Button
onready var file1 = $Panel/MarginContainer/VBoxContainer/File1 as Button
onready var file2 = $Panel/MarginContainer/VBoxContainer/file2 as Button

# Called when the node enters the scene tree for the first time.
func _ready():
	panel.hide()
	#print(Global.get_current_level())
	saving_file.load_game_button()
	#saving_file.load_game()
	#print(Global.save_button_click2)
	var printed_something = false

	if Global.get_map() != "":
		auto.text = "Autoload: " + Global.get_current_level()
		#print("one")
		printed_something = true

	if Global.save_button_click == true:
		file1.text = Global.get_current_level()
		#print("two")
		printed_something = true
	if not printed_something:
		auto.text = "Auto Save File"
		file1.text = "File 1"
		#print("four")
	#saving_file.load_game_button()
		
	
	
	# Connect signals from buttons to respective functions
	auto.connect("pressed", self, "auto_save")
	file1.connect("pressed", self, "file1_pressed")
	#file2.connect("pressed", self, "file2_pressed")

func auto_save() -> void:
	if Global.save_button_click == true and Global.get_player_current_position() != Vector2(0,0):
		Global.load_game_position = true
		SceneTransition.change_scene(Global.get_map())
		Global.save_triggered = false
		#print("one")
	else:
		#print("two")
		auto.text = "Auto Save File"
		

func file1_pressed():
	if Global.save_triggered == false:
		file1.text = Global.get_current_level()
		Global.save_button_click = true
		Global.save_triggered = true
		saving_file.save_game()	
		#print(Global.save_button_click)
	else:
		#saving_file.load_game_button()
		if Global.save_button_click == true:
			saving_file.load_game()
			Global.load_game_position = true
			SceneTransition.change_scene(Global.get_map())
			Global.save_triggered = false	
			#print("hello1")
		else:
			file1.text = "File 1"
			#print("hello2")


func _on_close_pressed():
	panel.hide()
	#Global.save_triggered = false

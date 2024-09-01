extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Label
onready var player = $YSort/Player
onready var player_controls = $YSort/Player/Controller
onready var interaction_button = $YSort/people/merricks2/TextureButton

var current_map ="res://World/room/night/orphanage_office_night.tscn"
var starting_player_position = Vector2(160, 170)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	resume.connect("pressed", self, "resume_the_game")
	interaction_button.connect("pressed", self, "merrick2")
	Global.set_map(current_map)
	
func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		#print("2")
	
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		#print("3")
	elif Global.get_player_current_position() != Vector2(0,0) and Global.player_position_retain == true:
		player.global_position = Global.get_player_current_position()
		
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			#print("4")
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			#print("Player position set from ", target_node_path)
		else:
			pass
	else:
		player.global_position = Global.get_player_current_position()
		#print("last")

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())

func resume_the_game() -> void:
	get_tree().paused = false
	topui.visible = true
	player_controller.visible = true
	pause_ui.hide()

func _process(_delta):
	Global.set_player_current_position(player.global_position)
	
func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()

func after_tutorial_headings(timelinename):
	topui.show()
	player_controller.show()
	
func merrick2():
	player_controls.visible = false
	interaction_button.visible = false
	
	Global.set_map(current_map)
	var new_dialog = Dialogic.start('stage2p3')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "after_question_no")

func after_question_no(timelineend):
	player_controls.visible = true
	#print(Dialogic.get_variable("talk_to_people"))
	#pass


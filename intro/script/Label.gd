extends Label

onready var save_n_load = $saving_file

func _process(delta):
	if Global2.stage2_trigger == true:
		PlayerStats.health = 5
		text = "Chapter1 U1 2 / 5"
		Global.set_current_level(text)
		save_n_load.auto_save_file()
	elif Global2.stage3_trigger == true:
		PlayerStats.health = 5
		text = "Chapter1 U1 3 / 5"
		Global.set_current_level(text)
		save_n_load.auto_save_file()

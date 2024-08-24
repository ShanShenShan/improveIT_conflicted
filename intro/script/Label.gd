extends Label

func _process(delta):
	if Global2.stage2_trigger == true:
		PlayerStats.health = 5
		text = "Chapter1 U1 2 / 5"
		Global.set_current_level(text)
	elif Global2.stage3_trigger == true:
		PlayerStats.health = 5
		text = "Chapter1 U1 3 / 5"
		Global.set_current_level(text)

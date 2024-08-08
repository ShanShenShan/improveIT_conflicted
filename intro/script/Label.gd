extends Label

func _process(delta):
	if Global2.stage2_trigger == true:
		text = "Chapter1 U1 2 / 5"
	elif Global2.stage3_trigger == true:
		text = "Chapter1 U1 3 / 5"

extends ColorRect

func _ready():
	set_process_input(true)

func _init(event):
	if event.is_action_pressed("shoot"):
		var _unused = get_tree().change_scene("res://scenes/level/Level1.tscn")

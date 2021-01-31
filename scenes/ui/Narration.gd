extends Control

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("shoot") or event.is_action_pressed("quit"):
		var _unused = get_tree().change_scene("res://scenes/level/Level1.tscn")

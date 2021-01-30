extends Node

const char_max_speed = 5

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func game_over():
	print("Game Over")

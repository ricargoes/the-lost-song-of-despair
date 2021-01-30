extends Node

const char_max_speed = 5

var playing_story = true
var have_won = false

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func game_over():
	have_won = false
	print("Game Over")
#	var _unused = get_tree().change_scene("res://scenes/ui/WinScreen.tscn")

func win():
	have_won = true

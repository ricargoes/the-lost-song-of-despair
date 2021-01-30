extends Node

const char_max_speed = 5

var playing_story = true
var have_won = false

var enemies_world_node = null
var nav_node = null

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func game_over(winning):
	have_won = winning
	print("Game Over")
#	enemies_world_node = null
#	nav_node = null
#	var _unused = get_tree().change_scene("res://scenes/ui/WinScreen.tscn")


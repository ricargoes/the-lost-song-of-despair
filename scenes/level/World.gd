extends Node2D

export var max_enemies = 50
export var char_max_speed = 5

func _ready():
	Global.max_enemies = max_enemies
	Global.char_max_speed = char_max_speed
	Global.enemies_world_node = find_node("Enemies")
	Global.nav_node = find_node("Navigation2D")
	Global.difficulty = 0
	$TrackPlayer.step_up()
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _on_TrackPlayer_bis_ended():
	Global.songs_listened += 1
	end_level()

func end_level():
	if Global.songs_listened > 1:
		Global.game_over(true)
	else:
		var _unused = get_tree().change_scene("res://scenes/level/Level2.tscn")

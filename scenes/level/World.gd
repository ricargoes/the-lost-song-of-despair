extends Node2D

export var max_enemies = 50
export var char_max_speed = 5

func _ready():
	Global.max_enemies = max_enemies
	Global.char_max_speed = char_max_speed
	Global.enemies_world_node = find_node("Enemies")
	Global.nav_node = find_node("Navigation2D")
	$TrackPlayer.step_up()

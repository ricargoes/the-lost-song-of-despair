extends Node2D

export var max_enemies = 50

func _ready():
	Global.max_enemies = max_enemies
	Global.enemies_world_node = $Enemies
	Global.nav_node = $Navigation2D
	$TrackPlayer.step_up()

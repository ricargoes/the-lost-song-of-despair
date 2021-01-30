extends Node2D

func _ready():
	Global.enemies_world_node = $Enemies
	Global.nav_node = $Navigation2D
	$TrackPlayer.step_up()

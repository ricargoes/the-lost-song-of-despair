extends "res://scenes/level/World.gd"

var spawner_groups = ["a", "b", "c"]
var current_group = "a"

func _ready():
	spawn_cassetes()
	activate_spawner_group()
	Global.songs_listened = 0
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _on_TrackPlayer_bis_ended():
	reset_song()
	spawn_cassetes()
	Global.ui_node.hide_cinematic()
	rotate_spawners()


func reset_song():
	Global.songs_listened += 1
	$TrackPlayer.song_n = ($TrackPlayer.song_n + 1) % 1
	$TrackPlayer.current_track = -1
	$TrackPlayer.prepare_tracks()
	$TrackPlayer.step_up()


func spawn_cassetes():
	var cassetes_spawner = get_tree().get_nodes_in_group("cassete_spawner")
	for spawner in cassetes_spawner:
		var cassete = ResourcesManager.cassete_class.instance()
		cassete.position = spawner.position
		spawner.get_parent().add_child(cassete)

func rotate_spawners():
	var i = spawner_groups.find(current_group)
	current_group = spawner_groups[(i+1) % spawner_groups.size()]
	activate_spawner_group()

func activate_spawner_group():
	for group in spawner_groups:
		if group == current_group:
			get_tree().call_group(group, "enable")
		else:
			get_tree().call_group(group, "disable")

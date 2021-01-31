extends "res://scenes/level/World.gd"

var spawner_groups = ["a", "b", "c"]

func _ready():
	spawn_cassetes()
	rotate_spawners()
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
	Global.difficulty = 0
	$TrackPlayer.song_n = ($TrackPlayer.song_n + 1) % 2
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
	var current_group_index = Global.songs_listened % spawner_groups.size()
	var n_spawners = min(floor(Global.songs_listened / spawner_groups.size()) + 1, spawner_groups.size())
	for group in spawner_groups:
		get_tree().call_group(group, "disable")
	
	for i in range(n_spawners):
		var group = spawner_groups[(current_group_index + i) % spawner_groups.size()]
		get_tree().call_group(group, "enable")

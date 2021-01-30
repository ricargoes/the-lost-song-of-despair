extends Node

var current_track = -1
export var song_n = 0

func _ready():
	Global.tracklist_node = self
	prepare_tracks()
	step_up()

func prepare_tracks():
	var tracks = $Tracks.get_children()
	for i in range(tracks.size()):
		tracks[i].stream = load("res://resources/music/"+str(song_n)+"/"+str(i+1)+".ogg")
		tracks[i].set_volume_db(-80)
		tracks[i].play()

func step_up():
	var tracks = get_node("Tracks").get_children()
	if current_track < len(tracks) - 1:
		tracks[current_track].set_volume_db(-80.0)
		current_track += 1
		tracks[current_track].set_volume_db(-0.0)

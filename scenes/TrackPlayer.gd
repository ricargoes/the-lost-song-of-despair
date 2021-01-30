extends Node

var current_track = -1

func _init_tracks(tracks):
	for track in tracks:
		track.set_volume_db(-80)
	for track in tracks:
		track.play()

func step_up():
	var tracks = get_node("Tracks").get_children()
	if current_track < len(tracks) - 1:
		if current_track == -1:
			_init_tracks(tracks)
		else:
			tracks[current_track].set_volume_db(-80.0)
		current_track += 1
		tracks[current_track].set_volume_db(-0.0)

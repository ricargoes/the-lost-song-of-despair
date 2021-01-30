extends Node

signal bis_cued
signal bis_ended

var current_track = -1
export var song_n = 0
export var cue_bis_after_loop:bool = false

func _ready():
	Global.tracklist_node = self
	prepare_tracks()

func _cue_bis():
	if cue_bis_after_loop:
		$Bis/AudioStreamPlayer.play($Tracks/AudioStreamPlayer1.stream.get_length())
	else:
		$Bis/AudioStreamPlayer.play()
	var _error = $Bis/AudioStreamPlayer.connect("finished", self, "_notify_bis_ended", [], $Bis/AudioStreamPlayer.CONNECT_ONESHOT)
	emit_signal("bis_cued")

func _notify_bis_ended():
	emit_signal("bis_ended")

func prepare_tracks():
	var tracks = $Tracks.get_children()
	for i in range(tracks.size()):
		tracks[i].stream = load("res://resources/music/"+str(song_n)+"/"+str(i)+".ogg")
		tracks[i].set_volume_db(-80)
		tracks[i].play()
	$Bis/AudioStreamPlayer.stream = load("res://resources/music/"+str(song_n)+"/"+str(tracks.size())+".ogg")

func step_up():
	var tracks = get_node("Tracks").get_children()
	if current_track < len(tracks) - 1:
		tracks[current_track].set_volume_db(-80.0)
		current_track += 1
		tracks[current_track].set_volume_db(-0.0)
	elif current_track == len(tracks) - 1:
		for i in range(tracks.size()):
			var ogg_stream = tracks[i].stream as AudioStreamOGGVorbis
			ogg_stream.loop = false
		var last_track = tracks[len(tracks)-1]
		var _error = last_track.connect("finished", self, "_cue_bis", [], last_track.CONNECT_ONESHOT)
		current_track += 1

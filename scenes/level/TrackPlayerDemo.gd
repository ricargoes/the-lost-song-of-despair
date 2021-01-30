extends Control

func _ready():
	var _error = $TrackPlayer.connect("bis_cued", self, "_on_TrackPlayer_bis_cued")
	var _error2 = $TrackPlayer.connect("bis_ended", self, "_on_TrackPlayer_bis_ended")

func _on_StepUpButton_button_up():
	$TrackPlayer.step_up()

func _on_ForwardLoopButton_button_up():
	for track in $TrackPlayer/Tracks.get_children():
		track.seek(track.stream.get_length()-5.0)

func _on_ForwardBisButton_button_up():
	$TrackPlayer/Bis/AudioStreamPlayer.seek($TrackPlayer/Bis/AudioStreamPlayer.stream.get_length()-20.0)

func _on_TrackPlayer_bis_cued():
	$CenterContainer/VBoxContainer/BisCued.visible = true
	$CenterContainer/VBoxContainer/ForwardLoopButton.disabled = true
	$CenterContainer/VBoxContainer/ForwardBisButton.disabled = false

func _on_TrackPlayer_bis_ended():
	$CenterContainer/VBoxContainer/BisEnded.visible = true


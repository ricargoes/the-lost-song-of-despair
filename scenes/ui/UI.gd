extends Node

var cassette_cinem = preload("res://scenes/ui/cassete_cinem.tres")
var solo_cinem = preload("res://scenes/ui/solo_cinem.tres")

func _ready():
	Global.ui_node = self

func play_cassete():
	$ControlRoot/CasseteTimer.start()
	$ControlRoot/CinematicScreen.texture = cassette_cinem
	$ControlRoot/CinematicScreen.texture.current_frame = 0
	$ControlRoot/CinematicScreen.show()


func _on_CasseteTimer_timeout():
	$ControlRoot/CinematicScreen.hide()
	$ControlRoot/CinematicScreen.texture = null


func play_solo():
	$ControlRoot/CasseteTimer.stop()
	$ControlRoot/CinematicScreen.texture = solo_cinem
	$ControlRoot/CinematicScreen.show()
	

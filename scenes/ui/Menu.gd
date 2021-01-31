extends Control

func _ready():
	if Global.show_title:
		$Title.visible = true
		$Title/AnimationPlayer.play("Nueva Animación")
		Global.show_title = false

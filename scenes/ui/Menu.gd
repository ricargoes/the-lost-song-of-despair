extends Control

func _ready():
	if Global.show_title:
		$Title.visible = true
		$Title/AnimationPlayer.play("Nueva Animación")
		Global.show_title = false
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("quit"):
		if $Title.visible:
			$Title.visible = false
		else:
			get_tree().quit()
	
	if event.is_action_pressed("shoot"):
		$Title.visible = false
		if $Narration.visible:
			var _unused = get_tree().change_scene("res://scenes/level/Level1.tscn")

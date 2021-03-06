extends CenterContainer

func _ready():
	
	var text_edit = $VBoxContainer/NinePatchRect/MarginContainer/TextEdit
	var title_label = $VBoxContainer/Label
	if Global.have_won:
		title_label.text = "You win."
		text_edit.text = "You have have won."
		$VBoxContainer/TextureRect.texture = preload("res://scenes/ui/solo_cinem.tres")
		$VBoxContainer/HBoxContainer2/Retry.hide()
	else:
		title_label.text = "Game Over."
		text_edit.text = "You have listened to "+str(Global.songs_listened)+" and collected "+str(Global.difficulty)+" tracks of the next one. May the power of metal go with you next time."
		$VBoxContainer/TextureRect.texture = preload("res://scenes/ui/platypus_death.tres")
	
	Global.have_won = false
	set_process_input(true)


func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()


func _on_Retry_pressed():
	if Global.playing_story:
		if Global.songs_listened < 1:
			var _unused = get_tree().change_scene("res://scenes/level/Level1.tscn")
		else:
			var _unused = get_tree().change_scene("res://scenes/level/Level2.tscn")
	else:
		var _unused = get_tree().change_scene("res://scenes/level/Endless.tscn")


func _on_MainMenu_pressed():
	var _unused = get_tree().change_scene("res://scenes/ui/Main.tscn")

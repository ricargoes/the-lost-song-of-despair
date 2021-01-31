extends CenterContainer

func _ready():
	
	var text_edit = $VBoxContainer/NinePatchRect/MarginContainer/TextEdit
	var title_label = $VBoxContainer/Label
	if Global.have_won:
		title_label.text = "You win."
		text_edit.text = "You have have won."
		$VBoxContainer/HBoxContainer2/Retry.hide()
	else:
		title_label.text = "Game Over."
		text_edit.text = "You have listened to "+str(Global.songs_listened)+" and collected "+str(Global.difficulty)+" tracks of the next one. May the power of metal go with you next time."
	
	Global.have_won = false
	set_process_input(true)


func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()


func _on_Retry_pressed():
	if Global.playing_story:
		var _unused = get_tree().change_scene("res://scenes/level/World.tscn")
	else:
		var _unused = get_tree().change_scene("res://scenes/level/Endless.tscn")


func _on_MainMenu_pressed():
	var _unused = get_tree().change_scene("res://scenes/ui/Main.tscn")

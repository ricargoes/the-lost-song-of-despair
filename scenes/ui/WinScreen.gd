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
		text_edit.text = "You have failed."
	
	Global.have_won = false

func _on_Retry_pressed():
	if Global.playing_story:
		var _unused = get_tree().change_scene("res://scenes/World.tscn")
	else:
		var _unused = get_tree().change_scene("res://scenes/World.tscn")


func _on_MainMenu_pressed():
	var _unused = get_tree().change_scene("res://scenes/ui/Main.tscn")

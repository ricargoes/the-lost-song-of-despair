extends Control


func _ready():
	Global.have_won = false
	$Main/Story.grab_focus()

func _on_Endless_pressed():
	Global.playing_story = false
	var _unused = get_tree().change_scene("res://scenes/level/Endless.tscn")

func _on_Story_pressed():
	Global.playing_story = true
	var _unused = get_tree().change_scene("res://scenes/level/World.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func set_explanation(text):
	$Main/HSeparator/Margin/HBoxContainer/TextEdit.text = text

func default_explanation():
	set_explanation("Pick your poison!")

func _on_Endless_mouse_entered():
	set_explanation("How far can you get?")

func _on_Story_mouse_entered():
	set_explanation("A platypus chronicle")

func _on_Quit_mouse_entered():
	set_explanation("Don't go!      :'")

extends Control

func _on_StepUpButton_button_up():
	get_node("TrackPlayer").step_up()

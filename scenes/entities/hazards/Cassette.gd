extends Area2D

func _ready():
	$AnimatedSprite.play()


func _on_Cassette_body_entered(body):
	if Global.tracklist_node == null:
		return
	
	Global.tracklist_node.step_up()
	Global.difficulty += 1
	Global.ui_node.play_cassete()
	queue_free()

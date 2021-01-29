extends KinematicBody2D

func _ready():
	set_physics_process(true)
	$AnimatedSprite.play()
	
func _physics_process(delta):
	var platypus = get_tree().get_nodes_in_group("platypus")[0]
	var move_dir = (platypus.position - position).normalized()
	move_and_collide(move_dir*Global.char_max_speed*0.75)

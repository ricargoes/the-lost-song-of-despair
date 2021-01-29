extends KinematicBody2D

const cos_45 = 1/sqrt(2)

func _ready():
	set_physics_process(true)
	$AnimatedSprite.play("down")
	
func _physics_process(delta):
	var platypus = get_tree().get_nodes_in_group("platypus")[0]

	var points = get_tree().get_nodes_in_group("nav")[0].get_simple_path(position, platypus.position, true)
	
	if points.size() > 0:
		var move_dir = (points[1] - position).normalized()
		if move_dir.x > cos_45:
			$AnimatedSprite.play("right")
		elif move_dir.x < -cos_45:
			$AnimatedSprite.play("left")
		elif move_dir.y > cos_45:
			$AnimatedSprite.play("down")
		elif move_dir.y < -cos_45:
			$AnimatedSprite.play("up")
		
		move_and_collide(move_dir*Global.char_max_speed*0.75)

func hit():
	die()


func die():
	queue_free()

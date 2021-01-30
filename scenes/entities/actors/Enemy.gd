extends KinematicBody2D

const cos_45 = 1/sqrt(2)

export var hits = 2
export var relative_speed = 0.75

func _ready():
	set_physics_process(true)
	$AnimatedSprite.play("down")
	
func _physics_process(delta):
	var platypus = get_tree().get_nodes_in_group("platypus")[0]
	
	if Global.nav_node == null:
		return
		
	var points = Global.nav_node.get_simple_path(position, platypus.position, true)
	
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
		
		var collision = Global.ground_slide_or_collide(self, move_dir*Global.char_max_speed*relative_speed)
		if collision:
			if collision.collider.is_in_group("platypus"):
				collision.collider.hit()
				die()

func hit(damage=1):
	hits -= damage
	if hits <= 0:
		die()


func die():
	queue_free()

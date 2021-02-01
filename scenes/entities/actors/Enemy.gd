extends KinematicBody2D

const cos_45 = 1/sqrt(2)

export var hits = 2
export var relative_speed = 0.75
export var hits_per_level = 0.5
export var speed_increment_per_level = 0.05

var move_dir = Vector2.DOWN

func _ready():
	set_physics_process(true)
	hits += Global.difficulty*hits_per_level
	relative_speed+= Global.difficulty*speed_increment_per_level
	$AnimatedSprite.play("down")
	
func _physics_process(delta):
	if $DeadAnim.is_playing():
		return
	
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
	collision_layer = 0
	collision_mask = 0
	$AnimatedSprite.stop()
	$AnimatedSprite.hide()
	$DeadAnim.show()
	$DeadAnim.play()


func _on_DeadAnim_animation_finished():
	queue_free()


func _on_PathfindingRefresh_timeout():
	var platypus = get_tree().get_nodes_in_group("platypus")[0]
	if Global.nav_node != null and (platypus.position - position).length() < 700:
		var points = Global.nav_node.get_simple_path(position, platypus.position, true)
		if points.size() > 0:
			move_dir = (points[1] - position).normalized()
	else:
		randomize()
		move_dir = Vector2(randf(), randf()).normalized()

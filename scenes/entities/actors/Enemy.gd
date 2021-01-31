extends KinematicBody2D

const cos_45 = 1/sqrt(2)

export var hits = 2
export var relative_speed = 0.75
export var hits_per_level = 0.5
export var speed_increment_per_level = 0.05

var default_move_dir = Vector2.DOWN

func _ready():
	randomize()
	default_move_dir = Vector2(randf(), randf()).normalized()
	set_physics_process(true)
	hits += Global.difficulty*hits_per_level
	relative_speed+= Global.difficulty*speed_increment_per_level
	$AnimatedSprite.play("down")
	
func _physics_process(delta):
	if $DeadAnim.is_playing():
		return
	
	if Global.nav_node == null:
		return
	
	var platypus = get_tree().get_nodes_in_group("platypus")[0]
	var move_dir = default_move_dir
	if (platypus.position - position).length() < 1000:
		var points = Global.nav_node.get_simple_path(position, platypus.position, false)
		if points.size() > 0:
			move_dir = (points[1] - position).normalized()
	
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
		default_move_dir = Vector2(randf(), randf()).normalized()

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

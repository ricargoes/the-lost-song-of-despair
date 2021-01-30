extends KinematicBody2D

const cos_45 = 1/sqrt(2)

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var move_dir = get_move_direction()
	var collision = move_and_collide(move_dir*Global.char_max_speed)
	
	var look_dir = get_look_direction()
	if look_dir.x > cos_45:
		$AnimatedSprite.play("right")
	elif look_dir.x < -cos_45:
		$AnimatedSprite.play("left")
	elif look_dir.y > cos_45:
		if move_dir == Vector2.ZERO:
			$AnimatedSprite.play("standing")
		else:
			$AnimatedSprite.play("down")
	elif look_dir.y < -cos_45:
		$AnimatedSprite.play("up")
		
	
	if Input.is_action_pressed("shoot") and $ShootCooldown.is_stopped():
		shoot(look_dir)


func get_move_direction():
	var move_vector = Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		move_vector.x += -1
	if Input.is_action_pressed("move_right"):
		move_vector.x += 1
	
	if Input.is_action_pressed("move_up"):
		move_vector.y += -1
	if Input.is_action_pressed("move_down"):
		move_vector.y += 1
	return move_vector.normalized()
	
func get_look_direction():
	return get_global_transform().get_origin().direction_to(get_global_mouse_position()).normalized()
	

func shoot(dir):
	var bullet = ResourcesManager.bullets_class["wind"].instance()
	bullet.position = position + dir*10
	bullet.rotation = dir.angle()
	get_parent().add_child(bullet)
	$ShootCooldown.start()

func hit():
	die()

func die():
	Global.game_over(false)
	

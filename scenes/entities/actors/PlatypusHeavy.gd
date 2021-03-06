extends KinematicBody2D

const cos_45 = 1/sqrt(2)
export var shoot_cooldown = 0.2
export var standing_shoot_speed_multiplier = 1.5

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	zoom_camera()
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
		shoot(look_dir, move_dir == Vector2.ZERO)
	
	if Global.difficulty >= 4:
		pyrotechnics()


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

func zoom_camera():
	if Input.is_action_just_released("zoom_in"):
		$Camera2D.zoom.x = max($Camera2D.zoom.x - 0.05, 0.5)
		$Camera2D.zoom.y = max($Camera2D.zoom.y - 0.05, 0.5)
	if Input.is_action_just_released("zoom_out"):
		$Camera2D.zoom.x = min($Camera2D.zoom.x + 0.05, 1.1)
		$Camera2D.zoom.y = min($Camera2D.zoom.y + 0.05, 1.1)

func shoot(dir, standing):
	var bullet
	if Global.difficulty < 1:
		bullet = ResourcesManager.bullets_class["wind"].instance()
	elif Global.difficulty == 1:
		bullet = ResourcesManager.bullets_class["axe"].instance()
	elif Global.difficulty == 2:
		bullet = ResourcesManager.bullets_class["lightning"].instance()
	elif Global.difficulty >= 3:
		bullet = ResourcesManager.bullets_class["explosive"].instance()
	
	bullet.position = position + dir*10
	bullet.rotation = dir.angle()
	get_parent().add_child(bullet)
	if standing:
		$ShootCooldown.start(shoot_cooldown/standing_shoot_speed_multiplier)
	else:
		$ShootCooldown.start(shoot_cooldown)


func pyrotechnics():
	if $Pyrotechnics/Cooldown.is_stopped():
		var victims = $Pyrotechnics.get_overlapping_bodies()
		for victim in victims:
			if victim.is_in_group("enemies"):
				victim.hit(5)
		$Pyrotechnics.show()
		$Pyrotechnics/AnimatedSprite.play()
		$Pyrotechnics/Cooldown.start()


func stop_pyrotechnics():
	$Pyrotechnics.hide()
	$Pyrotechnics/AnimatedSprite.stop()


func hit():
	die()

func die():
	Global.game_over(false)


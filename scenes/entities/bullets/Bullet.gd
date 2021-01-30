extends KinematicBody2D

var bullet_speed = 10
export var damage = 1

func _ready():
	set_physics_process(true)
	$AnimatedSprite.play()


func _physics_process(delta):
	var collision = move_and_collide(bullet_speed*Vector2(cos(rotation), sin(rotation)))
	if collision:
		if collision.collider.is_in_group("enemies"):
			collision.collider.hit(damage)
		die()
	

func die():
	queue_free()

extends KinematicBody2D

var bullet_speed = 10

func _ready():
	set_physics_process(true)
	$AnimatedSprite.play()


func _physics_process(delta):
	move_and_collide(bullet_speed*Vector2(cos(rotation), sin(rotation)))
	

func die():
	queue_free()

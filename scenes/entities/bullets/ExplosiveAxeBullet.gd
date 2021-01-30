extends "res://scenes/entities/bullets/Bullet.gd"


func die():
	collision_layer = 0
	collision_mask = 0
	bullet_speed = 0
	var victims = $ExplosionArea.get_overlapping_bodies()
	for victim in victims:
		if victim.is_in_group("enemies"):
			victim.hit(1)
	$ExplosionArea.show()
	$ExplosionArea/AnimatedSprite.play()


func _on_AnimatedSprite_animation_finished():
	queue_free()

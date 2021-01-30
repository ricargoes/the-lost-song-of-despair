extends Area2D

export var enabled = true
export var spawn_cooldown = 2
export var spawn_amount = 1
export var spawn_type = ""

func _ready():
	if enabled:
		enable()
	else:
		disable()

func enable(_activator=null):
	$AnimatedSprite.play()
	$SpawnCooldown.start()

func disable(_activator=null):
	$AnimatedSprite.stop()
	$SpawnCooldown.stop()


func spawn():
	if Global.enemies_world_node == null:
		return
	var enemy = ResourcesManager.enemies_class[spawn_type].instance()
	Global.enemies_world_node.add_child(enemy)
	enemy.position = position
	$SpawnCooldown.start()

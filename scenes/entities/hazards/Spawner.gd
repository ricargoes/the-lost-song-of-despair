extends Area2D

export var enabled = true
export var spawn_cooldown = 2.0
export var spawn_amount = 1.0
export var spawn_amount_per_level = 0.25
export var spawn_type = ""

func _ready():
	if enabled:
		enable()
	else:
		disable()

func enable(_activator=null):
	$AnimatedSprite.play()
	$SpawnCooldown.start(spawn_cooldown)

func disable(_activator=null):
	$AnimatedSprite.stop()
	$SpawnCooldown.stop()


func spawn():
	$SpawnCooldown.start(spawn_cooldown)
	if Global.enemies_world_node == null or get_tree().get_nodes_in_group("enemies").size() > Global.max_enemies:
		return
	for i in range(floor(spawn_amount+spawn_amount_per_level*Global.difficulty)):
		var enemy = ResourcesManager.enemies_class[spawn_type].instance()
		Global.enemies_world_node.add_child(enemy)
		enemy.position = position

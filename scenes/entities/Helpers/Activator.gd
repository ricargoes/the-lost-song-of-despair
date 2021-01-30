extends Area2D

export var group_affected = ""

func _on_Activator_body_entered(body):
	var spawners = get_tree().get_nodes_in_group(group_affected)
	for spawner in spawners:
		if spawner.has_method("enable"):
			spawner.enable()


func _on_Activator_body_exited(body):
	var spawners = get_tree().get_nodes_in_group(group_affected)
	for spawner in spawners:
		if spawner.has("disable"):
			spawner.disable()

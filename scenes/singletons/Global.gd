extends Node

const char_max_speed = 5
const ground_collision_bit = 4
const ground_collision_grease_factor = 2.0

var playing_story = true
var have_won = false

var enemies_world_node = null
var nav_node = null
var tracklist_node = null

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func game_over(winning):
	have_won = winning
	print("Game Over")
#	enemies_world_node = null
#	nav_node = null
#	var _unused = get_tree().change_scene("res://scenes/ui/WinScreen.tscn")

func ground_slide_or_collide(body, intended_movement):
		var collision = body.move_and_collide(intended_movement, true, true, true)
		if collision:
			var collider = collision.collider
			if collider.get_collision_layer_bit(ground_collision_bit):
				var slide = body.move_and_slide(intended_movement, collision.normal)
				if slide:
					body.position += slide * ground_collision_grease_factor
			else:
				return collision
		else:
			body.position += intended_movement

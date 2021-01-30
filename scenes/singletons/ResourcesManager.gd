extends Node

var enemies_class = {
	"skeleton": preload("res://scenes/entities/actors/Skeleton.tscn"),
	"spider": preload("res://scenes/entities/actors/Spider.tscn"),
	"zombie": preload("res://scenes/entities/actors/Zombie.tscn"),
}

var bullets_class = {
	"wind": preload("res://scenes/entities/bullets/WindBullet.tscn"),
	"axe": preload("res://scenes/entities/bullets/AxeBullet.tscn"),
	"lightning": preload("res://scenes/entities/bullets/LightningAxeBullet.tscn"),
	"explosive": preload("res://scenes/entities/bullets/ExplosiveAxeBullet.tscn")
}

extends Node2D

@export var ammo = [12, 12, 50]
@export var ammoType = 0

const ammoTextures = [preload("res://assets/357ammo_1(1).png"), preload("res://assets/Buckshot.png"), preload("res://assets/Chainammo_1(1).png")]

func _ready() -> void:
	$Sprite.texture = ammoTextures[ammoType]

func getAmmo():
	return [ammo[ammoType], ammoType + 1]

func delAmmo():
	queue_free()

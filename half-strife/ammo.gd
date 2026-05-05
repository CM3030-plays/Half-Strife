extends Node2D

@export var ammo = 100
@export var ammoType = 1

const ammoTextures = [preload("res://assets/357ammo_1(1).png"), preload("res://assets/Buckshot.png"), preload("res://assets/Chainammo_1(1).png")]

func _ready() -> void:
	$Sprite.texture = ammoTextures[ammoType]

func getAmmo():
	return [ammo, ammoType]

func delAmmo():
	queue_free()

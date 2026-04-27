extends CharacterBody2D

var health = 100

func _ready() -> void:
	add_to_group("enemies")


func takeDamage (damage : int):
	health -= damage
	if health <= 0:
		die()

func die():
	queue_free()

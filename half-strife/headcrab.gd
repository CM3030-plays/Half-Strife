extends CharacterBody2D

var health = 100

func _ready() -> void:
	add_to_group("enemies")
	randomize()



func takeDamage(damage: int):
	health -= damage

	var sound_array

	if health <= 0:
		sound_array = AudioFiles.sfx["hc_die"]
		die()
	else:
		sound_array = AudioFiles.sfx["hc_hit"]

	$sounds.stream = sound_array.pick_random()
	$sounds.play()

func die():
	queue_free()

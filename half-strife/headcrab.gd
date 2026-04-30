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
		$sounds.stream = sound_array.pick_random()
		$sounds.play()
		die()
	else:
		sound_array = AudioFiles.sfx["hc_hit"]
	
	$sounds.stream = sound_array.pick_random()
	$sounds.play()

	

func die():
	
	await $sounds.finished
	queue_free()


func _on_idle_timeout() -> void:
	$sounds.stream = AudioFiles.sfx["hc_idle"].pick_random()
	$sounds.play()

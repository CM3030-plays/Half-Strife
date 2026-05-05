extends CharacterBody2D

var health = 100
var dead = false
var speed = 65

var playerFound = false
var knockback = Vector2.ZERO

func _ready() -> void:
	add_to_group("enemies")
	randomize()
	$AnimatedSprite2D.play("Idle")
	rotate(randf_range(0, 2*PI))
	$Idle.start(randf_range(5, 30))

func takeDamage(damage: int, dir : Vector2):
	health -= damage
	
	var knockback_force = 200
	knockback -= dir * knockback_force
	
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
	$HeadcrabHitbox.set_disabled(true)
	dead = true
	
	$AnimatedSprite2D.animation = "Idle"
	$AnimatedSprite2D.pause()
	
	await $sounds.finished
	queue_free()


func _on_idle_timeout() -> void:
	if dead:
		return
	
	$Idle.start(randf_range(5, 60))
	$sounds.stream = AudioFiles.sfx["hc_idle"].pick_random()
	$sounds.play()

func playerTrack(position):
	if dead or !playerFound:
		return
	
	$AnimatedSprite2D.animation = "Walk"
	
	look_at(position)

	var direction = (position - global_position).normalized()
	var move_velocity = direction * speed
	velocity = move_velocity + knockback

	move_and_slide()
	knockback = knockback.move_toward(Vector2.ZERO, 400 * get_physics_process_delta_time())

func _on_detect_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if !playerFound:
			playerFound = true
			$sounds.stream = AudioFiles.sfx["hc_hit"][2]
			$sounds.play()

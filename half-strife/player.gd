extends CharacterBody2D

@export var SPEED = 500.0
@export var ACCELERATION = 10.0

const playerWalkAngle = [45, -45]

var hittable = true
var health = 100
var animation

signal attack
signal hit
signal switch

func _ready() -> void:
	$PlayerSprite.play($Attack.weaponSwitch() + "Idle")

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var target_velocity = input_dir * SPEED
	velocity = velocity.lerp(target_velocity, ACCELERATION * delta)
	move_and_slide()

func _process(delta: float) -> void:
	check_damage()
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var currentWeapon = $Attack.weaponSwitch()
	
	if Input.is_action_pressed("click") and $AttackCooldown.is_stopped() and $Attack.has_ammo():
		animation = "Attack"
		attack.emit(currentWeapon)
		$PlayerSprite.play()
	else:
		if $AttackCooldown.is_stopped():
			if input_dir == Vector2.ZERO:
				animation = "Idle"
			else:
				var forward = Vector2.RIGHT.rotated(rotation)
				var right = forward.rotated(PI / 2)
				var move_dir = input_dir.normalized()
				var right_dot = right.dot(move_dir)
				if abs(right_dot) > 0.5:
					if right_dot > 0:
						animation = "Right"
					else:
						animation = "Left"
				else:
					animation = "Walk"
	
	if $PlayerSprite.animation != currentWeapon + animation:
		$PlayerSprite.animation = currentWeapon + animation
		$PlayerSprite.play()

func check_damage():
	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i)
		var collider = col.get_collider()
	
		if health <= 0:
			health = 0
			hittable = false
		
		if hittable and collider.is_in_group("enemies"):
			health -= randi_range(8, 12)
			if health <= 0:
				health = 0
			
			var direction = (global_position - collider.global_position).normalized()
			var knockback_force = 800
			velocity = direction * knockback_force
			
			set_collision_layer_value(1, false)
			set_collision_mask_value(1, false)
			hittable = false
			
			$DamageCooldown.start()
			hit.emit()
			return

func _on_attack_cooldown_timeout() -> void:
	$AttackCooldown.stop()

func _on_flash_timer_timeout() -> void:
	$Attack/Flash.hide()

func _on_damage_cooldown_timeout() -> void:
	hittable = true
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)

func _on_pickup_area_entered(area: Area2D) -> void:
	if area.is_in_group("ammo"):
		$Weapons.stream = AudioFiles.sfx["ammo"].pick_random()
		$Weapons.play()
		
		var AmmoArray = area.getAmmo()
		$Attack.ammoCheck(AmmoArray, area)

func _on_switch() -> void:
	switch.emit()

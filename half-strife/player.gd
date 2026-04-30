extends CharacterBody2D

@export var SPEED = 500.0
@export var ACCELERATION = 10.0

const playerWalkAngle = [45, -45]

var weapons = ["crowbar", "revolver", "shotgun", "smg"]
var heldWeapons = [0, 2, 3]
var ammo = [100, 100, 100, 100]

var max_ammo = 100

@export var weaponIndex = 0
var animation

signal attack

func _ready() -> void:
	$PlayerSprite.play(weapons[weaponIndex] + "Idle")

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var target_velocity = input_dir * SPEED
	
	velocity = velocity.lerp(target_velocity, ACCELERATION * delta)
	
	move_and_slide()

func _process(delta: float) -> void:
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	
	if Input.is_action_just_pressed("weaponUp"):
		print("switch")
		if weaponIndex != heldWeapons.size() - 1:
			weaponIndex += 1
		else:
			weaponIndex = 0 
		$AttackCooldown.stop()
		
	if Input.is_action_just_pressed("weaponDown"):
		if weaponIndex != 0:
			weaponIndex -= 1
		else:
			weaponIndex = heldWeapons.size() - 1
		$AttackCooldown.stop()
	
	var currentWeapon = weapons[heldWeapons[weaponIndex]]
	
	if Input.is_action_pressed("click") and $AttackCooldown.is_stopped():
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

				# If mostly sideways → left/right
				if abs(right_dot) > 0.5:
					if right_dot > 0:
						animation = "Right"
					else:
						animation = "Left"
				else:
					# Otherwise → forward OR backward (sad animation)
					animation = "Walk"
	if $PlayerSprite.animation != currentWeapon + animation:
		$PlayerSprite.animation = currentWeapon + animation
		$PlayerSprite.play()

func _on_attack_cooldown_timeout() -> void:
	$AttackCooldown.stop()

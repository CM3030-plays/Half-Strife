extends CharacterBody2D

@export var SPEED = 500.0
@export var ACCELERATION = 10.0

const playerWalkAngle = [45, -45]

@export var currentWeapon = "crowbar"
var animation

signal attack

func _ready() -> void:
	$PlayerSprite.play("crowbarIdle")
	

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var target_velocity = input_dir * SPEED
	
	velocity = velocity.lerp(target_velocity, ACCELERATION * delta)
	
	move_and_slide()

func _process(delta: float) -> void:
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	
	if currentWeapon == "crowbar":
		$AttackCooldown.wait_time = 0.4
	
	if Input.is_action_pressed("click"):
		animation = "Attack"
		if $AttackCooldown.is_stopped():
			$AttackCooldown.start()
			attack.emit(currentWeapon)
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

	$PlayerSprite.animation = str(currentWeapon) + animation
		


func _on_attack_cooldown_timeout() -> void:
	$AttackCooldown.stop()

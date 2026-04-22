extends CharacterBody2D

@export var SPEED = 500.0
@export var ACCELERATION = 10.0

const playerWalkAngle = [45, -45]

var currentWeapon
var animation

func _ready() -> void:
	$PlayerSprite.play("crowbarIdle")
	currentWeapon = "crowbar"
	

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var target_velocity = input_dir * SPEED
	
	velocity = velocity.lerp(target_velocity, ACCELERATION * delta)
	
	move_and_slide()

func _process(delta: float) -> void:
	if currentWeapon == "crowbar":
		$AttackCooldown.wait_time = 0.4
	
	if Input.is_action_pressed("click"):
		animation = "Attack"
		if $AttackCooldown.is_stopped():
			$AttackCooldown.start()
	else:
		if $AttackCooldown.is_stopped():
			if velocity.is_zero_approx():
				animation = "Idle"
			else:
				var forward = Vector2.RIGHT.rotated(rotation)
				var move_dir = velocity.normalized()
				
				var angle = forward.angle_to(move_dir) # radians
				
				if abs(angle) <= deg_to_rad(45):
					animation = "Walk"
				else:
					animation = "Idle"

	$PlayerSprite.animation = str(currentWeapon) + animation
		
func attack():
	pass


func _on_attack_cooldown_timeout() -> void:
	$AttackCooldown.stop()

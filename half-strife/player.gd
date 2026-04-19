extends CharacterBody2D

@export var SPEED = 500.0
@export var ACCELERATION = 10.0

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
	if (Input.is_action_pressed("click")):
		animation = "Attack"
		$AttackCooldown.start()
	else:
		if $AttackCooldown.timeout:
			animation = "Idle"
		
func attack():
	pass

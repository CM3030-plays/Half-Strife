extends Node2D
var startingLevel = "res://Levels/level_debug.tscn"
var currentLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	$Hud/Health.text = str($Player.health)
	if $Player/Attack.get_current_index() != 0:
		$Hud/Ammo.text = str($Player/Attack.ammo[$Player/Attack.get_current_index()])
	else:
		$Hud/Ammo.text = ""
		
	for body in get_tree().get_nodes_in_group("enemies"):
		body.playerTrack($Player.position)

func start():
	loadLevel(startingLevel)
	$Player.global_position = $Level/Level/StartPos.global_position
	$Hud/menu.hide()
	$Player/Camera2D.enabled = true
	get_tree().paused = false

func loadLevel(path : String):
	if currentLevel:
		currentLevel.queue_free()
		currentLevel = null
	
	var level_scene = load(path)
	currentLevel = level_scene.instantiate()
	
	$Level.add_child(currentLevel)


func _on_player_hit() -> void:
	$Hud.hit($Player.health)

func _on_player_switch() -> void:
	$Hud.switch($Player/Attack.heldWeapons[$Player/Attack.weaponIndex])

extends Node2D
var startingLevel = "res://Levels/level_debug.tscn"
var currentLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loadLevel(startingLevel)
	$Player.global_position = $Level/Level/StartPos.global_position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Hud/Health.text = str($Player.health)
	
	for body in get_tree().get_nodes_in_group("enemies"):
		body.playerTrack($Player.position)

func loadLevel(path : String):
	if currentLevel:
		currentLevel.queue_free()
		currentLevel = null
	
	var level_scene = load(path)
	currentLevel = level_scene.instantiate()
	
	$Level.add_child(currentLevel)

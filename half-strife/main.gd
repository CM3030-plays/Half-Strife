extends Node2D
const levels = ["res://Levels/level_1.tscn", "res://Levels/level_2.tscn", "res://Levels/level_3.tscn"]
@export var levelIndex = 0

var startingLevel = levels[levelIndex]
var currentLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loadLevel(startingLevel)
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Hud/Health.text = str($Player.health)
	$Listener.position = $Player.position
	if $Player/Attack.get_current_index() != 0:
		$Hud/Ammo.text = str($Player/Attack.ammo[$Player/Attack.get_current_index()])
	else:
		$Hud/Ammo.text = ""
	
	for body in get_tree().get_nodes_in_group("enemies"):
		body.playerTrack($Player.position)

func start():
	$Hud.start()
	$Player/Camera2D.enabled = true

func restart():
	get_tree().paused = true
	$Hud.gameRunning = false
	$Hud.pause = false
	
	await  $Hud.die()
	
	loadLevel(startingLevel)
	levelIndex = 0
	$Hud/Health.hide()
	$Hud/Ammo.hide()
	$Hud/menu.show()
	$Hud/menu/Start.text = "New Game"
	$Hud/HEV.stop()
	$Hud/music.stop()

func restartWin():
	get_tree().paused = true
	$Hud.gameRunning = false
	$Hud.pause = false
	$Hud/HEV.stop()
	$Hud/music.stop()
	$Player.reset()
	
	await  $Hud.win()
	
	loadLevel(startingLevel)
	levelIndex = 0
	$Hud/Health.hide()
	$Hud/Ammo.hide()
	$Hud/menu.show()
	$Hud/menu/Start.text = "New Game"

	

func nextLevel():
	if !levelIndex == levels.size() - 1:
		levelIndex += 1
		loadLevel(levels[levelIndex])
	else:
		restartWin()

func loadLevel(path: String):
	if currentLevel:
		currentLevel.queue_free()
		currentLevel = null

	var level_scene = load(path)
	currentLevel = level_scene.instantiate()

	$Level.add_child(currentLevel)

	await get_tree().process_frame

	$Player.position = currentLevel.get_node("StartPos").position

	currentLevel.connect("nextLevel", nextLevel)


func _on_player_hit() -> void:
	$Hud.hit($Player.health)

func _on_player_switch() -> void:
	$Hud.switch($Player/Attack.heldWeapons[$Player/Attack.weaponIndex])

extends CanvasLayer

var last_song
var last_health = 100

signal startGame
var pause = false
var gameRunning = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	$menu/Start.pressed.connect(start)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	$Crosshair.position = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("pause") and pause == false and gameRunning:
		pause = true
		get_tree().paused = true
		
		$menu.show()
		$Health.hide()
		$Ammo.hide()
		
	elif Input.is_action_just_pressed("pause") and pause == true and gameRunning:
		pause = false
		get_tree().paused = false
		
		$menu.back()
		$menu.hide()
		$Health.show()
		$Ammo.show()

func die():
	$SFX.stream = AudioFiles.HEV["flatline"]
	$SFX.play()
	await $Label.gameOver()

func win():
	$music.stream = AudioFiles.HEV["success"]
	$music.play()
	await $Label.win()

func _on_music_finished() -> void:
	var temp = AudioFiles.music.pick_random()
	while (temp == last_song):
		temp = AudioFiles.music.pick_random()
	
	last_song = temp
	$music.stream = last_song
	$music.play()

func start():
	if gameRunning:
		get_tree().paused = false
		pause = false
		$menu.back()
		$menu.hide()
		$Health.show()
		$Ammo.show()
	else:
		await $Label.start()
		
		gameRunning = true
		get_tree().paused = false
		startGame.emit()
		
		$menu/Start.text = "Resume"
		$menu.back()
		$menu.hide()
		$Health.show()
		$Ammo.show()
		
		last_song = AudioFiles.music.pick_random()
		
		$HEV.stream = AudioFiles.HEV["HEV_Intro"]
		$HEV.play()
		
		await $HEV.finished
		
		$music.stream = last_song
		$music.play()

func hit(health):
	if health <= 0:
		$SFX.stream = preload("res://assets/sfx/flatline.wav")
		$SFX.play()
	
	if last_health > 25 and health <= 25:
		$HEV.stream = AudioFiles.HEV["health_critical"]
		$HEV.play()
	last_health = health
	
	$SFX.stream = AudioFiles.sfx["hit"]
	$SFX.play()
	

func switch(index):
	$weaponSwap.texture = AudioFiles.weapons[index]
	$weaponSwap.show()
	$weaponTime.start()
	
func _on_weapon_time_timeout() -> void:
	$weaponSwap.hide()

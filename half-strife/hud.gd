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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	$Crosshair.position = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("pause") and pause == false and gameRunning:
		get_tree().paused = true
		pause = true
		$menu.show()
		$HEV.stream_paused = true
		$music.stream_paused = true
		
		$Health.hide()
		$Ammo.hide()
		$weaponSwap.hide()
		
	elif Input.is_action_just_pressed("pause") and pause == true and gameRunning:
		get_tree().paused = false
		pause = false
		$menu.hide()
		$HEV.stream_paused = false
		$music.stream_paused = false
		
		$Health.show()
		$Ammo.show()

func _on_music_finished() -> void:
	var temp = AudioFiles.music.pick_random()
	while (temp == last_song):
		temp = AudioFiles.music.pick_random()
	
	last_song = temp
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


func _on_menu_start() -> void:
	startGame.emit()
	if !gameRunning:
		$Health.show()
		$Ammo.show()
		
		gameRunning = true
		last_song = AudioFiles.music.pick_random()
		
		$HEV.stream = AudioFiles.HEV["HEV_Intro"]
		$HEV.play()
		
		await $HEV.finished
		
		$music.stream = last_song
		$music.play()
	else:
		get_tree().paused = false
		pause = false
		$menu.hide()

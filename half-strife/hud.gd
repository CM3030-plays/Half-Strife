extends CanvasLayer

var last_song
var last_health = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	last_song = AudioFiles.music.pick_random()
	
	$HEV.stream = AudioFiles.HEV["HEV_Intro"]
	$HEV.play()
	
	await $HEV.finished
	
	$music.stream = last_song
	$music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	$Crosshair.position = get_viewport().get_mouse_position()


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
	
	

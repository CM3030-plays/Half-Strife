extends CanvasLayer

var last_song

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	last_song = AudioFiles.music.pick_random()
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

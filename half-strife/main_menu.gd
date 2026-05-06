extends CanvasLayer

var music_vol
var sfx_vol

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func exit():
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()

func options():
	$Start.hide()
	$Options.hide()
	$Exit.hide()
	
	$OptionMenu.show()

func back():
	$Start.show()
	$Options.show()
	$Exit.show()
	
	$OptionMenu.hide()

func on_vol_change(value):
	value = $OptionMenu/music.value
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)
	$UI_SFX.stream = AudioFiles.HEV["ui"]
	$UI_SFX.volume_linear = value
	$UI_SFX.play()

func on_vol_change_SFX(value) -> void:
	value = $OptionMenu/sfx.value
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)
	$UI_SFX.stream = AudioFiles.HEV["ui"]
	$UI_SFX.volume_linear = value
	$UI_SFX.play()

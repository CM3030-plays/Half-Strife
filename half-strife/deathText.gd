extends Label

signal done

var intro = "Subject:\nDr. Elijah Meyers\n\nStatus:\nTrapped under Black Mesa Bio-lockdown\n\nGoal:\nEscape"

var deathText = "Subject:\nDr. Elijah Meyers\n\nStatus:\nPresumed to have died in the Black Mesa Incident."
var winText = "Subject:\nDr. Elijah Meyers\n\nStatus:\nOut of range."
var credits = "Valve\nSource Sounds\nmaiik28\nFace Punch Studios\nsmoe."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = ""
	
func start():
	$"../AnimationPlayer".play("gameover")
	await  $"../AnimationPlayer".animation_finished
	await printText(intro, 3.0)
	await get_tree().create_timer(1.5,true).timeout
	$"../ColorRect".color.a = 0
	text = ""

func gameOver():
	$"../AnimationPlayer".play("gameover")
	await  $"../AnimationPlayer".animation_finished
	await printText(deathText, 3.0)
	await get_tree().create_timer(1.5,true).timeout
	$"../ColorRect".color.a = 0
	text = ""

func win():
	$"../AnimationPlayer".play("gameover")
	await  $"../AnimationPlayer".animation_finished
	await printText(winText, 4.0)
	await get_tree().create_timer(1.5,true).timeout
	
	$"../AnimationPlayer".play("text fade")
	await  $"../AnimationPlayer".animation_finished
	
	add_theme_color_override("font_color",Color("9e9e9e")) # same RGB, full alpha
	await printText(credits, 5.0)
	
	await get_tree().create_timer(3,true).timeout
	$"../ColorRect".color.a = 0
	text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func printText(fulltext : String, time : float):
	var pause = time / fulltext.length()
	for i in range(fulltext.length() + 1):
		text = fulltext.substr(0, i)
		await get_tree().create_timer(pause,true).timeout

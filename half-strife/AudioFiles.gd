extends Node

var sfx = {
	"crowbar_miss" : preload("res://assets/sfx/cbar_miss1.wav"), 
	"crowbar_hit" : preload("res://assets/sfx/cbar_hitbod2.wav"),
	"crowbar_hit_wall" : preload("res://assets/sfx/cbar_hit1.wav"),
	
	"revolver_fire" : [preload("res://assets/sfx/357_shot1.wav"), preload("res://assets/sfx/357_shot2.wav")],
	
	"shotgun_fire" : preload("res://assets/sfx/sbarrel1.wav"),
	
	"smg_fire" : [preload("res://assets/sfx/hks1.wav"), preload("res://assets/sfx/hks2.wav"), preload("res://assets/sfx/hks3.wav")],
	
	"ammo" : [preload("res://assets/sfx/reload1.wav"), preload("res://assets/sfx/reload2.wav"), preload("res://assets/sfx/reload3.wav")],
	"bullet" : [preload("res://assets/sfx/bullet_hit1.wav"), preload("res://assets/sfx/bullet_hit2.wav")],
	
	"hc_hit" : [preload("res://assets/sfx/hc_pain1.wav"), preload("res://assets/sfx/hc_pain2.wav"), preload("res://assets/sfx/hc_pain3.wav")],
	"hc_die" : [preload("res://assets/sfx/hc_die1.wav"), preload("res://assets/sfx/hc_die2.wav")],
	"hc_idle" : [preload("res://assets/sfx/hc_idle1.wav"), preload("res://assets/sfx/hc_idle2.wav"), preload("res://assets/sfx/hc_idle3.wav"), preload("res://assets/sfx/hc_idle4.wav"), preload("res://assets/sfx/hc_idle5.wav")]
	}
var music = [
preload("res://assets/music/half-life (1).mp3"),
preload("res://assets/music/half-life (2).mp3"),
preload("res://assets/music/half-life (3).mp3"),
preload("res://assets/music/half-life (4).mp3")
]

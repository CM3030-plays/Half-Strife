extends Area2D

var bodysMelee = []
var bodysStraight = []
var bodysSides = []

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		bodysMelee.append(body)
	print(body)


func _on_body_exited(body: Node2D) -> void:
	bodysMelee.erase(body)
	print("out")



func _on_player_attack(weapon : String) -> void:
	print("attack")
	if weapon == "crowbar":
		if bodysMelee.size() > 0:
			$"../Weapons".stream = AudioFiles.sfx["crowbar_hit"]
		else:
			$"../Weapons".stream = AudioFiles.sfx["crowbar_miss"]
			
		$"../Weapons".play()
		
		for body in bodysMelee:
			if body.has_method("takeDamage"):
				body.takeDamage(50)
	
	if weapon == "shotgun":
		bodysSides.append($Spread1.get_collider())
		bodysSides.append($Spread2.get_collider())
		bodysSides.append($Spread3.get_collider())
		bodysSides.append($Spread4.get_collider())
		bodysSides.append($Straight.get_collider())
		
		print(bodysSides)
		pass
		
		for body in bodysSides:
			if body.has_method("takeDamage"):
				body.takeDamage(30)

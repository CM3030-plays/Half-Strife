extends Area2D

var bodysMelee = []



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
		$"../AttackCooldown".wait_time = 0.4
		
		if bodysMelee.size() > 0:
			$"../Weapons".stream = AudioFiles.sfx["crowbar_hit"]
		else:
			$"../Weapons".stream = AudioFiles.sfx["crowbar_miss"]
			
		
		
		for body in bodysMelee:
			if body.has_method("takeDamage"):
				body.takeDamage(50)
	
	if weapon == "shotgun":
		var bodysSides = []
		
		$"../AttackCooldown".start(1)
		
		bodysSides.append($Spread1.get_collider())
		bodysSides.append($Spread2.get_collider())
		bodysSides.append($Spread3.get_collider())
		bodysSides.append($Spread4.get_collider())
		bodysSides.append($Straight.get_collider())
		
		$"../Weapons".stream = AudioFiles.sfx["shotgun_fire"]
		
		for body in bodysSides:
			if body != null:
				if body.has_method("takeDamage"):
					body.takeDamage(30)
	
	if weapon == "smg":
		var bodysStraight = []
		$"../AttackCooldown".start(0.4)
		
		bodysStraight.append($Straight.get_collider())
		
		$"../Weapons".stream = AudioFiles.sfx["smg_fire"].pick_random()
		
		for body in bodysStraight:
			if body != null:
				if body.has_method("takeDamage"):
					body.takeDamage(30)
	
	$"../Weapons".play()

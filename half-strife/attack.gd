extends Area2D

var bodysMelee = []
var bodysWall = []


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		bodysMelee.append(body)
	else:
		bodysWall.append(body)


func _on_body_exited(body: Node2D) -> void:
	bodysMelee.erase(body)
	bodysWall.erase(body)



func _on_player_attack(weapon : String) -> void:
	if weapon == "crowbar":
		$"../AttackCooldown".start(0.4)
		
		if bodysMelee.size() > 0:
			$"../Weapons".stream = AudioFiles.sfx["crowbar_hit"]
		elif bodysWall.size() > 0:
			$"../Weapons".stream = AudioFiles.sfx["crowbar_hit_wall"]
		else:
			$"../Weapons".stream = AudioFiles.sfx["crowbar_miss"]
			
		
		
		for body in bodysMelee:
			if body.has_method("takeDamage"):
				body.takeDamage(50)
	
	if weapon == "shotgun":
		var bodysSides = []
		
		$"../AttackCooldown".start(9.0/11.0)
		
		bodysSides.append($Spread1.get_collider())
		bodysSides.append($Spread2.get_collider())
		bodysSides.append($Spread3.get_collider())
		bodysSides.append($Spread4.get_collider())
		bodysSides.append($Straight.get_collider())
		
		$"../Weapons".stream = AudioFiles.sfx["shotgun_fire"]
		
		for body in bodysSides:
			if body != null:
				if body.has_method("takeDamage"):
					body.takeDamage(40)
	
	if weapon == "smg":
		var bodysStraight = []
		$"../AttackCooldown".start(0.1)
		
		bodysStraight.append($Straight.get_collider())
		
		$"../Weapons".stream = AudioFiles.sfx["smg_fire"].pick_random()
		
		for body in bodysStraight:
			if body != null:
				if body.has_method("takeDamage"):
					body.takeDamage(20)
	
	if weapon == "revolver":
		var bodysStraight = []
		$"../AttackCooldown".start(1)
		
		bodysStraight.append($Straight.get_collider())
		
		$"../Weapons".stream = AudioFiles.sfx["revolver_fire"].pick_random()
		
		for body in bodysStraight:
			if body != null:
				if body.has_method("takeDamage"):
					body.takeDamage(100)
	
	$"../Weapons".play()

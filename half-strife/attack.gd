extends Area2D

var bodysMelee = []
var bodysWall = []


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		bodysMelee.append(body)
	elif body.is_in_group("walls"):
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
				body.takeDamage(50, Vector2.ZERO)
	
	if weapon == "shotgun":
		var bodysSides = []
		
		$"../AttackCooldown".start(9.0/11.0)
		
		var rays = [$Spread1, $Spread2, $Spread3, $Spread4, $Straight]

		for ray in rays:
			var body = ray.get_collider()
			if body != null:
				if body.has_method("takeDamage"):
					var dir = ray.global_transform.x.normalized()
					body.takeDamage(40, dir)
		
		$"../Weapons".stream = AudioFiles.sfx["shotgun_fire"]
		
		$Flash.show()
		$FlashTimer.start()
		
	
	if weapon == "smg":
		$"../AttackCooldown".start(0.075)
		
		var straight = $Straight.get_collider()
		
		$"../Weapons".stream = AudioFiles.sfx["smg_fire"].pick_random()
		
		$Flash.show()
		$FlashTimer.start()
		
		if straight != null:
			if straight.has_method("takeDamage"):
				var dir = straight.global_transform.x.normalized()
				straight.takeDamage(40, dir)
	
	if weapon == "revolver":
		$"../AttackCooldown".start(1)
		
		var straight = $Straight.get_collider()
		
		$"../Weapons".stream = AudioFiles.sfx["revolver_fire"].pick_random()
		
		$Flash.show()
		$FlashTimer.start()
		
		if straight != null:
			if straight.has_method("takeDamage"):
				var dir = straight.global_transform.x.normalized()
				straight.takeDamage(1000, dir)
	
	$"../Weapons".play()

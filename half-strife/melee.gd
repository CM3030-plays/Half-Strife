extends Area2D

var bodys = []

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		bodys.append(body)
	print(body)


func _on_body_exited(body: Node2D) -> void:
	bodys.erase(body)
	print("out")



func _on_player_attack(weapon : String) -> void:
	print("attack")
	if weapon == "crowbar":
		if bodys.size() > 0:
			$"../Weapons".stream = AudioFiles.sfx["crowbar_hit"]
		else:
			$"../Weapons".stream = AudioFiles.sfx["crowbar_miss"]
			
		$"../Weapons".play()
		
		for body in bodys:
			if body.has_method("takeDamage"):
				body.takeDamage(10)

extends Area2D

var bodysMelee = []
var bodysWall = []

var weapons = ["crowbar", "revolver", "shotgun", "smg"]
@export var heldWeapons = [0]
@export var ammo = [1, 100, 0, 0]
var maxAmmo = [1, 30, 24, 150]

@export var weaponIndex = 0

signal switch

func get_current_index():
	return heldWeapons[weaponIndex]

func get_current_weapon():
	return weapons[get_current_index()]

func has_ammo():
	return ammo[get_current_index()] > 0 or get_current_weapon() == "crowbar"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		bodysMelee.append(body)
	elif body.is_in_group("walls"):
		bodysWall.append(body)

func _on_body_exited(body: Node2D) -> void:
	bodysMelee.erase(body)
	bodysWall.erase(body)



func attack():
	var index = get_current_index()
	var weapon = weapons[index]
	
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
				body.takeDamage(40, Vector2.ZERO)
				
		$"../Weapons".play()
		return true
	
	if weapon == "shotgun":
		if !ammo[index] <= 0:
			ammo[index] -= 1
			$"../AttackCooldown".start(9.0/11.0)
			
			var rays = [$Spread1, $Spread2, $Spread3, $Spread4, $Straight]
			for ray in rays:
				var body = ray.get_collider()
				if body != null and body.has_method("takeDamage"):
					var dir = -ray.global_transform.x.normalized()
					body.takeDamage(100, dir)
			
			$"../Weapons".stream = AudioFiles.sfx["shotgun_fire"]
			$Flash.show()
			$FlashTimer.start()
			$"../Weapons".play()
			return true
	
	if weapon == "smg":
		if !ammo[index] <= 0:
			ammo[index] -= 1
			$"../AttackCooldown".start(0.075)
			
			var straight = $Straight.get_collider()
			$"../Weapons".stream = AudioFiles.sfx["smg_fire"].pick_random()
			
			$Flash.show()
			$FlashTimer.start()
			
			if straight != null and straight.has_method("takeDamage"):
				var dir = straight.global_transform.x.normalized()
				straight.takeDamage(40, dir)
				
			$"../Weapons".play()
			return true
	
	if weapon == "revolver":
		if !ammo[index] <= 0:
			ammo[index] -= 1
			$"../AttackCooldown".start(0.975)
			
			var straight = $Straight.get_collider()
			$"../Weapons".stream = AudioFiles.sfx["revolver_fire"].pick_random()
			
			$Flash.show()
			$FlashTimer.start()
			
			if straight != null and straight.has_method("takeDamage"):
				var dir = straight.global_transform.x.normalized()
				straight.takeDamage(1000, dir)
			
			$"../Weapons".play()
			return true
	return false



func ammoCheck(array : Array, collider):
	var ammoAdd = array[0]
	var ammoType = array[1]
	
	if ammo[ammoType] >= maxAmmo[ammoType] and ammoType in heldWeapons:
		return
	
	if ammoType not in heldWeapons:
		heldWeapons.append(ammoType)
		heldWeapons.sort()
	
	ammo[ammoType] += ammoAdd
	if ammo[ammoType] > maxAmmo[ammoType]:
		ammo[ammoType] = maxAmmo[ammoType]
	
	collider.delAmmo()

func weaponSwitch():
	if Input.is_action_just_pressed("weaponUp"):
		if weaponIndex != heldWeapons.size() - 1:
			weaponIndex += 1
		else:
			weaponIndex = 0
		$"../AttackCooldown".stop()
		$"../Weapons".stream = AudioFiles.sfx["switch"]
		$"../Weapons".play()
		switch.emit()
		
	if Input.is_action_just_pressed("weaponDown"):
		if weaponIndex != 0:
			weaponIndex -= 1
		else:
			weaponIndex = heldWeapons.size() - 1
		$"../AttackCooldown".stop()
		$"../Weapons".stream = AudioFiles.sfx["switch"]
		$"../Weapons".play()
		switch.emit()
	
	return get_current_weapon()

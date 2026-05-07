extends Node2D

signal nextLevel
var completed = false

func _process(delta: float) -> void:
	if len(get_tree().get_nodes_in_group("enemies")) == 0:
		$levelChange.enableLight()
		completed = true

func _on_level_change_body_entered(body) -> void:
	print(body)
	if completed and body.is_in_group("player"):
		nextLevel.emit()

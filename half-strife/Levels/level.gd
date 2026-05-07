extends Node2D

signal nextLevel

func _process(delta: float) -> void:
	if len(get_tree().get_nodes_in_group("enemies")) == 0:
		$levelChange/door.enabled = true

func _on_level_change_body_entered(body) -> void:
	if $levelChange/door.enabled == true and body.is_in_group("player"):
		nextLevel.emit()

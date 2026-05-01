extends Timer

func _ready() -> void:
	set_wait_time(randf_range(5, 11))

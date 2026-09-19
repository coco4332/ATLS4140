extends Area2D

const MINION = preload("res://minions.tscn")

func _ready() -> void:
	global_position = get_global_mouse_position()
	%SummonCircle.global_rotation = 0
	%SummonCircle.play("default")
	await %SummonCircle.animation_finished

	var minion = MINION.instantiate()
	minion.global_position = global_position
	get_tree().current_scene.add_child(minion)

	queue_free()

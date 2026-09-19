extends Area2D

const MINION = preload("res://minions.tscn")

var spawn_position = Vector2.ZERO

func _ready() -> void:
	global_position = spawn_position
	%SummonCircle.global_rotation = 0
	%SummonCircle.play("default")
	await %SummonCircle.animation_finished

	var minion = MINION.instantiate()
	minion.global_position = spawn_position
	get_tree().current_scene.add_child(minion)
	
	queue_free()

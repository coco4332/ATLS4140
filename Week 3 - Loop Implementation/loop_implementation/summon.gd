extends Area2D

const MINION = preload("res://minions.tscn")

var spawn_position = Vector2.ZERO

func _ready() -> void:
	await get_tree().process_frame
	global_position = spawn_position

	# spawn the skeleton right away so both animations play together
	var minion = MINION.instantiate()
	get_tree().current_scene.add_child(minion)
	minion.global_position = spawn_position

	# both play at the same time
	%SummonCircle.play("default")

	# circle cleans itself up when its animation ends
	await %SummonCircle.animation_finished
	queue_free()

extends Area2D

var spawn_position = Vector2.ZERO

func _ready() -> void:
	await get_tree().process_frame
	global_position = spawn_position

	# no travel, no waiting for contact -- explode right where it landed
	%Spell.play("default")
	await explode()

	# let the cast animation finish, then clean up
	await %Spell.animation_finished
	queue_free()

func explode() -> void:
	%BlastArea/CollisionShape2D.set_deferred("disabled", false)
	await get_tree().physics_frame
	await get_tree().physics_frame

	var bodies = %BlastArea.get_overlapping_bodies()
	for target in bodies:
		if target.has_method("take_damage"):
			target.take_damage()

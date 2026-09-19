extends CharacterBody2D

var health = 3
var is_dead = false
var xp_reward = 10
var target = null
var is_hurt = false
var attack_range = 20
var attack_cooldown = 1.0
var can_attack = true

signal died(xp_value)

func _ready():
	%Orc.play("walk")

func _physics_process(delta: float) -> void:
	if is_dead or is_hurt:
		return

	target = get_nearest_target()

	if not target:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var dist = global_position.distance_to(target.global_position)

	if dist <= attack_range:
		velocity = Vector2.ZERO
		if can_attack:
			attack(target)
	else:
		var direction = global_position.direction_to(target.global_position)
		velocity = direction * 60
		%Orc.play("walk")
	move_and_slide()

func attack(enemy):
	can_attack = false

	%Orc.play("attack")
	await %Orc.animation_finished  

	if is_instance_valid(enemy) and enemy.has_method("take_damage"):
		enemy.take_damage()

	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func get_nearest_target():
	var targets = get_tree().get_nodes_in_group("friendly_targets")
	var nearest = null
	var nearest_dist = INF
	for t in targets:
		var dist = global_position.distance_to(t.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest = t
	return nearest

func die():
	is_dead = true
	set_physics_process(false)
	%Orc.play("death")
	await %Orc.animation_finished
	queue_free()

func take_damage():
	if is_dead:
		return
	health -= 1
	if health <= 0:
		died.emit(xp_reward)
		die()
	else:
		is_hurt = true
		velocity = Vector2.ZERO
		%Orc.play("hurt")
		await %Orc.animation_finished
		is_hurt = false
		%Orc.play("walk")

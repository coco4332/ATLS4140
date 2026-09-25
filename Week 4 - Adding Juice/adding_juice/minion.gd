extends CharacterBody2D

var health = 2
var is_dead = false
var target = null
var is_summoning = true
var is_hurt = false
var attack_range = 20
var attack_cooldown = 0.5
var can_attack = true

func _ready() -> void:
	add_to_group("friendly_targets")
	%MeleeSkeleton.play("summon")
	await %MeleeSkeleton.animation_finished
	is_summoning = false
	%MeleeSkeleton.play("walk")
	
func _physics_process(delta: float) -> void:
	if is_dead or is_summoning or is_hurt:
		return

	target = get_nearest_enemy()
	if not target:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var dist = global_position.distance_to(target.global_position)
	if dist <= attack_range:
		# In range: stop and attack
		velocity = Vector2.ZERO
		if can_attack:
			attack(target)
	else:
		# Out of range: chase
		var direction = global_position.direction_to(target.global_position)
		velocity = direction * 80
		if %MeleeSkeleton.animation != "attack":
			%MeleeSkeleton.play("walk")
	move_and_slide()

func attack(enemy):
	can_attack = false
	%MeleeSkeleton.play("attack")
	await %MeleeSkeleton.animation_finished
	

	# check the enemy still exists before damaging (it may have died)
	if is_instance_valid(enemy) and enemy.has_method("take_damage"):
		enemy.take_damage()
	
	%MeleeSkeleton.play("walk")

	# cooldown before next attack
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func get_nearest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var nearest = null
	var nearest_dist = INF
	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest = enemy
	return nearest
	
func take_damage():
	if is_dead:
		return
	health -= 1
	if health <= 0:
		die()
	else:
		is_hurt = true
		%MeleeSkeleton.play("hurt")
		velocity = Vector2(0,0)
		await %MeleeSkeleton.animation_finished
		is_hurt = false
		%MeleeSkeleton.play("walk")
		
func die():
	is_dead = true
	set_physics_process(false)
	%MeleeSkeleton.play("death")
	await %MeleeSkeleton.animation_finished 
	queue_free()

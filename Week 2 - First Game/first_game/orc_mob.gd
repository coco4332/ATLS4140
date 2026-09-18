extends CharacterBody2D

var health = 3
var is_dead = false
@onready var player = get_node("/root/Game/SoldierPlayer")

func _ready():
	%Orc.play("walk")

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300
	move_and_slide()

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
		die()
		const SMOKE_EXPLOSION = preload("uid://dhmhmrth6rdce")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
	else:
		%Orc.play("hurt")
		await %Orc.animation_finished 
		%Orc.play("walk")

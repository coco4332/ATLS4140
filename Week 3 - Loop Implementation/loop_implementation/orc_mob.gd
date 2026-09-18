extends CharacterBody2D

var health = 3
var is_dead = false
var xp_reward = 5
@onready var player = get_node("/root/Game/Player")

signal died(xp_value)

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
		died.emit(xp_reward)
		die()
		
	else:
		%Orc.play("hurt")
		await %Orc.animation_finished 
		%Orc.play("walk")

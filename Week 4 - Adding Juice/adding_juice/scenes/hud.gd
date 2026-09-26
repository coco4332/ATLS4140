extends CanvasLayer


func _on_player_health_depleted(current,max_hp) -> void:
	%HealthBar.max_value = max_hp
	%HealthBar.value = current

extends Control


var max_health = 6

func update_health_display():
	var current_health = %Player.health
	for i in range(max_health):
		var heart_sprite = $HBoxContainer.get_child(i)
		if i < current_health:
			heart_sprite.frame = 7  # Full heart
		else:
			heart_sprite.frame = 0  # Empty heart

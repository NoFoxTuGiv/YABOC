extends Control

#func _on_goquit_pressed() -> void:
	#get_tree().quit()

#func _on_play_again_pressed() -> void:
	#pass

func game_over():
	#play_again.grab_focus()
	visible = true # Show the menu
	get_tree().paused = true

func _process(_delta: float) -> void:
	pass

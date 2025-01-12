extends Control

@onready var vol_slider: HSlider = $MarginContainer/MarginContainer/VBoxContainer/vol_slider
@onready var mute_toggle: CheckButton = $MarginContainer/MarginContainer/VBoxContainer/MuteToggle
@onready var fs_toggle: CheckButton = $MarginContainer/MarginContainer/VBoxContainer/FSToggle
@onready var resolution_dd: OptionButton = $MarginContainer/MarginContainer/VBoxContainer/ResolutionDD
@onready var back_btn: Button = $MarginContainer/MarginContainer/VBoxContainer/BackBtn
@onready var mm_container: VBoxContainer = $"../MMContainer"


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED:
		if is_visible():
			back_btn.grab_focus()

func _on_back_btn_pressed() -> void:
	if get_parent():
		hide()
		mm_container.show()
		$"../MMContainer/Start".grab_focus()

func _on_resolution_selected(index: int) -> void:
	pass # Replace with function body.

func _on_fs_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.

func _on_vol_slider_value_changed(value: float) -> void:
	pass # Replace with function body.

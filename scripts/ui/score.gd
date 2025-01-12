extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("score_updated", _on_score_updated)
	text = "Score: %d" % Global.score

func _on_score_updated(new_score: int) -> void:
	text = "Score: %d" % new_score

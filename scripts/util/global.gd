extends Node

var score: int
var highScore: int
var rounds: int

signal score_updated(new_score: int)

func increment_score(points: int) -> void:
	score += points
	emit_signal("score_updated", score)

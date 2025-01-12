extends AudioStreamPlayer2D

@export var music_tracks: Array[AudioStream] = [preload("res://assets/sound/GameAudio1.mp3"), preload("res://assets/sound/GameAudio2.mp3"), preload("res://assets/sound/GameAudio3.mp3"), preload("res://assets/sound/GameAudio4.mp3"), preload("res://assets/sound/GameAudio5.mp3")]  # Assign your songs here
@export var shuffle: bool = true  # Enable shuffling, optional

var _current_track_index: int = -1  # Tracks the current song index

func _ready() -> void:
	if music_tracks.is_empty():
		print("No music tracks assigned!")
		return
	
	self.finished.connect(_on_finished)
	
	# Start the playlist
	play_next_song()

func play_next_song() -> void:
	# Pick the next track
	if shuffle:
		var new_index = randi() % music_tracks.size()
		while new_index == _current_track_index and music_tracks.size() > 1:
			new_index = randi() % music_tracks.size()
		_current_track_index = new_index
	else:
		_current_track_index = (_current_track_index + 1) % music_tracks.size()
	
	# Set the selected song and play it
	stream = music_tracks[_current_track_index]
	play()

func _on_finished() -> void:
	# Callback when a song finishes
	play_next_song()

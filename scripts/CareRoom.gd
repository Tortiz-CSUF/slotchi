### CareRoom.gd
extends Node2D



func _ready() -> void:
	# Sets game state to CARE
	GameManager.current_state = GameManager.GameState.CARE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

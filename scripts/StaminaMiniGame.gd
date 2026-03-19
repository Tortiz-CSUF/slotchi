### StaminaMiniGame.gd
extends Control

## UI Nodes
@onready var count_label: Label = $CountLabel
@onready var timer_label: Label = $TimerLabel
@onready var result_label: Label = $ResultLabel
@onready var instructions: Label = $Instructions
@onready var back_button: Label = $BackButton

## Game Settings
var game_duration: float = 5.0
var game_timer: float = 0.0
var tap_count: int = 0
var is_active: bool = false
var game_started: bool = false




func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass
	
	
func _input(event: InputEvent) -> void:
	
	
	
# Calcs Max HP gain based on tap count
func _finish_minigame() -> void:
	# Base HP gain = 1hp per 5 taps
	var base_gain: int = max(1, tap_count / 5)
	
	# Apply trainging multi
	var multiplier: float = MonsterData.get_training_multiplier()
	var final_gain:  int = max(1, int(base_gain * multiplier))
	
	# Apply stat gain
	MonsterData.max_hp += final_gain
	
	# show results
	result_label.text = "%d taps! Max HP +%d - %.1fx multi" % [tap_count, final_gain, multiplier]
	
	
func _on_back_pressed() -> void:
	GameManager.change_scene("res://scenes/care_room.tscn", GameManager.GameState.CARE)	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

### StaminaMiniGame.gd
extends Control

## UI Nodes
@onready var count_label: Label = $CountLabel
@onready var timer_label: Label = $TimerLabel
@onready var result_label: Label = $ResultLabel
@onready var instructions: Label = $Instructions
@onready var back_button: Button = $BackButton

## Game Settings
var game_duration: float = 5.0
var game_timer: float = 0.0
var tap_count: int = 0
var is_active: bool = false
var game_started: bool = false




func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	result_label.text = ""
	count_label.text = "0"
	timer_label.text = "5.0s"
	instructions.text = "Press SPACE to start!"


func _process(delta: float) -> void:
	if not is_active:
		return
		
	# count down
	game_timer -= delta
	timer_label.text = "%.1fs" % max(game_timer, 0.0)
	
	# Time expired
	if game_timer <= 0.0:
		is_active = false
		_finish_minigame()
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if not game_started:
			game_started = true
			is_active = true
			game_timer = game_duration
			instructions.text = "Mash SPACE as fast as you can!"
			tap_count = 0
		elif  is_active:
			tap_count += 1
			count_label.text = str(tap_count)
	
	
# Calcs Max HP gain based on tap count
func _finish_minigame() -> void:
	# Base HP gain = 1hp per 25 taps
	var base_gain: int = max(1, tap_count / 25)
	
	# Apply trainging multi
	var multiplier: float = MonsterData.get_training_multiplier()
	var final_gain:  int = max(1, int(base_gain * multiplier))
	
	# Apply stat gain
	MonsterData.max_hp += final_gain
	
	# show results
	result_label.text = "%d taps! Max HP +%d * %.1fx multi" % [tap_count, final_gain, multiplier]
	
	
func _on_back_pressed() -> void:
	GameManager.change_scene("res://scenes/care_room.tscn", GameManager.GameState.CARE)	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

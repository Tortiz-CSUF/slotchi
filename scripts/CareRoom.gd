### CareRoom.gd
extends Node2D


## UI Node References
@onready var hunger_bar: ProgressBar = $UI/TopLeftContainer/TopLeft/HungerBar
@onready var happiness_bar: ProgressBar = $UI/TopLeftContainer/TopLeft/HappinessBar
@onready var multiplier_label: Label = $UI/TopLeftContainer/TopLeft/MultiplierLabel
@onready var stats_label: Label = $UI/TopLeftContainer/TopLeft/StatusLabel
@onready var timer_label: Label = $UI/TimerContainer/TimerLabel
@onready var feed_button: Button = $UI/BottomBarContainer/BottomBar/FeedButton
@onready var play_button: Button = $UI/BottomBarContainer/BottomBar/PlayButton
@onready var train_button: Button = $UI/BottomBarContainer/BottomBar/TrainButton


func _ready() -> void:
	# Sets game state to CARE
	GameManager.current_state = GameManager.GameState.CARE
	
	# Start battle timer if not runnning
	if not GameManager.timer_running:
		GameManager.reset_battle_timer()
		
	# Connect button signals
	feed_button.pressed.connect(_on_feed_pressed)
	play_button.pressed.connect(_on_play_pressed)
	train_button.pressed.connect(_on_train_pressed)
	
	# Connect battle timer signal
	GameManager.battle_timer_expired.connect(_on_battle_timer_expired)
	
	# Update UI
	_update_ui()



func _process(delta: float) -> void:
	# Drain hunger and happiness over time
	MonsterData.drain_status(delta)
	
	# Update battle timer
	GameManager.update_battle_timer(delta)
	
	# Refresh all UI elements
	_update_ui()
	
	
## Refresh all UI elements to reflect curent data
func _update_ui() -> void:
	# Status bars
	hunger_bar.value = MonsterData.hunger
	happiness_bar.value = MonsterData.happiness
	
	# Multi display
	var mult: float = MonsterData.get_training_multiplier()
	multiplier_label.text = "Multiplier: %.1fx" % mult
	if mult > 1.0:
		multiplier_label.add_theme_color_override("font_color", Color.YELLOW)
	else: 
		multiplier_label.add_theme_color_override("font+color", Color.WHITE)
	
	# Stats Display
	stats_label.text = "STR: %d\nAGI: %d\nSTA: %d" % [
		MonsterData.atk, MonsterData.def, MonsterData.max_hp]
	
	# Battle timer
	timer_label.text = "BATTLE TIMER\n%s" % GameManager.get_timer_string()
	
	
## feed button to increase hunger
func _on_feed_pressed() -> void:
	MonsterData.feed()
		
	
## Play button increses happiness
func _on_play_pressed() -> void:
	MonsterData.play()
	
	
## Train button: transitions to training selection
func _on_train_pressed() -> void:
	GameManager.change_scene("res://scenes/train_select.tscn", GameManager.GameState.TRAINING)
	

## Battle timer expire: transitions to battle scene
func _on_battle_timer_expired() -> void:
	GameManager.change_scene("res://scenes/battle_arena.tscn", GameManager.GameState.BATTLE)
	
	
	
	
	
	
	
	
	
	

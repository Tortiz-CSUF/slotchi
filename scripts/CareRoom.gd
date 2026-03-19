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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
## Refresh all UI elements to reflect curent data
func _update_ui() -> void:
	# Status bars
	hunger_bar.value = MonsterData.hunger
	happiness_bar.value = MonsterData.happiness
	
	# Multi display
	var mult: float = MonsterData.get_training_multiplier()
	multiplier_label.text = "Multiplier: %.1fx" % mult
	
	# Stats Display
	stats_label.text = "STR: %d  |  AGI: %d  |  STA %d" % [
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
	pass ### will implement whe train scene is ready	
	

## Battle timer expire: transitions to battle scene
func _on_battle_timer_expired() -> void:
	### MUST INSERT BATTLE SCENE WHEN CREATED
	GameManager.change_scene("[INSERT SCENE HERE]", GameManager.GameState.BATTLE)
	
	
	
	
	
	
	
	
	
	

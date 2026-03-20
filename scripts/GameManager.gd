### GameData.gd
extends Node

## Autoload singleton that manages the battle timer, game state, and scene trans.

## BattleTimer (secs)
var battle_timer: float = 180.0
var timer_running: bool = false

## Game State Tracking
enum GameState { MENU, CARE, TRAINING, BATTLE }
var current_state: int = GameState.MENU

## Signals
signal battle_timer_expired				## emits when battle timer reaches zero


## Updates battle timer each frame. Called from care room
func update_battle_timer(delta: float) -> void:
	if timer_running and current_state == GameState.CARE:
		battle_timer -= delta
		if battle_timer <= 0.0:
			battle_timer = 0.0 
			timer_running = false
			battle_timer_expired.emit()


## Resets battle timer back to 3 mins (180 secs)
func reset_battle_timer() -> void:
	battle_timer = 180.0
	timer_running = true
	
	
## Returns battle timer in format MM:SS
func get_timer_string() -> String:
	var minutes: int = int(battle_timer) / 60
	var seconds: int = int(battle_timer) % 60
	return "%d:%02d" % [minutes, seconds]
	

## Changes scenes and updates game state
func change_scene(scene_path: String, new_state: int) -> void:
		current_state = new_state
		get_tree().change_scene_to_file(scene_path)
	
	

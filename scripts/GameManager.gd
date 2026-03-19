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



func update_battle_timer(delta: float) -> void:
	if timer_running and current_state == GameState.CARE:
		battle_timer -= delta
		if battle_timer <= 0.0:
			battle_timer = 0.0 
			timer_running = false
			battle_timer_expired.emit()

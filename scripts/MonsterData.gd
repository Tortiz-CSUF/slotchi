### MonsterData.gd
extends Node


## Autoload singleton that stores all persistent monster stats.
## Hunger/ Happiness will drain  overtime and affect trainging multipliers.

## Status Bars (0 - 100)
var hunger: float = 50.0
var happiness: float = 50.0

## Combat Stats
var atk: int = 5
var def: int = 5
var max_hp: int = 30
var current_hp: int = 30

## Status Drain Rate (points per sec)
var drain_rate: float = 1.0

# Feed/Play Increment Amt
var feed_amount: float = 20.0 
var play_amount: float = 20.0

## Calcs the training multiplier based on current stats.
## Each bar above 75% will grant a 1.5x multi.
func get_training_multiplier() -> float:
	var multiplier: float = 1.0
	if hunger > 75.0:
		multiplier *= 1.5
	if happiness > 75.0:
		multiplier *= 1.5
	return multiplier
	

## Feeds monster, increases hunger up to 100
func feed() -> void:
	hunger = min(hunger + feed_amount, 100.0)
	
	
## Plays with monster, increases happiness up to 100
func play() -> void:
	happiness = min(happiness + play_amount, 100.0)
	

## Drains hunger and happiness over time. Will be called by Care ROom
func drain_status(delta: float) -> void:
	hunger = max(hunger - drain_rate * delta, 0.0)
	happiness = max(happiness - drain_rate * delta, 0.0)
	

## Resets HP to max. Called at start of each battle. 
func reset_hp() -> void:
	current_hp = max_hp
	
	
	
	
	
	
	
	
	
	
	

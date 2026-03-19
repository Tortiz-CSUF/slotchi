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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

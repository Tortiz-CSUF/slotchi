### StrengthMiniGame.gd
extends Control

## Node Refs
@onready var power_bar: ProgressBar = $PowerBar
@onready var marker: ColorRect = $Marker
@onready var target_zone: ColorRect = $TargetZone
@onready var result_label: Label = $ResultLabel
@onready var back_button: Button = $BackButton


## Marker Movement
var marker_speed: float = 400.0			# pixels per sec
var marker_direction: int = 1 			# 1 = right, -1 = left
var bar_start_x: float = 0.0
var bar_end_x: float = 0.0
var is_active: bool = true				# true: mini game in progress




func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass
	
	
func _input(event: InputEvent) -> void:
	if not is_active:
		return
		
	# Press space to stop marker
	if event.is_action_pressed("ui_accept"):
		is_active = false
		
		
## Calcs how close the marker was stoped compared to target zone and awards ATK
func _calculate_result() -> void:
	# center target zone
	var target_center: float = target_zone.position.x + target_zone.size.x / 2.0
	var marker_center: float = marker.position.x + marker.size.x / 2.0
	
	# Dist from center (0 = perfect)
	var distance: float = abs(marker_center - target_center)
	var max_distance: float = (bar_end_x - bar_start_x) / 2.0
	
	# Score
	var accuracy: float = 1.0 - clamp(distance / max_distance, 0.0, 1.0)
	
	# Base ATK: can gain 1-5
	var base_gain: int = max(1, int(accuracy * 5))
	
	# Apply training multi from hunger and happiness
	var multiplier: float = MonsterData.get_training_multiplier()
	var final_gain: int = max(1, int(base_gain * multiplier))
	
	# Apply stats gain
	MonsterData.atk += final_gain
	
	# Show results
	result_label.text = "ATK +%d! (%.1fx mult)" % [final_gain, multiplier]
	

## Return to care room
func _on_back_pressed() -> void:
	GameManager.change_scene("res://scenes/care_room.tscn", GameManager.GameState.CARE)
	
	 

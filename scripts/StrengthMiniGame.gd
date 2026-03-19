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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

### AgilityMiniGame.gd
extends Control

## UI Nodes
@onready var prompt_label: Label = $PromptLabel
@onready var timer_bar: ProgressBar = $TimerBar
@onready var result_label: Label = $ResultLabel
@onready var round_label: Label = $RoundLabel
@onready var back_button: Button = $BackButton

## Round Settings
var total_rounds: int = 5
var current_round: int = 0
var successes: int = 0
var round_time: float = 1.5
var round_timer: float = 0.0
var is_active: bool = false
var waiting_for_input: bool = false

# Arrow Directions
var directions: Array = ["UP", "DOWN", "LEFT", "RIGHT"]
var current_direction: String = ""
var direction_actions: Dictionary ={
	"UP" : "ui_up",
	"DOWN" : "ui_down",
	"LEFT" : "ui_left",
	"RIGHT" : "ui_right"
}



func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass
	
	
func _input(event: InputEvent) -> void:
	
	

func _start_round() -> void:
	


func _next_round() -> void:
	
	

func _finish_minigame() -> void:
	
	
	
func _on_back_pressed() -> void:
	GameManager.change_scene("res://scenes/care_room.tscn", GameManager.GameState.CARE)
	
	
	
	
	
	
	
	
	
	
	

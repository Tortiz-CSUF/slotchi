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
	back_button.pressed.connect(_on_back_pressed)
	result_label.text = ""
	prompt_label.text = ""
	round_label.text = ""
	
	# Start first round
	await  get_tree().create_timer(0.5).timeout
	_start_round()


func _process(delta: float) -> void:
	if not is_active:
		return
	
	# Countdown reaction timer
	round_timer -= delta
	timer_bar.value = (round_timer / round_time) * 100.0
	
	# Time expired
	if round_timer <= 0.0:
		is_active = false
		waiting_for_input = false
		prompt_label.text = "MISS!"
		_next_round()
	
	
func _input(event: InputEvent) -> void:
	if not waiting_for_input:
		return
		
	# check if correct arrow was pressed
	if event.is_action_pressed(direction_actions[current_direction]):
		is_active = false
		waiting_for_input = false
		successes += 1
		prompt_label.text = "HIT!"
		_next_round()
	#wrong key pressed
	elif event is InputEventKey and event.pressed:
		for dir in directions:
			if dir != current_direction and event.is_action_pressed(direction_actions[dir]):
				is_active = false
				waiting_for_input = false
				prompt_label.text = "WRONG!"
				_next_round()
				return		
		
	
## Starts new round with random dir
func _start_round() -> void:
	current_round += 1
	round_label.text = "Round %d of %d" % [current_round, total_rounds]
	
	# Picks random dir
	current_direction = directions[randi() % directions.size()]
	prompt_label.text = current_direction
	
	# Reset Time
	round_timer = round_time
	timer_bar.value = 100.0
	is_active = true
	waiting_for_input = true
	

## Waits then starts next round or finishes
func _next_round() -> void:
	await  get_tree().create_timer(0.7).timeout
	
	if current_round >= total_rounds:
		_finish_minigame()
	else: 
		_start_round()
	
	
## Calcs DEF gain and shows results
func _finish_minigame() -> void:
	# base DEF gain = 1 per success
	var base_gain: int = successes
	
	# Apply training multi
	var multiplier: float = MonsterData.get_training_multiplier()
	var final_gain: int = max(1, int(base_gain * multiplier))
	
	# Apply stat gain
	MonsterData.def += final_gain
	
	# Show result
	prompt_label.text = ""
	round_label.text = ""
	result_label.text = "%d of %d hits! DEF +%d - %.1fx multi" % [successes, total_rounds, final_gain, multiplier]
	
	
func _on_back_pressed() -> void:
	GameManager.change_scene("res://scenes/care_room.tscn", GameManager.GameState.CARE)
	
	
	
	
	
	
	
	
	
	
	

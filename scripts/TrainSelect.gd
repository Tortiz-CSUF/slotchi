### TrainSelect.gd
extends Control

## Buttons
@onready var strength_btn: Button = $VBoxContainer/StrengthButton
@onready var agility_btn: Button = $VBoxContainer/AgilityButton
@onready var stamina_btn: Button = $VBoxContainer/StaminaButton
@onready var back_btn: Button = $BackButton


func _ready() -> void:
	strength_btn.pressed.connect(_on_strength)
	agility_btn.pressed.connect(_on_agility)
	stamina_btn.pressed.connect(_on_stamina)
	back_btn.pressed.connect(_on_back)


## On_Pressed Buttons functions
func _on_strength() -> void:
	GameManager.change_scene("res://scenes/strength_mini_game.tscn", GameManager.GameState.TRAINING)
	
	
func _on_agility() -> void:
	### INSERT AGILITY TRAIN SCENE PATH WHEN CREATED
	GameManager.change_scene("INSERT SCENE", GameManager.GameState.TRAINING)
	

func _on_stamina() -> void:
	### INSERT STAMINA TRAIN SCENE PATH WHEN CREATED
	GameManager.change_scene("INSERT SCENE", GameManager.GameState.TRAINING)
	
	
func _on_back() -> void:
	GameManager.change_scene("res://scenes/care_room.tscn", GameManager.GameState.CARE)
	
	
	
	

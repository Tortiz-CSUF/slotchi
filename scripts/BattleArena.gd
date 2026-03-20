### BattleArena.gd
extends Control

## UI Nodes
@onready var player_hp_bar: ProgressBar = $PlayerSideContainer/PlayerSide/PlayerHPBar
@onready var enemy_hp_bar: ProgressBar = $EnemySideContainer/EnemySide/EnemyHPBar
@onready var intent_icon: Label = $EnemySideContainer/EnemySide/IntentIcon
@onready var slot_grid: GridContainer = $SlotGrid
@onready var card1: Button = $CardContainer/Card/Card1
@onready var card2: Button = $CardContainer/Card/Card2
@onready var card3: Button = $CardContainer/Card/Card3
@onready var spin_button: Button = $SpinButton
@onready var info_label: Label = $InfoLabel
@onready var end_panel: ColorRect = $EndPanel
@onready var end_label: Label = $EndPanel/EndLabel
@onready var return_button: Button = $EndPanel/ReturnButton

## Icon Textures
var sword_icon: Texture2D = preload("res://assets/sprites/icons/sword.png")
var shield_icon: Texture2D = preload("res://assets/sprites/icons/shield.png")
var heart_icon: Texture2D = preload("res://assets/sprites/icons/heart.png")
var skull_icon: Texture2D = preload("res://assets/sprites/icons/skull.png")

## Symbol Pool
var symbol_pool: Array = []
var base_pool: Array = []

## Enemy State
var enemy_max_hp: int = 50
var enemy_hp: int = 50
var enemy_intent: String = "" 		## attack or sabotage

## Spin Sate
var is_spinning: bool = false
var spin_timer: float = 0.0
var spin_duration: float = 1.5
var spin_interval: float = 0.05			## amt slots randomzie
var spin_tick: float = 0.0

## Turn State
var card_selected: bool = false
var battle_over: bool = false

## Refs to slot textures
var slots: Array = []



func _ready() -> void:
	# Set game state
	GameManager.current_state = GameManager.GameState.BATTLE
	
	# Reset Player HP for new battle
	MonsterData.reset_hp()
	
	# Hide end panel
	end_panel.visible = false
	info_label.text = ""
	
	# Connect return button
	return_button.pressed.connect(_on_return_pressed)
	
	# Scale enemy hp
	enemy_max_hp = 30 + MonsterData.max_hp
	enemy_hp = enemy_max_hp
	
	# Panel fade
	end_panel.modulate.a = 0.0
	
	# Get all 16 slot texture from grid
	for i in range(16):
		slots.append(slot_grid.get_node("Slot" + str(i)))
		
	# Build base symbol pool
	base_pool = [sword_icon, sword_icon, shield_icon, shield_icon, heart_icon, heart_icon]
	_reset_pool()
	


## Return to care room
func _on_return_pressed() -> void:
	GameManager.reset_battle_timer()
	GameManager.change_scene("res://scenes/care_room.tscn", GameManager.GameState.CARE)




## resets symbol pool 
func _reset_pool() -> void:
	symbol_pool = base_pool.duplicate()
		

## Fills all slots with ranom icons
func _randomize_grid() -> void:
	for slot in slots:
		slot.texture = symbol_pool[randi() % symbol_pool.size()]
	

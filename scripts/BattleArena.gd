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
	
	# Connect card to spin 
	
	


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
	
	
## called when player picks card to add pool symbols
func _on_card_pressed(card_type: String) -> void:
	if card_selected or is_spinning or battle_over:
		return
		
	card_selected = true
	
	# add 3 chosen symbols to pool to increase odds
	match card_type:
		"sword":
			for i in range(3):
				symbol_pool.append(sword_icon)
			info_label.text = "Added Swords to the pool!"
		"shield":
			for i in range(3):
				symbol_pool.append(shield_icon)
			info_label.text = "Added Shields to the pool!"	
		"heart":
			for i in range(3):
				symbol_pool.append(heart_icon)
			info_label.text = "Added Hearts to the pool!"	
	
	## enable spin button after card is slected
	spin_button.disabled = false
	
	## disable card buttons
	card1.disabled = true
	card2.disabled = true
	card3.disabled = true
	
	
	## starts slot machine spin
func _on_spin_pressed() -> void:
	if is_spinning or not card_selected or battle_over:
		return
			
	# lock input
	is_spinning = true
	spin_timer = 0.0
	spin_tick = 0.0
	spin_button.disabled = true
	info_label.text = "Spinning..."


## Called when spin finishes
func _finalize_spin() -> void:
	# final randomizer to set results
	_randomize_grid()
	
	# 	count sumbols on the grid
	var sword_count: int = 0
	var shield_count: int = 0
	var heart_count: int = 0
	var skull_count: int = 0
	
	for slot in slots:
		if slot.texture == sword_icon:
			sword_count += 1
		elif slot.texture == shield_icon:
			shield_count += 1
		elif slot.texture == heart_icon:
			heart_count += 1
		elif slot.texture == skull_icon:
			skull_count += 1
			
	# Calc player actions
	var player_damage: int = sword_count * (2 + MonsterData.atk / 5)
	var player_defense: int = shield_count * (1 + MonsterData.def / 5)
	var player_heal: int = heart_count * 2
	var skull_damage: int = skull_count * 2
	
	# Calcs enemy actions
	var enemy_damage: int = 0
	if enemy_intent == "attack":
		enemy_damage = 5 + randi() % 4
		
	# Apply results
	enemy_hp = max(0, enemy_hp - player_damage)
	
	
			
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

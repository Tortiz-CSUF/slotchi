### MainMenu.gd
extends Control



func _ready() -> void:
	$VBoxContainer/StartButton.pressed.connect(_on_start_pressed)
	$VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_start"):
		_on_start_pressed()
	elif event.is_action_pressed("ui_quit"):
		_on_quit_pressed()
	
	
func _on_start_pressed() -> void:
	### MUST SWAP IN CARE ROOM SCENE ONCE IMPLEMENTED
	GameManager.change_scene("[INPUT CARE ROOM SCENE HERE]", GameManager.GameState.CARE)


func _on_quit_pressed() -> void:
	get_tree().quit()

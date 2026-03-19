### PlayerS;ime.gd
extends AnimatedSprite2D


## UI Node References
@onready var hunger_bar: ProgressBar = $UI/TopLeftContainer/TopLeft/HungerBar
@onready var happiness_bar: ProgressBar = $UI/TopLeftContainer/TopLeft/HappinessBar
@onready var multiplier_label: Label = $UI/TopLeftContainer/TopLeft/MultiplierLabel
@onready var stats_label: Label = $UI/TopLeftContainer/TopLeft/StatusLabel
@onready var timer_label: Label = $UI/TimerContainer/TimerLabel
@onready var feed_button: Button = $UI/BottomBarContainer/BottomBar/FeedButton
@onready var play_button: Button = $UI/BottomBarContainer/BottomBar/PlayButton
@onready var train_button: Button = $UI/BottomBarContainer/BottomBar/TrainButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

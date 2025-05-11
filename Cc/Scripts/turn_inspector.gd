extends Label

@onready var map : Node2D
func initialize(parent):
	map = parent
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over():
	map.is_game_over = true
	if Global.is_red_turn == true:
		text = "红方胜利"
	else:
		text = "黑方胜利"

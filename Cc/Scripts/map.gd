extends Node2D

@onready var grid_manager: Node = $GridManager
@onready var chess_manager: Node = $ChessManager
@onready var turn_inspector: Label = $turn_inspector

var is_game_over : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_game_over:
		if Global.is_red_turn:
			turn_inspector.text = "当前轮到红"
		else:
			turn_inspector.text = "当前轮到黑"
		

func GetChess(index : Vector2i):
	for chess in chess_manager.get_children() :
		if chess.index == index :
			return chess
	return null
			

func initialize() :
	for Manager in get_children() :
		Manager.initialize(self)

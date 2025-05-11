extends Node2D

var index : Vector2i

var grid : Node2D

@export var chess : Global.chess

var grid_manager : Node

@export var RedOrBlack : bool

@onready var circle: Sprite2D = $circle

func _ready() -> void:
	index = Vector2i(int(position.x - Global.StartPosition.x)/Global.gap , int(position.y - Global.StartPosition.y)/Global.gap)

func initialize(Parent) :
	grid_manager = Parent

func change_circle_visible():
	circle.visible = not circle.visible

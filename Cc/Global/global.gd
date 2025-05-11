extends Node

var gap : int = 24

var StartPosition : Vector2 = Vector2(12,12)

enum chess{
	将,
	士,
	卒,
	炮,
	车,
	马,
	象
}

var CurrentChess : Node2D

var is_red_turn : bool = true

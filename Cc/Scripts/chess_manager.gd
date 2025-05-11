extends Node

var map : Node2D

func initialize(Parent) :
	map = Parent
	for chess in get_children() :
		chess.initialize(self)

extends Node

var map : Node2D

func initialize(Parent) :
	map = Parent
	for grid in get_children() :
		grid.initialize(self)

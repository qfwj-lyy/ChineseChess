extends Node2D

var index : Vector2i

var chess : Node2D

var grid_manager : Node

var MouseIn : bool = false

#region 显示棋子的可移动区域的函数与变量
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
func Moveable() :
	sprite_2d_2.visible = !sprite_2d_2.visible
#endregion

func initialize(Parent) :
	grid_manager = Parent
	index = Vector2i(int(position.x - Global.StartPosition.x)/Global.gap , int(position.y - Global.StartPosition.y)/Global.gap)
	chess = grid_manager.map.GetChess(index)

func update_chess():
	chess = grid_manager.map.GetChess(index)
	
func _on_area_2d_mouse_entered() -> void:
	MouseIn = true

func _on_area_2d_mouse_exited() -> void:
	MouseIn = false

func inspect_road(places:Array):
	if places == []:
		print('1')
		return 0
	var chess_number : int = 0
	for place in places:
		if grid_manager.map.GetChess(place) != null:
			chess_number += 1
	return chess_number
func inspect():
	var map=grid_manager.map
	var chess_now = Global.CurrentChess
	# 检测是否轮到该颜色
	if chess_now.RedOrBlack != Global.is_red_turn:
		return false
	if chess_now.chess == Global.chess.卒:
		if Global.is_red_turn == true:
			if chess_now.index.y >=5:
				if not (index == chess_now.index + Vector2i(0,1) or index == chess_now.index + Vector2i(1,0) or index == chess_now.index + Vector2i(-1,0) ):
					return false
			else:
				if index != chess_now.index+Vector2i(0,1):
					return false
		else:
			if chess_now.index.y <=4:
				if not (index == chess_now.index + Vector2i(0,-1) or index == chess_now.index + Vector2i(1,0) or index == chess_now.index + Vector2i(-1,0) ):
					return false
			else:
				if index != chess_now.index+Vector2i(0,-1):
					return false
	elif chess_now.chess == Global.chess.将:
		if Global.is_red_turn == true:
			if index.x <3 or index.x > 5 or index.y > 2:
				return false
			elif index.distance_to(chess_now.index) != 1:
				return false
		else:
			if index.x <3 or index.x > 5 or index.y < 7:
				return false
			elif index.distance_to(chess_now.index) != 1:
				return false
	elif chess_now.chess == Global.chess.士:
		if not (index.distance_squared_to(chess_now.index)==2 ):
			return false
	elif chess_now.chess == Global.chess.象:
		if index.distance_squared_to(chess_now.index) != 8:
			return false
		if Global.is_red_turn == true:
			if index.y >= 5:
				return false
			var middle_places : Array[Vector2i]= []
			middle_places.append((chess_now.index + index)/2) 
			if inspect_road(middle_places) == 1:
				return false
		else:
			if index.y <= 4:
				return false
			var middle_places : Array[Vector2i]= []
			middle_places.append((chess_now.index + index)/2) 
			if inspect_road(middle_places) == 1:
				return false
	elif chess_now.chess == Global.chess.马:
		print("马")
		if chess_now.index.distance_squared_to(index) != 5:
			return false
		#var places = []
		if index.y == chess_now.index.y -2:
			if inspect_road([chess_now.index+Vector2i(0,-1)])==1:
				return false
		if index.y == chess_now.index.y +2:
			if inspect_road([chess_now.index+Vector2i(0,1)])==1:
				return false
		if index.x == chess_now.index.x +2:
			if inspect_road([chess_now.index+Vector2i(1,0)])==1:
				return false
		if index.x == chess_now.index.x -2:
			if inspect_road([chess_now.index+Vector2i(-1,0)])==1:
				return false
	elif chess_now.chess == Global.chess.车:
		if index.x != chess_now.index.x and index.y != chess_now.index.y:
			return false
		if index.x == chess_now.index.x:
			var minn : int = min(index.y,chess_now.index.y)
			var maxn : int = max(index.y,chess_now.index.y)
			var place_range : Array[Vector2i] = []
			for i in range(minn+1,maxn):
				place_range.append(Vector2i(index.x,i))
			if inspect_road(place_range)!=0:
				return false
		else:
			var minn : int = min(index.x,chess_now.index.x)
			var maxn : int = max(index.x,chess_now.index.x)
			var place_range : Array[Vector2i] = []
			for i in range(minn+1,maxn):
				place_range.append(Vector2i(i,index.y))
			if inspect_road(place_range)!=0:
				return false
	elif chess_now.chess == Global.chess.炮:
		if index.x != chess_now.index.x and index.y != chess_now.index.y:
			return false
		if index.x == chess_now.index.x:
			var minn : int = min(index.y,chess_now.index.y)
			var maxn : int = max(index.y,chess_now.index.y)
			var place_range : Array[Vector2i] = []
			for i in range(minn+1,maxn):
				place_range.append(Vector2i(index.x,i))
			if inspect_road(place_range)>1:
				return false
			if inspect_road(place_range)==1:
				if not chess:
					return false
			if inspect_road(place_range)==0:
				if chess:
					return false
		else:
			var minn : int = min(index.x,chess_now.index.x)
			var maxn : int = max(index.x,chess_now.index.x)
			var place_range : Array[Vector2i] = []
			for i in range(minn+1,maxn):
				place_range.append(Vector2i(i,index.y))
			if inspect_road(place_range)>1:
				return false
			if inspect_road(place_range)==1:
				if not chess:
					return false
			if inspect_road(place_range)==0:
				if chess:
					return false
	print("could go")
	return true
	
func _input(event: InputEvent) -> void:
	if MouseIn and Input.is_action_just_pressed("Left_Click") :
		if Global.CurrentChess :
			print(1)
			if chess:
				if chess.RedOrBlack == Global.CurrentChess.RedOrBlack:
					Global.CurrentChess.change_circle_visible()
					chess.change_circle_visible()
					Global.CurrentChess = chess
					return
			if inspect() == false:
				return
			if chess :
				if chess.chess == Global.chess.将:
					grid_manager.map.turn_inspector.game_over()
				chess.queue_free()
			chess = Global.CurrentChess
			chess.position = position
			chess.index = index
			chess.change_circle_visible()
			for grid in grid_manager.get_children():
				grid.update_chess()
			Global.CurrentChess = null
			Global.is_red_turn = not Global.is_red_turn
		else :
			print(2)
			if chess :
				print(3)
				if Global.is_red_turn == chess.RedOrBlack:
					Global.CurrentChess = chess
					chess.change_circle_visible()

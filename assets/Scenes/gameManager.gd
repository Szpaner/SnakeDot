extends Node2D
class_name GameManager

var points = 0
@onready var ui : UI = get_node("/root/Game/UICanvas/UI")

var grid = []
var gWidth = 17
var gHeight = 9

func _init():
	for i in gWidth:
		grid.append([])
		for j in gHeight:
			grid[i].append(null)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func addPoints(i: int):
	points += i
	ui.updatePointsText(points)

func checkCollision(v : Vector2) -> Object:
	var x = int(v.x/64)
	var y = int(v.y/64)
	return grid[x][y]

func updateGrid(v: Vector2, o: Object) :
	var x = int(v.x/64)
	var y = int(v.y/64)
	grid[x][y] = o

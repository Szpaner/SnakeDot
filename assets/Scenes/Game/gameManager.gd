extends Node2D
class_name GameManager
@onready var UICanvas = $Camera/UICanvas

var points = 0
@onready var ui : UI = $Camera/UICanvas/UI

var pause_menu : Control = null

var isPaused = false
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
	if Input.is_action_just_pressed("menu"):
		pauseMenu()

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


func pauseMenu():
	var pause_menu_proto = load("res://assets/Scenes/Menu/PauseMenu/pauseMenu.tscn")
	pause_menu = pause_menu_proto.instantiate() as Control
	pause_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	pause_menu.set_name("PauseMenu")
	UICanvas.add_child(pause_menu)
	pause_menu.resume_game.connect(_on_pause_menu_resume_game)
	get_tree().paused = true
	isPaused = true

func _on_pause_menu_resume_game():
	pause_menu.queue_free()
	get_tree().paused = false
	isPaused = false

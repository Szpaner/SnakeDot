extends Area2D
class_name Apple

var spawnPos : Vector2 = Vector2()
var appleType : String = "normal"

var gm : GameManager = null

func _ready():
	changePosition()

func changePosition():
	getGameManager().updateGrid(position, null)
	spawnPos.x = randi_range(-8,8)*64
	spawnPos.y = randi_range(-4,4)*64
	while (getGameManager().checkCollision(spawnPos) != null):
		spawnPos.x = randi_range(-8,8)*64
		spawnPos.y = randi_range(-4,4)*64
	position = spawnPos
	print (position)
	getGameManager().updateGrid(position, self)

func getGameManager():
	if gm == null:
		gm = get_node("/root/Game")
	return gm

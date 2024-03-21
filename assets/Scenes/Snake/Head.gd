extends CharacterBody2D
class_name SnakeHeadCharBody

@onready var playerSprite : AnimatedSprite2D = $HeadSprite
@onready var headCol : CollisionShape2D = $HeadCol
var snake : Snake
var vel : Vector2
var gm : GameManager = null

func move(v: Vector2):
	vel = v
	getGameManager().updateGrid(position, null)
	position = position + v
	getGameManager().updateGrid(position, self)
	manageAnimations()

func manageAnimations():
	if vel.x < 0:
		playAnimations("MoveLeft")
	elif vel.y > 0:
		playAnimations("MoveDown")
	elif vel.y < 0:
		playAnimations("MoveUp")
	else:
		playAnimations("MoveRight")


func playAnimations(animName):
	
	if playerSprite.animation != animName:
		playerSprite.play(animName)
	
func getParent() -> Snake:
	if (snake == null):
		snake = get_parent()
	return snake

func getGameManager():
	if gm == null:
		gm = get_node("/root/Game")
	return gm

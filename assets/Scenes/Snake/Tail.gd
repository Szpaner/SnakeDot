extends Area2D
class_name SnakeTailCharBody

@onready var playerSprite : AnimatedSprite2D = $TailSprite
@onready var tailCol : CollisionShape2D = $TailCol

var vel : Vector2

var gm : GameManager = null

func move(v: Vector2, nextVel: Vector2):
	vel = nextVel
	getGameManager().updateGrid(position, null)
	position = position + v
	getGameManager().updateGrid(position, self)
	manageAnimations()

func manageAnimations():
	if vel.x < 0:
		playAnimations("PointRight")
	elif vel.y > 0:
		playAnimations("PointUp")
	elif vel.y < 0:
		playAnimations("PointDown")
	else:
		playAnimations("PointLeft")


func playAnimations(animName):
	
	if playerSprite.animation != animName:
		playerSprite.play(animName)
	
func getGameManager():
	if gm == null:
		gm = get_node("/root/Game")
	return gm

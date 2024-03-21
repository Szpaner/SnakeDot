extends Area2D
class_name SnakeBodyCharBody

var playerSprite : AnimatedSprite2D
var vel : Vector2
var nextVel : Vector2
var gm : GameManager = null

@onready var bodyCol : CollisionShape2D = $BodyCol

func move(v: Vector2, nV: Vector2):
	vel = v
	nextVel = nV
	getGameManager().updateGrid(position, null)
	position = position + v
	getGameManager().updateGrid(position, self)
	manageAnimations()
	
func _ready():
	playerSprite = find_child("BodySprite")
	
func copyAttributes(sbcb: SnakeBodyCharBody):
	setPosition(sbcb.position)
	vel = sbcb.vel
	nextVel = sbcb.nextVel
	manageAnimations()
	
func setPosition(p: Vector2):
	position = p
	
func manageAnimations():
	if vel.x > 0 and nextVel.y > 0 or vel.y < 0 and nextVel.x < 0:
		playAnimations("LeftDown")
	elif vel.x < 0 and nextVel.y < 0 or vel.y > 0 and nextVel.x > 0:
		playAnimations("RightUp")
	elif vel.x < 0 and nextVel.y > 0 or vel.y < 0 and nextVel.x > 0:
		playAnimations("RightDown")
	elif vel.x > 0 and nextVel.y < 0 or vel.y > 0 and nextVel.x < 0:
		playAnimations("LeftUp")
	elif vel.y != 0 and nextVel.y != 0:
		playAnimations("Vertical")
	elif vel.x != 0 and nextVel.x != 0:
		playAnimations("Horizontal")
	
func playAnimations(animName):
	if playerSprite.animation != animName:
		playerSprite.play(animName)
	
func getGameManager():
	if gm == null:
		gm = get_node("/root/Game")
	return gm



func _on_body_entered(body):
	print("test")
	#pass # Replace with function body.

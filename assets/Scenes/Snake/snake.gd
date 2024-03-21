extends Node2D
class_name Snake

var moveSpeed: int = 64

var vel : Array = Array()
var bodies : Array = Array()
var facingDir : Vector2 = Vector2()
var lastActionPressed : String = "move_right"

var hasEaten : bool = false
var eatenCount : float = 0.0

var timeMultiplier : float = 4


@onready var timer = $Timer
@onready var head : SnakeHeadCharBody = $Head
@onready var tail : SnakeTailCharBody = $Tail


@export var nextMoveDelay : float = 1.0
var currentDelay : float

var gameManager : GameManager = null

func _ready():
	currentDelay = nextMoveDelay
	bodies.push_back($Body)
	var i = 0
	while i < bodies.size() + 1:
		vel.push_front(Vector2.ZERO)
		i += 1
		
	timer.start();

func _process(delta):
	#inputs
	#vel = Vector2()
	
	if Input.is_action_pressed("move_up") and vel[0].y == 0:
		lastActionPressed = "move_up"
	elif Input.is_action_pressed("move_down") and vel[0].y == 0:
		lastActionPressed = "move_down"
	if Input.is_action_pressed("move_left") and vel[0].x == 0:
		lastActionPressed = "move_left"
	if Input.is_action_pressed("move_right") and vel[0].x == 0:
		lastActionPressed = "move_right"
	
	currentDelay -= delta
	if currentDelay <= 0:
		handleMovement()
		currentDelay = nextMoveDelay

func _on_timer_timeout():
	pass

func handleMovement():
	var nextVel : Vector2 = Vector2()
	if lastActionPressed == "move_up":
		nextVel.y = 1
		nextVel.x = 0
		facingDir = Vector2(0,-1)
	if lastActionPressed == "move_down":
		nextVel.y = -1
		nextVel.x = 0
		facingDir = Vector2(0,1)
	if lastActionPressed == "move_left":
		nextVel.y = 0
		nextVel.x = -1
		facingDir = Vector2(-1,0)
	if lastActionPressed == "move_right":
		nextVel.y = 0
		nextVel.x = 1
		facingDir = Vector2(1,0)
	
	nextVel = nextVel.normalized()
	nextVel = nextVel*moveSpeed
	
	
	vel.push_front(nextVel)
	if hasEaten:
		hasEaten = false
		bodies[0].move(vel[1], vel[0])
	else:	
		var j = 0
		for i in range(bodies.size()):
			if(vel[i+1] == Vector2.ZERO):
				bodies[i].move(Vector2(1,0).normalized()*moveSpeed, vel[j])
			else:
				bodies[i].move(vel[i+1], vel[i])
			j = i
		if(vel[j+2] == Vector2.ZERO):
			tail.move(Vector2(1,0).normalized()*moveSpeed, vel[j+1])
		else:
			tail.move(vel[j+2], vel[j+1])
		
		
		if(vel.size()+2 > bodies.size()):
			vel.pop_back()
	
	var headCollider = getGameManager().checkCollision(head.position+nextVel)
	if headCollider != null and headCollider.is_in_group("SnakePart"):
		die()
	elif headCollider != null and headCollider.is_in_group("Apple"):
		eatApple(headCollider)
		head.move(nextVel)
	else:
		head.move(nextVel)

func eatApple(apple : Apple):
	getGameManager().addPoints(1)
	eatenCount += 1
	spawnBodyPart()
	speedUp()
	apple.changePosition()
	
func spawnBodyPart():
	var newBody = load("res://assets/Scenes/Snake/body.tscn")
	var newBodyInstance = newBody.instantiate() as SnakeBodyCharBody
	newBodyInstance.set_name("Body")
	add_child(newBodyInstance)
	newBodyInstance.copyAttributes(bodies[0])
	
	bodies.push_front(newBodyInstance)
	hasEaten = true

func getGameManager() -> GameManager:
	if gameManager == null:
		gameManager = get_parent()
	return gameManager

func speedUp():
	nextMoveDelay = timeMultiplier/(eatenCount+timeMultiplier)
	#timer.wait_time = timeMultiplier/(eatenCount+timeMultiplier)
	#print(timer.wait_time)

func die():
	queue_free()

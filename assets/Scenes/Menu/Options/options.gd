extends Control

const INPUT_ACTIONS = [ "move_up", "move_down", "move_left", "move_right", "menu" ]
const CONFIG_FILE = "user://config.cfg"

@onready var rebindCont : BoxContainer = $RebindContainer
@onready var inpName : Label = $RebindContainer/RebindPanel/InputName
@onready var upBtn : Button = $HBoxContainer/LPanel/GridContainer/UpButton
@onready var downBtn : Button = $HBoxContainer/LPanel/GridContainer/DownButton
@onready var leftBtn : Button = $HBoxContainer/LPanel/GridContainer/LeftButton
@onready var rightBtn : Button = $HBoxContainer/LPanel/GridContainer/RightButton
@onready var menuBtn : Button = $HBoxContainer/LPanel/GridContainer/MenuButton

var action : String
var curBtn : Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func _input(event):
	if event is InputEventKey:
		set_process_input(false)
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, event)
		rebindCont.visible = false
		curBtn.button_pressed = false
		curBtn.text = event.as_text()

func _on_up_button_toggled(toggled_on):
	inpName.text="UP"
	rebindCont.visible = true
	action = "move_up"
	curBtn = upBtn
	set_process_input(true)


func _on_down_button_toggled(toggled_on):
	inpName.text="DOWN"
	rebindCont.visible = true
	action = "move_down"
	curBtn = downBtn
	set_process_input(true)


func _on_left_button_toggled(toggled_on):
	inpName.text="LEFT"
	rebindCont.visible = true
	action = "move_left"
	curBtn = leftBtn
	set_process_input(true)


func _on_right_button_toggled(toggled_on):
	inpName.text="RIGHT"
	rebindCont.visible = true
	action = "move_right"
	curBtn = rightBtn
	set_process_input(true)


func _on_menu_button_toggled(toggled_on):
	inpName.text="MENU"
	rebindCont.visible = true
	action = "menu"
	curBtn = menuBtn
	set_process_input(true)

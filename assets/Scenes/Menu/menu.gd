extends Control


@onready var gameMenu : VBoxContainer = $GameMenu
@onready var options : Control = $Options

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameMenu/StartButton.grab_focus()



func _on_start_pressed():
	get_tree().change_scene_to_file("res://assets/Scenes/Game/game.tscn")


func _on_options_pressed():
	gameMenu.hide()
	options.show()


func _on_quit_pressed():
	get_tree().quit()


func _on_options_2_closed_options():
	options.hide()
	gameMenu.show()

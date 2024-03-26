extends Control

signal resume_game

@onready var gameMenu : VBoxContainer = $GameMenu
@onready var options : Control = $Options

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameMenu/ResumeButton.grab_focus()

func _on_quit_pressed():
	get_tree().quit()


func _on_options_2_closed_options():
	options.hide()
	gameMenu.show()


func _on_resume_button_pressed():
	print("emiting resume")
	resume_game.emit()


func _on_options_button_pressed():
	gameMenu.hide()
	options.show()

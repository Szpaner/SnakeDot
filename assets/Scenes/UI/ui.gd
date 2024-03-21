extends Control
class_name UI

@onready var pointsText : Label = $Points

func updatePointsText(points):
	pointsText.text = str("Points: ", points)

extends CanvasLayer

signal start_game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_game_over():
	init_message("Game Over")
	# wait until the MessageTimer has counted down
	yield($MessageTimer, "timeout")

	show_message("Dodge the\nCreeps!")

	# pause for 1 sec before showing start button
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func init_message(text):
	show_message(text)
	$MessageTimer.start()
	
func show_message(text):
	$Message.text = text
	$Message.show()

func _on_MessageTimer_timeout():
	$Message.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

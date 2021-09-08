extends TextureRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D):
		flip_h = false
	if Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A):
		flip_h = true

func shakeHead():
	for	n in 5:
		yield(get_tree().create_timer(0.33), "timeout")
		flip_h = !flip_h

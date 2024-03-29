extends Area2D

signal hit

# Declare member variables here.
export var speed = 400 # pixels/sec
var screen_size
var target = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	
	if position.distance_to(target) > 10:
		velocity = target - position

#	if Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D): 
#		velocity.x += 1
#	if Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A):
#		velocity.x -= 1
#	if Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S):
#		velocity.y += 1
#	if Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W):
#		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	# diagonal
	if velocity.y != 0 && velocity.x != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	elif velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		target = event.position

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	target = pos
	show()
	$CollisionShape2D.disabled = false

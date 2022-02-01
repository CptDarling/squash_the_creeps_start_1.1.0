extends KinematicBody

# How fast the player movesd in meters per second.
export var speed = 14

# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

# Vertical impulse applied to the character upon jumping in meters per second.
export var jump_impulse = 20

# Vertical impulse applied to the character upon bouncing over a mob in
# meters per second.
export var bounce_impulse = 16

var velocity = Vector3.ZERO

onready var pivot : Spatial = $Pivot

# Emitted when the player is hit by a mob.
signal hit

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction : Vector3 = Vector3.ZERO
	
	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		pivot.look_at(translation + direction, Vector3.UP)
		$AnimationPlayer.playback_speed = 4
	else:
		$AnimationPlayer.playback_speed = 1
	
	# Ground velocity
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	# Verticle velocity
	velocity.y -= fall_acceleration * delta
	
	# Jumping
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
	
	# Moving the character
	velocity = move_and_slide(velocity, Vector3.UP)
	
	for index in range(get_slide_count()):
		# We check every collision that occurred this frame.
		var collision = get_slide_collision(index)
		# If we collide with a monster...
		if collision.collider.is_in_group("mob"):
			var mob = collision.collider
			# ...we check that we are hitting it from above.
			if Vector3.UP.dot(collision.normal) > 0.1:
				# If so, we squash it and bounce.
				mob.squash()
				velocity.y = bounce_impulse

	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse

func die():
	emit_signal("hit")
	queue_free()


func _on_MobDetector_body_entered(_body):
	die()

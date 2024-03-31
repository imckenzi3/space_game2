extends Character

#shovel - ref to node
@onready var shovel: Node2D = get_node("Shovel")
@onready var shovel_animation_player: AnimationPlayer = shovel.get_node("ShovelAnimationPlayer")

func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()

	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
		
	#update the rotation of the shovel using the angle of the mouse direction
	shovel.rotation = mouse_direction.angle()
	if shovel.scale.y == 1 and mouse_direction.x < 0:
		shovel.scale.y = -1
	elif shovel.scale.y == -1 and mouse_direction.x > 0:
		shovel.scale.y = 1
	
	#check if attack is pressed and the attack animation is not playing
	if Input.is_action_just_pressed("ui_attack") and not shovel_animation_player.is_playing():
		print("Player attacked")
		shovel_animation_player.play("attack")
		
	#jump
	jump()
		

func get_input() -> void:
	mov_direction = Vector2.ZERO
	#if Input.is_action_pressed("ui_down"):
		#mov_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		mov_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		mov_direction += Vector2.RIGHT

func jump():
	if Input.is_action_just_pressed("ui_up"):
	#check if current jumps is less than our max jumps
	#if we have jumped twice we do not want to jump again
		if current_jumps < max_jumps:
			velocity.y = jump_power
			current_jumps = current_jumps + 1
	else:
			#adding gravity
			velocity.y += gravity
			
		#hit the ground reset jumps
	if is_on_floor():
		current_jumps = 1
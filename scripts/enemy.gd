#@icon("res://Art/v1.1 dungeon crawler 16x16 pixel pack/enemies/goblin/goblin_idle_anim_f0.png") #icon 

extends Character #Character ref
class_name Enemy

@onready var player: CharacterBody2D = get_tree().current_scene.get_node("Player") #ref to player node
@onready var path_timer: Timer = get_node("PathTimer") #ref to Pathtimer node

#@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var nav_agent: NavigationAgent2D = get_node("NavigationAgent2D") #ref to navigation node

#grab damage numbers from scene
@onready var damage_numbers_origin: Node2D = get_node("DamageNumbersOrigin") #ref to navigation node

#tracking speed
const trackingSpeed = 25

#@onready var damage_number_origin: Node2D = get_node("DamageNumbersOrigin")
#enemy must have min max health so we will do 100/5 something like that idk

#func _ready() -> void:
	##var __ = connectz("tree_exited", Callable(get_parent(), "_on_enemy_killed")) #if I know god knows
		
func chase() -> void:
	if not nav_agent.is_target_reached():
		var vector_to_next_point: Vector2 = nav_agent.get_next_path_position() - global_position
		move_direction = vector_to_next_point 
		#move_direction = vector_to_next_point * trackingSpeed
			
		#change sprite based on mouse location
		if vector_to_next_point.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif vector_to_next_point.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true

#chaned to -> void and added else
func _on_path_timer_timeout() -> void:
	#stop enemy movement after playerdeath
	if is_instance_valid(player):
		_get_path_to_player()
	else:
		path_timer.stop()
		move_direction = Vector2.ZERO
		
#gets path to player
func _get_path_to_player() -> void:
	nav_agent.target_position = player.position 
	

##sets bar hp tp enemy hp
func set_hp(new_hp: int)  -> void:
	hp = new_hp
	emit_signal("hp_changed", new_hp)
	
	
	$HealthBar.set_bar_value(new_hp*1.0) #sets enemy bar hp based on enemy hp
	#var damage = hitbox.damage
	#var is_critial = hitbox.crit_change > randf ()
	#DamageNumbers.display_number(damage, damage_numbers_origin.global_position, is_critial)

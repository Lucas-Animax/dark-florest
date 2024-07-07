extends CharacterBody2D
class_name Player_Class

#region int
var jump_cont:int = 2
var wall_dic:int
#endregion
#region bool
var on_floor:bool 
var in_attack:bool = false
var in_defence:bool = false
var in_crouch:bool = false
var check_input:bool = true
var not_wall:bool = true
#endregion
#region objects @export
@export_category("Objects")
@export var spr:Sprite2D
@export var wall_ray:RayCast2D
#endregion
#region variables @export
@export_category("Variables")
@export var speed:float
@export var gravit_value:float
@export var jump_value:float
#endregion
#region consts
const FRIC = 0.1
const WALL_GRAVIT = 30
const WALL_JUMP = 700
const WALL_IMPUSE = 250
#endregion
func _check_inputs():
	if not on_floor:
		if in_attack or in_defence or in_crouch:
			check_input = false
		else:check_input = true
	
	
	
	pass

func _physics_process(delta:float):
	if check_input == true:
		move_and_slide()
		_move_horizontal()
		_move_vertical()
	_actions()
	_check_inputs()
	_gravit()
	spr._animate(velocity)
	pass

func _move_horizontal():
	var dic:float = Input.get_axis("move_left","move_right")
	if dic != 0:
		velocity.x = lerp(velocity.x, dic * speed,FRIC)
	else: velocity.x = move_toward(velocity.x,0,speed)
	pass

func _move_vertical():
	if is_on_floor() or next_to_wall():
		jump_cont = 0
	if  Input.is_action_just_pressed("jump") and jump_cont < 2:
		jump_cont += 1
		if next_to_wall() and not is_on_floor():
			velocity.y -= WALL_JUMP
			velocity.x = wall_dic * WALL_IMPUSE
		else:
			velocity.y -= jump_value
		
func _gravit():
	if next_to_wall() and not is_on_floor():
		velocity.y += WALL_GRAVIT
		if velocity.y > WALL_GRAVIT:
			velocity.y = WALL_GRAVIT
		
	elif not is_on_floor():
		on_floor = true
		velocity.y += gravit_value 
		if velocity.y > gravit_value:
			velocity.y = gravit_value

func _actions():
	attack()
	defence()
	crouch()
	pass

func attack():
	if Input.is_action_just_pressed("attack") and is_on_floor() and not in_attack:
		in_attack = true
		spr.attack_normal = true
		await get_tree().create_timer(0.7).timeout
		in_attack = false
		return
	
	
	pass

func defence():
	if Input.is_action_pressed("defence") and is_on_floor() and not in_crouch:
		in_defence = true
	else:
		in_defence = false
		spr.defence_off = true
	
	
	
	
	pass

func crouch():
	if Input.is_action_pressed("crouch") and is_on_floor() and not in_defence:
		in_crouch = true
	else:
		in_crouch = false
		spr.crouch_off = true
	pass

func next_to_wall() -> bool:
	if wall_ray.is_colliding() and not is_on_floor():
		if not_wall:
			velocity.y = 0
			not_wall = false
		return true
	else:
		not_wall = true 
		return false
	
	
	pass

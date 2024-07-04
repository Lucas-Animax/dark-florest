extends CharacterBody2D
class_name Player_Class
#region int
var jump_cont:int = 2
#endregion
#region bool
var on_floor:bool 
var in_attack:bool = false
var in_defence:bool = false
var in_crouch:bool = false
var check_input:bool = true

#endregion
@export_category("Objects")
@export var spr:Sprite2D
@export_category("Variables")
@export var speed:float
@export var gravit_value:float
@export var jump_value:float

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
	spr._animate(velocity)
	pass


func _move_horizontal():
	var dic:float = Input.get_axis("move_left","move_right")
	velocity.x = dic * speed
	pass

func _move_vertical():
	if is_on_floor():
		jump_cont = 0
	if Input.is_action_just_pressed("jump") and jump_cont < 1 and is_on_floor():
		velocity.y -= jump_value
		jump_cont += 1
	elif Input.is_action_just_pressed("jump") and jump_cont == 1 and not is_on_floor():
		velocity.y -= jump_value
		jump_cont += 1
		return
	if not is_on_floor():
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

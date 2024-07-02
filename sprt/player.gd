extends CharacterBody2D
class_name Player
#region int
var jump_cont:int = 2
#endregion
@export_category("Objects")
@export var spr:Sprite2D
@export_category("Variables")
@export var speed:float
@export var gravit_value:float
@export var jump_value:float

func _physics_process(delta:float):
	move_and_slide()
	_move_horizontal()
	_move_vertical()
	_gravit()
	spr._animate(velocity)
	
	pass
func _move_horizontal():
	var dic:float = Input.get_axis("move_left","move_right")
	velocity.x = dic * speed
	pass
func _gravit():
	velocity.y += gravit_value
	if velocity.y > gravit_value:
		velocity.y = gravit_value
	
	pass
func _move_vertical():
	if is_on_floor():
		jump_cont = 0
		
	if Input.is_action_just_pressed("jump") and jump_cont < 2:
		velocity.y -= jump_value
		jump_cont += 1
		return
	print(jump_cont)
	
	
	pass

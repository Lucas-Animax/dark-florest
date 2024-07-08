extends Sprite2D
class_name Anim_Player
var dic_name:String
var defence_off:bool = true
var crouch_off:bool = true
var  attack_normal:bool = true
@export_category("Objects")
@export var anim:AnimationPlayer
@export var player_ref:CharacterBody2D
func _animate(dic:Vector2):
	if not player_ref.check_input or player_ref.next_to_wall():
		anim_actions()
	elif  dic.y != 0:
		_anim_vertical(dic)
	elif player_ref.on_floor:
		anim.play("fall")
	else: _anim_horizontal(dic)
	_check_dic(dic)
	
	pass
func _check_dic(dic):
	if dic.x > 0:
		flip_h = false
		dic_name = "_left"
		player_ref.direction = -1
		position = Vector2.ZERO
		player_ref.wall_ray.target_position = Vector2(10,0)
	elif dic.x < 0:
		flip_h = true
		dic_name = "_right"
		player_ref.direction = 1
		position = Vector2(-5,0)
		player_ref.wall_ray.target_position = Vector2(-15,0)
	
	
	pass
func _anim_vertical(dic):
	if dic.y > 0:
		anim.play("down")
	elif dic.y < 0:
		anim.play("up")
	
	
	pass
func _anim_horizontal(dic):
	if dic.x != 0:
		anim.play("walk")
		return
	anim.play("idle")
	pass
func anim_actions():
	if player_ref.next_to_wall():
		anim.play("wall_slide")
		
	if player_ref.in_attack and attack_normal:
		anim.play("attack"+dic_name)
		return
	elif player_ref.in_defence and defence_off:
		anim.play("shild")
		defence_off = false
	elif player_ref.in_crouch and crouch_off:
		anim.play("crouch")
		crouch_off = false
		
	pass

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"fall":
			player_ref.on_floor = false
	pass # Replace with function body.

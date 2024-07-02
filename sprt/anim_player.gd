extends Sprite2D
class_name Anim_Player
var on_floor:bool = false
@export_category("Objects")
@export var anim:AnimationPlayer
func _animate(dic:Vector2):
	if dic.y != 0:
		_anim_vertical(dic)
	else: _anim_horizontal(dic)
	_check_dic(dic)
	pass
func _check_dic(dic):
	if dic.x > 1:
		flip_h = false
	elif dic.x < 0:
		flip_h = true
	
	
	
	
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

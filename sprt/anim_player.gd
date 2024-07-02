extends Sprite2D
class_name Anim_Player
@export_category("Objects")
@export var anim:AnimationPlayer
func _animate(dic:Vector2):
	if dic.y != 1:
		_anim_vertical(dic)
	elif  dic.x != 0:
		_anim_horizontal(dic)
		
	_check_dic(dic)
	pass
func _anim_horizontal(dic):
	if dic.x != 0:
		anim.play("walk")
		return
	anim.play("idle")
	pass
func _check_dic(dic):
	if dic.x > 0:
		flip_h = false
	elif dic.x < 0:
		flip_h = true
	
	
	
	
	pass
func _anim_vertical(dic):
	if dic.y > 1:
		anim.play("down")
	if dic.y < 1:
		anim.play("up")
	
	
	pass

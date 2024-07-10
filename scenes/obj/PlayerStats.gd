extends Node
class_name PlayerStats

var shilding:bool = false
#region base 
var base_health:int = 15
var base_mana:int = 10
var base_shild:int = 3
var base_attack:int = 10
var base_magic_attack:int = 15
#endregion
#region bonus
var bonus_health:int = 0
var bonus_mana:int = 0
var bonus_shild:int = 0
var bonus_attack:int = 0
var bonus_magic_attack:int = 0
#endregion
#region actual
var current_health:int
var current_mana:int
var current_exp:int = 0

#endregion
#region max 
var max_health:int
var max_mana:int
#endregion
#region level
var level:int = 1
var max_level:int = 9
var level_dic:Dictionary = {
	"1":25,
	"2":35,
	"3":50,
	"4":70,
	"5":100,
	"6":130,
	"7":160,
	"8":200,
	"9":290}
#endregion

func _ready():
	current_health = base_health + bonus_health
	max_health = current_health
	current_mana = base_mana + bonus_mana
	max_mana = current_mana
	
	
	
	
	pass

func update_exp(value:int):
	current_exp += value
	if current_exp >= level_dic[str(level)] and level < max_level:
		var leftover:int = current_exp - level_dic[str(level)]
		current_exp = leftover
		level += 1
		on_level_up()
	elif current_exp >= level_dic[str(level)] and level == max_level:
		current_exp =  level_dic[str(level)]
		
		return
	
	
	
	pass

func on_level_up():
	current_health = base_health + bonus_health
	current_mana = base_mana + bonus_mana
	
	
	pass

func update_health(type:String,value:int):
	match type:
		"positive":
			current_health += value
			if current_exp >= max_health:
				current_health = max_health
		"negative":
			check_shilding(value)
			if current_health <= 0:
				pass #chmar animação de morte
			else: pass #chamr animação de dano

func check_shilding(value:int):
	if not shilding:
		current_health -= value
	elif shilding:
		if (base_shild+bonus_shild) > value:
			return 
		else:
			var damege:int = abs((base_shild + bonus_shild)-value)
			current_health -= damege
	
	
	pass
	
	
func update_mana(type:String,value:int):
	match type:
		"positive":
			current_mana += value
			if current_mana >= max_mana:
				current_mana = max_mana
		"negative":
			current_mana -= value
	
	
	
	
	
	pass

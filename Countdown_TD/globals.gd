extends Node2D

signal on_gold_change
var gold = 10
func mob_died() ->void:
	gold = gold + 1
	on_gold_change.emit(gold)
func spend_gold(val: int) -> bool:
	if gold >= val:
		gold = gold - val
		on_gold_change.emit(gold)
		return true
	return false

signal on_health_change
var health = 10
func mob_reached_goal() -> void:
	health = health - 1
	on_health_change.emit(health)

signal on_day_night_change
func day_night_changed(val: bool) -> void:
	on_day_night_change.emit(val)

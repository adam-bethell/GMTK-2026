extends Node2D

signal on_gold_change
var gold:float = 10
func mob_died() ->void:
	gold = snapped(gold + 0.1, 0.1)
	on_gold_change.emit(gold)
	$Deaths.play()
	
func spend_gold(val: int) -> bool:
	if gold >= val:
		gold = snapped(gold - val, 0.1)
		
		on_gold_change.emit(gold)
		return true
	return false

signal on_health_change
var health = 10
func mob_reached_goal() -> void:
	health = health - 1
	on_health_change.emit(health)
	$Portal.play()
	
signal on_day_night_change
func day_night_changed(val: bool) -> void:
	on_day_night_change.emit(val)
	if not val:
		$FogHorn.play()
		$Night.play()
	else:
		$Day.play()


func tower_placed() -> void:
	$Place.play()

func detonation() -> void:
	$Detonation.play()
	
func select_tower() -> void:
	$SelectTower.play()

func fire1SFX() -> void:
	$StakeSFX.play()
	
func fire2SFX() -> void:
	$TrebuchetSFX.play()
	
func fire3SFX() -> void:
	$WaterSFX.play()

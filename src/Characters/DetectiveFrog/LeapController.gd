extends Node

class_name LeapController

export var maxLeap:float = 200
export var leapGain:float = 5
var _charge:float
var _isOnFloor:bool

func get_velocity(isOnFloor:bool) -> float:
	_isOnFloor = isOnFloor
	charge()
	if isReady():
		return release()
	elif Input.is_action_just_released("leap"):
		release()
	return 0.0
	
func charge() -> void:
	if Input.is_action_pressed("leap"):
		_charge += leapGain
	_charge = clamp(_charge,0,maxLeap)
	Events.emit_signal("leap_set",_charge/maxLeap * 100)
	
func release() -> float:
	var output = _charge
	_charge = 0.0
	return output
	
func isReady() -> bool:
	if _isOnFloor and Input.is_action_just_released("leap"):
		return true
	else:
		return false

extends Node2D


func _ready() -> void:
	$DialogueRadio.send_dialogue("res://assets/Dialogue/intro.json")
	Events.connect("dialogue_end",self,"_start_level")
	pass
	
func _start_level():
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://src/Levels/Swamp.tscn")

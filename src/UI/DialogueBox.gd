extends NinePatchRect

class_name DialogueBox

var finished:bool = false
var showing = false
var dialogue:Array
var has_dialogue:bool
var conversation_index:int = 0

func _ready() -> void:
	rect_position.y += rect_size.y
	Events.connect("send_dialogue",self,"_on_dialogue_recieved")
	$TextDisplay.connect("finished_playing_character",self,"_on_finished_playing_character")
	pass
	
	
func _on_dialogue_recieved(dialogue:Array) -> void:
	conversation_index = 0
	self.dialogue = dialogue
	has_dialogue = true
	start()
	
func clear_portraits():
	$CharacterPortraitLeft/TextureRect.texture = null
	$CharacterPortraitLeft/Name.text = ""
	$CharacterPortraitRight/TextureRect.texture = null
	$CharacterPortraitRight/Name.text = ""
	
func start() -> void:
	if !showing:
		animated_show()
		play_character(dialogue[conversation_index])
		
func _on_finished_playing_character():
	stop()
	pass
	
func stop() -> void:
	if showing:
		animated_hide()
		

func animated_show() -> void:
	Events.emit_signal("dialogue_show")
	$Tween.interpolate_property(self,"rect_position:y",rect_position.y,rect_position.y - rect_size.y,0.2)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	showing = true
	
func animated_hide() -> void:
	Events.emit_signal("dialogue_hide")
	$Tween.interpolate_property(self,"rect_position:y",rect_position.y,rect_position.y + rect_size.y,0.2)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	showing = false
	
func play_character(speech) -> void:
	clear_portraits()
	$TextDisplay.set_buffer(speech.text)
	if(speech.name == "Player"):
		$CharacterPortraitLeft/Name.text = speech.name
		$CharacterPortraitLeft/TextureRect.texture = load("res://assets/Dialogue/portraits/%s" % speech.portrait)
	else:
		$CharacterPortraitRight/Name.text = speech.name
		$CharacterPortraitRight/TextureRect.texture = load("res://assets/Dialogue/portraits/%s" % speech.portrait)
	

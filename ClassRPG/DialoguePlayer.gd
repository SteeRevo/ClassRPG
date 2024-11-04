extends CanvasLayer

@export_file("*json") var scene_text_file: String

var scene_text: Dictionary = {}
var in_progress: bool = false
var text_index = 0
var text_size = 0

@onready var background = $Background
@onready var text_label = $TextLabel
@onready var portrait = $Portrait
@onready var portaitBG = $PortraitBG
var bb_portrait = preload("res://Visual_novel_scene/bb_portrait.png")
var sophie_portrait = preload("res://Visual_novel_scene/sophie_portraits.png")



func _ready():
	background.visible = false
	portrait.visible = false
	portaitBG.visible = false
	scene_text = load_scene_text()
	SignalBus.connect("display_dialogue", Callable(self, "on_display_dialogue"))

func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		var file = FileAccess.open(scene_text_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()

func show_text(text):
	text_label.text = text

func next_line(text_key):
	text_index += 1
	if text_index < text_size:
		var speaker = scene_text[text_key][text_index][0]
		var speaker_emote = scene_text[text_key][text_index][1]
		change_portrait(speaker, speaker_emote)
		var text = scene_text[text_key][text_index][2]
		show_text(text)
	else:
		finish()

func finish():
	text_label.text = ""
	background.visible = false
	portrait.visible = false
	portaitBG.visible = false
	in_progress = false
	get_tree().paused = false
	
func on_display_dialogue(text_key):
	if in_progress:
		next_line(text_key)
	else:
		get_tree().paused = true
		background.visible = true
		portaitBG.visible = true
		portrait.visible = true
		in_progress = true
		var speaker = scene_text[text_key][text_index][0]
		var speaker_emote = scene_text[text_key][text_index][1]
		var text = scene_text[text_key][text_index][2]
		text_size = scene_text[text_key].size()
		change_portrait(speaker, speaker_emote)
		show_text(text)

"SQUINT, SHADOW, SMILE, UPSET, CHILL, DISAPPOINTED, JOKING, SURPRISED, SIGH"

"NORMAL, GRRR, HAPPY, SCOLD, DEVIOUS, DOWN, SCREAM, WORRIED, DREAMING, SAD"

func change_portrait(speaker, emote):
	match speaker:
		"BB":
			portrait.texture = bb_portrait
			match emote:
				"normal":
					portrait.frame = PortraitEnums.PORTRAITS_BB.NORMAL
				"squint":
					portrait.frame = PortraitEnums.PORTRAITS_BB.SQUINT
				"shadow":
					portrait.frame = PortraitEnums.PORTRAITS_BB.SHADOW
				"smile":
					portrait.frame = PortraitEnums.PORTRAITS_BB.SMILE
				"upset":
					portrait.frame = PortraitEnums.PORTRAITS_BB.UPSET
				"chill":
					portrait.frame = PortraitEnums.PORTRAITS_BB.CHILL
				"disappointed":
					portrait.frame = PortraitEnums.PORTRAITS_BB.DISAPPOINTED
				"joking":
					portrait.frame = PortraitEnums.PORTRAITS_BB.JOKING
				"suprised":
					portrait.frame = PortraitEnums.PORTRAITS_BB.SURPRISED
				"sigh":
					portrait.frame = PortraitEnums.PORTRAITS_BB.SIGH
		"Sophie":
			portrait.texture = sophie_portrait
			match emote:
				"normal":
					portrait.frame = PortraitEnums.PORTRAITS_SOPHIE.NORMAL
				"grrr":
					portrait.frame = PortraitEnums.PORTRAITS_SOPHIE.GRRR
				"happy":
					portrait.frame = PortraitEnums.PORTRAITS_SOPHIE.HAPPY
				"scold":
					portrait.frame = PortraitEnums.PORTRAITS_SOPHIE.SCOLD
				"devious":
					portrait.frame = PortraitEnums.PORTRAITS_SOPHIE.DEVIOUS
				"down":
					portrait.frame = PortraitEnums.PORTRAITS_SOPHIE.DOWN
				"scream":
					portrait.frame = PortraitEnums.PORTRAITS_SOPHIE.SCREAM
				"worried":
					portrait.frame = PortraitEnums.PORTRAITS_SOPHIE.WORRIED
				"dreaming":
					portrait.frame = PortraitEnums.PORTRAITS_SOPHIE.DREAMING
				"sad":
					portrait.frame = PortraitEnums.PORTRAITS_SOPHIE.SAD
				

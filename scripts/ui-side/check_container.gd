class_name CheckContainer
extends Control

var correct_icon = load("res://icons/checkmark_correct.png")
var uncheck_icon = load("res://icons/checkmark_uncheck.png")
var wrong_icon  = load("res://icons/checkmark_wrong.png")
var correct
var uncheck
var wrong

func _ready():
	self.custom_minimum_size = Vector2(20, 20)
	correct = TextureRect.new()
	uncheck = TextureRect.new()
	wrong = TextureRect.new()
	correct.texture = correct_icon
	uncheck.texture = uncheck_icon
	wrong.texture = wrong_icon
	correct.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	uncheck.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	wrong.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	correct.custom_minimum_size = Vector2(20, 20)
	uncheck.custom_minimum_size = Vector2(20, 20)
	wrong.custom_minimum_size = Vector2(20, 20)
	correct.anchor_top = 0.5
	correct.anchor_bottom = 0.5
	correct.offset_top = -10
	correct.offset_bottom = -10
	uncheck.anchor_top = 0.5
	uncheck.anchor_bottom = 0.5
	uncheck.offset_top = -10
	uncheck.offset_bottom = -10
	wrong.anchor_top = 0.5
	wrong.anchor_bottom = 0.5
	wrong.offset_top = -10
	wrong.offset_bottom = -10
	add_child(correct)
	add_child(uncheck)
	add_child(wrong)
	correct.set_visible(false)
	uncheck.set_visible(true)
	wrong.set_visible(false)

func set_correct():
	correct.set_visible(true)
	uncheck.set_visible(false)
	wrong.set_visible(false)

func set_wrong():
	correct.set_visible(false)
	uncheck.set_visible(false)
	wrong.set_visible(true)

func set_uncheck():
	correct.set_visible(false)
	uncheck.set_visbile(true)
	wrong.set_visible(false)

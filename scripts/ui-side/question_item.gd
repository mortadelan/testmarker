class_name QuestionItem
extends GridContainer

@export var label : String
@export var question : Question
var check_child : CheckContainer
var option_child : OptionButton
var ease_child : OptionButton
var disc_child : OptionButton
var label_child = Label.new()

func _ready():
	label_child.text = label
	add_child(label_child)

	option_child = OptionButton.new()
	option_child.add_item("A", QuestionList.OPTIONS.A)
	option_child.add_item("B", QuestionList.OPTIONS.B)
	option_child.add_item("C", QuestionList.OPTIONS.C)
	option_child.add_item("D", QuestionList.OPTIONS.D)
	option_child.add_item("E", QuestionList.OPTIONS.E)
	option_child.add_item(" ", QuestionList.OPTIONS.NULL)
	option_child.select(5)
	option_child.item_selected.connect(_on_item_selected)
	add_child(option_child)

	check_child = CheckContainer.new()
	add_child(check_child)
	columns = 3

	ease_child = OptionButton.new()
	ease_child.add_item("Very Easy", QuestionList.EASE.VERY_EASY)
	ease_child.add_item("Easy", QuestionList.EASE.EASY)
	ease_child.add_item("Average", QuestionList.EASE.AVERAGE)
	ease_child.add_item("Hard", QuestionList.EASE.HARD)
	ease_child.add_item("Very Hard", QuestionList.EASE.VERY_HARD)
	add_child(ease_child)

	disc_child = OptionButton.new()
	disc_child.add_item("High", QuestionList.DISC.HIGH)
	disc_child.add_item("Very Good", QuestionList.DISC.VERY_GOOD)
	disc_child.add_item("Good", QuestionList.DISC.GOOD)
	disc_child.add_item("Average", QuestionList.DISC.AVERAGE)
	disc_child.add_item("Deficient", QuestionList.DISC.DEFICIENT)
	add_child(disc_child)

	_on_item_selected()

func _on_item_selected(_idx = 0):
	question.selected = option_child.selected as QuestionList.OPTIONS
	question.ease = ease_child.selected as QuestionList.EASE
	question.disc = disc_child.selected as QuestionList.DISC

func check():
	if is_correct() == true:
		check_child.set_correct()
	elif is_correct() == false:
		check_child.set_wrong()
	else:
		check_child.set_uncheck()

func is_correct() -> bool:
	return question.is_correct()

class_name QuestionContainer
extends GridContainer

@export var questions : QuestionList

func _ready():
	if questions != null:
		for questioni in questions.list.size():
			var question := QuestionItem.new()
			question.label = "Question " + str(questioni + 1)
			question.question = questions.list[questioni]
			add_child(question)

func _on_check_button_pressed():
	for child in get_children():
		child.check()

func _on_h_slider_value_changed(value: float) -> void:
	self.columns = int(value)

func _on_set_button_pressed():
	questions.commit_selected()

func _re_ready():
	for child in get_children():
		child.queue_free()
	_ready()

class_name QuestionContainer
extends GridContainer

@export var questions : QuestionList

func _ready():
	self.get_viewport().size_changed.connect(resize)
	spawn_children()
	resize()

func _on_check_button_pressed():
	for child in get_children():
		child.check()

func _on_set_button_pressed():
	questions.commit_selected()

func _re_ready():
	for child in get_children():
		child.queue_free()
	spawn_children()

func spawn_children():
	if questions != null:
		for questioni in questions.list.size():
			var question := QuestionItem.new()
			question.label = "Question " + str(questioni + 1)
			question.question = questions.list[questioni]
			add_child(question)

func resize():
	if get_child(0) != null:
		var child := get_child(0)
		var item_width = child.size.x
		var available_width = self.get_window().size.x
		self.columns = max(1, int(available_width / item_width))

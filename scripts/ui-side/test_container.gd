class_name TestContainer
extends Label

@export var test : Test

var save_button : Button
var set_button : Button
var check_button : Button
var questions : QuestionContainer
var log_button : Button
var time_button : Button
var time_label : Label
var stopwatch : Stopwatch

func _ready():
	if test != null:
		self.label_settings = load("res://scripts/ui-side/label_settings.tres")
		var new_test : bool
		if questions == null && save_button == null && set_button == null && check_button == null:
			questions = QuestionContainer.new()
			save_button = Button.new()
			set_button = Button.new()
			check_button = Button.new()
			log_button = Button.new()
			time_button = Button.new()
			time_label = Label.new()
			stopwatch = Stopwatch.new()
			new_test = true
		else:
			new_test = false

		questions.questions = test.lists[0]
		questions.anchor_top = 0.25
		questions.anchor_bottom = 0.25
		questions.offset_right = 40
		questions.offset_bottom = 40
		questions.position = Vector2(0, 30)
		questions.size_flags_horizontal = SizeFlags.SIZE_EXPAND_FILL
		# all the tedious setup of:
		# the save_button
		#  - connect pressed() signal to correct test.lists[i]._on_save_button_pressed()
		save_button.text = "Save"
		save_button.anchor_left = 1.0
		save_button.anchor_right = 1.0
		save_button.offset_top = 5
		save_button.offset_right = -98
		save_button.offset_bottom = 5
		save_button.grow_horizontal = GrowDirection.GROW_DIRECTION_BEGIN
		# the set_button
		#  - connect pressed() signal to correct test.lists[i]._on_set_button_pressed()
		set_button.text = "Set"
		set_button.anchor_left = 1.0
		set_button.anchor_right = 1.0
		set_button.offset_top = 5
		set_button.offset_right = -60
		set_button.offset_bottom = 5
		set_button.grow_horizontal = GrowDirection.GROW_DIRECTION_BEGIN
		# the check_button
		#  - connect pressed() signal to correct test.lists[i]._on_check_button_pressed()
		check_button.text = "Check"
		check_button.anchor_left = 1.0
		check_button.anchor_right = 1.0
		check_button.offset_top = 5
		check_button.offset_right = 0
		check_button.offset_bottom = 5
		check_button.grow_horizontal = GrowDirection.GROW_DIRECTION_BEGIN
		# log_button
		log_button.text = "Save log"
		log_button.anchor_left = 1.0
		log_button.anchor_right = 1.0
		log_button.offset_top = 5
		log_button.offset_right = -148
		log_button.offset_bottom = 5
		log_button.grow_horizontal = GrowDirection.GROW_DIRECTION_BEGIN
		# time_button
		time_button.text = "Start timer"
		time_button.anchor_left = 1.0
		time_button.anchor_right = 1.0
		time_button.offset_top = 5
		time_button.offset_right = -226
		time_button.offset_bottom = 5
		time_button.grow_horizontal = GrowDirection.GROW_DIRECTION_BEGIN
		# time_label
		time_label.text = ""
		time_label.anchor_left = 1.0
		time_label.anchor_right = 1.0
		time_label.offset_top = 9
		time_label.offset_right = -322
		time_label.offset_bottom = 9
		time_label.grow_horizontal = GrowDirection.GROW_DIRECTION_BEGIN
		# then correctly populate children with:
		# slider
		# buttons
		# test.lists[i] : QuestionList
		self.text = test.name
		if new_test == true:
			add_child(questions)
			add_child(save_button)
			add_child(set_button)
			add_child(check_button)
			add_child(log_button)
			add_child(time_button)
			add_child(time_label)
			add_child(stopwatch)
			save_button.pressed.connect(self._on_save_button_pressed)
			set_button.pressed.connect(questions._on_set_button_pressed)
			check_button.pressed.connect(questions._on_check_button_pressed)
			log_button.pressed.connect(self._on_save_button_pressed.bind(true))
			time_button.pressed.connect(stopwatch.start)
		else:
			questions._re_ready()
	else:
		test = load("res://tests/blank.tres")
		_ready()

func _process(_delta: float):
	if time_label != null && stopwatch != null && stopwatch.is_stopped() != true:
		time_label.text = stopwatch.pretty_count

func _on_save_button_pressed(log_flag := false):
	var file_dialog = FileDialog.new()
	file_dialog.file_mode = FileDialog.FileMode.FILE_MODE_SAVE_FILE
	# file_dialog.current_dir = test_dir.?
	# maybe we make some sort of TestDir global, so that all open tests
	# and test directories are easily accessible once they're opened
	file_dialog.access = FileDialog.Access.ACCESS_FILESYSTEM
	var filter := "*.json, *.tres, *.test"
	var description := "Test file"
	var mime_type := "application/json, application/x-godot-resource"
	file_dialog.add_filter(filter, description, mime_type)
	add_child(file_dialog)
	file_dialog.file_selected.connect(_on_path_selected.bind(log_flag))
	file_dialog.get_cancel_button().pressed.connect(_on_cancelled)
	file_dialog.popup_file_dialog()

func _on_cancelled():
	print("Cancelled")
	free_dialogs()

func _on_path_selected(path: String, log_flag := false):
	var file = FileAccess.open(path, FileAccess.WRITE)
	var save_dict : Dictionary
	if log_flag:
		save_dict = test.save(true, time_label.text)
	else:
		save_dict = test.save()
	var json_string = JSON.stringify(save_dict)
	file.store_line(json_string)
	free_dialogs()

func free_dialogs():
	for child in get_children():
		if child is FileDialog:
			child.queue_free()
	print("Dialogs freed")

func _on_open_button_pressed():
	# - open file dialog
	# - get path out of dialog
	var select_dialog = FileDialog.new()
	select_dialog.file_mode = FileDialog.FileMode.FILE_MODE_OPEN_FILE
	# file_dialog.current_dir = test_dir.?
	# maybe we make some sort of TestDir global, so that all open tests
	# and test directories are easily accessible once they're opened
	select_dialog.access = FileDialog.Access.ACCESS_FILESYSTEM
	var filter := "*.json, *.tres, *.test"
	var description := "Test file"
	var mime_type := "application/json, application/x-godot-resource"
	select_dialog.add_filter(filter, description, mime_type)
	add_child(select_dialog)
	select_dialog.file_selected.connect(_on_file_selected)
	select_dialog.get_cancel_button().pressed.connect(_on_cancelled)
	select_dialog.popup_file_dialog()

func _on_file_selected(path: String):
	# - parse json
	# - make sure new test assigns everything to the right objects
	var file = FileAccess.open(path, FileAccess.READ)
	var file_string = file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(file_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", parse_result, " at line ", json.get_error_line())
	var save_dict = json.data
	self.test = Test.new()
	test.parse_dict(save_dict)
	free_dialogs()
	# this would have to be tweaked for multiple Tests and QuestionLists
	self._ready()

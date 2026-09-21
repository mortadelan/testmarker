class_name Question
extends Resource

@export var selected : QuestionList.OPTIONS
@export var correct : QuestionList.OPTIONS
@export var ease : float
@export var discrim : float

func is_correct() -> bool:
	return selected == correct

func parse_dict(save_dict: Dictionary):
	correct = save_dict["correct"] as QuestionList.OPTIONS
	ease = save_dict["ease"]
	discrim = save_dict["discrim"]

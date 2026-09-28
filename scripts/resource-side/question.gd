class_name Question
extends Resource

@export var selected : QuestionList.OPTIONS
@export var correct : QuestionList.OPTIONS
@export var ease : QuestionList.EASE
@export var disc : QuestionList.DISC

func is_correct() -> bool:
	return selected == correct

func parse_dict(save_dict: Dictionary):
	correct = save_dict["correct"] as QuestionList.OPTIONS
	ease = save_dict["ease"] as QuestionList.EASE
	if save_dict.has("disc"):
		disc = save_dict["disc"] as QuestionList.DISC
	else:
		disc = save_dict["discrim"] as QuestionList.DISC

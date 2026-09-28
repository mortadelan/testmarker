class_name QuestionList
extends Resource

enum OPTIONS { A, B, C, D, E, NULL = 5 }
enum EASE { VERY_EASY, EASY, AVERAGE, HARD, VERY_HARD }
enum DISC { HIGH, VERY_GOOD, GOOD, AVERAGE, DEFICIENT }
@export var list : Array[Question] = [ Question.new(), \
	Question.new(), Question.new(), Question.new(), \
	Question.new(), Question.new(), Question.new(), \
	Question.new(), Question.new(), Question.new(), \
	Question.new(), Question.new(), Question.new(), \
	Question.new(), Question.new() ]

func commit_selected():
	if list.size() > 0:
		for question in list:
			question.correct = question.selected

func save(log_flag := false) -> Dictionary:
	var save_dict : Dictionary
	if list.size() > 0:
		for questioni in list.size():
			var question : Dictionary
			if log_flag:
				question.assign({questioni : {
					"selected" : list[questioni].selected,
					"correct" : list[questioni].correct,
					"ease" : list[questioni].ease,
					"disc" : list[questioni].disc
					}})
			else:
				question.assign({questioni : {
					"correct" : list[questioni].correct,
					"ease" : list[questioni].ease,
					"disc" : list[questioni].disc
					}})
			save_dict.merge(question)
		return save_dict
	return Dictionary() # empty dict

func parse_dict(save_dict: Dictionary):
	if list.size() > 0:
		for questioni in list.size():
			list[questioni].parse_dict(save_dict[str(questioni)])

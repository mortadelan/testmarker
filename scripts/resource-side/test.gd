class_name Test
extends Resource

@export var name : String
@export var lists : Array[QuestionList] = [ QuestionList.new() ]

func save(log_flag : bool = false, time : String = "") -> Dictionary:
	var save_dict
	if log_flag && time != "":
		save_dict = {
			"test_name": name,
			# insert future score formulas here
			"time": time,
			"question_list_#": "1",
			"question_list_1": lists[0].save(log_flag)
			}
	else:
		save_dict = {
			"test_name": name,
			# insert future score formulas here
			"question_list_#": "1",
			"question_list_1": lists[0].save()
			}

	return save_dict

func parse_dict(save_dict: Dictionary):
	name = save_dict["test_name"]
	lists[0].parse_dict(save_dict["question_list_1"])

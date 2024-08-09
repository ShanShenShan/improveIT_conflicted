extends Node

#Badges, levels, stages
var badge1 = false
var badge2 = false

#quest
var explore_town = 0

#levels UI triger cange
var stage2_trigger = false

var stage3_trigger = false

#Stage completion trigger for the display notification
var stage1_complete = false 
var stage2_complete = false


# Evaluation: using dictionaries for questions, answers, and feedback
var evaluations = {
	"questions": ["", "", "", "",""],
	"answers": ["", "", "", "","", "", "", "","",""
	, "", "", "","", "", "", "", "", "", ""],
	"feedback": ["", "", "", "","", "", "", "","",""
	, "", "", "","", "", "", "", "", "", ""]
}

#Questions
func set_question(index: int, question_local: String):
	evaluations["questions"][index] = question_local

func get_question(index: int) -> String:
	return evaluations["questions"][index]
	
#answers
func set_answers(index: int, answers_local: String):
	evaluations["answers"][index] = answers_local

func get_answers(index: int) -> String:
	return evaluations["answers"][index]

#Questions
func set_feedback(index: int, feedback_local: String):
	evaluations["feedback"][index] = feedback_local

func get_feedback(index: int) -> String:
	return evaluations["feedback"][index]

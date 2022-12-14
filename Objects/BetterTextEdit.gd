extends TextEdit

#Made because textedit has no options for text centering, cursor control, or character control
#Note that this is for user experience, not security

var content = ""
export var hint = ""
export var max_length = 4
export var onlyascii = true
export var asciisymbols = false
export var asciinums = false
export var allcaps = true
var symbols
var nums

# Called when the node enters the scene tree for the first time.
func _ready():
	#Ascii characters for numbers and symbols
	nums = range(48,58)
	symbols = range(32,48)
	symbols.append_array(range(58,65))
	symbols.append_array(range(91,97))
	$Hint.text = hint
	$Hint.add_color_override("font_color",Color8(80,80,80,255))

func _process(_delta):
	cursor_set_column(text.length())

func _on_BetterTextEdit_text_changed():
	var temp = text.substr(0,max_length)
	var worked=false
	if allcaps: temp = temp.to_upper()
	if onlyascii:
		temp = temp.to_ascii()
		for i in range(temp.size()):
			if temp[i] > 122:
				temp.remove(i)
			elif not asciisymbols and temp[i] in symbols:
				temp.remove(i)
			elif not asciinums and temp[i] in nums:
				temp.remove(i)
		temp = temp.get_string_from_ascii()
	text = temp
	$Label.text = temp
	$Hint.visible = temp.length()==0 #you're not alone!


func _on_BetterTextEdit_focus_entered():
	$Hint.add_color_override("font_color",Color8(160,160,160,255))

func _on_BetterTextEdit_focus_exited():
	$Hint.add_color_override("font_color",Color8(80,80,80,255))

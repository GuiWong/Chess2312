extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$HTTPRequest.request_completed.connect(_on_request_completed)
	#$HTTPRequest.request("http://0.0.0.0:8000/data.txt")
	#
	#$HTTPRequest.request("0",PackedStringArray.new(),HTTPClient.METHOD_POST)
	test_post()
	

func test_post():
	var headers = ["Content-Type: application/json"]
	var body = "name: value; name2: value2" #{"email":$VBoxContainer/UserNameLineEdit.get_text(),"password":$VBoxContainer/PasswordLineEdit.get_text()}
	#body = JSON.parse_string(body)
	var error = $HTTPRequest.request("http://0.0.0.0:8000/",headers, HTTPClient.METHOD_POST, body)
	print(error)

func _on_request_completed(result, response_code, headers, body):
	#var json = JSON.parse_string(body.get_string_from_utf8())
	#print(json["name"])
	var txt = ''
	for c in body:
		txt += char(c)
	print(result)
	print(response_code)
	print(headers)
	print(txt)
	
func _process(delta):
		pass

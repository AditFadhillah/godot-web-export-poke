extends Control
# Simple player login/registration system

@onready var username_input = $VBoxContainer/UsernameInput
@onready var login_button = $VBoxContainer/LoginButton
@onready var status_label = $VBoxContainer/StatusLabel

var current_username = ""

func _ready():
	login_button.pressed.connect(_on_login_pressed)
	
	# Connect to Supabase manager signals
	if SupabaseManager:
		SupabaseManager.player_data_loaded.connect(_on_player_loaded)
		SupabaseManager.error_occurred.connect(_on_error_occurred)

func _on_login_pressed():
	current_username = username_input.text.strip_edges()
	
	if current_username.length() < 3:
		status_label.text = "Username must be at least 3 characters"
		return
	
	status_label.text = "Logging in..."
	login_button.disabled = true
	
	# Try to get existing player first
	SupabaseManager.get_player(current_username)

func _on_player_loaded(player_data):
	if player_data:
		status_label.text = "Welcome back, " + player_data.username + "!"
		SupabaseManager.current_player_id = player_data.id
		
		# Store player data in GameManager
		if GameManager:
			GameManager.current_player = player_data
		
		# Wait a moment then switch to main menu
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
	else:
		# Player doesn't exist, create new one
		status_label.text = "Creating new player..."
		SupabaseManager.create_player(current_username)

func _on_error_occurred(message):
	# If player doesn't exist, create them
	if "no rows returned" in message.to_lower() or "not found" in message.to_lower():
		status_label.text = "Creating new player..."
		SupabaseManager.create_player(current_username)
	else:
		status_label.text = "Error: " + message
		login_button.disabled = false

func _on_player_created(player_data):
	status_label.text = "Account created! Welcome, " + current_username + "!"
	SupabaseManager.current_player_id = player_data.id
	
	# Store in GameManager
	if GameManager:
		GameManager.current_player = player_data
	
	# Wait a moment then switch to main menu
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
extends Node

signal kill_count_updated(count)

var kill_count = 0

# Method to increment the kill count
func increase_kill_count():
	kill_count += 1
	print("Total kill count: ", kill_count)
	emit_signal("kill_count_updated", kill_count) 

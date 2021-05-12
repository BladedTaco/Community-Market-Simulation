with (obj_agent) {
	instance_destroy();	
}


sales = 0
with (obj_booth) {
	other.sales += sales
}

show_debug_message("EVENT ENDED, RESULTS:")
show_debug_message("   GENRE - " + string(events[0][0]))
show_debug_message("   SCALE - " + string(events[0][1]))
show_debug_message("   PROFITS - " + string(sales))
show_debug_message("   WINDOW_SALES - " + string(window_shopping_sales))
show_debug_message("   AVG CONGESTION - " + string_format(edge_weight_sum/edge_weight_count, 1, 10))


var _s = string(events[0][0]) 
+ ","
+ string(events[0][1])
+ ","
+ string(sales) 
+ ","
+ string(window_shopping_sales)  
+ ","
+ string_format(edge_weight_sum/edge_weight_count, 1, 10)

var _f = file_text_open_append(working_directory + "results.csv")
file_text_write_string(_f, _s)
file_text_writeln(_f)
file_text_close(_f)

// cycle through events
if (--events_left <= 0) {
	if (array_length(events) > 0) {
		array_delete(events, 0, 1)	
	}
	events_left = EVENT_COUNT
}

if (array_length(events) > 0) {
	event_user(0)
} else {
	show_debug_message("DONE")
	game_end();
}
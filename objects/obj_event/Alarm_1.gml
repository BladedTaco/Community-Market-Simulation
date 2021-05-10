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


// cycle through events
if (events_left-- <= 0) {
	if (array_length(events) > 0) {
		array_delete(events, 0, 1)	
	}
}

event_user(0)
with (obj_entry) {
	event_user(1)
}


with (obj_booth) {
	event_user(1)
}


spawn_agents = true;


sales = 0
window_shopping_sales = 0
edge_weight_count = 0
edge_weight_sum = 0

alarm[0] = EVENT_LENGTH

allocate_booths(events[0][0], events[0][1])
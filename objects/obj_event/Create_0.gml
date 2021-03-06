nodes = []
var i = 0;

with (obj_intersection) {
	other.nodes[i] = self
	i++;
}

with (obj_entry) {
	other.nodes[i] = self
	i++;
}

graph = new Graph(nodes)
graph.generate_edges(obj_booth);

with (obj_entry) {
	graph = other.graph	
	node = other.graph.closest_node(self)
	closest_nodes = other.graph.overlapping_edges(self)
}

with (obj_booth) {
	closest_nodes = other.graph.overlapping_edges(doorway)
}

depth = -10000
events_left = EVENT_COUNT
events = [
	[EVENT_SETUP.GENRE_CLUMPED, EVENT_SETUP.GENRE_SCALE_SMOOTH],
	[EVENT_SETUP.GENRE_CLUMPED, EVENT_SETUP.GENRE_SCALE_ROUGH],
	[EVENT_SETUP.GENRE_CLUMPED, EVENT_SETUP.GENRE_SCALE_RANDOM],
	[EVENT_SETUP.GENRE_SPREAD, EVENT_SETUP.GENRE_SCALE_SMOOTH],
	[EVENT_SETUP.GENRE_SPREAD, EVENT_SETUP.GENRE_SCALE_ROUGH],
	[EVENT_SETUP.GENRE_SPREAD, EVENT_SETUP.GENRE_SCALE_RANDOM],
	[EVENT_SETUP.GENRE_RANDOM, EVENT_SETUP.GENRE_SCALE_SMOOTH],
	[EVENT_SETUP.GENRE_RANDOM, EVENT_SETUP.GENRE_SCALE_ROUGH],
	[EVENT_SETUP.GENRE_RANDOM, EVENT_SETUP.GENRE_SCALE_RANDOM]
]

all_visible = true

// set function for booth placement.
event_user(1)

// start the first event
event_user(0)
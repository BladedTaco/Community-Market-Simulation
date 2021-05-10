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
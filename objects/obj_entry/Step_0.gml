if (!keyboard_check(vk_shift) and obj_event.spawn_agents) {
	image_blend = c_gray
	if (countdown-- <= 0) {
		image_blend = c_white
		spawn_count++;
		with (instance_create_depth(x, y, depth - 1, obj_agent)) {
			node = other.node
			entry = other
		}
		countdown = AGENT_SPAWN_COUNTDOWN
	}
} else {
	image_blend = c_dkgray
}
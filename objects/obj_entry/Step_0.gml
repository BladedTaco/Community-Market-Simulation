if (!keyboard_check(vk_shift) and !keyboard_check(vk_control)) {
	if (countdown-- <= 0) {
		spawn_count++;
		with (instance_create_depth(x, y, depth - 1, obj_agent)) {
			node = other.node
			entry = other
		}
		countdown = AGENT_SPAWN_COUNTDOWN
	}
}
if (!keyboard_check(vk_shift)) {
	if (countdown-- <= 0) {
		with (instance_create_depth(x, y, depth - 1, obj_agent)) {
			node = other.node
			entry = other
		}
		countdown = AGENT_SPAWN_COUNTDOWN_MIN + irandom(AGENT_SPAWN_COUNTDOWN_RAND)
	}
}
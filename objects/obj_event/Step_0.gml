spawn_agents = keyboard_check_pressed(vk_control) ? !spawn_agents : spawn_agents

if (keyboard_check_pressed(vk_space)) {
	all_visible = !all_visible
	with (all) {
		visible = other.all_visible
	}
	visible = true
	show_debug_overlay(true)
	
	if (all_visible) {
		if (!instance_exists(obj_inspector)) {
			instance_create_depth(0, 0, -10000, obj_inspector)	
		}
	} else {
		with (obj_inspector) {
			instance_destroy(obj_inspector)
		}
	}
}
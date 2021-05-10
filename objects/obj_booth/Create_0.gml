trigger = instance_create_depth(x, y + 64*image_yscale, depth, obj_trigger);
trigger.owner = self;
trigger.image_xscale = 3;
trigger.image_yscale = 3;

doorway = instance_create_depth(x, y + 64*image_yscale, depth, obj_trigger);
doorway.owner = self;
doorway.image_yscale = 3;

closest_nodes = []

event_user(1)

event_inherited();
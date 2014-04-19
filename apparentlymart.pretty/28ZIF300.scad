
// all dimensions are in mil (0.001in)

corner_radius = 50;
height = 430;
length = 2000;
width = 600;
pin_pitch = 100;
pin_spacing = 300;
zif_slot_spacing = 160;
zif_slot_width = 140;
zif_slot_length = 1400;
zif_slot_depth = 100;
lever_metal_length = 400;
lever_metal_radius = 30;
lever_handle_length = 270;
lever_handle_radius = 180 / 2;
lever_handle_bottom_spacing = 1;
lever_indent_width = 100;
lever_indent_length = 300;
lever_indent_height = height - 200;
lever_metal_protrusion = lever_metal_length - lever_indent_length;
body_color = [1, 0.40, 0.25];
lever_metal_color = [0.75, 0.75, 0.75];
copper_color = [0.75, 0.75, 0.65];
pin_length = 130;
pin_width = 30;
pin_breadth = 20;

module body() {

    linear_extrude(height=height)
    hull()
    {
        translate(
	        [
                corner_radius,
                corner_radius,
                0
	        ]
        )
        circle(r=corner_radius);

        translate(
	        [
                corner_radius,
                width - corner_radius,
                0
	        ]
        )
        circle(r=corner_radius);

        translate(
	        [
                length - corner_radius,
                corner_radius,
                0
	        ]
        )
        circle(r=corner_radius);

        translate(
	        [
                length - corner_radius,
                width - corner_radius,
                0
	        ]
        )
        circle(r=corner_radius);
    }

}

module lever_handle() {
    hull()
    {
        translate(
            [
                lever_handle_radius,
                lever_handle_radius,
                lever_handle_radius
            ]
        )
        sphere(r=lever_handle_radius);
        translate(
            [
                lever_handle_length - lever_handle_radius,
                lever_handle_radius,
                lever_handle_radius
            ]
        )
        sphere(r=lever_handle_radius);
    }
}

module pins() {
    for (i = [0 : 13]) {
        translate([i * pin_pitch, 0, 0])
        cube([pin_breadth, pin_width, pin_length * 2]);
        translate([i * pin_pitch, pin_spacing, 0])
        cube([pin_breadth, pin_width, pin_length * 2]);
    }
}

color(body_color) difference() {
    body();
    translate(
        [-corner_radius, -corner_radius, height - lever_indent_height]
    )
    cube([lever_indent_length + corner_radius, lever_indent_width + corner_radius, height]);

    translate(
        [350, (width / 2) + (zif_slot_spacing / 2), height - zif_slot_depth]
    )
    cube([zif_slot_length, zif_slot_width, height]);

    translate(
        [350, (width / 2) - (zif_slot_spacing / 2) - zif_slot_width, height - zif_slot_depth]
    )
    cube([zif_slot_length, zif_slot_width, height]);
}

translate([-lever_handle_length - lever_metal_protrusion, -lever_handle_radius + lever_metal_radius + (lever_indent_width - (lever_metal_radius*2)) / 2, -lever_handle_radius + lever_metal_radius + lever_handle_bottom_spacing + (height - lever_indent_height)])
color(body_color) lever_handle();

color(lever_metal_color)
translate([-lever_metal_protrusion - lever_handle_radius, lever_metal_radius + (lever_indent_width - (lever_metal_radius*2)) / 2, lever_metal_radius + lever_handle_bottom_spacing + (height - lever_indent_height)])
rotate(a=[0, 90, 0])
cylinder(r=lever_metal_radius, h=lever_metal_length + lever_handle_radius*2);

color(copper_color)
translate([390, 130, -pin_length])
pins();
$fn = 100;
plinth();

module plinth(size=[80,60,10], support=[35,45], base_fat=5, cutout=3) {

	top_height=1;
	top_pad = 3;
	difference() {
		hull() {
			//base_cyl
			translate([0,0, -(size[2]-base_fat)/2]) {
				cylinder(d=size[0], h=base_fat, center = true);
			}

			//top_cube
			translate([0,0, (size[2]-top_height)/2]) {
				cylinder(d=size[1], h=top_height, center = true);
			}
		}
		//cutout
		translate([0,0,(size[2])/2]) {
			cube([support[0], support[1], cutout*2], center=true);
		}

	}
}
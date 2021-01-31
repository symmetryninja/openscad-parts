
$fn = 100;
outer_inner_spacer = 3;
inner_d = 55;
inner_h = 6;
inner_button_d = 12;
inner_button_h = inner_h + 2;

outer_wall_thickness = 4;
outer_diameter_base = inner_d + outer_inner_spacer;
outer_oversize_h = 4;
outer_h = 10;
outer_d_oversize = 8;
outer_d = inner_d + outer_d_oversize;

sensor_cutout_h = 4;
sensor_cutout_d = 19;
sensor_cable_x = 8;
sensor_cable_y = 60;

translate([outer_d/2, outer_d/2,0]) 
  make_inner();
translate([-outer_d/2, -outer_d/2,0]) 
  make_outer();
// inner
  module make_inner() {
    difference() {
      union() {
        cylinder(h=inner_h, d=inner_d, center=true);
        translate([0,0,1]) {
          cylinder(h=inner_button_h, d=inner_button_d, center=true);
        }
      }
      screw_cutout(merge=true);
    }
  }

// outer
  module make_outer() {  
    difference() {
      cylinder(h = outer_h, d = outer_d, center = true);
      union() {
        sensor_cutout();
        screw_cutout();
      }
    }
  }

  module sensor_cutout() {
    translate([0,0,outer_oversize_h]) {
      cylinder(h = outer_h, d = outer_d - outer_d_oversize + 1, center = true);
    }
    translate([0,0,-0.5]) {
      cylinder( h = sensor_cutout_h, d = sensor_cutout_d, center = true);
      translate([0, sensor_cable_y/2, 0]) {
        cube([sensor_cable_x, sensor_cable_y, sensor_cutout_h], center = true);
      }
    }
  }
  module screw_cutout(merge=false) {
    rotate([0,0,60])
      screw_piece(merge);
    rotate([0,0,180])
      screw_piece(merge);
    rotate([0,0,300])
      screw_piece(merge);
  }

  module screw_piece(merge) {
    hull() {
      translate([0, 25,0]) {
        rotate([90,0,0]) {
          if (merge) {
            translate([0,0.5,0])
              cylinder(d = 3.5, h = 15, center = true);
          }
          else {
            translate([0,3,0])
            cylinder(d = 2.5, h = 15, center = true);
          }
        }
      }
      if (merge) {
        translate([0, 25,-4]) {
          rotate([90,0,0]) {
            cylinder(d = 3.5, h = 15, center = true);
          }
        }
      }

    }
  }


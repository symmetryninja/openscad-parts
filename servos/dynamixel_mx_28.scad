// dynamixel_mx_28.scad

dm28_horne_hub_D = 23.4899 * 2;
dm28_horne_hub_outer_D = 70;
dm28_horne_hub_space_H = 41;
dm28_horne_screw_space = 4;
dm28_horne_hub_H = dm28_horne_hub_space_H + (2 * dm28_horne_screw_space);
dm28_horne_hub_outer_angle = 55;
dm28_horne_hub_arc_R = 30;


module dm_mx_28_load_stl() {
  import("../openscad-parts/servos/MX-28T_R.stl");
}


module dm_mx_28_horne_hub_join() {
  rotate([0,0,180])
  difference() {
    hull() {
      translate([0,-5,0]) {
        cylinder(d = 42, h = dm28_horne_hub_H, center=true);
      }
      translate([0,-25,0]) {
        cube([42, 20, dm28_horne_hub_H], center=true);
      }
    }
    cylinder(h=41, d=100, center=true);
  }
}

module dm_mx_28_horne_cutouts(with_cutout=true) {
  for (i = [0:7]) {
    rotate([0,0,135 - (i * 45)]) {
      dm_mx_28_horne_bolt();
    }
  }
  
  hull() {
    cylinder(d=8.5, h=70, center = true);
    if (with_cutout) {
      translate([0,-15,0]) {
        cylinder(d=8.5, h=70, center = true);
      }
    }
  }
  if (with_cutout) {
    translate([0,-25,0]) {
      cylinder(d=34, h=70, center = true);
    }
  }
}

module dm_mx_28_horne_bolt() {
  translate([0,8,0]) {
    cylinder(d=2, h=70, center=true);
  }
}

module dm_mx_28_chassis() {
  difference() {
    dm_mx_28_chassis_box();
    // cutout for rotorbits
    translate([0,-72,0]) {
      cylinder(d = 30, h=50, center=true);
    }
  }
}

module dm_mx_28_chassis_box() {
  hull() {
    hull() {
      cylinder(h=35.6, d=50.6, center=true);
      translate([0,-59, 0]) {
        cube([50.6, 10, 35.6], center = true);
      }
    }
    hull() {
      cylinder(h=25.6, d=53.6, center=true);
      translate([0,-62, 0]) {
        cube([53.6, 10, 25.6], center = true);
      }
    }
  }
}
module dm_mx_28_chassis_cutout(include_web=true) {
  union () {
    if (include_web) {
      //horne size slice
      
      bolt_offset = 15;
      bolt_offset_2 = 8.5;

      bolt_offset_1_Y = 4.5;
      bolt_offset_2_Y = -12.5;
      bolt_offset_3_Y = -29.5;
      bolt_offset_4_Y = -35.8;

      //bolts - front
      translate([bolt_offset,bolt_offset_1_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }
      translate([-bolt_offset, bolt_offset_1_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }
      //bolts - middle
      translate([bolt_offset, bolt_offset_2_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }
      translate([-bolt_offset, bolt_offset_2_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }
      //bolts - end
      translate([bolt_offset, bolt_offset_3_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }
      translate([-bolt_offset, bolt_offset_3_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }
      // bolts - rear
      // translate([bolt_offset_2, bolt_offset_4_Y,0]) {
      //   cylinder(d=2.7, h=60, center = true);
      // }
      // translate([-bolt_offset_2, bolt_offset_4_Y,0]) {
      //   cylinder(d=2.7, h=60, center = true);
      // }
      // central cutout
      translate([0,-10.4,0]) {
        cube([25,45.6,35.9], center=true);
      }

    }
    // screw shelf box cutout (oversized)
    translate([0,-13.35,0]) {
      cube([36.5,51.5,30.3], center=true);
    }
  }
}

module yorick_mx28_horne_for_print(with_cutout=true) {
  difference() {
    dm_mx_28_horne_hub_join();
    dm_mx_28_horne_cutouts(with_cutout);
  }
}



module xht_power_plugs() {
  overall_offset_Y = 3;
  xht_outer_diameter = 8.1;
  outer_diameter_inset = 6.9;
  complete_length = 32.5;

  outer_width = 17;
  plug_grip_end = 13.9;
  cable_end_stub = 1.6;
  plug_end_stub = 2.7;

  grip_wide_h = 1.4;
  join_thickness = 1.6;

  cable_thickness  = 6;
  cable_length  = 15;

  centre_offset = (outer_width - xht_outer_diameter) / 2;

  // thin terminal
  translate([centre_offset, 0, (plug_grip_end - 1)/2]) {
    cylinder(d = outer_diameter_inset, h = complete_length - plug_grip_end  + 1, center = true);
  }
  // wide terminal
  translate([-centre_offset, 0, (plug_grip_end - 1)/2]) {
    cylinder(d = xht_outer_diameter, h = complete_length - plug_grip_end  + 1, center = true);
  }

  base_offset_Z = -(complete_length/2 - plug_grip_end/2);

  // base join
  union() {
    translate([centre_offset, 0, base_offset_Z]) {
      xht_power_plug_base(diameter = xht_outer_diameter, height = plug_grip_end);
    }
    translate([0, 0, -(complete_length/2 - (plug_grip_end+1)/2)]) {
      cube([6, join_thickness, plug_grip_end - 1.8], center = true);
    }
    translate([-centre_offset, 0, base_offset_Z]) {
      xht_power_plug_base(diameter = xht_outer_diameter, height = plug_grip_end);
    }
  }
  // cables
  translate([-centre_offset, 0, base_offset_Z - cable_length + 2]) {
    cylinder(d = cable_thickness, h = cable_length, center = true);
  }
  translate([centre_offset, 0, base_offset_Z - cable_length + 2]) {
    cylinder(d = cable_thickness, h = cable_length, center = true);
  }

}

module xht_power_plug_base(diameter, height){
  cylinder(d = diameter-0.7, h=height, center = true);
  bottom_thickness = 1.8;
  top_thickness = 2.3;
  rib_thickness = 1.2;

  rib_count = 4;
  rib_space = height - top_thickness - rib_thickness/2;

  rib_spacer = rib_space / 5;

  offset = height / 2;

  offset_top = offset - top_thickness / 2;
  offset_bottom = offset - top_thickness / 2;

  offset_1 = offset_top - (rib_spacer * 1) - rib_thickness / 2;
  offset_2 = offset_top - (rib_spacer * 2) - rib_thickness / 2;
  offset_3 = offset_top - (rib_spacer * 3) - rib_thickness / 2;
  offset_4 = offset_top - (rib_spacer * 4) - rib_thickness / 2;

  union() {
    //topblock
    translate([0,0,offset_top]) {
      cylinder(d = diameter, h = top_thickness, center = true);
    }

    //ring 1
    translate([0,0,offset_1]) {
      cylinder(d = diameter, h = rib_thickness, center = true);
    }

    //ring 2
    translate([0,0,offset_2]) {
      cylinder(d = diameter, h = rib_thickness, center = true);
    }

    //ring 3
    translate([0,0,offset_3]) {
      cylinder(d = diameter, h = rib_thickness, center = true);
    }

    //ring 4
    translate([0,0,offset_4]) {
      cylinder(d = diameter, h = rib_thickness, center = true);
    }

    //bottomblock
    translate([0,0,-offset + bottom_thickness/2]) {
      cylinder(d = diameter, h = bottom_thickness, center = true);
    }
  }
}

module xt_60_plug() {
  front_side_X = 11;
  front_side_Y = 15.7;
  front_side_Z = 8.2;
  translate([front_side_X/2, 0, 0]) {

    hull() {
      translate([0,-(front_side_Y/2 -2.75),(front_side_Z/2 - 2.75)]) {
        rotate([0,90,0]) {
          cylinder(d=5.5, h = front_side_X, center = true);
        }
      }
      translate([0,-(front_side_Y/2 -2.75),-(front_side_Z/2 - 2.75)]) {
        rotate([0,90,0]) {
          cylinder(d=5.5, h = front_side_X, center = true);
        }
      }
      translate([0,front_side_Y/2 - 0.5, 0]) {
        cube([front_side_X, 1, front_side_Z], center = true);
      }
    }
  }

  translate([-1.249,0,0]) {
    makeRoundedBox_rotate_90_Y([2.5,17.2, 9.5], d = 4);
  }

  hull() {
    translate([-2.249, 3.6, 0]) {
      rotate([0,90,0]) {
        cylinder(d = 7.8, h=10, center = true);
      }
    }
    translate([-2.249, -3.6, 0]) {
      rotate([0,90,0]) {
        cylinder(d = 7.8, h=10, center = true);
      }
    }
  }
  hull() {
    translate([-8, 3.6, 0]) {
      rotate([0,90,0]) {
        cylinder(d = 6, h=20, center = true);
      }
    }
    translate([-8, -3.6, 0]) {
      rotate([0,90,0]) {
        cylinder(d = 6, h=20, center = true);
      }
    }
  }
}
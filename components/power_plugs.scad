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
    ccylinder(d = outer_diameter_inset, h = complete_length - plug_grip_end  + 1);
  }
  // wide terminal
  translate([-centre_offset, 0, (plug_grip_end - 1)/2]) {
    ccylinder(d = xht_outer_diameter, h = complete_length - plug_grip_end  + 1);
  }

  base_offset_Z = -(complete_length/2 - plug_grip_end/2);

  // base join
  union() {
    translate([centre_offset, 0, base_offset_Z]) {
      xht_power_plug_base(diameter = xht_outer_diameter, height = plug_grip_end);
    }
    translate([0, 0, -(complete_length/2 - (plug_grip_end+1)/2)]) {
      ccube([6, join_thickness, plug_grip_end - 1.8]);
    }
    translate([-centre_offset, 0, base_offset_Z]) {
      xht_power_plug_base(diameter = xht_outer_diameter, height = plug_grip_end);
    }
  }
  // cables
  translate([-centre_offset, 0, base_offset_Z - cable_length + 2]) {
    ccylinder(d = cable_thickness, h = cable_length);
  }
  translate([centre_offset, 0, base_offset_Z - cable_length + 2]) {
    ccylinder(d = cable_thickness, h = cable_length);
  }

}

module xht_power_plug_base(diameter, height){
  ccylinder(d = diameter-0.7, h=height);
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
      ccylinder(d = diameter, h = top_thickness);
    }

    //ring 1
    translate([0,0,offset_1]) {
      ccylinder(d = diameter, h = rib_thickness);
    }

    //ring 2
    translate([0,0,offset_2]) {
      ccylinder(d = diameter, h = rib_thickness);
    }

    //ring 3
    translate([0,0,offset_3]) {
      ccylinder(d = diameter, h = rib_thickness);
    }

    //ring 4
    translate([0,0,offset_4]) {
      ccylinder(d = diameter, h = rib_thickness);
    }

    //bottomblock
    translate([0,0,-offset + bottom_thickness/2]) {
      ccylinder(d = diameter, h = bottom_thickness);
    }
  }
}

module xt_60_plug(for_cutout = false) {
  if (for_cutout) {
    xt_60_plug_sized(oversize = 2, for_cutout=for_cutout);
  }
  else {
    xt_60_plug_sized(oversize = 0, for_cutout=for_cutout);
  }
}

module xt_60_plug_sized(oversize = 0, for_cutout = false) {
  front_side_X = 11;
  front_side_Y = 15.7;
  front_side_Z = 8.2;
  translate([front_side_X/2, 0, 0]) {
    hull() {
      translate([0,-(front_side_Y/2 -2.75),(front_side_Z/2 - 2.75)]) {
        rotate([0,90,0]) {
          ccylinder(d=5.5 + oversize, h = front_side_X);
        }
      }
      translate([0,-(front_side_Y/2 -2.75),-(front_side_Z/2 - 2.75)]) {
        rotate([0,90,0]) {
          ccylinder(d=5.5 + oversize, h = front_side_X);
        }
      }
      translate([0,front_side_Y/2 - 0.5, 0]) {
        ccube([front_side_X, 1, front_side_Z + oversize]);
      }
    }
  }

  // mount lip
  translate([-1.249,0,0]) {
    makeRoundedBox_rotate_90_Y([2.5,17.2, 9.5], d = 4);
  }

  //cable mount point
  hull() {
    translate([-2.249, 3.6, 0]) {
      rotate([0,90,0]) {
        ccylinder(d = 7.8 + oversize, h=10);
      }
    }
    translate([-2.249, -3.6, 0]) {
      rotate([0,90,0]) {
        ccylinder(d = 7.8 + oversize, h=10);
      }
    }
  }
  if (for_cutout) {
    //cable tails
    black()
    hull() {
      translate([-8, 3.6, 0]) {
        rotate([0,90,0]) {
          ccylinder(d = 7, h=20);
        }
      }
      translate([-8, -3.6, 0]) {
        rotate([0,90,0]) {
          ccylinder(d = 7, h=20);
        }
      }
    }
  }
}

module xt_60_plug_with_panel(cutouts_only = false) {
  difference() {
    union() {
      // plug
      translateZ(6)
      rotateY(-90)
      xt_60_plug(for_cutout=cutouts_only);
      // panel
      
      if (cutouts_only) {
        translateY(14.5) {
          ccylinder(h=20, d = 3.5);
        }
        translateY(-14.5) {
          ccylinder(h=20, d = 3.5);
        }
      }
      else {
        green() {
          makeRoundedBox([10.8, 38, 1.6], d = 4);
        }
      }
    }
    union() {
      hull() {
        if (!cutouts_only) {
          translateY(14.5) {
            make_rounded_slot(d = 3.5, l = 6.5, h = 3);
          }
        }
      }
      hull() {
        if (!cutouts_only) {
          translateY(-14.5) {
            make_rounded_slot(d = 3.5, l = 6.5, h = 3);
          }
        }
      }
      //3.5 6.5 29
    }
  }
}

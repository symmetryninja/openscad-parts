
s939_box_X = 23;
s939_box_Y = 12.5;
s939_box_Z = 24;

s939_spline_offset_X = 5.5;
s939_spline_offset_minor_X = -6;
s939_spline_D        = 4.0;
s939_spline_H        = 3;
s939_spline_offset_Z = 9.6;

s939_spline_raiser_D = 12.1;
s939_spline_raiser_H = 5.3;
s939_spline_raiser_minor_D = 6.3;
s939_spline_raiser_minor_H = s939_spline_raiser_H;

s939_cable_offset_from_bottom = 2.7;

s939_overall_height = 28.7;

s939_box_centre_offset_X =  - s939_spline_offset_X;
s939_box_centre_offset_Y = 0;
s939_box_centre_offset_Z = (-(s939_overall_height/2 - s939_box_Z/2)) + 3;

s939_screw_panel_X = 32;
s939_screw_panel_Z = 3;
s939_screw_panel_offset_from_top_Z = 7.5;

s939_screw_panel_offset_X = -s939_spline_offset_X;
s939_screw_panel_offset_Z = s939_overall_height/2 - s939_screw_panel_offset_from_top_Z + 3;

function get_939_box_X() = s939_box_X;
function get_939_box_Y() = s939_box_Y;
function get_939_box_Z() = s939_box_Z;
function get_939_spline_offset_X() = s939_spline_offset_X;
function get_939_spline_offset_minor_X() = s939_spline_offset_minor_X;
function get_939_spline_D() = s939_spline_D;
function get_939_spline_H() = s939_spline_H;
function get_939_spline_offset_Z() = s939_spline_offset_Z;
function get_939_spline_raiser_D() = s939_spline_raiser_D;
function get_939_spline_raiser_H() = s939_spline_raiser_H;
function get_939_spline_raiser_minor_D() = s939_spline_raiser_minor_D;
function get_939_spline_raiser_minor_H() = s939_spline_raiser_minor_H;
function get_939_cable_offset_from_bottom() = s939_cable_offset_from_bottom;
function get_939_overall_height() = s939_overall_height;
function get_939_box_centre_offset_X() = s939_box_centre_offset_X;
function get_939_box_centre_offset_Y() = s939_box_centre_offset_Y;
function get_939_box_centre_offset_Z() = s939_box_centre_offset_Z;
function get_939_screw_panel_X() = s939_screw_panel_X;
function get_939_screw_panel_Z() = s939_screw_panel_Z;
function get_939_screw_panel_offset_from_top_Z() = s939_screw_panel_offset_from_top_Z;
function get_939_screw_panel_offset_X() = s939_screw_panel_offset_X;
function get_939_screw_panel_offset_Z() = s939_screw_panel_offset_Z;


//Main servo
module ds_939_servo() {
  union() {
    ds_939_box();
    ds_939_spline();
    ds_939_spline_raisers();
    ds_939_screw_panel();
  }
}


//box
module ds_939_box() {
  translate([s939_box_centre_offset_X, s939_box_centre_offset_Y, s939_box_centre_offset_Z]) {
    cube([s939_box_X, s939_box_Y, s939_box_Z], center = true);
  }
}

//spline
module ds_939_spline() {
  translate([0,0,s939_spline_H/2 + 3]) {
    cylinder(d=s939_spline_D, h=s939_overall_height + s939_spline_H, center = true);
  }
}
//spline raisers
module ds_939_spline_raisers() {
  translate([0,0,3]) {
    cylinder(d = s939_spline_raiser_D, h = s939_overall_height, center = true);
  }
  translate([s939_spline_offset_minor_X,0,3]) {
    cylinder(d = s939_spline_raiser_minor_D, h = s939_overall_height, center = true);
  }
}
//screw panel
module ds_939_screw_panel() {
  translate([s939_screw_panel_offset_X,0,s939_screw_panel_offset_Z]) {
    cube([s939_screw_panel_X, s939_box_Y, s939_screw_panel_Z], center = true);
  }
}

s939_horne_middle_H = 4.6;
s939_horne_middle_D = 4.6;
s939_horne_outer_H = 1.6;
s939_horne_outer_D = 21;
s939_horne_outer_top_difference = 0.5;

s939_horne_screw_distance = 15;
s939_horne_screw_distance_2 = 13.14;
s939_horne_offset_Z = s939_overall_height/2 + 4;

s939_servo_screw_difference = 28.7;
s939_servo_screw_D = 1.5;
s939_servo_screw_H = 16;

module ds_939_round_horne() {
  difference() {
    union() {
      cylinder(d = s939_horne_middle_D, h = s939_horne_middle_H, center = true);
      translate([0,0, s939_horne_middle_H/2 - s939_horne_outer_H/2 - s939_horne_outer_top_difference]) {
        cylinder(d = s939_horne_outer_D, h = s939_horne_outer_H, center = true);
      }
    }
    ds_939_round_screws();
  }
}

module ds_939_round_screws(withHexBlank=true) {
  translate([-s939_horne_screw_distance/2, 0, 1.2]) {
    screw6M25Button(withHexBlank=withHexBlank, hexBlankH = 5, hexBlankD=9, screwPurchase = 3, screwheadDiameter = 10);
  }
  translate([s939_horne_screw_distance/2, 0, 1.2]) {
    screw6M25Button(withHexBlank=withHexBlank, hexBlankH = 5, hexBlankD=9, screwPurchase = 3, screwheadDiameter = 10);
  }
  translate([0,-s939_horne_screw_distance_2/2, 1.2]) {
    screw6M25Button(withHexBlank=withHexBlank, hexBlankH = 5, hexBlankD=9, screwPurchase = 3, screwheadDiameter = 10);
  }
  translate([0,s939_horne_screw_distance_2/2, 1.2]) {
    screw6M25Button(withHexBlank=withHexBlank, hexBlankH = 5, hexBlankD=9, screwPurchase = 3, screwheadDiameter = 10);
  }
}
module ds_939_round_horne_cutouts() {
  union() {
    translate([0,0, s939_horne_offset_Z + 2]) {
      cylinder(d = s939_horne_middle_D, h = s939_horne_middle_H + 8, center = true);
      translate([0,0, s939_horne_middle_H/2 - s939_horne_outer_H/2 - s939_horne_outer_top_difference - 1]) {
        cylinder(d = s939_horne_outer_D, h = s939_horne_outer_H + 2, center = true);
      }
      ds_939_round_screws(withHexBlank=false);
      translate([0, 0, 10.235]) {
        cube([15, 10, 10.1], center = true);
      }
    }
    translate([0, 0, -19]) {
      screw10M3Button(withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3, screwheadHeight = 4);
    }
    translate([0, 0, -21]) {
      cylinder(d = 5, h = 10, center = true);
    }
    translate([0, 0, -17.5]) {
      cylinder(d = 6, h = 3, center = true);
    }
    translate([10, 0, -9]) {
      cube([10,9,3], center = true);
    }
    translate([s939_box_centre_offset_X, 0, 3]) {
      translate([s939_servo_screw_difference/2, 0, 0]) {
        cylinder(d = s939_servo_screw_D, h = s939_servo_screw_H, center = true);
      }
      translate([-s939_servo_screw_difference/2, 0, 0]) {
        cylinder(d = s939_servo_screw_D, h = s939_servo_screw_H, center = true);
      }
    }
  }
}

//servo screws
s939_horne_join_H = 5;
s939_horne_join_D = 26;
s939_horne_join_D_2 = 26;
s939_horne_join_2_offset_X = 20;
s939_horne_join_offset_Z = s939_horne_offset_Z + 3.5;


module ds_939_horne_hub_1() {
  translate([0, 0, s939_horne_join_offset_Z]) {
    cylinder(d = s939_horne_join_D, h = s939_horne_join_H, center = true);
  }
}
module ds_939_horne_hub_2() {
  translate([0, 0, -s939_horne_join_offset_Z]) {
    cylinder(d = s939_horne_join_D, h = s939_horne_join_H, center = true);
  }
}


module ds_939_horne_hubs(with_minor = false) {
  union() {
    hull() {
      ds_939_horne_hub_1();
      if (with_minor) {
        translate([s939_horne_join_2_offset_X, 0,s939_horne_join_offset_Z]) {
          cylinder(d =s939_horne_join_D_2, h =s939_horne_join_H, center = true);
        }
      }
    }

    hull() {
      ds_939_horne_hub_2();
      if (with_minor) {
        translate([s939_horne_join_2_offset_X, 0, -s939_horne_join_offset_Z]) {
          cylinder(d = s939_horne_join_D_2, h = s939_horne_join_H, center = true);
        }
      }
    }
  }
}

module ds_939_horne_joins() {
  difference() {
    ds_939_horne_hubs(with_minor = true);
    ds_939_round_horne_cutouts();
  }
}

module ds_939_horne_join_top() {
  difference() {
    ds_939_horne_joins();
    union() {
      translate([30, 0 ,0]) {
        cube([40,6,10], center = true);
      }
      translate([0,0,-50]) {
        cube([100, 100, 100], center = true);
      }
    }
  }
}



module ds_939_horne_join_bottom() {
  intersection() {
    ds_939_horne_joins();
    union() {
      translate([30, 0 ,0]) {
        cube([40,6,10], center = true);
      }
      translate([0,0,-50]) {
        cube([100, 100, 100], center = true);
      }
    }
  }
}

module make_939_servo_box(include_servo_cable = true, box_tail_oversize = 20) {
  difference() {
    union() {
      translate([s939_box_centre_offset_X + (6 - box_tail_oversize/2),s939_box_centre_offset_Y,s939_box_centre_offset_Z - 2.8]) {
        make_rounded_box([get_939_box_X() + box_tail_oversize, get_939_box_Y() + 3, get_939_screw_panel_offset_Z() + 14.5]);
      }
      if (include_servo_cable) {
        translate([s939_box_centre_offset_X, 5, -2]) {
          rotate([0, 90, 0]) {
            difference() {
              cylinder(d = 23, h = 6, center = true);
              cylinder(d = 16, h = 12, center = true);
            }
          }
        }
      }
      translate([0, 0, -15.5]) {
        cylinder(d = get_939_box_Y() + 3, h = 6, center = true);
      }
    }
    union() {
      ds_939_servo();
      ds_939_round_horne_cutouts();
      translate([s939_box_centre_offset_X, 0, -1]) {
        cube([15, 18.9, 10], center = true);
      }
    }
  }
}



939_box_X = 23;
939_box_Y = 12.5;
939_box_Z = 24;

939_spline_offset_X = 5.5;
939_spline_offset_minor_X = -6;
939_spline_D        = 4.0;
939_spline_H        = 3;
939_spline_offset_Z = 9.6;

939_spline_raiser_D = 12.1;
939_spline_raiser_H = 5.3;
939_spline_raiser_minor_D = 6.3;
939_spline_raiser_minor_H = 939_spline_raiser_H;

939_cable_offset_from_bottom = 2.7;

939_overall_height = 28.7;

939_box_centre_offset_X =  - 939_spline_offset_X;
939_box_centre_offset_Y = 0;
939_box_centre_offset_Z = (-(939_overall_height/2 - 939_box_Z/2)) + 3;

939_screw_panel_X = 32;
939_screw_panel_Z = 3;
939_screw_panel_offset_from_top_Z = 7.5;

939_screw_panel_offset_X = -939_spline_offset_X;
939_screw_panel_offset_Z = 939_overall_height/2 - 939_screw_panel_offset_from_top_Z + 3;

function get_939_box_X() = 939_box_X;
function get_939_box_Y() = 939_box_Y;
function get_939_box_Z() = 939_box_Z;
function get_939_spline_offset_X() = 939_spline_offset_X;
function get_939_spline_offset_minor_X() = 939_spline_offset_minor_X;
function get_939_spline_D() = 939_spline_D;
function get_939_spline_H() = 939_spline_H;
function get_939_spline_offset_Z() = 939_spline_offset_Z;
function get_939_spline_raiser_D() = 939_spline_raiser_D;
function get_939_spline_raiser_H() = 939_spline_raiser_H;
function get_939_spline_raiser_minor_D() = 939_spline_raiser_minor_D;
function get_939_spline_raiser_minor_H() = 939_spline_raiser_minor_H;
function get_939_cable_offset_from_bottom() = 939_cable_offset_from_bottom;
function get_939_overall_height() = 939_overall_height;
function get_939_box_centre_offset_X() = 939_box_centre_offset_X;
function get_939_box_centre_offset_Y() = 939_box_centre_offset_Y;
function get_939_box_centre_offset_Z() = 939_box_centre_offset_Z;
function get_939_screw_panel_X() = 939_screw_panel_X;
function get_939_screw_panel_Z() = 939_screw_panel_Z;
function get_939_screw_panel_offset_from_top_Z() = 939_screw_panel_offset_from_top_Z;
function get_939_screw_panel_offset_X() = 939_screw_panel_offset_X;
function get_939_screw_panel_offset_Z() = 939_screw_panel_offset_Z;


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
  translate([939_box_centre_offset_X, 939_box_centre_offset_Y, 939_box_centre_offset_Z]) {
    cube([939_box_X, 939_box_Y, 939_box_Z], center = true);
  }
}

//spline
module ds_939_spline() {
  translate([0,0,939_spline_H/2 + 3]) {
    cylinder(d=939_spline_D, h=939_overall_height + 939_spline_H, center = true);
  }
}
//spline raisers
module ds_939_spline_raisers() {
  translate([0,0,3]) {
    cylinder(d = 939_spline_raiser_D, h = 939_overall_height, center = true);
  }
  translate([939_spline_offset_minor_X,0,3]) {
    cylinder(d = 939_spline_raiser_minor_D, h = 939_overall_height, center = true);
  }
}
//screw panel
module ds_939_screw_panel() {
  translate([939_screw_panel_offset_X,0,939_screw_panel_offset_Z]) {
    cube([939_screw_panel_X, 939_box_Y, 939_screw_panel_Z], center = true);
  }
}

939_horne_middle_H = 4.6;
939_horne_middle_D = 4.6;
939_horne_outer_H = 1.6;
939_horne_outer_D = 21;
939_horne_outer_top_difference = 0.5;

939_horne_screw_distance = 15;
939_horne_screw_distance_2 = 13.14;
939_horne_offset_Z = 939_overall_height/2 + 4;

939_servo_screw_difference = 28.7;
939_servo_screw_D = 1.5;
939_servo_screw_H = 16;

module ds_939_round_horne() {
  difference() {
    union() {
      cylinder(d = 939_horne_middle_D, h = 939_horne_middle_H, center = true);
      translate([0,0, 939_horne_middle_H/2 - 939_horne_outer_H/2 - 939_horne_outer_top_difference]) {
        cylinder(d = 939_horne_outer_D, h = 939_horne_outer_H, center = true);
      }
    }
    ds_939_round_screws();
  }
}

module ds_939_round_screws(withHexBlank=true) {
  translate([-939_horne_screw_distance/2, 0, 1.2]) {
    screw6M25Button(withHexBlank=withHexBlank, hexBlankH = 5, hexBlankD=9, screwPurchase = 3, screwheadDiameter = 10);
  }
  translate([939_horne_screw_distance/2, 0, 1.2]) {
    screw6M25Button(withHexBlank=withHexBlank, hexBlankH = 5, hexBlankD=9, screwPurchase = 3, screwheadDiameter = 10);
  }
  translate([0,-939_horne_screw_distance_2/2, 1.2]) {
    screw6M25Button(withHexBlank=withHexBlank, hexBlankH = 5, hexBlankD=9, screwPurchase = 3, screwheadDiameter = 10);
  }
  translate([0,939_horne_screw_distance_2/2, 1.2]) {
    screw6M25Button(withHexBlank=withHexBlank, hexBlankH = 5, hexBlankD=9, screwPurchase = 3, screwheadDiameter = 10);
  }
}
module ds_939_round_horne_cutouts() {
  union() {
    translate([0,0, 939_horne_offset_Z + 2]) {
      cylinder(d = 939_horne_middle_D, h = 939_horne_middle_H + 8, center = true);
      translate([0,0, 939_horne_middle_H/2 - 939_horne_outer_H/2 - 939_horne_outer_top_difference - 1]) {
        cylinder(d = 939_horne_outer_D, h = 939_horne_outer_H + 2, center = true);
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
    translate([939_box_centre_offset_X, 0, 3]) {
      translate([939_servo_screw_difference/2, 0, 0]) {
        cylinder(d = 939_servo_screw_D, h = 939_servo_screw_H, center = true);
      }
      translate([-939_servo_screw_difference/2, 0, 0]) {
        cylinder(d = 939_servo_screw_D, h = 939_servo_screw_H, center = true);
      }
    }
  }
}

//servo screws
939_horne_join_H = 5;
939_horne_join_D = 26;
939_horne_join_D_2 = 26;
939_horne_join_2_offset_X = 20;
939_horne_join_offset_Z = 939_horne_offset_Z + 3.5;


module ds_939_horne_hub_1() {
  translate([0, 0, 939_horne_join_offset_Z]) {
    cylinder(d = 939_horne_join_D, h = 939_horne_join_H, center = true);
  }
}
module ds_939_horne_hub_2() {
  translate([0, 0, -939_horne_join_offset_Z]) {
    cylinder(d = 939_horne_join_D, h = 939_horne_join_H, center = true);
  }
}


module ds_939_horne_hubs(with_minor = false) {
  union() {
    hull() {
      ds_939_horne_hub_1();
      if (with_minor) {
        translate([939_horne_join_2_offset_X, 0, 939_horne_join_offset_Z]) {
          cylinder(d = 939_horne_join_D_2, h = 939_horne_join_H, center = true);
        }
      }
    }

    hull() {
      ds_939_horne_hub_2();
      if (with_minor) {
        translate([939_horne_join_2_offset_X, 0, -939_horne_join_offset_Z]) {
          cylinder(d = 939_horne_join_D_2, h = 939_horne_join_H, center = true);
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
      translate([939_box_centre_offset_X + (6 - box_tail_oversize/2), 939_box_centre_offset_Y, 939_box_centre_offset_Z - 2.8]) {
        makeRoundedBox([get_939_box_X() + box_tail_oversize, get_939_box_Y() + 3, get_939_screw_panel_offset_Z() + 14.5]);
      }
      if (include_servo_cable) {
        translate([939_box_centre_offset_X, 5, -2]) {
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
      translate([939_box_centre_offset_X, 0, -1]) {
        cube([15, 18.9, 10], center = true);
      }
    }
  }
}


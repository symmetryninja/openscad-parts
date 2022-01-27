include <../../openscad-parts/tools.scad>

/*
  outputs
*/

// drain_bucket();
// %gizmo_resovior_base_shape(height_Z = 20);
// gizmo_top_panel();
gizmo_top_panel_base();
gizmo_top_panel_top();

// Resovior basic shape
R_main_rectangle_X = 212;
R_main_rectangle_Y = 126;
R_rail_tabs_X = 60;
R_rail_tabs_Y = 16;
R_front_tab_X = 30;
R_front_tab_Y = 16;

R_drain_tab_X = 90;
R_drain_tab_Y = 6;
R_drain_tab_Z = 20;



$fn = 80;

module gizmo_resovior_base_shape(height_Z = 4) {
  union() {
    ccube([R_main_rectangle_X, R_main_rectangle_Y, height_Z]);
    translate([-(R_main_rectangle_X/2 - R_rail_tabs_X/2), R_rail_tabs_Y/2, 0]) {
      ccube([R_rail_tabs_X, R_main_rectangle_Y + R_rail_tabs_Y, height_Z]);
    }
    translate([(R_main_rectangle_X/2 - R_rail_tabs_X/2), R_rail_tabs_Y/2, 0]) {
      ccube([R_rail_tabs_X, R_main_rectangle_Y + R_rail_tabs_Y, height_Z]);
    }
    translate([0, -R_front_tab_Y/2, 0]) {
      ccube([R_front_tab_X, R_main_rectangle_Y + R_front_tab_Y, height_Z]);
    }
  }
}

module gizmo_resovior_base_oversize(oversize, height_Z = 4) {
  minkowski() {
    gizmo_resovior_base_shape(height_Z=height_Z - 2);
    ccube([oversize, oversize, 1]);
  }
}

module drain_bucket() {
  difference() {
    union() {
      base_bolt(bolt_H=6);
      gizmo_resovior_base_oversize(oversize=20, height_Z = 7);
    }
    union() {
      translate([0,0,0.5])
      gizmo_resovior_base_oversize(oversize=10, height_Z = 7);
      base_bolt(bolt_D = 3, bolt_H = 10);
    }
  }
}

// Bolt values
  bolt_row_1_Y = R_main_rectangle_Y / 2 + 13;
  bolt_row_2_Y = -bolt_row_1_Y;

  bolt_1_X = R_main_rectangle_X / 2 + 8;
  bolt_2_a_X = 35;
  bolt_3_a_X = -bolt_2_a_X;
  bolt_2_b_X = 25;
  bolt_3_b_X = -bolt_2_b_X;
  bolt_4_X = -bolt_1_X;

  boly_ends_offset_Y_1 = 10;
  boly_ends_offset_Y_2 = 5;

  bolt_space_D = 15;


module base_bolt(bolt_D = 10, bolt_H = 4) {
  translate([0, bolt_row_1_Y, 0]) {
    translate([bolt_1_X, boly_ends_offset_Y_1, 0]) {
      ccylinder(d = bolt_D, h = bolt_H);
    }
    translate([bolt_2_a_X, 0, 0]) {
      ccylinder(d = bolt_D, h = bolt_H);
    }
    translate([bolt_3_a_X, 0, 0]) {
      ccylinder(d = bolt_D, h = bolt_H);
    }
    translate([bolt_4_X, boly_ends_offset_Y_1, 0]) {
      ccylinder(d = bolt_D, h = bolt_H);
    }
  }
  translate([bolt_1_X, 0, 0]) {
    ccylinder(d = bolt_D, h = bolt_H);
  }
  translate([bolt_4_X, 0, 0]) {
    ccylinder(d = bolt_D, h = bolt_H);
  }
  translate([0, bolt_row_2_Y, 0]) {
    translate([bolt_1_X, boly_ends_offset_Y_2, 0]) {
      ccylinder(d = bolt_D, h = bolt_H);
    }
    translate([bolt_2_b_X, 0, 0]) {
      ccylinder(d = bolt_D, h = bolt_H);
    }
    translate([bolt_3_b_X, 0, 0]) {
      ccylinder(d = bolt_D, h = bolt_H);
    }
    translate([bolt_4_X, boly_ends_offset_Y_2, 0]) {
      ccylinder(d = bolt_D, h = bolt_H);
    }
  }
}

module gizmo_top_panel_unibody() {
  Tz(-2.5) {
    gizmo_resovior_base_oversize(oversize = 7, height_Z = 15);
  }

  translate([-65, -77.5, 8]) {
    ccube([70, 55, 35]);
  }
  translate([-61, -75.5, 8]) {
    ccube([97, 62, 35]);
  }
}
module gizmo_top_panel_cutouts() {
  Tz(-4.5) {
    gizmo_resovior_base_oversize(oversize = 1, height_Z = 15);
  }
  //bucket cutouts
  translate([-65, -76, 5]) {
    ccube([75, 50, 30]);
  }
  translate([-60.5, -60, 5]) {
    ccube([92, 20, 30]);
  }

  // boltholes
  translate([-63.5, -80, 6]) {
    translate([-42,0,0]) {
      ccylinder(d = 3.5, h = 40);
    }
    translate([42,0,0]) {
      ccylinder(d = 3.5, h = 40);
    }
  }
  // Vertical columns
  translate([-87.5, 75, 0]) {
    ccube([20, 40, 40]);
  }
  translate([87.5, 75, 0]) {
    ccube([20, 40, 40]);
  }
}

module gizmo_top_panel() {
  difference() {
    gizmo_top_panel_unibody();
    gizmo_top_panel_cutouts();
  }
}

module gizmo_top_panel_cutter_box() {
  translate([-65, -70, 24.5001]) {
    ccube([110, 80, 40]);
  }
}

module gizmo_top_panel_top() {
  Ry(-180)
  translate([65, 200, -9])
  intersection() {
    gizmo_top_panel_cutter_box();
    gizmo_top_panel();
  }
}
module gizmo_top_panel_base() {
  Ry(-180)
  difference() {
    gizmo_top_panel();
    gizmo_top_panel_cutter_box();
  }
}
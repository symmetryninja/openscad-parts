/****
  3A non shielded bucky
  ---------------------------
****/
module make_power_supply_bucky_3a() {
  difference() {
    union() {  
      board_X = 21;
      board_Y = 43;
      board_Z = 1.6;
      // board
      green() {
        ccube([board_X, board_Y, board_Z]);
      }
      // caps
      offset_Y = (board_Y - 8)/2;
      offset_Z = 4.5;
      translate([0, offset_Y, offset_Z])
        component_make_electrolytic_capacitor(cap_D = 8, cap_H = 9.5, case_color="silver");
      translate([0, -offset_Y, offset_Z])
        component_make_electrolytic_capacitor(cap_D = 8, cap_H = 9.5, case_color="silver");
      // adjustment pot
      blue() {
        translate([-6.5, -7, 5])
        ccube([4.5, 9.5, 10.5]);

      }
      // coil
      black() {
        translate([4, -6, 4])
        ccube([12, 12, 8.5]);

      // ic
        translate([5.5,6,2.75]) ccube([8.5, 9.8, 6]);

      }
      // solderpads
      pad_X = (board_X - 4.5)/2 - 0.1;
      pad_Y = (board_Y - 4.5)/2 - 0.1;
      pad_Z = 0.6;
      silver() {
        translate([pad_X, pad_Y, pad_Z]) ccube([4.5, 4.5, 0.5]);
        translate([pad_X, -pad_Y, pad_Z]) ccube([4.5, 4.5, 0.5]);
        translate([-pad_X, pad_Y, pad_Z]) ccube([4.5, 4.5, 0.5]);
        translate([-pad_X, -pad_Y, pad_Z]) ccube([4.5, 4.5, 0.5]);
        translate([-8, -15, pad_Z]) ccylinder(d = 4.5, h = pad_Z);
        translate([8, 15, pad_Z]) ccylinder(d = 4.5, h = pad_Z);
      }
    }
    #make_power_supply_bucky_3a_screws();
  }
}

module make_power_supply_bucky_3a_screws(height = 5) {
  translate([-8, -15, 0]) ccylinder(d = 3.5, h = height);
  translate([8, 15, 0]) ccylinder(d = 3.5, h = height);
}

/****
  5A non shielded bucky
  ---------------------------
****/
module make_power_supply_bucky_5a() {
  difference() {
    union() {  
      board_X = 38;
      board_Y = 66;
      board_Z = 1.6;
      // board
      green() ccube([board_X, board_Y, board_Z]);
      // caps
      offset_X = -11;
      offset_Y = 20;
      offset_Z = 4.5;
      translate([offset_X, offset_Y, offset_Z])
        component_make_electrolytic_capacitor(cap_D = 10, cap_H = 9.5, case_color="silver");
      translate([offset_X, -offset_Y, offset_Z])
        component_make_electrolytic_capacitor(cap_D = 10, cap_H = 9.5, case_color="silver");
      // adjustment pot
      blue() {
        translate([-16.5, 6, 5])
        ccube([4.5, 9.5, 10.5]);
      }
      // coil
      peru() {
        translate([-7.4, 7.6, 4])
        torus_square(6, 12, 9);
      }
      // ic & heatsync
      silver() {
        translate([-7.4, -7.6, 4.9]) ccube([16, 12, 10]);
      }
      // wiring blocks
      blue() {
        translate([0, 27, 5.5]) {
          cube([11, 8, 11], center=true);
        }
        translate([0, -27, 5.5]) {
          cube([11, 8, 11], center=true);
        }
      }
      // display box
      white() translate([12, 0, 5]) ccube([14, 22, 9]);
      // button
      translate([15, 21, 0]) component_momentary_switch_smd();

    }
    #make_power_supply_bucky_5a_screws();
  }
}

module make_power_supply_bucky_5a_screws(height = 5, screw_diameter = 3.5) {
  make_drill_holes([31.8, 59.9, height], shaftD = screw_diameter);
}


/****
  10A non shielded bucky
  ---------------------------
****/

function buck_10a_board_X() = 42.7;
function buck_10a_board_Y() = 56;
function buck_10a_board_Z() = 1.6;

function buck_10a_heatsync_X() = 15;
function buck_10a_heatsync_Y() = buck_10a_board_Y();
function buck_10a_heatsync_Z() = 20;

function buck_10a_heatsync_space() = 34;
function buck_10a_board_offset_Z() = buck_10a_board_Z() / 2;

heatsync_box_offset_spacer_Y = 1.65;
heatsync_box_offset_spacer_X = 1.85;

heatsync_box_X = buck_10a_heatsync_X() + 4;
heatsync_box_Y = (buck_10a_board_Y() - (heatsync_box_offset_spacer_Y * 8)) / 7;
heatsync_box_Z = buck_10a_heatsync_Z() + 4;

heatsync_box_offset_Y_0 = 0;
heatsync_box_offset_Y_1 = (heatsync_box_Y * 1) + (heatsync_box_offset_spacer_Y * 1);
heatsync_box_offset_Y_2 = (heatsync_box_Y * 2) + (heatsync_box_offset_spacer_Y * 2);
heatsync_box_offset_Y_3 = (heatsync_box_Y * 3) + (heatsync_box_offset_spacer_Y * 3);

heatsync_box_offset_X = (heatsync_box_X/2 + heatsync_box_offset_spacer_X) - (buck_10a_heatsync_X()/2);
heatsync_box_offset_Z = 0;

module make_power_supply_bucky_10a() {
  //board
  color("green") {
    translate([0, 0, buck_10a_board_offset_Z()]) {
      cube([buck_10a_board_X(), buck_10a_board_Y(), buck_10a_board_Z()], center = true);
    }
  }

  //toroid
  color("Peru") {
    translate([0, -5, 6.5 + buck_10a_board_Z() + 0.01]) {
      difference() {
        cylinder(d = 21, h = 13, center = true);
        cylinder(d = 9, h = 15, center = true);
      }
    }
  }

  //terminal
  color("blue") {
    translate([6, buck_10a_board_Y()/2 - 3.5, 5 + buck_10a_board_Z()]) {
      cube([20, 7, 10], center = true);
    }
  }

  //caps
  color("green") {
    translate([0, 0, 8 + buck_10a_board_Z() + 0.01]) {
      translate([11, 12, 0]) {
        cylinder(d = 10, h = 16, center = true);
      }
      translate([-11, 12, 0]) {
        cylinder(d = 10, h = 16, center = true);
      }
      translate([1, 14, 0]) {
        cylinder(d = 10, h = 16, center = true);
      }
      translate([-11, 22, 0]) {
        cylinder(d = 10, h = 16, center = true);
      }
    }
  }

  //LEDs
  color("red") {
    translate([0, -24, 4]) {
      cylinder(d = 3, h = 5, center = true);
    }
  }
  color("white") {
    translate([-6, -24, 4]) {
      cylinder(d = 3, h = 5, center = true);
    }
  }

  //Variable resistors
  color("blue") {
    translate([-14, -buck_10a_board_Y() / 2 + 4.5, 5 + buck_10a_board_Z()]) {
      cube([5, 9, 10], center = true);
    }
    translate([11, -buck_10a_board_Y() / 2 + 2.5, 5 + buck_10a_board_Z()]) {
      cube([9, 5, 10], center = true);
    }
  }

  //heatsyncs
  color("DimGray") {
    translate([0, -2, 0]) {
      make_bucky_10a_heatsync();
    }
    translate([0, -1, 0]) {
      mirror([1, 0, 0]) {
        make_bucky_10a_heatsync();
      }
    }
  }
}

module make_bucky_10a_heatsync_screw_single() {
  translate([-4, heatsync_box_offset_Y_3 + 0.4, 20]) {
    cylinder(d=2.7, h=30, center = true);
    
  }
  translate([-4, -heatsync_box_offset_Y_3, 20]) {
    cylinder(d=2.7, h=30, center = true);
  }
}

module make_bucky_10a_heatsync() {
  translate([buck_10a_heatsync_X()/2 + buck_10a_heatsync_space()/2, 0, buck_10a_heatsync_Z()/2 + buck_10a_board_Z() + 0.01]) {
    difference() {
      //outer box
      cube([buck_10a_heatsync_X(), buck_10a_heatsync_Y(), buck_10a_heatsync_Z()], center = true);
      union() {
        //inner boxes
        translate([heatsync_box_offset_X +3.2, heatsync_box_offset_Y_3, heatsync_box_offset_Z]) {
          cube([heatsync_box_X, heatsync_box_Y, heatsync_box_Z], center = true);
        }
        translate([heatsync_box_offset_X, heatsync_box_offset_Y_2, heatsync_box_offset_Z]) {
          cube([heatsync_box_X, heatsync_box_Y, heatsync_box_Z], center = true);
        }
        translate([heatsync_box_offset_X, heatsync_box_offset_Y_1, heatsync_box_offset_Z]) {
          cube([heatsync_box_X, heatsync_box_Y, heatsync_box_Z], center = true);
        }
        translate([heatsync_box_offset_X, heatsync_box_offset_Y_0, heatsync_box_offset_Z]) {
          cube([heatsync_box_X, heatsync_box_Y, heatsync_box_Z], center = true);
        }
        translate([heatsync_box_offset_X, -heatsync_box_offset_Y_1, heatsync_box_offset_Z]) {
          cube([heatsync_box_X, heatsync_box_Y, heatsync_box_Z], center = true);
        }
        translate([heatsync_box_offset_X, -heatsync_box_offset_Y_2, heatsync_box_offset_Z]) {
          cube([heatsync_box_X, heatsync_box_Y, heatsync_box_Z], center = true);
        }
        translate([heatsync_box_offset_X +3.2, -heatsync_box_offset_Y_3, heatsync_box_offset_Z]) {
          cube([heatsync_box_X, heatsync_box_Y, heatsync_box_Z], center = true);
        }
      }
    }
    make_bucky_10a_heatsync_screw_single();
  }
}

module make_bucky_10a_heatsync_screws() {
  translate([0, -2, 0]) {
    translate([buck_10a_heatsync_X()/2 + buck_10a_heatsync_space()/2, 0, buck_10a_heatsync_Z()/2 + buck_10a_board_Z() + 0.01]) {
      make_bucky_10a_heatsync_screw_single();
    }
  }
  translate([0, -1, 0]) {
    mirror([1, 0, 0]) translate([buck_10a_heatsync_X()/2 + buck_10a_heatsync_space()/2, 0, buck_10a_heatsync_Z()/2 + buck_10a_board_Z() + 0.01]) {
      make_bucky_10a_heatsync_screw_single();
    }
  }
}



/****
  10A shielded bucky 
  ---------------------------
****/

power_supply_offset_X = -90;
power_supply_offset_Y = -15;
power_supply_offset_Z = 27;

power_supply_X = 58;
power_supply_Y = 34;
power_supply_Z = 85;

power_supply_spacing_X = 8;
power_supply_spacing_Y = 10;

power_board_offset_X_1 = power_supply_Y/2 + power_supply_spacing_X/2;
power_board_offset_X_0 = power_board_offset_X_1 + power_supply_Y + power_supply_spacing_X;
power_board_offset_X_2 = -power_board_offset_X_1;
power_board_offset_X_3 = -power_board_offset_X_0;
power_board_offset_Y = 0;
power_board_offset_Z = power_supply_Z/2;

power_board_rotation_X = 0;
power_board_rotation_Y = 0;
power_board_rotation_Z = 90;


function get_power_supply_offset_X() = power_supply_offset_X;
function get_power_supply_offset_Y() = power_supply_offset_Y;
function get_power_supply_offset_Z() = power_supply_offset_Z;
function get_power_supply_X() = power_supply_X;
function get_power_supply_Y() = power_supply_Y;
function get_power_supply_Z() = power_supply_Z;
function get_power_supply_spacing_X() = power_supply_spacing_X;
function get_power_supply_spacing_Y() = power_supply_spacing_Y;
function get_power_board_offset_X_1() = power_board_offset_X_1;
function get_power_board_offset_X_0() = power_board_offset_X_0;
function get_power_board_offset_X_2() = power_board_offset_X_2;
function get_power_board_offset_X_3() = power_board_offset_X_3;
function get_power_board_offset_Y() = power_board_offset_Y;
function get_power_board_offset_Z() = power_board_offset_Z;
function get_power_board_rotation_X() = power_board_rotation_X;
function get_power_board_rotation_Y() = power_board_rotation_Y;
function get_power_board_rotation_Z() = power_board_rotation_Z;

function get_board_power_supply_spacing_X() = power_grid_spacing_X;
function get_board_power_supply_spacing_Y() = power_grid_spacing_Y;

module boards_make_4_power_supply() {
  translate([power_supply_offset_X, power_supply_offset_Y, power_supply_offset_Z]) {
    translate([power_board_offset_X_0, power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_10a_shielded_bucky();
      }
    }
    translate([power_board_offset_X_1, power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_10a_shielded_bucky();
      }
    }
    translate([power_board_offset_X_2, -power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_10a_shielded_bucky();
      }
    }
    translate([power_board_offset_X_3, -power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_10a_shielded_bucky();
      }
    }
  }
}

module make_4_power_supply_screws() {
  translate([power_supply_offset_X, power_supply_offset_Y, power_supply_offset_Z]) {
    translate([power_board_offset_X_0, power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_power_supply_screws();
      }
    }
    translate([power_board_offset_X_1, power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_power_supply_screws();
      }
    }
    translate([power_board_offset_X_2, power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_power_supply_screws();
      }
    }
    translate([power_board_offset_X_3, power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_power_supply_screws();
      }
    }
  }
}

module make_4_power_supply_frames() {
  translate([power_supply_offset_X, power_supply_offset_Y, power_supply_offset_Z]) {
    translate([power_board_offset_X_0, power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_power_supply_frame();
      }
    }
    translate([power_board_offset_X_1, power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_power_supply_frame();
      }
    }
    translate([power_board_offset_X_2, -power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_power_supply_frame();
      }
    }
    translate([power_board_offset_X_3, -power_board_offset_Y, power_board_offset_Z]) {
      rotate([power_board_rotation_X, power_board_rotation_Y, power_board_rotation_Z]) {
        make_power_supply_frame();
      }
    }
  }
}

//heatsync size
ps_thick_heatsync = 1.7;

//bottom end
ps_bottom_cutout_1_X = power_supply_X - ps_thick_heatsync;
ps_bottom_cutout_1_Y = 17;
ps_bottom_cutout_1_Z = 5.3;
ps_bottom_cutout_1_offset_X = -ps_thick_heatsync/2 - 0.01;
ps_bottom_cutout_1_offset_Y = (power_supply_Y/2 - ps_bottom_cutout_1_Y/2 + 0.01);
ps_bottom_cutout_1_offset_Z = -(power_supply_Z/2 - ps_bottom_cutout_1_Z/2 + 0.01) + 1;
ps_bottom_cutout_2_X = 12.9;
ps_bottom_cutout_2_Y = power_supply_Y - ps_thick_heatsync + 0.01;
ps_bottom_cutout_2_Z = 5.3;
ps_bottom_cutout_2_offset_X = -(power_supply_X/2 - ps_bottom_cutout_2_X/2 + 3.01);
ps_bottom_cutout_2_offset_Y = ps_thick_heatsync/2;
ps_bottom_cutout_2_offset_Z = -(power_supply_Z/2 - ps_bottom_cutout_2_Z/2 + 0.01) + 1;

//boards
ps_circuit_board_X = power_supply_X - 3;
ps_circuit_board_Y = 2.5;
ps_circuit_board_Z = 86;
ps_circuit_board_offset_X = 0;
ps_circuit_board_offset_Y = -(power_supply_Y/2-7);
ps_circuit_board_offset_Z = 1;
//screw mounts
ps_screw_edge_offset_1 = 5.3;
ps_screw_edge_offset_2 = 14.1;

module make_10a_shielded_bucky(for_frame = false) {
  /** base size **/
  union() {
    difference() {
      union() {
        cube([power_supply_X, power_supply_Y, power_supply_Z], center=true);
      }
      union() {
        /** parts to chop out **/
        translate([ps_bottom_cutout_1_offset_X, ps_bottom_cutout_1_offset_Y, ps_bottom_cutout_1_offset_Z]) {
          cube([ps_bottom_cutout_1_X, ps_bottom_cutout_1_Y, ps_bottom_cutout_1_Z + 2], center = true);
        }

        translate([ps_bottom_cutout_2_offset_X -3, ps_bottom_cutout_2_offset_Y, ps_bottom_cutout_2_offset_Z]) {
          cube([ps_bottom_cutout_2_X + 6, ps_bottom_cutout_2_Y, ps_bottom_cutout_2_Z + 2], center = true);
        }
        if (!for_frame) {
          translate([0, 0, ps_bottom_cutout_1_Z + 2]) {
            cube([power_supply_X - 2, power_supply_Y - 3, power_supply_Z], center=true);
          }
        }

        translate([-1,1,power_supply_Z/2 - 4.87]) {
          cube([power_supply_X, power_supply_Y, 9.76], center=true);
        }

        union() {
          if (!for_frame) {
            make_power_supply_cutouts(drill_only=false);
          }
          make_power_supply_screws();
        }
      }
    }
    if (for_frame) {
      translate([0, 0, 3.8 ]) {
        cube([power_supply_X - 1, power_supply_Y - 3, power_supply_Z - 5], center=true);
      }
    }
  }

  translate([ps_circuit_board_offset_X, ps_circuit_board_offset_Y, ps_circuit_board_offset_Z]) {
    cube([ps_circuit_board_X, ps_circuit_board_Y, ps_circuit_board_Z], center = true);
  }


  screw_drum_size = 6;
  //top
  translate([-power_supply_X/2 + ps_screw_edge_offset_1, -power_supply_Y/2 + screw_drum_size/2, power_supply_Z/2 - ps_screw_edge_offset_1]) {
    rotate([90,0,0]) {
      cylinder(d=screw_drum_size, h=screw_drum_size, center=true);
    }
  }

  //bottom
  translate([-power_supply_X/2 + ps_screw_edge_offset_1, -power_supply_Y/2 + screw_drum_size/2, -power_supply_Z/2 + ps_screw_edge_offset_2]) {
    rotate([90,0,0]) {
      cylinder(d=screw_drum_size, h=screw_drum_size, center=true);
    }
  }
}

module make_power_supply_cutouts(drill_only=false) {
  union() {
    if (drill_only) {
      translate([power_supply_X/2 - 3.5, -power_supply_Y/2 + 5, power_supply_Z/2 - 3.4]) {
        rotate([90, 0, 0]) {
          screw29M3Button();
        }
      }
    }
    else {
      translate([power_supply_X/2 - 5, -power_supply_Y/2, power_supply_Z/2 - 3.9]) {
        rotate([90, 0, 0]) {
          cylinder(d=3.9, h= 5, center=true);
        }
      }
      translate([power_supply_X/2 , power_supply_Y/2 - 8.6, -power_supply_Z/2]) {
        rotate([0, 90, 0]) {
          hull() {
            translate([-2.5, 0, 0]) {
              cylinder(d=3, h=5, center=true);
            }
            translate([2.5, 0, 0]) {
              cylinder(d=3, h=5, center=true);
            }
          }
        }
      }

      translate([-power_supply_X/2 + 6, -power_supply_Y/2, -power_supply_Z/2]) {
        rotate([90, 90, 0]) {
          hull() {
            translate([-2.5, 0, 0]) {
              cylinder(d=3, h=5, center=true);
            }
            translate([2.5, 0, 0]) {
              cylinder(d=3, h=30, center=true);
            }
          }
        }
      }
    }
  }
}

ps_screw_1_Z = -38;
ps_screw_1_X = -24.3;
ps_screw_1_Y = 2.9;
ps_screw_1_rotation = [180, 0, 0];
ps_screw_2_X = -(power_supply_X/2) + 5.6;
ps_screw_2_Y = -15;
ps_screw_2_Z = -(power_supply_Z/2) + 14;
ps_screw_2_rotation = [90, 0, 0];
ps_screw_3_X = -(power_supply_X/2 - 5.6);
ps_screw_3_Y = -15;
ps_screw_3_Z = (power_supply_Z/2 - 4);
ps_screw_3_rotation = [90, 0, 0];


module make_power_supply_screws() {
  translate([ps_screw_1_X, ps_screw_1_Y, ps_screw_1_Z]) {
    rotate(ps_screw_1_rotation) {
      screw29M3Button();
    }
  }
  // translate([ps_screw_2_X, ps_screw_2_Y + 10, ps_screw_2_Z]) {
  //   rotate(ps_screw_2_rotation) {
  //     screw29M3Button();
  //   }
  // }
  translate([ps_screw_3_X, ps_screw_3_Y + 10, ps_screw_3_Z]) {
    rotate(ps_screw_3_rotation) {
      screw29M3Button();
    }
  }
}

module make_power_supply_frame() {
  difference() {
    union() {
      //bottom screw
      translate([ps_screw_1_X, ps_screw_1_Y, ps_screw_1_Z - 1.5]) {
        rotate(ps_screw_1_rotation) {
          cylinder(d = 8, h=4, center = true);
        }
      }
      ////// bottom plate
      hull() {
        //bottom cutout base 1
        translate([-power_supply_X/2 + 4, power_supply_Y/2, ps_screw_1_Z - 4]) {
          cube([12,8,5], center = true);
        }

        //bottom cutout base 2
        translate([-power_supply_X/2 + 4, -power_supply_Y/2 - 1, ps_screw_1_Z - 4]) {
          cube([12,8,5], center = true);
        }
        
        //bottom cutout side
        translate([power_supply_X/2 - 1, power_supply_Y/2, ps_screw_1_Z - 4]) {
          cube([8,8,5], center = true);
        }

        //bottom join
        translate([power_supply_X/2 - 1, -power_supply_Y/2 - 1, ps_screw_1_Z - 4]) {
          cube([8,8,5], center = true);
        }
      }

      ////// back plate
      union() {
        hull() {
          //bottom right
          translate([ps_screw_2_X - 3.5, ps_screw_2_Y - 5.5, ps_screw_2_Z - 12]) {
            rotate(ps_screw_2_rotation) {
              cylinder(d = 8, h=3, center = true);
            }
          }
          //top right
          translate([ps_screw_2_X - 3.5, ps_screw_2_Y - 5.5, ps_screw_3_Z + 7]) {
            rotate(ps_screw_3_rotation) {
              cylinder(d = 8, h=3, center = true);
            }
          }
        }
        hull() {
          translate([ps_screw_2_X - 10, ps_screw_2_Y - 5.5, 10]) {
            rotate(ps_screw_3_rotation) {
              cylinder(d = 8, h=3, center = true);
            }
          }
          translate([ps_screw_2_X - 10, ps_screw_2_Y - 5.5, -10]) {
            rotate(ps_screw_3_rotation) {
              cylinder(d = 8, h=3, center = true);
            }
          }
          translate([ps_screw_2_X - 3.5, ps_screw_2_Y - 5.5, 17]) {
            rotate(ps_screw_3_rotation) {
              cylinder(d = 8, h=3, center = true);
            }
          }
          translate([ps_screw_2_X - 3.5, ps_screw_2_Y - 5.5, -17]) {
            rotate(ps_screw_3_rotation) {
              cylinder(d = 8, h=3, center = true);
            }
          }
        }

        hull() {
          //bottom right
          translate([ps_screw_2_X - 2.5, ps_screw_2_Y - 5.5, ps_screw_2_Z - 12]) {
            rotate(ps_screw_2_rotation) {
              cylinder(d = 8, h=3, center = true);
            }
          }
          //bottom left
          translate([power_supply_X/2 - 1, ps_screw_3_Y - 5.5, ps_screw_2_Z - 12]) {
            rotate([90, 0, 0]) {
              cylinder(d = 8, h = 3, center = true);
            }
          }
        }
        hull() {
          //top left
          translate([power_supply_X/2 - 1, ps_screw_3_Y - 5.5, ps_screw_3_Z + 7]) {
            rotate([90, 0, 0]) {
              cylinder(d = 8, h = 3, center = true);
            }
          }
          //top right
          translate([ps_screw_2_X - 2.5, ps_screw_2_Y - 5.5, ps_screw_3_Z + 7]) {
            rotate(ps_screw_3_rotation) {
              cylinder(d = 8, h=3, center = true);
            }
          }
        }
      }
    }
    union() {
      // make_power_supply_cutouts(drill_only=true);
      make_power_supply_screws();
      make_10a_shielded_bucky(for_frame=true);
      translate([2,7,0]) {
        cube([45,32, 140], center = true);
      }
    }
  }
  difference() {
    ////// back plate separator
    union() {
      hull() {
        //side bottom screw
        translate([2, ps_screw_2_Y - 4.5, 0]) {
          rotate(ps_screw_2_rotation) {
            cylinder(d = 10, h = 5, center = true);
          }
        }
        //side top bolthole
        translate([power_supply_X/2 - 1.5, ps_screw_3_Y - 4.5, power_supply_Z/2 +2]) {
          rotate([90, 0, 0]) {
            cylinder(d = 10, h = 5, center = true);
          }
        }
      }
      //side bottom screw
      hull() {
        //side top screw
        translate([ps_screw_3_X, ps_screw_3_Y - 4.5, ps_screw_3_Z]) {
          rotate(ps_screw_3_rotation) {
            cylinder(d = 10, h = 5, center = true);
          }
        }
        //side top bolthole
        translate([power_supply_X/2 - 2, ps_screw_3_Y - 4.5, ps_screw_2_Z -11]) {
          rotate([90, 0, 0]) {
            cylinder(d = 10, h = 5, center = true);
          }
        }
      }
    }
    union() {
      make_power_supply_cutouts(drill_only=true);
      make_power_supply_screws();
    }
  }
}
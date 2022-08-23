// dynamixel_mx_64.scad

dm64_horne_hub_D = 38;
dm64_horne_hub_outer_D = 90;
dm64_horne_hub_space_H = 47;
dm64_horne_screw_space = 4;
dm64_horne_hub_H = dm64_horne_hub_space_H + (dm64_horne_screw_space * 2);
dm64_horne_hub_outer_angle = 55;
dm64_horne_hub_arc_R = 30;
dm64_horne_hub_cutout = 47;

function get_dm64_horne_hub_cutout() = dm64_horne_hub_cutout;

module dm_mx_64_load_stl() {
  import("../openscad-parts/servos/MX-64R.stl");
}


module dm_mx_64_horne_hub_join(rescale=1, for_shoulder=false) {
  rotate([0,0,180])
  difference() {
    scale([rescale, rescale, rescale]) {
      hull() {
        cylinder(d = dm64_horne_hub_D, h = dm64_horne_hub_H, center=true);
        translate([0,-29,0]) {
          cube([dm64_horne_hub_D, dm64_horne_hub_D, dm64_horne_hub_H], center=true);
        }
        if (for_shoulder) {
            cylinder(d = dm64_horne_hub_D, h = dm64_horne_hub_H, center=true);
            translate([-37,-17,0]) {
              cylinder(d = dm64_horne_hub_D - 10, h = dm64_horne_hub_H, center=true); 
            }
        }
      }
    }
    cylinder(h=dm64_horne_hub_cutout, d=120, center=true);
  }
}


module dm_mx_64_horne_cutouts(with_cutout=true, for_shoulder=false) {
  union() {
    for (i = [0:7]) {
      rotate([0,0,135 - (i * 45)]) {
        dm_mx_64_horne_bolt();
      }
    }
    if (with_cutout) {
      translate([0,-30,0])
      cylinder(d=35, h=70, center = true);
    }
    
    if (for_shoulder) {
      translate([45,17.5,0]) {
        cylinder(d=3, h=90,center=true); 
      }
      translate([40,22.5,0]) {
        cylinder(d=3, h=90,center=true); 
      }
    }
            
    hull() {
      cylinder(d=11.2, h=70, center = true); // TODO: uncomment
      if (with_cutout) {
        translate([0,-20,0]) {
          cylinder(d=11.2, h=70, center = true);
        }
      }
    }
  }
}


module dm_mx_64_horne_cutout_basic(with_key = false) {
  union() {
    for (i = [0:7]) {
      rotate([0,0,135 - (i * 45)]) {
        dm_mx_64_horne_bolt();
      }
    }
    if (with_key) {
      translate([0,-30,0])
      cylinder(d=35, h=70, center = true);
    }
    hull() {
      cylinder(d=11.2, h=70, center = true); // TODO: uncomment
      if (with_key) {
        translate([0,-20,0]) {
          cylinder(d=11.2, h=70, center = true);
        }
      }
    }
  }
}

module dm_mx_64_horne_bolt() {
  union() {
    translate([0,11,0]) {
      cylinder(d=2.7, h=70, center=true);
    }
  }
}



module yorick_mx64_horne_for_print(with_cutout=true, rescale=1, for_shoulder=false) {
  difference() {
    dm_mx_64_horne_hub_join(rescale=rescale, for_shoulder=for_shoulder);
    dm_mx_64_horne_cutouts(with_cutout, for_shoulder=for_shoulder);
  }
}

module dm_mx_64_chassis(for_shoulder=false) {
  difference() {
    dm_mx_64_chassis_box(for_shoulder=for_shoulder);
    dm_mx_64_chassis_cutout(for_shoulder=for_shoulder);
  }
}

module dm_mx_64_chassis_box(for_shoulder=false) {
  union() {
    hull() {
      hull() {
        translate([0,4.5,0]) {
          scale([1,0.85,1]) {
            cylinder(h=41.2, d=51, center=true);
          }
        }
        translate([0,-47, 0]) {
          cube([51, 10, 41.2], center = true);
        }
      }
      hull() {
        translate([0,4.5,0]) {
          scale([1,0.85,1]) {
            cylinder(h=30, d=53, center=true);
          }
        }
        translate([0,-47, 0]) {
          cube([53, 10, 30], center = true);
        }
      }
    }
    if (!for_shoulder) {
      translate([-20,-42, 0]) {
        hull() {
          cylinder(d=25, h = 41.2, center = true);
          cylinder(d=30, h = 30, center = true);
        }
      }
    }
  }
}


dm64_bolt_plate_X = 41;
dm64_bolt_plate_Y = 63;
dm64_bolt_plate_Z = 34.2;
dm64_bolt_plate_size = [dm64_bolt_plate_X, dm64_bolt_plate_Y, dm64_bolt_plate_Z];
function get_dm64_bolt_plate_size() = dm64_bolt_plate_size;

dm64_bolt_plate_offset_X = 0;
dm64_bolt_plate_offset_Y = -17.5;
dm64_bolt_plate_offset_Z = 0;
dm64_bolt_plate_offset = [dm64_bolt_plate_offset_X, dm64_bolt_plate_offset_Y, dm64_bolt_plate_offset_Z];
function get_dm64_bolt_plate_offset() = dm64_bolt_plate_offset;

dm64_body_plate_X = 30;
dm64_body_plate_Y = 57.2;
dm64_body_plate_Z = 42;
dm64_body_plate_size = [dm64_body_plate_X, dm64_body_plate_Y, dm64_body_plate_Z];
function get_dm64_body_plate_size() = dm64_body_plate_size;

dm64_body_plate_offset_X = 0;
dm64_body_plate_offset_Y = -14.6;
dm64_body_plate_offset_Z = 0;
dm64_body_plate_offset = [dm64_body_plate_offset_X, dm64_body_plate_offset_Y, dm64_body_plate_offset_Z];
function get_dm64_body_plate_offset() = dm64_body_plate_offset;

module dm_mx_64_chassis_basic_cutout_with_bolts(front = true, mid = true, end = true, tail = true) {
  union() {
    dm_mx_64_chassis_basic_cutout()
    if (front) {
      dm_mx_64_chassis_bolt_front();
    }
    if (mid) {
      dm_mx_64_chassis_bolt_mid();
    }
    if (end) {
      dm_mx_64_chassis_bolt_end();
    }
    if (tail) {
      dm_mx_64_chassis_bolt_tail();
    }
  }
}
module dm_mx_64_chassis_basic_cutout() {
  union () {
    //bolt plate
    translate(dm64_bolt_plate_offset) {
      cube(dm64_bolt_plate_size, center=true);
    }
    // horne spacer
    cylinder(d = 29.5, h = 60, center=true);

    // core frame
    translate(dm64_body_plate_offset) {
      cube(dm64_body_plate_size, center=true);
    }
  }
}

module dm_mx_64_chassis_cutout(for_shoulder=true) {
  bolt_offset = 17.3;
  bolt_offset_2 = 11;

  bolt_x1=4;
  bolt_x2=bolt_x1 - 22; // 22
  bolt_x3=bolt_x1 - 44; // 44

  union () {
    //bolt plate
    translate([0,-17.5,0]) {
      red() {
        cube([41,62,34.2], center=true);
      }
    }
    // horne spacer
    cylinder(d = 29.5, h = 60, center=true);

    // core frame
    translate([0,-14.6,0]) {
      cube([29,56.2,42], center=true);
    }
    //tail spacer
    translate([0,-50,0]) {
      cube([24,30,24], center = true);
    }

    // cable spacer
    translate([0,20,0]) {
      cube([80,50,11], center = true);
    }

    if (for_shoulder) {
      // side-holes
      translate([0,-17.5,0]) {
        makeRoundedBox_rotate_90_Y([53.7,62,30]);
      }

      translate([0,22,0]) {
        rotate([0,0,22]) {
          screwM3DoubleWithHex_m3_20_button_10mhex(headBuffer=0, hexBlankBuffer=2, screwPurchase=2, screwHeadD=6.5);
        }
      }
      hull() {
        translate([0,13,0]) {
          makeRoundedBox_rotate_90_Y([60,10, 20]);
        }
        translate([0,7,0]) {
          makeRoundedBox_rotate_90_Y([60,10, 30]);
        }
      }
    }
    if (!for_shoulder) {
     
      // side-holes
      difference() {
        translate([0,-17.5,0]) {
          makeRoundedBox_rotate_90_Y([53.7,62,30]);
        }
         translate([-28,-40, 0]) {
          cube([8,22,31], center=true);
        }
      }
      translate([17,16,0]) {
        rotate([0,0,22]) {
          screwM3DoubleWithHex_m3_20_button_10mhex(headBuffer=0, hexBlankBuffer=2, screwPurchase=2, screwHeadD=6.5);
        }
      }
      translate([-17,16,0]) {
        rotate([0,0,-22]) {
          screwM3DoubleWithHex_m3_20_button_10mhex(headBuffer=0, hexBlankBuffer=2, screwPurchase=2, screwHeadD=6.5);
        }
      }
    }
  }
}


  dm_mx_64_chassis_bolt_offset = 17.3;
  dm_mx_64_chassis_bolt_offset_tail = 11;

  dm_mx_64_chassis_bolt_x1=4;
  dm_mx_64_chassis_bolt_x2=dm_mx_64_chassis_bolt_x1 - 22; // 22
  dm_mx_64_chassis_bolt_x3=dm_mx_64_chassis_bolt_x1 - 44; // 44
  dm_mx_64_chassis_bolt_x4=dm_mx_64_chassis_bolt_x1 - 49; // 44

module dm_mx_64_chassis_bolt_front() {
  translate([dm_mx_64_chassis_bolt_offset,dm_mx_64_chassis_bolt_x1,0]) {
    dm_mx_64_chassis_bolt();
  }
  translate([-dm_mx_64_chassis_bolt_offset,dm_mx_64_chassis_bolt_x1,0]) {
    dm_mx_64_chassis_bolt();
  }
}

module dm_mx_64_chassis_bolt_mid() {
  translate([dm_mx_64_chassis_bolt_offset,dm_mx_64_chassis_bolt_x2,0]) {
    dm_mx_64_chassis_bolt();
  }
  translate([-dm_mx_64_chassis_bolt_offset,dm_mx_64_chassis_bolt_x2,0]) {
    dm_mx_64_chassis_bolt();
  }
}

module dm_mx_64_chassis_bolt_end() {
  translate([dm_mx_64_chassis_bolt_offset,dm_mx_64_chassis_bolt_x3,0]) {
    dm_mx_64_chassis_bolt();
  }
  translate([-dm_mx_64_chassis_bolt_offset,dm_mx_64_chassis_bolt_x3,0]) {
    dm_mx_64_chassis_bolt();
  }
}

module dm_mx_64_chassis_bolt_tail() {
  translate([dm_mx_64_chassis_bolt_offset_tail,dm_mx_64_chassis_bolt_x4,0]) {
    dm_mx_64_chassis_bolt();
  }
  translate([-dm_mx_64_chassis_bolt_offset_tail,dm_mx_64_chassis_bolt_x4,0]) {
    dm_mx_64_chassis_bolt();
  }
}


module dm_mx_64_chassis_bolt() {
  // translate([0,0,23.5]) 
  // cylinder(d=5, h = 10, center = true);
  cylinder(d=3.1, h=60, center = true);
  // translate([0,0,-23.5])
  // cylinder(d=5, h = 10, center = true);
}

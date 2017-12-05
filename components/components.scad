
module component_make_t0_220_reg() {
  box_over_offset_X = 0.8;
  box_size = [4.6, 10.3, 8.5];
  box_offset_Z = 4;
  box_offset = [0 - box_over_offset_X, 0, box_size[2]/2 + box_offset_Z];

  color("black") {
    translate(box_offset) {
      cube(box_size, center = true);
    }
  }

  back_size = [1.3, 10, 12];
  back_offset_Z = 6;
  back_offset = [
    -(box_size[0] - back_size[0])/2 - 0.01 - box_over_offset_X,
    0, 
    back_size[2]/2 + back_offset_Z
    ];

  color("gray") {
    translate(back_offset) {
      cube(back_size, center = true);
    }
  }

  pin_size = [0.4, 1.4, 8];
  pin_space = 2.54;

  pin_offset_1 = [0,pin_space,pin_size[2]/2 - 2];
  pin_offset_2 = [0,0,pin_size[2]/2 - 2];
  pin_offset_3 = [0,-pin_space,pin_size[2]/2 - 2];

  color("gray") {
    translate(pin_offset_1) {
      cube(pin_size, center = true);
    }
    translate(pin_offset_2) {
      cube(pin_size, center = true);
    }
    translate(pin_offset_3) {
      cube(pin_size, center = true);
    }
  }


}


module component_make_t03_reg() {
  base_H  = 1.6;
  base_c_end_D = 7;
  base_c_mid_D = 25;
  base_length = 40;

  cap_c_D = 20;
  cap_c_H = 8.5;

  cap_c_offset_X = 0;
  cap_c_offset_Y = 0;
  cap_c_offset_Z = cap_c_H/2 + base_H/2 - 0.01;
  cap_c_offset = [cap_c_offset_X, cap_c_offset_Y, cap_c_offset_Z];

  leg_H = 12;
  leg_d = 2;
  leg_offset_X = 5.5;
  leg_offset_Y = 4;
  leg_offset_Z = -(leg_H/2) - base_H/2 + 0.01;

  leg_offset_1 = [-leg_offset_X, leg_offset_Y, leg_offset_Z];
  leg_offset_2 = [leg_offset_X, leg_offset_Y, leg_offset_Z];
  //base
  color("gray")
  union() {
    hull() {
      translate([0,(base_length - base_c_end_D)/2,0])
        cylinder(h= base_H, d = base_c_end_D, center= true);
      cylinder(h= base_H, d = base_c_mid_D, center= true);
      translate([0,-(base_length - base_c_end_D)/2,0])
        cylinder(h= base_H, d = base_c_end_D, center= true);
    }
    //caps
    translate(cap_c_offset) {
      cylinder(h = cap_c_H, d = cap_c_D, center = true);
    }

    //legs
    translate(leg_offset_1) {
      cylinder(h = leg_H, d = leg_d, center = true);
    }
    translate(leg_offset_2) {
      cylinder(h = leg_H, d = leg_d, center = true);
    }
  }
}

module component_make_electrolytic_capacitor(cap_D, cap_H, leg_D, leg_H, case_color="black") {
  union() {
    color(case_color)
    cylinder(d = cap_D, h = cap_H, center = true);
    color("gray")
    cylinder(d = cap_D * (2/3), h = cap_H + 0.01, center = true);

    color("gray")
    translate([4,0,15])
      cylinder(d = leg_D, h = leg_H, center = true);
    color("gray")
    translate([-4,0,15])
      cylinder(d = leg_D, h = leg_H, center = true);
  }
}

function get_trim_pot_D() = 8.6;
function get_trim_pot_H() = 11;

module component_make_trimpot(rotation=[0,0,0]) {
  trim_pot_D = get_trim_pot_D();
  trim_pot_H = get_trim_pot_H();
  trim_pot_X = 3;

  rotate(rotation) {
    color("gray") {
      union() {
        translate([0,0,get_trim_pot_H() - get_trim_pot_D()/2 + 1]) {
          translate([0,0,-(trim_pot_D/2) - 0.01]) {
            cube([trim_pot_X, trim_pot_D, (trim_pot_H - trim_pot_D/2) +2], center = true);
          }
          rotate([90,0,90]) {
            cylinder(d = trim_pot_D, h = trim_pot_X, center = true);
          }
        }
      }
    }
  }
}

function component_ssr_outer_case_X() = 60;
function component_ssr_outer_case_Y() = 45;
function component_ssr_outer_case_Z() = 23;
function component_ssr_bolt_hole_cutout_end_space() = 8;
function component_ssr_bolt_hole_cutout_H() = component_ssr_outer_case_Z() + 5;
function component_ssr_bolt_hole_cutout_D() = 4.6;
function component_ssr_bolt_hole_cutout_offset_X() = component_ssr_outer_case_X()/2 - component_ssr_bolt_hole_cutout_end_space() +  component_ssr_bolt_hole_cutout_D()/2;


module component_make_SSR(include_bolt_holes=true, include_terminal_cutouts=true) {
  outer_case_X = component_ssr_outer_case_X();
  outer_case_Y = component_ssr_outer_case_Y();
  outer_case_Z = component_ssr_outer_case_Z();
  plate_oversize_X = 1.6;
  plate_Z = 5;


  //cutouts

  //short end
  terminal_cube_1_X = 10;
  terminal_cube_1_Y = 10;
  terminal_cube_1_Z = 10;
  terminal_cube_1 = [terminal_cube_1_X,terminal_cube_1_Y,terminal_cube_1_Z];
  
  terminal_cube_1_spacer = (outer_case_Y - (2 * terminal_cube_1_Y)) / 4;
  terminal_cube_1_offset_Y = outer_case_Y/2 - (terminal_cube_1_Y/2) - terminal_cube_1_spacer/2;
  terminal_cube_1_offset_X = outer_case_X/2 - terminal_cube_1_X/2 + 0.01;
  terminal_cube_1_offset_Z = outer_case_Z / 2 - terminal_cube_1_Z / 2 + 0.01;
  terminal_cube_offset_1_A = [terminal_cube_1_offset_X, terminal_cube_1_offset_Y, terminal_cube_1_offset_Z];
  terminal_cube_offset_1_B = [terminal_cube_1_offset_X, -terminal_cube_1_offset_Y, terminal_cube_1_offset_Z];


  //longer end
  terminal_cube_2_X = 12;
  terminal_cube_2_Y = 10;
  terminal_cube_2_Z = 10;
  terminal_cube_2 = [terminal_cube_2_X,terminal_cube_2_Y,terminal_cube_2_Z];
  
  terminal_cube_2_spacer = (outer_case_Y - (2 * terminal_cube_2_Y)) / 4;
  terminal_cube_2_offset_Y = -(outer_case_Y/2 - (terminal_cube_2_Y/2) - terminal_cube_2_spacer/2);
  terminal_cube_2_offset_X = -(outer_case_X/2 - terminal_cube_2_X/2 + 0.01);
  terminal_cube_2_offset_Z = (outer_case_Z / 2 - terminal_cube_2_Z / 2 + 0.01);
  terminal_cube_offset_2_A = [terminal_cube_2_offset_X, terminal_cube_2_offset_Y, terminal_cube_2_offset_Z];
  terminal_cube_offset_2_B = [terminal_cube_2_offset_X, -terminal_cube_2_offset_Y, terminal_cube_2_offset_Z];

  difference() {
    union() {
      //box
      color("white")
      cube([outer_case_X,outer_case_Y,outer_case_Z], center = true);

      //bottom plate
      translate([0,0, -(outer_case_Z/2 - plate_Z/2 + 0.01) ])
      color("gray")
      cube([outer_case_X + plate_oversize_X, outer_case_Y - 0.01, plate_Z], center = true);
    }
    union() {
      color("white") {
        if (include_terminal_cutouts) {
          translate(terminal_cube_offset_1_A) {
            cube(terminal_cube_1, center = true);
          }
          translate(terminal_cube_offset_1_B) {
            cube(terminal_cube_1, center = true);
          }
        }

        bolt_cutout_1_Z = outer_case_Z - plate_Z;
        bolt_cutout_1_offset_Z = plate_Z/2 + 0.01;

        translate([terminal_cube_1_offset_X,0,bolt_cutout_1_offset_Z]) {
          cylinder(h = bolt_cutout_1_Z, d = terminal_cube_1_Y, center = true);
        }
        translate([terminal_cube_1_offset_X + terminal_cube_1_X/2,0,bolt_cutout_1_offset_Z]) {
          cube([terminal_cube_1[0],terminal_cube_1[1],bolt_cutout_1_Z], center = true);
        }
      }
      color("white") {
        if (include_terminal_cutouts) {
          translate(terminal_cube_offset_2_A) {
            cube(terminal_cube_2, center = true);
          }
          translate(terminal_cube_offset_2_B) {
            cube(terminal_cube_2, center = true);
          }
        }

        bolt_cutout_2_Z = outer_case_Z - plate_Z;
        bolt_cutout_2_offset_Z = plate_Z/2 + 0.01;

        translate([terminal_cube_2_offset_X,0,bolt_cutout_2_offset_Z]) {
          cylinder(h = bolt_cutout_2_Z, d = terminal_cube_2_Y, center = true);
        }
        translate([terminal_cube_2_offset_X - terminal_cube_2_X/2,0,bolt_cutout_2_offset_Z]) {
          cube([terminal_cube_2[0],terminal_cube_2[1],bolt_cutout_2_Z], center = true);
        }
      }
      if (include_bolt_holes) {
        color("gray") {
          component_make_SSR_boltholes();
        }
      }
    }
  }
}

module component_make_SSR_boltholes() {
  translate([component_ssr_bolt_hole_cutout_offset_X(),0,0]) {
    cylinder(h = component_ssr_bolt_hole_cutout_H(), d = component_ssr_bolt_hole_cutout_D(), center = true);
  }
  translate([-(component_ssr_bolt_hole_cutout_offset_X()),0,0]) {
    cylinder(h = component_ssr_bolt_hole_cutout_H(), d = component_ssr_bolt_hole_cutout_D(), center = true);
  }
}

module component_make_terminal_negative() {
  component_make_terminal(color_of_case = "black");
}

module component_make_terminal_positive() {
  component_make_terminal();
}

module component_make_terminal(color_of_case = "red", just_the_hole=false) {
  overall_length = 15;

  outer_band_D = 10.5;
  outer_band_H = 7.6;

  inner_band_top_D = 8;
  inner_band_top_H = 8.2;
  inner_band_bottom_D = 5.6;

  nut_H = 2.5;
  nut_D = 8.5;
  inner_diameter = 4.2;

  general_z_offset = (inner_band_top_H - overall_length/2);

  difference() {
    if (!just_the_hole)
    union() {
      translate([0,0,outer_band_H/2])
      color(color_of_case) {
        cylinder(h = outer_band_H, d = outer_band_D, center = true);
      }
      color("gray") {
        translate([0,0,inner_band_top_H/2]) {
          cylinder(h = inner_band_top_H, d = inner_band_top_D, center = true);
        }
        translate([0,0,general_z_offset]) {
          cylinder(h = overall_length, d = inner_band_bottom_D, center = true);
        }
        translate([0,0,-(protoboard_get_Z()/2 + nut_H/2)]) {
          cylinder(d = nut_D, h = nut_H, center = true, $fn = 6);
        }
      }
    }
    color("gray") {
      cylinder(d = inner_diameter, h = overall_length + 10, center = true);
    }
  }
}


function get_component_header_base_XY() = 2.54;
function get_component_header_base_H() = 2.8;

function component_header_pin_range_X(rows=2) = get_component_header_base_XY() * rows;
function component_header_pin_range_Y(cols=2) = get_component_header_base_XY() * cols;


module component_make_header_pin_range(rows=2, cols=2) {
  header_pin_height = 12;
  header_pin_bottom = 3;
  header_pin_D = 0.6;

  header_pin_offset_Z = (header_pin_height - header_pin_bottom - protoboard_get_Z())/2;

  header_base_XY = get_component_header_base_XY();
  header_base_H = get_component_header_base_H();

  overall_offset_X = -(cols * header_base_XY)/2 - header_base_XY/2;
  overall_offset_Y = -(rows * header_base_XY)/2 - header_base_XY/2;
  overall_offset_Z = header_pin_offset_Z;

  translate([overall_offset_X, overall_offset_Y, overall_offset_Z])
  for (pinX = [1:cols]) {
    for (pinY = [1:rows]) {
      translate([pinX * header_base_XY, pinY * header_base_XY, 0])
      cylinder(h = header_pin_height, d = header_pin_D, center = true);
    }
  }

  translate([0,0,header_base_H/2]) {
    color("black")
    cube([cols * header_base_XY, rows * header_base_XY, header_base_H], center = true);
  }
}

module component_make_small_surface_mount_pins_with_clip(num_pins=4) {
  component_make_surface_mount_pins_with_clip(pins=num_pins);
}

module component_make_large_surface_mount_pins_with_clip(num_pins=4) {
  component_make_surface_mount_pins_with_clip(pins=num_pins, pin_D = 1.5, pin_spacer = 4, pin_endspace = 2, pin_offset_Y = 1, base_box_Y = 10);
}


module component_make_surface_mount_pins_with_clip(pins=4, pin_D = 0.8, pin_spacer = 2.5, pin_endspace = 1, pin_offset_Y = 1, base_box_Y = 5.6) {
  back_Z = 11.5;

  pin_H = 16;
  pin_offset_Z = pin_H/2 - (pin_H - back_Z) + protoboard_get_Z()/2;

  base_box_X = ((pins - 1) * pin_spacer) + (2 * pin_endspace);
  base_box_Z = 3;

  base_box_offset_X = 0;
  base_box_offset_Y = 0;
  base_box_offset_Z = base_box_Z/2 + protoboard_get_Z()/2;

  back_face_X = (pins - 1) * pin_spacer;
  back_face_Y = 0.7;
  back_face_Z = 11.5;

  back_face_offset_X = 0;
  back_face_offset_Y = base_box_Y/2 - back_face_Y/2 ;
  back_face_offset_Z = back_face_Z/2 + protoboard_get_Z()/2;


  // base box
  color("white") {
    translate([base_box_offset_X, base_box_offset_Y, base_box_offset_Z]) {
      cube([base_box_X, base_box_Y, base_box_Z], center = true);
    }

    // back face
    translate([back_face_offset_X, back_face_offset_Y, back_face_offset_Z]) {
      cube([back_face_X, back_face_Y, back_face_Z], center = true);
    }
  }

  // pins
  color("gray") {
    translate([-(pins/2*pin_spacer - (pin_spacer/2)),0,0]) {
      for (pin_I = [1: pins]) {
        translate([(pin_I - 1) * pin_spacer, pin_offset_Y, pin_offset_Z]) {
          cylinder(h = pin_H, d = pin_D, center = true);
        }
      }
    }
  }
}


module component_make_teensy_32(with_pins=true) {
  //board
  board_X = 37;
  board_Y = 18;
  board_Z = 1.6;
  rotate([0,180,0]) {
    union() {
      //protoboard
      make_protoboard(size_X=board_X, size_Y=board_Y, drill_holes=false);

      //cpu
      cpu_size = [10,10,1.8];
      cpu_offset = [board_X/2 - (4 + cpu_size[0]), 0, -(protoboard_get_Z()/2 + cpu_size[2]/2)];
      color("black") {
        translate(cpu_offset) {
          cube(cpu_size, center=true);
        }
      }

      //usb mini
      usb_size = [5.6,8.6,2.3];
      usb_offset = [-(board_X/2 + 1.6 - usb_size[0]/2), 0, -(protoboard_get_Z()/2 + usb_size[2]/2)];
      color("gray") {
        translate(usb_offset) {
          cube(usb_size, center=true);
        }
      }

      if (with_pins) {
        translate([0,0,protoboard_get_Z()/2]) {
          translate([0,board_Y/2 - component_header_pin_range_Y(1)/2,0])
          component_make_header_pin_range(rows=1, cols=14);
          translate([board_X/2 - component_header_pin_range_Y(1)/2,0,0])
          component_make_header_pin_range(rows=5, cols=1);
          translate([0,-(board_Y/2 - component_header_pin_range_Y(1)/2),0])
          component_make_header_pin_range(rows=1, cols=14);
        }
      }
    }
  }
}
module component_make_square_fan_40() {
  component_make_square_fan(size = [40,40,11], include_screw_holes = true, screw_hole_size = 3.54, screw_hole_offset = 4.3);
}

module component_make_square_fan_30() {
  component_make_square_fan(size = [30,30,10.5], include_screw_holes = true, screw_hole_size = 3.1, screw_hole_offset = 3.35);
}

module component_make_square_fan_40_bolts(left_only=false) {
  component_make_square_fan_bolts(size = [40,40,30], screw_hole_size = 3.54, screw_hole_offset=4.3,left_only=left_only);
}

module component_make_square_fan_30_bolts() {
  component_make_square_fan_bolts(size = [30,30,10.5], screw_hole_size = 3.1, screw_hole_offset=3.35);
}

module component_make_square_fan_40_tunnel() {
  component_make_square_fan_tunnel(size = [40,40,30], screw_hole_size = 3.54, screw_hole_offset=4.3);
}

module component_make_square_fan_30_tunnel() {
  component_make_square_fan_tunnel(size = [30,30,10.5], screw_hole_size = 3.1, screw_hole_offset=3.35);
}

module component_make_square_fan_tunnel(size=[40,40,10], screw_hole_size = 3, screw_hole_offset=3) {
  cylinder(h = size[2] + 15, d = size[0] * 0.9, center = true);
}

module component_make_square_fan_bolts(size=[40,40,10], screw_hole_size = 3, screw_hole_offset=3, left_only=false) {
  offset_X = size[0]/2 - screw_hole_offset;
  offset_Y = size[1]/2 - screw_hole_offset;
  translate([offset_X, offset_Y, 0]) {
    cylinder(h = size[2] + 20, d = screw_hole_size, center = true);
  }
  translate([-offset_X, offset_Y, 0]) {
    cylinder(h = size[2] + 20, d = screw_hole_size, center = true);
  }
  if (!left_only) {
    translate([offset_X, -offset_Y, 0]) {
      cylinder(h = size[2] + 20, d = screw_hole_size, center = true);
    }
    translate([-offset_X, -offset_Y, 0]) {
      cylinder(h = size[2] + 20, d = screw_hole_size, center = true);
    }
  }

}
module component_make_square_fan(size=[40,40,10], include_screw_holes=true, screw_hole_size = 3, screw_hole_offset=3) {
  difference() {
    makeRoundedBox(size);
    union() {
      difference() {
        cylinder(h = size[2] + 10, d = size[0] * 0.9, center = true);
        union() {
          cube([size[0], size[1] / 10, size[2] + 15], center = true);
          cube([size[0] / 10, size[1], size[2] + 15], center = true);
        }
      }
      component_make_square_fan_bolts(size = size, screw_hole_size = screw_hole_size, screw_hole_offset = screw_hole_offset);
    }
  }
}

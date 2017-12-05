/* tft screens */

/* members */
tft_base_board_X = 33;
tft_base_board_Y = 1.7;
tft_base_board_Z = 44.3;
tft_base_board_size = [tft_base_board_X, tft_base_board_Y, tft_base_board_Z];
tft_base_board_screw_outcrop_D = 5.3;

tft_base_pin_size_X = 32.7;
tft_base_pin_size_Y = 3.66;
tft_base_pin_size_Z = 3.66;

tft_screen_frame_X = 32.5;
tft_screen_frame_Y = 4;
tft_screen_frame_Z = 38;
tft_screen_frame_size = [tft_screen_frame_X, tft_screen_frame_Y, tft_screen_frame_Z];
tft_screen_frame_size_cutout = [tft_screen_frame_X + 1, tft_screen_frame_Y, tft_screen_frame_Z + 4.5];

tft_screen_panel_top_space = 2;
tft_screen_panel_side_space = 2;
tft_screen_panel_bottom_space = 7;


screen_X = tft_screen_frame_X - tft_screen_panel_side_space * 2;
screen_Y = tft_screen_frame_Y + 2;
screen_Z = tft_screen_frame_Z - tft_screen_panel_top_space - tft_screen_panel_bottom_space;

tft_chip_back_spacer_X = 22;
tft_chip_back_spacer_Y = 2.5;

tft_plug_spacer_X = 30;
tft_plug_spacer_Y = 8;
tft_plug_spacer_Z = 7;
/* functions */


function get_component_tft_base_board_X() = tft_base_board_X;
function get_component_tft_base_board_Y() = tft_base_board_Y;
function get_component_tft_base_board_Z() = tft_base_board_Z;
function get_component_tft_base_board_size() = tft_base_board_size;
function get_component_tft_base_board_screw_outcrop_D() = tft_base_board_screw_outcrop_D;
function get_component_tft_base_pin_size_X() = tft_base_pin_size_X;
function get_component_tft_base_pin_size_Y() = tft_base_pin_size_Y;
function get_component_tft_base_pin_size_Z() = tft_base_pin_size_Z;
function get_component_tft_screen_frame_X() = tft_screen_frame_X;
function get_component_tft_screen_frame_Y() = tft_screen_frame_Y;
function get_component_tft_screen_frame_Z() = tft_screen_frame_Z;
function get_component_tft_screen_frame_size() = tft_screen_frame_size;
function get_component_tft_screen_panel_top_space() = tft_screen_panel_top_space;
function get_component_tft_screen_panel_side_space() = tft_screen_panel_side_space;
function get_component_tft_screen_panel_bottom_space() = tft_screen_panel_bottom_space;
function get_component_tft_chip_back_spacer_X() = tft_chip_back_spacer_X;
function get_component_tft_chip_back_spacer_Y() = tft_chip_back_spacer_Y;
function get_component_tft_plug_spacer_X() = tft_plug_spacer_X;
function get_component_tft_plug_spacer_Y() = tft_plug_spacer_Y;
function get_component_tft_plug_spacer_Z() = tft_plug_spacer_Z;
function get_component_tft_outcrop_offset() = (tft_base_board_Z/2 - tft_base_board_screw_outcrop_D/2) + 3.5;

/* modules */

module tft_screen(for_cutout=false) {
  union() {
    tft_base_board(for_cutout=for_cutout);
    tft_frame(for_cutout=for_cutout);
    tft_screen_panel(for_cutout=for_cutout);
    tft_back_chips_and_bits(for_cutout=for_cutout);
  }
}

module tft_base_board(for_cutout=false) {
  color("green") {
    // base
    cube(tft_base_board_size, center=true);

    // screw outcrops
    hull() {
      translate([(tft_base_board_X/2 + tft_base_board_screw_outcrop_D/2), 0, (tft_base_board_Z/2 - tft_base_board_screw_outcrop_D/2)])
        rotate([90, 0, 0])
          cylinder(h=tft_base_board_Y, d=tft_base_board_screw_outcrop_D, center=true);
      translate([-(tft_base_board_X/2 + tft_base_board_screw_outcrop_D/2), 0, (tft_base_board_Z/2 - tft_base_board_screw_outcrop_D/2)])
        rotate([90, 0, 0])
          cylinder(h=tft_base_board_Y, d=tft_base_board_screw_outcrop_D, center=true);
    }
    hull() {
      translate([(tft_base_board_X/2 + tft_base_board_screw_outcrop_D/2), 0, -(tft_base_board_Z/2 - tft_base_board_screw_outcrop_D/2)])
        rotate([90, 0, 0])
          cylinder(h=tft_base_board_Y, d=tft_base_board_screw_outcrop_D, center=true);
      translate([-(tft_base_board_X/2 + tft_base_board_screw_outcrop_D/2), 0, -(tft_base_board_Z/2 - tft_base_board_screw_outcrop_D/2)])
        rotate([90, 0, 0])
          cylinder(h=tft_base_board_Y, d=tft_base_board_screw_outcrop_D, center=true);
    }
  }
  if (!for_cutout)
  color("white") {
    //solder pins
    hull() {
      translate([(tft_base_pin_size_X/2 - tft_base_pin_size_Y/2), -(tft_base_pin_size_Y/2 + 0.01 - tft_base_board_Y/2), (tft_base_board_Z/2 - tft_base_pin_size_Y/2)])
          rotate([90, 0, 0])
            cylinder(h=tft_base_pin_size_Z, d=tft_base_pin_size_Y, center=true);
      translate([-(tft_base_pin_size_X/2 - tft_base_pin_size_Y/2), -(tft_base_pin_size_Y/2 + 0.01 - tft_base_board_Y/2), (tft_base_board_Z/2 - tft_base_pin_size_Y/2)])
          rotate([90, 0, 0])
            cylinder(h=tft_base_pin_size_Z, d=tft_base_pin_size_Y, center=true);
    }
  }
}

module tft_frame(for_cutout=false) {
  color("white") {
    translate([0, -(tft_screen_frame_Y/2 - 0.01),-(tft_base_board_Z/2 - tft_screen_frame_Z/2 - 0.1)]) {
      if (!for_cutout) {
        cube(tft_screen_frame_size, center=true);
      }
      else {
        translate([0,0,4])
          cube(tft_screen_frame_size_cutout, center=true);
      }
    }
  }
}

module tft_screen_panel() {
  color("black") {
    screen_offset_Z = -(tft_base_board_Z/2 - tft_screen_frame_Z/2 - 0.1 - tft_screen_panel_bottom_space/2 + tft_screen_panel_top_space/2);
    translate([0, -(tft_screen_frame_Y/2),screen_offset_Z])
    cube([screen_X, screen_Y, screen_Z], center=true);
  }
}

module tft_back_chips_and_bits() {
  //memory card slot cpu and other board bits
  translate([0,tft_chip_back_spacer_Y/2 + tft_base_board_Y/2 - 0.01, 0])
    cube([tft_chip_back_spacer_X, tft_chip_back_spacer_Y, tft_base_board_Z], center=true);

  //rear plug/pins
  tft_plug_spacer_X = 30;
  tft_plug_spacer_Y = 15;
  tft_plug_spacer_Z = 7;

  translate([0, tft_plug_spacer_Y/2 + tft_base_board_Y/2 - 0.1, (tft_base_board_Z/2 - tft_plug_spacer_Z/2)])
    cube([tft_plug_spacer_X, tft_plug_spacer_Y, tft_plug_spacer_Z], center = true);
}

module tft_screws() {
  translate([(tft_base_board_X/2 + tft_base_board_screw_outcrop_D/2), 0, (tft_base_board_Z/2 - tft_base_board_screw_outcrop_D/2)])
    rotate([90, 0, 0])
      cylinder(h=40, d=2.5, center=true);
  translate([-(tft_base_board_X/2 + tft_base_board_screw_outcrop_D/2), 0, (tft_base_board_Z/2 - tft_base_board_screw_outcrop_D/2)])
    rotate([90, 0, 0])
      cylinder(h=40, d=2.5, center=true);
  translate([(tft_base_board_X/2 + tft_base_board_screw_outcrop_D/2), 0, -(tft_base_board_Z/2 - tft_base_board_screw_outcrop_D/2)])
    rotate([90, 0, 0])
      cylinder(h=40, d=2.5, center=true);
  translate([-(tft_base_board_X/2 + tft_base_board_screw_outcrop_D/2), 0, -(tft_base_board_Z/2 - tft_base_board_screw_outcrop_D/2)])
    rotate([90, 0, 0])
      cylinder(h=40, d=2.5, center=true);
}

tft_18_X = 34.2;
tft_18_Y = 56;
tft_18_Z = 1.8;

function get_tft_18_X() = tft_18_X;
function get_tft_18_Y() = tft_18_Y;
function get_tft_18_Z() = tft_18_Z;

module tft_18_base(with_screws=true) {
  difference() {
    makeRoundedBox([tft_18_X, tft_18_Y, tft_18_Z], d = 2);
    if (with_screws) {
      tft_18_screws();
    }
  }
}

module tft_18_screws() {
  screw_offset_X = 29.5;
  screw_offset_Y = 51;

  translate([-screw_offset_X/2, screw_offset_Y/2, 0]) {
    screw10M25Button();
  }
  translate([-screw_offset_X/2, -screw_offset_Y/2, 0]) {
    screw10M25Button();
  }
  translate([screw_offset_X/2, -screw_offset_Y/2, 0]) {
    screw10M25Button();
  }
  translate([screw_offset_X/2, screw_offset_Y/2, 0]) {
    screw10M25Button();
  }
}


/* tft 98" screens */

/* members */
tft_98_base_board_X = 33;
tft_98_base_board_Y = 1.7;
tft_98_base_board_Z = 44.3;
tft_98_base_board_size = [tft_98_base_board_X, tft_98_base_board_Y, tft_98_base_board_Z];
tft_98_base_board_screw_outcrop_D = 5.3;

tft_98_base_pin_size_X = 32.7;
tft_98_base_pin_size_Y = 3.66;
tft_98_base_pin_size_Z = 3.66;

tft_98_screen_frame_X = 32.5;
tft_98_screen_frame_Y = 4;
tft_98_screen_frame_Z = 38;
tft_98_screen_frame_size = [tft_98_screen_frame_X, tft_98_screen_frame_Y, tft_98_screen_frame_Z];
tft_98_screen_frame_size_cutout = [tft_98_screen_frame_X + 1, tft_98_screen_frame_Y, tft_98_screen_frame_Z + 4.5];

tft_98_screen_panel_top_space = 2;
tft_98_screen_panel_side_space = 2;
tft_98_screen_panel_bottom_space = 7;


tft_98_screen_X = tft_98_screen_frame_X - tft_98_screen_panel_side_space * 2;
tft_98_screen_Y = tft_98_screen_frame_Y + 2;
tft_98_screen_Z = tft_98_screen_frame_Z - tft_98_screen_panel_top_space - tft_98_screen_panel_bottom_space;

tft_98_chip_back_spacer_X = 22;
tft_98_chip_back_spacer_Y = 2.5;

tft_98_plug_spacer_X = 30;
tft_98_plug_spacer_Y = 8;
tft_98_plug_spacer_Z = 7;

tft_98_screw_D = 2.7;
tft_98_screw_H = 40;
/* functions */


function get_component_tft_98_base_board_X() = tft_98_base_board_X;
function get_component_tft_98_base_board_Y() = tft_98_base_board_Y;
function get_component_tft_98_base_board_Z() = tft_98_base_board_Z;
function get_component_tft_98_base_board_size() = tft_98_base_board_size;
function get_component_tft_98_base_board_screw_outcrop_D() = tft_98_base_board_screw_outcrop_D;
function get_component_tft_98_base_pin_size_X() = tft_98_base_pin_size_X;
function get_component_tft_98_base_pin_size_Y() = tft_98_base_pin_size_Y;
function get_component_tft_98_base_pin_size_Z() = tft_98_base_pin_size_Z;
function get_component_tft_98_screen_frame_X() = tft_98_screen_frame_X;
function get_component_tft_98_screen_frame_Y() = tft_98_screen_frame_Y;
function get_component_tft_98_screen_frame_Z() = tft_98_screen_frame_Z;
function get_component_tft_98_screen_frame_size() = tft_98_screen_frame_size;
function get_component_tft_98_screen_panel_top_space() = tft_98_screen_panel_top_space;
function get_component_tft_98_screen_panel_side_space() = tft_98_screen_panel_side_space;
function get_component_tft_98_screen_panel_bottom_space() = tft_98_screen_panel_bottom_space;
function get_component_tft_98_chip_back_spacer_X() = tft_98_chip_back_spacer_X;
function get_component_tft_98_chip_back_spacer_Y() = tft_98_chip_back_spacer_Y;
function get_component_tft_98_plug_spacer_X() = tft_98_plug_spacer_X;
function get_component_tft_98_plug_spacer_Y() = tft_98_plug_spacer_Y;
function get_component_tft_98_plug_spacer_Z() = tft_98_plug_spacer_Z;
function get_component_tft_98_outcrop_offset() = (tft_98_base_board_Z/2 - tft_98_base_board_screw_outcrop_D/2) + 3.5;

/* modules */

module tft_98_screen(for_cutout=false) {
  difference() {
    union() {
      tft_98_base_board(for_cutout=for_cutout);
      tft_98_frame(for_cutout=for_cutout);
      tft_98_screen_panel(for_cutout=for_cutout);
      tft_98_back_chips_and_bits(for_cutout=for_cutout);
    }
    if (!for_cutout) {
      tft_98_screws();
    }
  }
}

module tft_98_base_board(for_cutout=false) {
  color("green") {
    // base
    ccube(tft_98_base_board_size);

    // screw outcrops
    hull() {
      translate([(tft_98_base_board_X/2 + tft_98_base_board_screw_outcrop_D/2), 0, (tft_98_base_board_Z/2 - tft_98_base_board_screw_outcrop_D/2)])
        rotate([90, 0, 0])
          ccylinder(h=tft_98_base_board_Y, d=tft_98_base_board_screw_outcrop_D);
      translate([-(tft_98_base_board_X/2 + tft_98_base_board_screw_outcrop_D/2), 0, (tft_98_base_board_Z/2 - tft_98_base_board_screw_outcrop_D/2)])
        rotate([90, 0, 0])
          ccylinder(h=tft_98_base_board_Y, d=tft_98_base_board_screw_outcrop_D);
    }
    hull() {
      translate([(tft_98_base_board_X/2 + tft_98_base_board_screw_outcrop_D/2), 0, -(tft_98_base_board_Z/2 - tft_98_base_board_screw_outcrop_D/2)])
        rotate([90, 0, 0])
          ccylinder(h=tft_98_base_board_Y, d=tft_98_base_board_screw_outcrop_D);
      translate([-(tft_98_base_board_X/2 + tft_98_base_board_screw_outcrop_D/2), 0, -(tft_98_base_board_Z/2 - tft_98_base_board_screw_outcrop_D/2)])
        rotate([90, 0, 0])
          ccylinder(h=tft_98_base_board_Y, d=tft_98_base_board_screw_outcrop_D);
    }
  }
  if (!for_cutout)
  color("white") {
    //solder pins
    hull() {
      translate([(tft_98_base_pin_size_X/2 - tft_98_base_pin_size_Y/2), -(tft_98_base_pin_size_Y/2 + 0.01 - tft_98_base_board_Y/2), (tft_98_base_board_Z/2 - tft_98_base_pin_size_Y/2)])
          rotate([90, 0, 0])
            ccylinder(h=tft_98_base_pin_size_Z, d=tft_98_base_pin_size_Y);
      translate([-(tft_98_base_pin_size_X/2 - tft_98_base_pin_size_Y/2), -(tft_98_base_pin_size_Y/2 + 0.01 - tft_98_base_board_Y/2), (tft_98_base_board_Z/2 - tft_98_base_pin_size_Y/2)])
          rotate([90, 0, 0])
            ccylinder(h=tft_98_base_pin_size_Z, d=tft_98_base_pin_size_Y);
    }
  }
}

module tft_98_frame(for_cutout=false) {
  color("white") {
    translate([0, -(tft_98_screen_frame_Y/2 - 0.01),-(tft_98_base_board_Z/2 - tft_98_screen_frame_Z/2 - 0.1)]) {
      if (!for_cutout) {
        ccube(tft_98_screen_frame_size);
      }
      else {
        translate([0,0,4])
          ccube(tft_98_screen_frame_size_cutout);
      }
    }
  }
}

module tft_98_screen_panel() {
  color("black") {
    screen_offset_Z = -(tft_98_base_board_Z/2 - tft_98_screen_frame_Z/2 - 0.1 - tft_98_screen_panel_bottom_space/2 + tft_98_screen_panel_top_space/2);
    translate([0, -(tft_98_screen_frame_Y/2),screen_offset_Z])
    ccube([tft_98_screen_X, tft_98_screen_Y, tft_98_screen_Z]);
  }
}

module tft_98_back_chips_and_bits() {
  //memory card slot cpu and other board bits
  translate([0,tft_98_chip_back_spacer_Y/2 + tft_98_base_board_Y/2 - 0.01, 0])
    ccube([tft_98_chip_back_spacer_X, tft_98_chip_back_spacer_Y, tft_98_base_board_Z]);

  //rear plug/pins
  tft_98_plug_spacer_X = 30;
  tft_98_plug_spacer_Y = 15;
  tft_98_plug_spacer_Z = 7;

  translate([0, tft_98_plug_spacer_Y/2 + tft_98_base_board_Y/2 - 0.1, (tft_98_base_board_Z/2 - tft_98_plug_spacer_Z/2)])
    ccube([tft_98_plug_spacer_X, tft_98_plug_spacer_Y, tft_98_plug_spacer_Z]);
}


module tft_98_screws() {
  translate([(tft_98_base_board_X/2 + tft_98_base_board_screw_outcrop_D/2), 0, (tft_98_base_board_Z/2 - tft_98_base_board_screw_outcrop_D/2)])
    rotate([90, 0, 0])
      ccylinder(h=tft_98_screw_H, d=tft_98_screw_D);
  translate([-(tft_98_base_board_X/2 + tft_98_base_board_screw_outcrop_D/2), 0, (tft_98_base_board_Z/2 - tft_98_base_board_screw_outcrop_D/2)])
    rotate([90, 0, 0])
      ccylinder(h=tft_98_screw_H, d=tft_98_screw_D);
  translate([(tft_98_base_board_X/2 + tft_98_base_board_screw_outcrop_D/2), 0, -(tft_98_base_board_Z/2 - tft_98_base_board_screw_outcrop_D/2)])
    rotate([90, 0, 0])
      ccylinder(h=tft_98_screw_H, d=tft_98_screw_D);
  translate([-(tft_98_base_board_X/2 + tft_98_base_board_screw_outcrop_D/2), 0, -(tft_98_base_board_Z/2 - tft_98_base_board_screw_outcrop_D/2)])
    rotate([90, 0, 0])
      ccylinder(h=tft_98_screw_H, d=tft_98_screw_D);
}

tft_98_18_X = 35.2;
tft_98_18_Y = 56;
tft_98_18_Z = 1.8;

function get_tft_98_18_X() = tft_98_18_X;
function get_tft_98_18_Y() = tft_98_18_Y;
function get_tft_98_18_Z() = tft_98_18_Z;

module tft_98_18_base(with_screws=true) {
  difference() {
    makeRoundedBox([tft_98_18_X, tft_98_18_Y, tft_98_18_Z], d = 2);
    if (with_screws) {
      tft_98_18_screws();
    }
  }
}

module tft_98_18_screws() {
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


/* tft 2.8" screens */

/* members */
tft_280_base_board_X = 50.8;
tft_280_base_board_Y = 1.7;
tft_280_base_board_Z = 81.4;
tft_280_base_board_size = [tft_280_base_board_X, tft_280_base_board_Y, tft_280_base_board_Z];
tft_280_base_board_screw_outcrop_D = 5.3;

tft_280_base_pin_size_X = 46.7;
tft_280_base_pin_size_Y = 3.66;
tft_280_base_pin_size_Z = 3.66;

tft_280_screen_panel_top_space = 2;
tft_280_screen_panel_bottom_space = 7;

tft_280_screen_X = 50;
tft_280_screen_Y = 4;
tft_280_screen_Z = 70;

tft_280_chip_back_spacer_X = 22;
tft_280_chip_back_spacer_Y = 2.5;

tft_280_screw_X = 57.16;
tft_280_screw_Z = 76.2;

tft_280_screw_D = 3.2;
tft_280_screw_H = 40;

/* modules */

module tft_280_screen(for_cutout=false) {
  difference() {
    union() {
      tft_280_base_board(for_cutout);
      tft_280_screen_panel(for_cutout);
      tft_280_back_chips_and_bits(for_cutout);
    }
    if (!for_cutout) {
      tft_280_screws();
    }
  }
}

module tft_280_base_board(for_cutout=false) {
  color("green") {
    // base
    ccube(tft_280_base_board_size);

    // screw outcrops
    hull() {
      translate([(tft_280_screw_X/2), 0, (tft_280_screw_Z/2)])
        rotate([90, 0, 0])
          ccylinder(h=tft_280_base_board_Y, d=tft_280_base_board_screw_outcrop_D);
      translate([-(tft_280_screw_X/2), 0, (tft_280_screw_Z/2)])
        rotate([90, 0, 0])
          ccylinder(h=tft_280_base_board_Y, d=tft_280_base_board_screw_outcrop_D);
    }
    hull() {
      translate([(tft_280_screw_X/2), 0, -(tft_280_screw_Z/2)])
        rotate([90, 0, 0])
          ccylinder(h=tft_280_base_board_Y, d=tft_280_base_board_screw_outcrop_D);
      translate([-(tft_280_screw_X/2), 0, -(tft_280_screw_Z/2)])
        rotate([90, 0, 0])
          ccylinder(h=tft_280_base_board_Y, d=tft_280_base_board_screw_outcrop_D);
    }
  }
  if (!for_cutout)
  color("white") {
    //solder pins
    Tz((tft_280_base_board_Z/2 - tft_280_base_pin_size_Y/2)) {
      hull() {
        translate([(tft_280_base_pin_size_X/2), -(tft_280_base_pin_size_Y/2 + 0.01 - tft_280_base_board_Y/2), 0])
            rotate([90, 0, 0])
              ccylinder(h=tft_280_base_pin_size_Z, d=tft_280_base_pin_size_Y);
        translate([-(tft_280_base_pin_size_X/2), -(tft_280_base_pin_size_Y/2 + 0.01 - tft_280_base_board_Y/2), 0])
            rotate([90, 0, 0])
              ccylinder(h=tft_280_base_pin_size_Z, d=tft_280_base_pin_size_Y);
      }
    }
    Tz(-(tft_280_base_board_Z/2 - tft_280_base_pin_size_Y/2)) {
      hull() {
        translate([(tft_280_base_pin_size_X/2), -(tft_280_base_pin_size_Y/2 + 0.01 - tft_280_base_board_Y/2), 0])
            rotate([90, 0, 0])
              ccylinder(h=tft_280_base_pin_size_Z, d=tft_280_base_pin_size_Y);
        translate([-(tft_280_base_pin_size_X/2), -(tft_280_base_pin_size_Y/2 + 0.01 - tft_280_base_board_Y/2), 0])
            rotate([90, 0, 0])
              ccylinder(h=tft_280_base_pin_size_Z, d=tft_280_base_pin_size_Y);
      }
    }
  }
}

module tft_280_screen_panel() {
  color("black") {
    screen_offset_Z = -(tft_280_base_board_Z/2 - 2 - 0.1 - tft_280_screen_panel_bottom_space/2 + tft_280_screen_panel_top_space/2);
    ccube([tft_280_screen_X, tft_280_screen_Y, tft_280_screen_Z]);
  }
}

module tft_280_back_chips_and_bits() {
  //memory card slot cpu and other board bits
  translate([0,tft_280_chip_back_spacer_Y/2 + tft_280_base_board_Y/2 - 0.01, 0])
    ccube([tft_280_chip_back_spacer_X, tft_280_chip_back_spacer_Y, tft_280_base_board_Z]);

  //rear plug/pins
  plug_spacer_X = 50;
  plug_spacer_Y = 15;
  plug_spacer_Z = 7;

  plug_spacer_offset_X = 0;
  plug_spacer_offset_Y = plug_spacer_Y/2 + tft_280_base_board_Y/2 - 0.1;
  plug_spacer_offset_Z = (tft_280_base_board_Z/2 - plug_spacer_Z/2);

  translate([plug_spacer_offset_X, plug_spacer_offset_Y, plug_spacer_offset_Z]) {
    ccube([plug_spacer_X, plug_spacer_Y, plug_spacer_Z]);
  }
  translate([plug_spacer_offset_X, plug_spacer_offset_Y, -plug_spacer_offset_Z]) {
    ccube([plug_spacer_X, plug_spacer_Y, plug_spacer_Z]);
  }
}

module tft_280_screws() {
  translate([(tft_280_screw_X/2), 0, (tft_280_screw_Z/2)])
    rotate([90, 0, 0])
      ccylinder(h=tft_280_screw_H, d=tft_280_screw_D);
  translate([-(tft_280_screw_X/2), 0, (tft_280_screw_Z/2)])
    rotate([90, 0, 0])
      ccylinder(h=tft_280_screw_H, d=tft_280_screw_D);
  translate([(tft_280_screw_X/2), 0, -(tft_280_screw_Z/2)])
    rotate([90, 0, 0])
      ccylinder(h=tft_280_screw_H, d=tft_280_screw_D);
  translate([-(tft_280_screw_X/2), 0, -(tft_280_screw_Z/2)])
    rotate([90, 0, 0])
      ccylinder(h=tft_280_screw_H, d=tft_280_screw_D);
}

tft_280_18_X = 35.2;
tft_280_18_Y = 56;
tft_280_18_Z = 1.8;

function get_tft_280_18_X() = tft_280_18_X;
function get_tft_280_18_Y() = tft_280_18_Y;
function get_tft_280_18_Z() = tft_280_18_Z;

module tft_280_18_base(with_screws=true) {
  difference() {
    makeRoundedBox([tft_280_18_X, tft_280_18_Y, tft_280_18_Z], d = 2);
    if (with_screws) {
      tft_280_18_screws();
    }
  }
}

module tft_280_18_screws() {
  screw_offset_X = 29.5;
  screw_offset_Y = 51;

  translate([-screw_offset_X/2, screw_offset_Y/2, 0]) {
    screw10M3Button();
  }
  translate([-screw_offset_X/2, -screw_offset_Y/2, 0]) {
    screw10M3Button();
  }
  translate([screw_offset_X/2, -screw_offset_Y/2, 0]) {
    screw10M3Button();
  }
  translate([screw_offset_X/2, screw_offset_Y/2, 0]) {
    screw10M3Button();
  }
}


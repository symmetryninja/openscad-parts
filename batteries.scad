
/****************** 18650 */
  battery_18650_H = 65;
  battery_18650_D = 18.4;

  battery_18650_case_length = 76.60;
  battery_18650_case_width = 39.92;
  battery_18650_case_height = 15.24;
  battery_18650_case_end_thickness = 3.6;
  battery_18650_case_side_thickness = 2.2;
  battery_18650_case_base_thickness = 1.2;
  battery_18650_case_sub_space_Z = 7;
  battery_18650_case_sub_space_X = 35;
  battery_18650_case_screw_offset_X = 10.7;
  battery_18650_case_screw_offset_Z = 5;
  battery_18650_case_battery_gap_width = 1;
  battery_18650_case_cutout_width = 8.1;
  battery_18650_case_terminal_X = 5;
  battery_18650_case_terminal_Y = 7;
  battery_18650_case_terminal_Z = 0.4;
  battery_18650_case_heightWithBattery = 19.2;

  battery_18650_clip_thickness = 3;
  battery_18650_clip_size_space_X = 35;
  battery_18650_clip_size_space_Y = 39;
  battery_18650_clip_size_space_Z_cutout = 3.4;
  battery_18650_clip_size_space_Z = 19;

  battery_18650_clip_size_X = battery_18650_clip_size_space_X;
  battery_18650_clip_size_Y = battery_18650_clip_size_space_Y + battery_18650_clip_thickness * 2;
  battery_18650_clip_size_Z = battery_18650_clip_size_space_Z + battery_18650_clip_thickness + 3;
  battery_18650_clip_size = [battery_18650_clip_size_X, battery_18650_clip_size_Y, battery_18650_clip_size_Z];

  function BatteryBattery18650DualCaseTerminalX() = battery_18650_case_terminal_X;
  function BatteryBattery18650DualCaseTerminalY() = battery_18650_case_terminal_Y;
  function BatteryBattery18650DualCaseTerminalZ() = battery_18650_case_terminal_Z;


  function Battery18650DualCaseHeight() = battery_18650_case_heightWithBattery;
  function Battery18650DualCaseWidth() = battery_18650_case_width;
  function Battery18650DualCaseLength() = battery_18650_case_length;
  function Battery18650DualCaseScrewOffsetX() = battery_18650_case_length/2 - battery_18650_case_screw_offset_X;
  function Battery18650DualCaseScrewOffsetZ() = 16/2 - (16-battery_18650_case_screw_offset_Z);

  module battery_holder_dual_18650_bolts(withHexBlank=false, hexBlankH=10) {
    translate([Battery18650DualCaseScrewOffsetX(), 0, Battery18650DualCaseScrewOffsetZ()])
      screw16M3ButtonOversize(withHexBlank=withHexBlank, hexBlankH=hexBlankH);
    translate([-Battery18650DualCaseScrewOffsetX(), 0, Battery18650DualCaseScrewOffsetZ()])
      screw16M3ButtonOversize(withHexBlank=withHexBlank, hexBlankH=hexBlankH);
  }

  module battery_holder_dual_18650_part() {
    translate([Battery18650DualCaseScrewOffsetX(), 0, Battery18650DualCaseScrewOffsetZ()])
      children();
    translate([-Battery18650DualCaseScrewOffsetX(), 0, Battery18650DualCaseScrewOffsetZ()])
      children();
  }

  module battery_holder_dual_18650(withBatteries=true) {
    black()
    translate([0,0,battery_18650_case_height/2])
    difference() {
      hull() {
        //make the bottom box
        translate([0,0,(battery_18650_case_height - battery_18650_case_sub_space_Z)/2 - (battery_18650_case_height/2)]) {
          cube([battery_18650_case_length, battery_18650_case_width, battery_18650_case_height - battery_18650_case_sub_space_Z], center=true);
        }

        //make the topbox
        translate([0,0,battery_18650_case_height/2 + 0.5]) {
          cube([battery_18650_case_length, battery_18650_case_sub_space_X, 1], center=true);
        }
      }
      union() {
        //box cutout
        translate([0,0,1.2])
          cube([battery_18650_case_length - (battery_18650_case_end_thickness * 2), battery_18650_case_width - (battery_18650_case_side_thickness * 2), battery_18650_case_height], center=true);
        //side cutout 1
        translate([0,battery_18650_case_width/3,0])
          cube([battery_18650_case_length - (battery_18650_case_end_thickness * 2), battery_18650_case_cutout_width, battery_18650_case_height * 2], center=true);
        //side cutout 2
        translate([0,-battery_18650_case_width/3,0])
          cube([battery_18650_case_length - (battery_18650_case_end_thickness * 2), battery_18650_case_cutout_width, battery_18650_case_height * 2], center=true);
        //make the screws
        battery_holder_dual_18650_bolts();
      }
    }


    //make the batteries if we want them
    batteryOffsetY = (battery_18650_D / 2 + battery_18650_case_battery_gap_width/2);
    batteryOffsetZ = battery_18650_D/2 + (battery_18650_case_heightWithBattery - battery_18650_D);
    if (withBatteries) {
      red()
      translate([0,0,batteryOffsetZ]) {
        rotate([0,90,0]) {
          translate([0,batteryOffsetY,0])
            battery_18650();
          translate([0,-batteryOffsetY,0])
            battery_18650();
        }
      }
    }
  }

  module battery_18650() {
    cylinder(h=battery_18650_H, d=battery_18650_D, center=true);
  }

  module battery_18650_retainer_clip(battery_18650_clip_size_space_Y = 39) {
    difference() {
      ccube([battery_18650_clip_size_space_X, battery_18650_clip_size_space_Y + battery_18650_clip_thickness * 2, battery_18650_clip_size_space_Z + battery_18650_clip_thickness + 3]);
      #battery_18650_retainer_clip_cutouts(battery_18650_clip_size_space_Y);
    }
  }

  module battery_18650_retainer_clip_cutouts(battery_18650_clip_size_space_Y) {
    Tz(-(battery_18650_clip_thickness/2 + 0.01) + 1 ) {
      ccube([battery_18650_clip_size_space_X + 0.1, battery_18650_clip_size_space_Y, battery_18650_clip_size_space_Z ]);
    }
    Tz(-(battery_18650_clip_size_Z/2 - battery_18650_clip_size_space_Z_cutout / 2 + 0.01)) {
      ccube([battery_18650_clip_size_space_X + 0.1, battery_18650_clip_size_space_Y - 6, battery_18650_clip_size_space_Z_cutout + 0.02]);
    }
  }

/****************** multistar_s3_52 */

  function battery_multistar_s3_52_L() = 103;
  function battery_multistar_s3_52_L_2() = 112;
  function battery_multistar_s3_52_W() = 49;
  function battery_multistar_s3_52_H() = 36;

  module battery_multistar_s3_52(oversize_L = 0, oversize_W = 0, oversize_H = 0) {
      bat_L = battery_multistar_s3_52_L() + oversize_L;
      bat_L_2 = battery_multistar_s3_52_L_2() + oversize_L;
      bat_W = battery_multistar_s3_52_W() + oversize_W;
      bat_H = battery_multistar_s3_52_H() + oversize_H;

      
      bat_X = bat_L/2;
      bat_XT = bat_X + bat_L_2 - bat_L;
      bat_Y = bat_W/2;

      bat_Z_T = bat_H/2;
      bat_Z_B = -bat_Z_T;

      /*
      10 points:
      Top
      * tip, * box xy, box x-y, box -x-y, box -xy
      bottom
      * tip, * box xy, box x-y, box -x-y, box -xy
      */
      green()
      polyhedron( 
      points = [
          [ bat_XT, 0,   bat_Z_T],
          [ bat_X, bat_Y,bat_Z_T],
          [-bat_X, bat_Y,bat_Z_T],
          [-bat_X,-bat_Y,bat_Z_T],
          [ bat_X,-bat_Y,bat_Z_T],

          [ bat_XT, 0,    bat_Z_B],
          [ bat_X, bat_Y, bat_Z_B],
          [-bat_X, bat_Y, bat_Z_B],
          [-bat_X,-bat_Y, bat_Z_B],
          [ bat_X,-bat_Y, bat_Z_B],
      ], 
      faces = [
        [4, 3, 2, 1, 0],
        [0, 1, 6, 5],
        [1, 2, 7, 6],
        [2, 3, 8, 7],
        [3, 4, 9, 8],
        [4, 0, 5, 9],
        [5, 6, 7, 8, 9],
      ]
    );
  }
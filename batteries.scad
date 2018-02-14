
18650_batteryH = 65;
18650_batteryD = 18.4;

18650CaseLength = 76.60;
18650CaseWidth = 39.92;
18650CaseHeight = 15.24;
18650CaseEndThickness = 3.6;
18650CaseSideThickness = 2.2;
18650CaseBaseThickness = 1.2;
18650CaseSubSpaceZ = 7;
18650CaseSubSpacex = 35;
18650CaseScrewOffsetX = 10.7;
18650CaseScrewOffsetZ = 5;
18650CaseBatteryGapWidth = 1;
18650CaseCutoutWidth = 8.1;
18650TerminalX = 5;
18650TerminalY = 7;
18650TerminalZ = 0.4;
18650CaseHeightWithBattery = 19.2;

function 18650DualCaseTerminalX() = 18650TerminalX;
function 18650DualCaseTerminalY() = 18650TerminalY;
function 18650DualCaseTerminalZ() = 18650TerminalZ;


function 18650DualCaseHeight() = 18650CaseHeightWithBattery;
function 18650DualCaseWidth() = 18650CaseWidth;
function 18650DualCaseLength() = 18650CaseLength;
function 18650DualCaseScrewOffsetX() = 18650CaseLength/2 - 18650CaseScrewOffsetX;
function 18650DualCaseScrewOffsetZ() = 16/2 - (16-18650CaseScrewOffsetZ);

module battery_holder_dual_18650_bolts(withHexBlank=false, hexBlankH=10) {
  translate([18650DualCaseScrewOffsetX(), 0, 18650DualCaseScrewOffsetZ()])
    screw16M3ButtonOversize(withHexBlank=withHexBlank, hexBlankH=hexBlankH);
  translate([-18650DualCaseScrewOffsetX(), 0, 18650DualCaseScrewOffsetZ()])
    screw16M3ButtonOversize(withHexBlank=withHexBlank, hexBlankH=hexBlankH);
}

module battery_holder_dual_18650(withBatteries=true) {
  translate([0,0,18650CaseHeight/2])
  difference() {
    hull() {
      //make the bottom box
      translate([0,0,(18650CaseHeight - 18650CaseSubSpaceZ)/2 - (18650CaseHeight/2)]) {
        cube([18650CaseLength, 18650CaseWidth, 18650CaseHeight - 18650CaseSubSpaceZ], center=true);
      }

      //make the topbox
      translate([0,0,18650CaseHeight/2 + 0.5]) {
        cube([18650CaseLength, 18650CaseSubSpacex, 1], center=true);
      }
    }
    union() {
      //box cutout
      translate([0,0,1.2])
        cube([18650CaseLength - (18650CaseEndThickness * 2), 18650CaseWidth - (18650CaseSideThickness * 2), 18650CaseHeight], center=true);
      //side cutout 1
      translate([0,18650CaseWidth/3,0])
        cube([18650CaseLength - (18650CaseEndThickness * 2), 18650CaseCutoutWidth, 18650CaseHeight * 2], center=true);
      //side cutout 2
      translate([0,-18650CaseWidth/3,0])
        cube([18650CaseLength - (18650CaseEndThickness * 2), 18650CaseCutoutWidth, 18650CaseHeight * 2], center=true);
      //make the screws
      battery_holder_dual_18650_bolts();
    }
  }


  //make the batteries if we want them
  batteryOffsetY = (18650_batteryD / 2 + 18650CaseBatteryGapWidth/2);
  batteryOffsetZ = 18650_batteryD/2 + (18650CaseHeightWithBattery - 18650_batteryD);
  if (withBatteries) {
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
  cylinder(h=18650_batteryH, d=18650_batteryD, center=true);
}

function battery_multistar_s3_52_L() = 98;
function battery_multistar_s3_52_L_2() = 107;
function battery_multistar_s3_52_W() = 50;
function battery_multistar_s3_52_H() = 39;

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
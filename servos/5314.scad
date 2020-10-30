include <../sn_tools.scad>
include <general_servo.scad>
include <5314_hornes.scad>


function 5314ServoHorneHeight() = baseCubeHeight + (2 * baseToHorneOffset);
function 5314GetbaseCubeHeight() = baseCubeHeight;
function 5314GetbaseCubeY() = baseCubeY;
function 5314GetbaseCubeX() = baseCubeX;
function 5314GetbaseCubeHeight() = baseCubeHeight;

baseCubeY = 43.3;
baseCubeHeight = 32.3;
baseCubeX = 32.3;
servoYoffset = 12.65;
baseToHorneOffset = 3.2;

baseCubeCurveY = 10;
baseCubeCurveX = 20.29;

cutoutCylinderR = 40;
cutoutCylinderOffsetX = - 10;
cutoutCylinderOffsetY = 8;
cutoutCylinderHeight = baseCubeHeight + 0;

module 5314Base(blunt_offset = -34.5) {
  hull() {
    translate([0,(baseCubeY/2) + (baseCubeCurveY/2)]) {
      cube([baseCubeX,baseCubeCurveY, baseCubeHeight], center = true);
    }
    difference() {
      cylinder(d = baseCubeX, h = baseCubeHeight, center = true);
      union() {
        translate([0, 35/2, 0]) {
          cube([35,35,35], center = true);
        }
        translate([0, (blunt_offset/2) - servoYoffset, 0]) {
          cube([35,35,35], center = true);
        }
      }
    }
  }
}

module 5314BaseScale(newSize = [10,10,10], positionOffset = [0,0,0], blunt_offset = -34.5) {
  translate(positionOffset)
    resize(newSize) 5314Base(blunt_offset = blunt_offset);
}

module 5314CubeBaseWithHub() {
  union(){
    5314HubWithOffset();
    5314Base();
  }
}

function get_5314_base_back_oversize_X() = 5314BaseBackOversizeX;
function get_5314_base_back_oversize_Y() = 5314BaseBackOversizeY;
function get_5314_base_back_oversize_Z() = 5314BaseBackOversizeZ;

5314BaseBackOversizeX = 45;
5314BaseBackOversizeY = 20;
5314BaseBackOversizeZ = 5314GetbaseCubeHeight() + 5;
5314BaseBackOffsetY = 35;
5314BucketExtensionBoltOffset = 5314BaseBackOffsetY + 1;

module 5314CubeBaseBackstopBolts() {
  CubeBaseBackstopBoltThreadWidth = 3.2;
  CubeBaseBackstopBoltHeadD= 6.5;
  CubeBaseBackstopBoltHeight = 29;
  CubeBaseBackstopNutDiameter = 7.045;
  CubeBaseBackstopNutHeight = 3;
  CubeBaseBackstopBoltBlankHeight = 10;
  xCenter = 5314BaseBackOversizeX/2 - 5;

  headZposition = ((CubeBaseBackstopBoltHeight - CubeBaseBackstopNutHeight) / 2) + (CubeBaseBackstopBoltBlankHeight/2);
  nutZposition = -headZposition - CubeBaseBackstopNutHeight;
  union() {
    //bolt heads
    translate([xCenter, 5314BucketExtensionBoltOffset, 0])
      screwM3Button(height=29, withHexBlank=true, hexBlankH = CubeBaseBackstopBoltBlankHeight, hexBlankD = CubeBaseBackstopNutDiameter, screwPurchase=2);
    translate([0, 5314BucketExtensionBoltOffset, 0])
      screwM3Button(height=29, withHexBlank=true, hexBlankH = CubeBaseBackstopBoltBlankHeight, hexBlankD = CubeBaseBackstopNutDiameter, screwPurchase=2);
    translate([-xCenter, 5314BucketExtensionBoltOffset, 0])
      screwM3Button(height=29, withHexBlank=true, hexBlankH = CubeBaseBackstopBoltBlankHeight, hexBlankD = CubeBaseBackstopNutDiameter, screwPurchase=2);
  }
}

include <../sn_tools.scad>
include <general_servo.scad>
include <5314_hornes.scad>


function 5314ServoHorneZ() = 5314baseCubeZ + (2 * 5314baseToHorneOffset);
function 5314GetbaseCubeX() = 5314baseCubeX;
function 5314GetbaseCubeY() = 5314baseCubeY;
function 5314GetbaseCubeZ() = 5314baseCubeZ;

5314baseCubeX = 32.3;
5314baseCubeY = 43.3;
5314baseCubeZ = 32.3;
5314servoYoffset = 12.65;
5314baseToHorneOffset = 3.2;

5314baseCubeCurveY = 10;
5314baseCubeCurveX = 20.29;

5314cutoutCylinderR = 40;
5314cutoutCylinderOffsetX = - 10;
5314cutoutCylinderOffsetY = 8;
5314cutoutCylinderHeight = 5314baseCubeZ + 0;

module 5314Base(blunt_offset = -34.5) {
  hull() {
    translate([0,(5314baseCubeY/2) + (5314baseCubeCurveY/2)]) {
      cube([5314baseCubeX,5314baseCubeCurveY, 5314baseCubeZ], center = true);
    }
    difference() {
      cylinder(d = 5314baseCubeX, h = 5314baseCubeZ, center = true);
      union() {
        translate([0, 35/2, 0]) {
          cube([35,35,35], center = true);
        }
        translate([0, (blunt_offset/2) - 5314servoYoffset, 0]) {
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

module 5314CubeBaseWithHub(with_screws=true) {
  union(){
    5314HubWithOffset();
    5314Base();
    if (with_screws) {
      5314MountScrews();
    }
  }
}

function get_5314_base_back_oversize_X() = 5314BaseBackOversizeX;
function get_5314_base_back_oversize_Y() = 5314BaseBackOversizeY;
function get_5314_base_back_oversize_Z() = 5314BaseBackOversizeZ;

5314BaseBackOversizeX = 45;
5314BaseBackOversizeY = 20;
5314BaseBackOversizeZ = 5314GetbaseCubeZ() + 5;
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

module 5314MountScrews() {
  translate([0,(5314baseCubeY/2) - 6.4])
  make_drill_holes(size=[27,27,50], shaftD=2.5);
}
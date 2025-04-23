include <../sn_tools.scad>
include <general_servo.scad>
include <servo_5314_hornes.scad>


function servo_5314ServoHorneZ() = servo_5314baseCubeZ + (2 * servo_5314baseToHorneOffset);
function servo_5314GetbaseCubeX() = servo_5314baseCubeX;
function servo_5314GetbaseCubeY() = servo_5314baseCubeY;
function servo_5314GetbaseCubeZ() = servo_5314baseCubeZ;

servo_5314baseCubeX = 32.3;
servo_5314baseCubeY = 43.3;
servo_5314baseCubeZ = 32.3;
servo_5314servoYoffset = 12.65;
servo_5314baseToHorneOffset = 3.2;

servo_5314baseCubeCurveY = 10;
servo_5314baseCubeCurveX = 20.29;

servo_5314cutoutCylinderR = 40;
servo_5314cutoutCylinderOffsetX = - 10;
servo_5314cutoutCylinderOffsetY = 8;
servo_5314cutoutCylinderHeight = servo_5314baseCubeZ + 0;

module servo_5314Base(blunt_offset = -34.5) {
  hull() {
    translate([0,(servo_5314baseCubeY/2) + (servo_5314baseCubeCurveY/2)]) {
      cube([servo_5314baseCubeX,servo_5314baseCubeCurveY, servo_5314baseCubeZ], center = true);
    }
    difference() {
      cylinder(d = servo_5314baseCubeX, h = servo_5314baseCubeZ, center = true);
      union() {
        translate([0, 35/2, 0]) {
          cube([35,35,35], center = true);
        }
        translate([0, (blunt_offset/2) - servo_5314servoYoffset, 0]) {
          cube([35,35,35], center = true);
        }
      }
    }
  }
}

module servo_5314BaseScale(newSize = [10,10,10], positionOffset = [0,0,0], blunt_offset = -34.5) {
  translate(positionOffset)
    resize(newSize) servo_5314Base(blunt_offset = blunt_offset);
}

module servo_5314CubeBaseWithHub(with_screws=true) {
  union(){
    servo_5314HubWithOffset();
    servo_5314Base();
    if (with_screws) {
      servo_5314MountScrews();
    }
  }
}

function get_servo_5314_base_back_oversize_X() = servo_5314BaseBackOversizeX;
function get_servo_5314_base_back_oversize_Y() = servo_5314BaseBackOversizeY;
function get_servo_5314_base_back_oversize_Z() = servo_5314BaseBackOversizeZ;

servo_5314BaseBackOversizeX = 45;
servo_5314BaseBackOversizeY = 20;
servo_5314BaseBackOversizeZ = servo_5314GetbaseCubeZ() + 5;
servo_5314BaseBackOffsetY = 35;
servo_5314BucketExtensionBoltOffset = servo_5314BaseBackOffsetY + 1;

module servo_5314CubeBaseBackstopBolts() {
  CubeBaseBackstopBoltThreadWidth = 3.2;
  CubeBaseBackstopBoltHeadD= 6.5;
  CubeBaseBackstopBoltHeight = 29;
  CubeBaseBackstopNutDiameter = 7.045;
  CubeBaseBackstopNutHeight = 3;
  CubeBaseBackstopBoltBlankHeight = 10;
  xCenter = servo_5314BaseBackOversizeX/2 - 5;

  headZposition = ((CubeBaseBackstopBoltHeight - CubeBaseBackstopNutHeight) / 2) + (CubeBaseBackstopBoltBlankHeight/2);
  nutZposition = -headZposition - CubeBaseBackstopNutHeight;
  union() {
    //bolt heads
    translate([xCenter, servo_5314BucketExtensionBoltOffset, 0])
      screwM3Button(height=29, withHexBlank=true, hexBlankH = CubeBaseBackstopBoltBlankHeight, hexBlankD = CubeBaseBackstopNutDiameter, screwPurchase=2);
    translate([0, servo_5314BucketExtensionBoltOffset, 0])
      screwM3Button(height=29, withHexBlank=true, hexBlankH = CubeBaseBackstopBoltBlankHeight, hexBlankD = CubeBaseBackstopNutDiameter, screwPurchase=2);
    translate([-xCenter, servo_5314BucketExtensionBoltOffset, 0])
      screwM3Button(height=29, withHexBlank=true, hexBlankH = CubeBaseBackstopBoltBlankHeight, hexBlankD = CubeBaseBackstopNutDiameter, screwPurchase=2);
  }
}

module servo_5314MountScrews() {
  translate([0,(servo_5314baseCubeY/2) - 6.4])
  make_drill_holes(size=[27,27,50], d=2.5);
}
/** includes **/
include <general_servo.scad>
// include <5932_hornes.scad>
include <../sn_tools.scad>

/* TODO
* servo position sensor
* sensors and servos cabling clips and channels
*/

/** general members **/
  //servo box
  5932servoBoxX = 20.5; 
  5932servoBoxY = 40.5;
  5932servoBoxZ = 37.1;
  servoBoxSplineOffset = 10.5;

  //bolt-plate
  5932_bolt_plate_X = 20;
  5932_bolt_plate_Y = 54;
  5932_bolt_plate_Z = 3.5;

  5932_bolt_plate_offset_Z = 10;

  5932_bolt_spacer_X = 9.7;
  5932_bolt_spacer_Y = 48;
  5932_bolt_D = 4.89;

  //servo spline case round bit thing thats part of the servo box
  splineCaseH = 40.9;
  splineCaseTopD = 12.9;
  splineCaseBotD = 11.9;
  splineD = 6;
  splineExtrusionHeight = 4;
  splineCaseOffset = splineCaseH/2 - (splineCaseH/4);


  //the cable spacer
  cableSizeX = 7;
  cableSizeY = 6;
  cableSizeZ = 5;
  cableZoffset = 30 - 5932servoBoxZ/2;

  //the bucket case
  bucketOverhangX = 6;
  bucketOverhangY = 7;
  bucketHeight = 5932servoBoxZ - 4;
  bucketPlateHeight = 5;
  bucketX = 5932servoBoxX + bucketOverhangX * 2;
  bucketY = bucketOverhangY;
  bucketCutoutY = 20;

  bucketTopRetainerHeightDifference = 4;
  bucketTopRetainerHeight = 5932servoBoxZ + 2*bucketTopRetainerHeightDifference;
  bucketTopRetainerD = 40;
  // bucketTopRetainerOffset = get5932HorneDimensionX() + 3;
  bucketTopRetainerOffsetY = (servoBoxSplineOffset + bucketTopRetainerD/2) + 10;
  bucketTopRetainerOverhangEnd = 10;

  sideBoltRetainerD = 15;
  sideBoltRetainerH = 35;
  sideBoltRetainerOffsetZ = -2.4;
  sideBoltRetainerRearOffsetY = 46;
  sideBoltRetainerFrontOffsetY = 10;
  sideBoltRetainerRearOffsetX = bucketX/2 + 2;
  sideBoltRetainerFrontOffsetX = bucketX/2 + 4;

/** Main output modules **/
module 5932_servo(with_detail=false) {
  difference() {
    union() {
      5932_box();
      5932_spline();
      5932_cable_blank();
      5932_bolt_plate();
    }
    union() {
      5932_servo_cutout();
      5932_servo_detail();
    }
  }
}

module 5932_servo_detail() {
  difference() {
    translate([0,- 5932servoBoxX / 2, 5932servoBoxZ / 2]) {
      cube([5932servoBoxX +2, 5932servoBoxX, 3.7], center=true);
    }
    translate([0,0, 0]) {
      cylinder(d=5932servoBoxX - 0.5, h=5932servoBoxZ + 8, center=true);
    }
  }

  triangleZ = 1.5;
  triangleO = 1.0;

  //bottom: shamfer 2mmZ 1.5mmX/Y
  //4 triagles
  translate([0, servoBoxSplineOffset, -5932servoBoxZ/2]) {
    translate([ 5932servoBoxX/2, 0, 0]) {
      rotate([90, 0, 0]) {
        make_triangle([ triangleO * 2, triangleZ * 2, 5932servoBoxY + 4]);
      }
    }
    translate([ -5932servoBoxX/2, 0, 0]) {
      rotate([90, 0, 0]) {
        make_triangle([ triangleO * 2, triangleZ * 2, 5932servoBoxY + 4]);
      }
    }
    translate([ 0, 5932servoBoxY/2, 0]) {
      rotate([90, 0, 90]) {
        make_triangle([ triangleO * 2, triangleZ * 2, 5932servoBoxY + 4]);
      }
    }
    translate([ 0, -5932servoBoxY/2, 0]) {
      rotate([90, 0, 90]) {
        make_triangle([ triangleO * 2, triangleZ * 2, 5932servoBoxY + 4]);
      }
    }
  }

}

module 5932_servo_cutout(undersize=0) {
  5932_servo_bolts(undersize=undersize);
}

/* the side-ish loops */
  module 5932_servo_bolts(undersize=0) {
    translateY(servoBoxSplineOffset) {
      translate([5932_bolt_spacer_X/2, 5932_bolt_spacer_Y/2, -1]) {
        ccylinder(d=5932_bolt_D - undersize, h = 40);
      }
      translate([5932_bolt_spacer_X/2, -5932_bolt_spacer_Y/2, -1]) {
        ccylinder(d=5932_bolt_D - undersize, h = 40);
      }
      translate([-5932_bolt_spacer_X/2, 5932_bolt_spacer_Y/2, -1]) {
        ccylinder(d=5932_bolt_D - undersize, h = 40);
      }
      translate([-5932_bolt_spacer_X/2, -5932_bolt_spacer_Y/2, -1]) {
        ccylinder(d=5932_bolt_D - undersize, h = 40);
      }
    }
  }

/** tooling modules **/
  module 5932_box() {
    //the actual servo box
    translate([0,servoBoxSplineOffset,0])
      ccube([5932servoBoxX, 5932servoBoxY, 5932servoBoxZ]);
  }

  module 5932_bolt_plate() {
    //the screw plate
    translate([0,servoBoxSplineOffset,5932_bolt_plate_offset_Z])
      ccube([5932_bolt_plate_X, 5932_bolt_plate_Y, 5932_bolt_plate_Z]);
  }

  module 5932_spline() {
    union() {
      //the spline case spacer thing
      translateZ(5)
      cylinder(h=5932servoBoxZ + 2 * splineExtrusionHeight - 10, d=splineD, center=true);
    }
  }

  module 5932_cable_blank() {
    cableBlankOffsetY = (servoBoxSplineOffset + (cableSizeY/2)) - 1;
    translate([0,-cableBlankOffsetY, -cableZoffset + cableSizeZ - 6.899])
      ccube([cableSizeX, cableSizeY + 16, 6]);
  }


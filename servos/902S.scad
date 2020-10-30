/** includes **/
include <general_servo.scad>
include <902S_hornes.scad>
include <../sn_tools.scad>

/* TODO
* servo position sensor
* sensors and servos cabling clips and channels
*/

/** general members **/
//servo box
servoBoxX = 20; 
servoBoxY = 41.5;
servoBoxZ = 37.8;
servoBoxSplineOffset = 10.5;

//servo spline case round bit thing thats part of the servo box
splineCaseH = 40.9;
splineCaseTopD = 12.9;
splineCaseBotD = 11.9;
splineD = 5;
splineExtrusionHeight = 4;
splineCaseOffset = splineCaseH/2 - (splineCaseH/4);


//the cable spacer
cableSizeX = 7;
cableSizeY = 6;
cableSizeZ = 5;
cableZoffset = 30 - servoBoxZ/2;

//the bucket case
bucketOverhangX = 6;
bucketOverhangY = 7;
bucketHeight = servoBoxZ - 4;
bucketPlateHeight = 5;
bucketX = servoBoxX + bucketOverhangX * 2;
bucketY = bucketOverhangY;
bucketCutoutY = 20;

bucketTopRetainerHeightDifference = 4;
bucketTopRetainerHeight = servoBoxZ + 2*bucketTopRetainerHeightDifference;
bucketTopRetainerD = 40;
bucketTopRetainerOffset = get902SHorneDimensionX() + 3;
bucketTopRetainerOffsetY = (servoBoxSplineOffset + bucketTopRetainerD/2) + 10;
bucketTopRetainerOverhangEnd = 10;

sideBoltRetainerD = 15;
sideBoltRetainerH = 35;
sideBoltRetainerOffsetZ = -2.4;
sideBoltRetainerRearOffsetY = 46;
sideBoltRetainerFrontOffsetY = 10;
sideBoltRetainerRearOffsetX = bucketX/2 + 2;
sideBoltRetainerFrontOffsetX = bucketX/2 + 4;

bucket_flat_mount_X = 20;
bucket_flat_mount_Y = 35;
bucket_flat_mount_D = 10;
bucket_flat_mount_O = 2;
bucket_flat_mount_H = bucketHeight;

/** functions **/

// function get_902S_() = ;
// function get_902S_() = ;
function get_902S_bucketHeight() = bucketHeight;
function get_902S_bucketTopRetainerOffsetY() = bucketTopRetainerOffsetY;
function get_902S_bucketTopRetainerHeight() = bucketTopRetainerHeight;

/** Main output modules **/
module 902S_servo(with_detail=false) {
  difference() {
    union() {
      902S_box();
      902S_spline();
      902S_cable_blank();
    }
    if (with_detail) {
      902S_servo_detail();
    }
  }
}
module 902S_servo_detail() {
  //top: cylinder cutout 1mm from front of servo, 0.5mm thinner 2mm off the top
  // servoBoxX = 19.9; 
  // servoBoxY = 41.5;
  // servoBoxZ = 37.8;
  // servoBoxSplineOffset = 10.5;
  difference() {
    translate([0,- servoBoxX/2, servoBoxZ/2]) {
      cube([servoBoxX +2, servoBoxX, 3.7], center=true);
    }
    translate([0,0, 0]) {
      cylinder(d=servoBoxX - 0.5, h=servoBoxZ + 8, center=true);
    }
  }

  triangleZ = 1.5;
  triangleO = 1.0;

  //bottom: shamfer 2mmZ 1.5mmX/Y
  //4 triagles
  translate([0, servoBoxSplineOffset, -servoBoxZ/2]) {
    translate([ servoBoxX/2, 0, 0]) {
      rotate([90, 0, 0]) {
        make_triangle([ triangleO * 2, triangleZ * 2, servoBoxY + 4]);
      }
    }
    translate([ -servoBoxX/2, 0, 0]) {
      rotate([90, 0, 0]) {
        make_triangle([ triangleO * 2, triangleZ * 2, servoBoxY + 4]);
      }
    }
    translate([ 0, servoBoxY/2, 0]) {
      rotate([90, 0, 90]) {
        make_triangle([ triangleO * 2, triangleZ * 2, servoBoxY + 4]);
      }
    }
    translate([ 0, -servoBoxY/2, 0]) {
      rotate([90, 0, 90]) {
        make_triangle([ triangleO * 2, triangleZ * 2, servoBoxY + 4]);
      }
    }
  }

}

module 902S_servo_cutout() {
  difference() {
    union() {
      translate([0,servoBoxSplineOffset,0]) {
        union() {
          cube([servoBoxX, servoBoxY, servoBoxZ], center = true);

          hull() {
            cube([servoBoxX+.1, servoBoxY, servoBoxZ-20], center = true);
            cube([servoBoxX, servoBoxY, servoBoxZ -15], center = true);
          }
        }
      }
      902S_spline();
      902S_cable_blank();
    }
    902S_servo_detail();
  }
}

module 902S_servo_bucket_top(withBolts=true, withServoCutout=true) {
  difference() {
    902S_servo_bucket(withBolts=withBolts, withServoCutout=withServoCutout, keyOversize=1.25);
    translate([0,0,-49.5]) {
      cube([200,200,100], center = true);
    }
  }
}

module 902S_servo_bucket_bottom(withBolts=true, withServoCutout=true, left=true) {
  difference() {
    902S_servo_bucket(withBolts=withBolts, withServoCutout=withServoCutout, keyOversize=1.25, left=left);
    translate([0,0,49.5]) {
      cube([200,200,100], center = true);
    }
  }
}

module 902S_servo_bucket_frame_join() {
  difference() {
    translate([0,28,0]) {
      makeRoundedRhombus(bucket_flat_mount_X+3, bucket_flat_mount_Y-1, bucket_flat_mount_D, bucket_flat_mount_O, 15);
    }
    union() {
      902S_servo_bucket(withBolts=false, withServoCutout=false);
      902S_servo_bolts();
    }
  }
}

module 902S_servo_bucket(withBolts=true, withServoCutout=true, keyOversize=0, left=true) {
  retainerH = 42;
  difference() {
    union() {
      //basic servo bucket inner
      difference() {
        union() {
          hull() {
            translate([0,servoBoxSplineOffset + bucketY/2 + servoBoxY/2,0]) {
              cube([bucketX, bucketY, bucketHeight], center=true);
            }
            translate([0, -(bucketOverhangY +1),0]) {
              scale([1,.8,1])
              cylinder(h=bucketHeight, d = servoBoxX + bucketOverhangX * 2, center=true);
            }
          }
          difference() {
            translate([0, -(bucketOverhangY +1),0]) {
              scale([1,.8,1]) {
                cylinder(h=retainerH, d = servoBoxX + bucketOverhangX * 2, center=true);
              }
            }
            translate([0, 3,0]) {
              cylinder(h=retainerH + 2, d = 25, center=true);
            }
          }
        }
      }

      //keycube outer = base height of webbing 10mm each side rear shifted - 20
      joinerX = 20;
      joinerY = 35;
      roundedBoxD = 10;

      centerOffsetX = 14;
      difference() {
        union() {
          translate([0,28,0]) {
            makeRoundedRhombus(bucket_flat_mount_X, bucket_flat_mount_Y, bucket_flat_mount_D, bucket_flat_mount_O, bucket_flat_mount_H);
          }
          translate([0,servoBoxSplineOffset+21,0]) {
            mirror([0,1,0])
            makeRoundedRhombus(12, 17, bucket_flat_mount_D, -2, retainerH);
          }
        }
        cube([150,150,15 + keyOversize], center = true);
      }


      902S_servo_bucket_retainer(left=left);
      translate([0, 30, retainerH/2]) {
        rotate([0, 0, 0])
          linear_extrude(height = 2)

          drawbiohazard( d=27, cheat_ring = 0);
      }
    }
    union() {
      if (withServoCutout) {
        902S_servo_cutout();
      }
      if (withBolts) {
        902S_servo_bolts();
      }
    }
  }
}

module 902S_cable_support_bottom(left=true) {
  /* the base loop */ 
  support_inner_D = 13;
  support_inner_offsetX = 2;
  support_outer_D = 23 ;
  support_H = 9;

  offset_X = -5;
  offset_Y = 14;
  offset_Z = -2.5;

  translate([0,0, -bucketTopRetainerHeight/2 - support_inner_D/2])
  rotate([0,90,90])
  difference() {
    hull() {
      if (left) {
        translate([offset_X,-offset_Y,offset_Z]) {
          cylinder(d=support_outer_D, h=support_H, center=true);
        }
        translate([offset_X - 12,-offset_Y ,offset_Z]) {
          cube([6,15,9], center = true);
        }
      }
      else {
        translate([offset_X,offset_Y,offset_Z]) {
          cylinder(d=support_outer_D, h=support_H, center=true);
        }
        translate([offset_X - 12,offset_Y ,offset_Z]) {
          cube([6,15,9], center = true);
        }
      }
    }
    translate([support_inner_offsetX,0,0]) {
      if (left) {
        translate([offset_X,-offset_Y,offset_Z]) {
          cylinder(d=support_inner_D, h=support_H + 10.1, center=true);
        }
      }
      else {
        translate([offset_X,offset_Y,offset_Z]) {
          cylinder(d=support_inner_D, h=support_H + 10.1, center=true);
        }
      }
    }
  }
}

/* the side-ish loops */
module 902S_cable_support_side(left=true) {
  support_inner_D = 9;
  support_inner_offsetX = 2;
  support_outer_D = 15;
  support_H = 12;

  support_offsetX = 20;
  support_offsetY = 20;
  support_offsetZ = sideBoltRetainerOffsetZ;

  if (left) {
    translate([support_offsetX, support_offsetY, support_offsetZ])
      difference() {
        hull() {
          cylinder(d = support_outer_D , h = sideBoltRetainerH, center = true);
          translate([-3,10,0])
            cube([support_outer_D + 3.5,support_outer_D/2,sideBoltRetainerH], center = true);
        }
        cylinder(d = support_inner_D, h = sideBoltRetainerH + 0.1, center = true);
      }
  }
  else {
    translate([-support_offsetX, support_offsetY, support_offsetZ])
      difference() {
        hull() {
          cylinder(d = support_outer_D , h = sideBoltRetainerH, center = true);
          translate([3,10,0])
            cube([support_outer_D + 3.5,support_outer_D/2,sideBoltRetainerH], center = true);
        }
        cylinder(d = support_inner_D, h = sideBoltRetainerH + 0.1, center = true);
      }
  }
}
module 902S_servo_bucket_retainer(left = true) {
  translate([0,bucketTopRetainerOffsetY - 6,-1.5]) {
    902S_cable_support_bottom(left = left);
  }
}

module 902S_servo_bolts() {
  translate([sideBoltRetainerFrontOffsetX, sideBoltRetainerFrontOffsetY, -1])
    rotate([0,0,30])
      screw29M3Button(withHexBlank=true, hexBlankH = 10, hexBlankD=hex_blank_largeM3StainlessD());
  translate([-sideBoltRetainerFrontOffsetX, sideBoltRetainerFrontOffsetY, -1])
    rotate([0,0,30])
      screw29M3Button(withHexBlank=true, hexBlankH = 10, hexBlankD=hex_blank_largeM3StainlessD());
  translate([sideBoltRetainerRearOffsetX, sideBoltRetainerRearOffsetY, -1])
    rotate([0,0,30])
      screw29M3Button(withHexBlank=true, hexBlankH = 10, hexBlankD=hex_blank_largeM3StainlessD());
  translate([-sideBoltRetainerRearOffsetX, sideBoltRetainerRearOffsetY, -1])
    rotate([0,0,30])
      screw29M3Button(withHexBlank=true, hexBlankH = 10, hexBlankD=hex_blank_largeM3StainlessD());
  translate([-7, sideBoltRetainerFrontOffsetY - 25, -1])
    screw39M3Button(withHexBlank=true, hexBlankH = 10, hexBlankD=hex_blank_largeM3StainlessD());
  translate([7, sideBoltRetainerFrontOffsetY - 25, -1])
    screw39M3Button(withHexBlank=true, hexBlankH = 10, hexBlankD=hex_blank_largeM3StainlessD());
}

/** tooling modules **/
module 902S_box() {
  //the actual servo box
  translate([0,servoBoxSplineOffset,0])
    cube([servoBoxX, servoBoxY, servoBoxZ], center = true);
}

module 902S_spline() {
  union() {
    //the spline case spacer thing
    translate([0,0,splineCaseOffset])
      cylinder(h = splineCaseH/2, d=splineCaseTopD, center=true);
    translate([0,0,-splineCaseOffset])
      cylinder(h = splineCaseH/2, d=splineCaseBotD, center=true);
    cylinder(h=servoBoxZ + 2* splineExtrusionHeight, d=splineD, center=true);
  }
}

module 902S_cable_blank() {
  cableBlankOffsetY = (servoBoxSplineOffset + (cableSizeY/2)) - 1;
  translate([0,-cableBlankOffsetY, -cableZoffset + cableSizeZ - 6.899])
    cube([cableSizeX, cableSizeY + 16, 6], center = true);
}





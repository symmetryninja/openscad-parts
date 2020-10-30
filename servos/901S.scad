/** includes **/
include <general_servo.scad>
include <902S.scad>

include <../sn_tools.scad>

/* TODO
* servo position sensor
* sensors and servos cabling clips and channels
*/

/** general members **/

901s_servoBoxX = 20.5; 
servoBoxZ = 37.8;

901s_outcrop_X = 901s_servoBoxX;
901s_outcrop_Y = 56;
901s_outcrop_Z = 2.7;
901s_outcrop_offset_Z = 29.7 - (servoBoxZ/2) ;

901s_bolt_D = 5;
901s_bolt_offset_X = 4.85;
901s_bolt_offset_Y_1 = servoBoxSplineOffset -25;
901s_bolt_offset_Y_2 = servoBoxSplineOffset +25;

901s_servo_bucket_thickness = 3;
901s_servo_bucket_X = 901s_outcrop_X + (901s_servo_bucket_thickness * 2);
901s_servo_bucket_Y = 901s_outcrop_Y - 0.01;
901s_servo_bucket_Z = 22;


/** functions **/

/** Main output modules **/
module 901S_servo(with_detail=false) {
  difference() {
    union() {
      901S_box();
      901S_spline();
      901S_cable_blank();
    }
    if (with_detail) {
      901S_servo_detail();
    }
  }
}

module 901S_servo_detail() {
  //top: cylinder cutout 1mm from front of servo, 0.5mm thinner 2mm off the top
  // 901s_servoBoxX = 19.9; 
  // servoBoxY = 41.5;
  // servoBoxZ = 37.8;
  // servoBoxSplineOffset = 10.5;
  difference() {
    translate([0,- 901s_servoBoxX/2, servoBoxZ/2]) {
      cube([901s_servoBoxX +2, 901s_servoBoxX, 3.7], center=true);
    }
    translate([0,0, 0]) {
      cylinder(d=901s_servoBoxX - 0.5, h=servoBoxZ + 8, center=true);
    }
  }
  
  901S_servo_cutout_bolts();
  
  triangleZ = 1.5;
  triangleO = 1.0;

  //bottom: shamfer 2mmZ 1.5mmX/Y
  //4 triagles
  translate([0, servoBoxSplineOffset, -servoBoxZ/2]) {
    translate([ 901s_servoBoxX/2, 0, 0]) {
      rotate([90, 0, 0]) {
        make_triangle([ triangleO * 2, triangleZ * 2, servoBoxY + 4]);
      }
    }
    translate([ -901s_servoBoxX/2, 0, 0]) {
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

module 901S_servo_cutout_bolts() {
  translate([901s_bolt_offset_X, 901s_bolt_offset_Y_1, 0]) {
    screw39M3Button();
  }
  translate([-901s_bolt_offset_X, 901s_bolt_offset_Y_1, 0]) {
    screw39M3Button();
  }

  translate([901s_bolt_offset_X, 901s_bolt_offset_Y_2, 0]) {
    screw39M3Button();
  }
  translate([-901s_bolt_offset_X, 901s_bolt_offset_Y_2, 0]) {
    screw39M3Button();
  }


}


module 901S_servo_cutout() {
  difference() {
    union() {
      translate([0,servoBoxSplineOffset,0]) {
        union() {
          cube([901s_servoBoxX, servoBoxY, servoBoxZ], center = true);

          hull() {
            cube([901s_servoBoxX+.1, servoBoxY, servoBoxZ-20], center = true);
            cube([901s_servoBoxX, servoBoxY, servoBoxZ -15], center = true);
          }
        }
      }
      901S_spline();
      901S_cable_blank();
    }
    901S_servo_detail();
  }
}

module 901S_servo_bucket(withBolts=true, withServoCutout=true, keyOversize=0, left=true) {
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
              cylinder(h=bucketHeight, d = 901s_servoBoxX + bucketOverhangX * 2, center=true);
            }
          }
          difference() {
            translate([0, -(bucketOverhangY +1),0]) {
              scale([1,.8,1]) {
                cylinder(h=retainerH, d = 901s_servoBoxX + bucketOverhangX * 2, center=true);
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


      901S_servo_bucket_retainer(left=left);
      translate([0, 30, retainerH/2]) {
        rotate([0, 0, 0])
          linear_extrude(height = 2)

          drawbiohazard( d=27, cheat_ring = 0);
      }
    }
    union() {
      if (withServoCutout) {
        901S_servo_cutout();
      }
      if (withBolts) {
        901S_servo_bolts();
      }
    }
  }
}

module 901S_cable_support_bottom(left=true) {
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
module 901S_cable_support_side(left=true) {
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

module 901S_servo_bucket_retainer(left = true) {
  translate([0,bucketTopRetainerOffsetY - 6,-1.5]) {
    901S_cable_support_bottom(left = left);
  }
}

module 901S_servo_bolts() {
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
module 901S_box() {
  //the actual servo box
  translate([0,servoBoxSplineOffset,0])
    cube([901s_servoBoxX, servoBoxY, servoBoxZ], center = true);
  translate([0,servoBoxSplineOffset,901s_outcrop_offset_Z])
    cube([901s_outcrop_X, 901s_outcrop_Y, 901s_outcrop_Z], center = true);
}

module 901S_spline() {
  902S_spline();
}

module 901S_cable_blank() {
  translate([0,15, -20])
    cube([8.5, 3, 10], center = true);
}





include <../sn_tools.scad>
/**
 * this is the servo horne hub objects, used for differential calc on servo arms
 */


function servo_5314MergeOverlap() = 2;

 // -- model calc -- //
module servo_5314HubWithOffset(offset=[0,0,0], hubBlanks=true) {
  translate([offset[0],offset[1],offset[2] + servo_5314barrelOffsetZ]) {
    //buid the hub barrel
    servo_5314MakeHubCenter();

    //make the hub bolts
    servo_5314MakeHubBolts();
    mirror ([0,0,1]) {
      servo_5314MakeHubBolts();
    }
    if (hubBlanks) {
      mirror ([0,0,1]) {
        5134MakeHubBlanks();
      }
      5134MakeHubBlanks();
    }
  }
}

// -- members -- //
//the horne barrel
servo_5314barrelZ = 40.1;
servo_5314barrelD = 20;
servo_5314barrelOffsetZ = 0.5;

//hub bolts
servo_5314hubBoltD = 2.7;
servo_5314hubBoltH = 10;
servo_5314hubBoltOffset = 3.5;
servo_5314hubBoltNutH = 5;
servo_5314hubBoltNutD = 7.044 + 2;
servo_5314hubBoltRadialCenter = (servo_5314barrelD / 2) - (2.36 + (1.39/2));

//the mount screw extrusion
servo_5314mountScrewExD = 9;
servo_5314mountScrewExH = 10 + servo_5314hubBoltOffset + servo_5314hubBoltNutH;

//general stuff

module servo_5314MakeHubCenter() {
  servo_5314MakeHubBarrel();
  servo_5314MakeHubBarrelMountScrews();
}

module servo_5314MakeHubBarrel() {
  ccylinder(d = servo_5314barrelD, h=servo_5314barrelZ);

}

module servo_5314MakeHubBarrelMountScrews() {
  ccylinder(d = servo_5314mountScrewExD, h=servo_5314barrelZ + servo_5314mountScrewExH);
  ccylinder(d = servo_5314mountScrewExD + 2, h= 2 + servo_5314barrelZ);

}

module 5134MakeHubBlanks() {
  translate([0,0,((servo_5314barrelZ / 2) + servo_5314hubBoltOffset)]) {
    cylinder(r = servo_5314hubBoltRadialCenter + (servo_5314hubBoltNutD/2), h = servo_5314hubBoltNutH);
  }
}

module servo_5314MakeHubBolts() {
  servo_5314MakeHubBolt([ 0, servo_5314hubBoltRadialCenter, (servo_5314barrelZ / 2) - servo_5314MergeOverlap()]);
  servo_5314MakeHubBolt([ 0, -servo_5314hubBoltRadialCenter, (servo_5314barrelZ / 2) - servo_5314MergeOverlap()]);
  servo_5314MakeHubBolt([ servo_5314hubBoltRadialCenter, 0, (servo_5314barrelZ / 2) - servo_5314MergeOverlap()]);
  servo_5314MakeHubBolt([ -servo_5314hubBoltRadialCenter, 0, (servo_5314barrelZ / 2) - servo_5314MergeOverlap()]);
}

module servo_5314MakeHubBolt(translateVector=[0,0,0]) {
  translate(translateVector) {
    cylinder(d=servo_5314hubBoltD, h = servo_5314hubBoltH + servo_5314MergeOverlap());
  }
}

servo_5314horneX = 35;
servo_5314horneY = 60;
servo_5314horneZ = 5;
servo_5314horneZFlush = 8;

function horneBackOffset() = 20;
// function horneBackCubeOffsetFromSpindle() = horneBackOffset() + (servo_5314horneZ/2) + (servo_5314horneZFlush/2);
function horneBackCubeOffsetFromSpindle() = servo_5314horneX + (servo_5314horneX /2) + horneBackOffset() + (servo_5314hornJoinExtensionY/2) -0.1;


servo_5314horneBackX = 20;
servo_5314horneBackY = 20;
servo_5314horneBackZ = 17.5;

servo_5314hornJoinExtensionX = 0;
servo_5314hornJoinExtensionY = 5;

function servo_5314HornJoinXToCenter() = servo_5314horneX - (servo_5314horneX /2) + horneBackOffset() + (servo_5314hornJoinExtensionY/2) +0.1;
function servo_5314HornMountBlockYoffset() = -servo_5314horneX + (servo_5314horneX /2) - horneBackOffset();

//hornes
module servo_5314Hornes(arcRadius=0, arcDetail=100 ) {
  difference() {
    union() {
      servo_5314horneTop(arcRadius=arcRadius,arcDetail=arcDetail);
    }
    servo_5314HorneBolts(arcRadius=arcRadius);
  }

  difference() {
    union() {
      servo_5314horneBottom(arcRadius=arcRadius,arcDetail=arcDetail);
    }
    servo_5314HorneBolts(arcRadius=arcRadius);
  }

}
module servo_5314HorneBolts(arcRadius=0) {
  horneBoltHeight = 16;
  horneBoltBlankHeight = 10;
  horneBoltPurchase = 3;
  horneBoltCutoutHeight = horneBoltBlankHeight + ((horneBoltHeight - horneBoltPurchase) * 2);
  horneBoltHeadDiameter = 7;
  horneBoltHeadBlankHeight = 16;
  arcChopAngle = servo_5314horneCalculateChopAngle(arcRadius=arcRadius);

  union() {
    servo_5314CubeBaseWithHub();
    rotate([0,0,-(arcChopAngle)]) {
      translate([0,servo_5314HornMountBlockYoffset() - hexBlankDiameter()/1.5,0])
        ccylinder(h = horneBoltCutoutHeight + 2, d = 3.2);

      translate([0,servo_5314HornMountBlockYoffset() - hexBlankDiameter()/1.5,(horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        ccylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter);

      translate([0,servo_5314HornMountBlockYoffset() - hexBlankDiameter()/1.5, - (horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        ccylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter);

      translate([0,servo_5314HornMountBlockYoffset() + hexBlankDiameter()/1.5,0])
        ccylinder(h = horneBoltCutoutHeight + 2, d = 3.2);

      translate([0,servo_5314HornMountBlockYoffset() + hexBlankDiameter()/1.5,(horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        ccylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter);

      translate([0,servo_5314HornMountBlockYoffset() + hexBlankDiameter()/1.5, - (horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        ccylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter);
    }
  }
}


module servo_5314HornJoin() {
  translate([0,-servo_5314horneX + (servo_5314horneX /2) - horneBackOffset() - (servo_5314hornJoinExtensionY/2) -0.1, 0] ) {
    ccube([servo_5314horneBackX + servo_5314hornJoinExtensionX, servo_5314horneBackY + servo_5314hornJoinExtensionY, horneBackOffset()]);
  }
}

function servo_5314horneCalculateChopAngle(arcRadius) = (arcRadius == 0) ? 0 : calc_arc_slice_from_length(length = servo_5314horneBackY/2, radius = arcRadius) * 2;

module servo_5314horneTop(arcRadius=0, arcDetail=100) {
  //calculate the chop angle
  arcChopAngle = servo_5314horneCalculateChopAngle(arcRadius=arcRadius);
  translate([0,0, (servo_5314ServoHorneHeight() / 2) + (servo_5314horneZ / 2) + 1.5 ]) {
    union() {
      hull() {
        ccylinder(d = servo_5314horneX, h = servo_5314horneZFlush);
        translate([0,-servo_5314horneX + (servo_5314horneX /2),(servo_5314horneZ/2) - (servo_5314horneZFlush/2)]) {
          ccylinder(d = servo_5314horneX, h = servo_5314horneZ);
          rotate([0,0,-(arcChopAngle * 2)])
            translate([0,-horneBackOffset(),0]) {
              ccube([servo_5314horneBackX, servo_5314horneBackY, servo_5314horneZ]);
            }
        }
      }
      //if no arc angle, just make a cube
      if (arcRadius == 0) {
        translate([0,-servo_5314horneX + (servo_5314horneX /2) - horneBackOffset(), - (servo_5314horneBackZ/2)]) { 
          ccube([servo_5314horneBackX, servo_5314horneBackY, servo_5314horneBackZ]);
        }
      }
      else {
        //make the arc and move it into place
        union() {
          translate([-arcRadius + (servo_5314horneBackY/2), 0, -(servo_5314horneBackZ/2)]) {
            rotate([0,0,-(arcChopAngle * 2)])
              arc(thickness = servo_5314horneBackX, depth = servo_5314horneBackZ, radius = arcRadius, degrees = arcChopAngle, detail = arcDetail);
          }
        }
      }
    }
  }
}

module servo_5314horneBottom(arcRadius=0, arcDetail=100) {
  //calculate the chop angle
  arcChopAngle = servo_5314horneCalculateChopAngle(arcRadius=arcRadius);
  translate([0,0,(-(servo_5314ServoHorneHeight() / 2)) - (servo_5314horneZ / 2) - 1.5]) {
    union() {
      hull() {
        ccylinder(d = servo_5314horneX, h = servo_5314horneZFlush);
        translate([0,-servo_5314horneX + (servo_5314horneX /2),-((servo_5314horneZ/2) - (servo_5314horneZFlush/2))]) {
          ccylinder(d = servo_5314horneX, h = servo_5314horneZ);
          rotate([0,0,-(arcChopAngle * 2)])
            translate([0,-horneBackOffset(),0]) {
              ccube([servo_5314horneBackX, servo_5314horneBackY, servo_5314horneZ]);
            }
        }
      }
      //if no arc angle, just make a cube
      if (arcRadius == 0) {
        translate([0,-servo_5314horneX + (servo_5314horneX /2) - horneBackOffset(), + (servo_5314horneBackZ/2)]) {
          ccube([servo_5314horneBackX, servo_5314horneBackY, servo_5314horneBackZ]);
        }
      }
      else {
        //make the arc and move it into place
        union() {
          translate([-arcRadius + (servo_5314horneBackY/2),0, + (servo_5314horneBackZ/2)]) {
            rotate([0,0,-(arcChopAngle * 2)])
              arc(thickness = servo_5314horneBackX, depth = servo_5314horneBackZ, radius = arcRadius, degrees = arcChopAngle, detail = arcDetail);
          }
        }
      }
    }
  }
}

module servo_5314horneSingle() {
  hull() {
    ccylinder(d = servo_5314horneX, h = servo_5314horneZFlush);
    translate([0,-servo_5314horneX + (servo_5314horneX /2),(servo_5314horneZ/2) - (servo_5314horneZFlush/2)]) {
      ccylinder(d = servo_5314horneX, h = servo_5314horneZ);
    }
  } 
}



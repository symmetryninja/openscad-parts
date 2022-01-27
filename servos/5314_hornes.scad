include <../sn_tools.scad>
/**
 * this is the servo horne hub objects, used for differential calc on servo arms
 */


function 5314MergeOverlap() = 2;

 // -- model calc -- //
module 5314HubWithOffset(offset=[0,0,0], hubBlanks=true) {
  translate([offset[0],offset[1],offset[2] + 5314barrelOffsetZ]) {
    //buid the hub barrel
    5314MakeHubCenter();

    //make the hub bolts
    5314MakeHubBolts();
    mirror ([0,0,1]) {
      5314MakeHubBolts();
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
5314barrelZ = 40.1;
5314barrelD = 20;
5314barrelOffsetZ = 0.5;

//hub bolts
5314hubBoltD = 2.7;
5314hubBoltH = 10;
5314hubBoltOffset = 3.5;
5314hubBoltNutH = 5;
5314hubBoltNutD = 7.044 + 2;
5314hubBoltRadialCenter = (5314barrelD / 2) - (2.36 + (1.39/2));

//the mount screw extrusion
5314mountScrewExD = 9;
5314mountScrewExH = 10 + 5314hubBoltOffset + 5314hubBoltNutH;

//general stuff

module 5314MakeHubCenter() {
  5314MakeHubBarrel();
  5314MakeHubBarrelMountScrews();
}

module 5314MakeHubBarrel() {
  ccylinder(d = 5314barrelD, h=5314barrelZ);

}

module 5314MakeHubBarrelMountScrews() {
  ccylinder(d = 5314mountScrewExD, h=5314barrelZ + 5314mountScrewExH);
  ccylinder(d = 5314mountScrewExD + 2, h= 2 + 5314barrelZ);

}

module 5134MakeHubBlanks() {
  translate([0,0,((5314barrelZ / 2) + 5314hubBoltOffset)]) {
    cylinder(r = 5314hubBoltRadialCenter + (5314hubBoltNutD/2), h = 5314hubBoltNutH);
  }
}

module 5314MakeHubBolts() {
  5314MakeHubBolt([ 0, 5314hubBoltRadialCenter, (5314barrelZ / 2) - 5314MergeOverlap()]);
  5314MakeHubBolt([ 0, -5314hubBoltRadialCenter, (5314barrelZ / 2) - 5314MergeOverlap()]);
  5314MakeHubBolt([ 5314hubBoltRadialCenter, 0, (5314barrelZ / 2) - 5314MergeOverlap()]);
  5314MakeHubBolt([ -5314hubBoltRadialCenter, 0, (5314barrelZ / 2) - 5314MergeOverlap()]);
}

module 5314MakeHubBolt(translateVector=[0,0,0]) {
  translate(translateVector) {
    cylinder(d=5314hubBoltD, h = 5314hubBoltH + 5314MergeOverlap());
  }
}

5314horneX = 35;
5314horneY = 60;
5314horneZ = 5;
5314horneZFlush = 8;

function horneBackOffset() = 20;
// function horneBackCubeOffsetFromSpindle() = horneBackOffset() + (5314horneZ/2) + (5314horneZFlush/2);
function horneBackCubeOffsetFromSpindle() = 5314horneX + (5314horneX /2) + horneBackOffset() + (5314hornJoinExtensionY/2) -0.1;


5314horneBackX = 20;
5314horneBackY = 20;
5314horneBackZ = 17.5;

5314hornJoinExtensionX = 0;
5314hornJoinExtensionY = 5;

function 5314HornJoinXToCenter() = 5314horneX - (5314horneX /2) + horneBackOffset() + (5314hornJoinExtensionY/2) +0.1;
function 5314HornMountBlockYoffset() = -5314horneX + (5314horneX /2) - horneBackOffset();

//hornes
module 5314Hornes(arcRadius=0, arcDetail=100 ) {
  difference() {
    union() {
      5314horneTop(arcRadius=arcRadius,arcDetail=arcDetail);
    }
    5314HorneBolts(arcRadius=arcRadius);
  }

  difference() {
    union() {
      5314horneBottom(arcRadius=arcRadius,arcDetail=arcDetail);
    }
    5314HorneBolts(arcRadius=arcRadius);
  }

}
module 5314HorneBolts(arcRadius=0) {
  horneBoltHeight = 16;
  horneBoltBlankHeight = 10;
  horneBoltPurchase = 3;
  horneBoltCutoutHeight = horneBoltBlankHeight + ((horneBoltHeight - horneBoltPurchase) * 2);
  horneBoltHeadDiameter = 7;
  horneBoltHeadBlankHeight = 16;
  arcChopAngle = 5314horneCalculateChopAngle(arcRadius=arcRadius);

  union() {
    5314CubeBaseWithHub();
    rotate([0,0,-(arcChopAngle)]) {
      translate([0,5314HornMountBlockYoffset() - hexBlankDiameter()/1.5,0])
        ccylinder(h = horneBoltCutoutHeight + 2, d = 3.2);

      translate([0,5314HornMountBlockYoffset() - hexBlankDiameter()/1.5,(horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        ccylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter);

      translate([0,5314HornMountBlockYoffset() - hexBlankDiameter()/1.5, - (horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        ccylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter);

      translate([0,5314HornMountBlockYoffset() + hexBlankDiameter()/1.5,0])
        ccylinder(h = horneBoltCutoutHeight + 2, d = 3.2);

      translate([0,5314HornMountBlockYoffset() + hexBlankDiameter()/1.5,(horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        ccylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter);

      translate([0,5314HornMountBlockYoffset() + hexBlankDiameter()/1.5, - (horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        ccylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter);
    }
  }
}


module 5314HornJoin() {
  translate([0,-5314horneX + (5314horneX /2) - horneBackOffset() - (5314hornJoinExtensionY/2) -0.1, 0] ) {
    ccube([5314horneBackX + 5314hornJoinExtensionX, 5314horneBackY + 5314hornJoinExtensionY, horneBackOffset()]);
  }
}

function 5314horneCalculateChopAngle(arcRadius) = (arcRadius == 0) ? 0 : calc_arc_slice_from_length(length = 5314horneBackY/2, radius = arcRadius) * 2;

module 5314horneTop(arcRadius=0, arcDetail=100) {
  //calculate the chop angle
  arcChopAngle = 5314horneCalculateChopAngle(arcRadius=arcRadius);
  translate([0,0, (5314ServoHorneHeight() / 2) + (5314horneZ / 2) + 1.5 ]) {
    union() {
      hull() {
        ccylinder(d = 5314horneX, h = 5314horneZFlush);
        translate([0,-5314horneX + (5314horneX /2),(5314horneZ/2) - (5314horneZFlush/2)]) {
          ccylinder(d = 5314horneX, h = 5314horneZ);
          rotate([0,0,-(arcChopAngle * 2)])
            translate([0,-horneBackOffset(),0]) {
              ccube([5314horneBackX, 5314horneBackY, 5314horneZ]);
            }
        }
      }
      //if no arc angle, just make a cube
      if (arcRadius == 0) {
        translate([0,-5314horneX + (5314horneX /2) - horneBackOffset(), - (5314horneBackZ/2)]) { 
          ccube([5314horneBackX, 5314horneBackY, 5314horneBackZ]);
        }
      }
      else {
        //make the arc and move it into place
        union() {
          translate([-arcRadius + (5314horneBackY/2), 0, -(5314horneBackZ/2)]) {
            rotate([0,0,-(arcChopAngle * 2)])
              arc(thickness = 5314horneBackX, depth = 5314horneBackZ, radius = arcRadius, degrees = arcChopAngle, detail = arcDetail);
          }
        }
      }
    }
  }
}

module 5314horneBottom(arcRadius=0, arcDetail=100) {
  //calculate the chop angle
  arcChopAngle = 5314horneCalculateChopAngle(arcRadius=arcRadius);
  translate([0,0,(-(5314ServoHorneHeight() / 2)) - (5314horneZ / 2) - 1.5]) {
    union() {
      hull() {
        ccylinder(d = 5314horneX, h = 5314horneZFlush);
        translate([0,-5314horneX + (5314horneX /2),-((5314horneZ/2) - (5314horneZFlush/2))]) {
          ccylinder(d = 5314horneX, h = 5314horneZ);
          rotate([0,0,-(arcChopAngle * 2)])
            translate([0,-horneBackOffset(),0]) {
              ccube([5314horneBackX, 5314horneBackY, 5314horneZ]);
            }
        }
      }
      //if no arc angle, just make a cube
      if (arcRadius == 0) {
        translate([0,-5314horneX + (5314horneX /2) - horneBackOffset(), + (5314horneBackZ/2)]) {
          ccube([5314horneBackX, 5314horneBackY, 5314horneBackZ]);
        }
      }
      else {
        //make the arc and move it into place
        union() {
          translate([-arcRadius + (5314horneBackY/2),0, + (5314horneBackZ/2)]) {
            rotate([0,0,-(arcChopAngle * 2)])
              arc(thickness = 5314horneBackX, depth = 5314horneBackZ, radius = arcRadius, degrees = arcChopAngle, detail = arcDetail);
          }
        }
      }
    }
  }
}

module 5314horneSingle() {
  hull() {
    ccylinder(d = 5314horneX, h = 5314horneZFlush);
    translate([0,-5314horneX + (5314horneX /2),(5314horneZ/2) - (5314horneZFlush/2)]) {
      ccylinder(d = 5314horneX, h = 5314horneZ);
    }
  } 
}



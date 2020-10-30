include <../sn_tools.scad>
/**
 * this is the servo horne hub objects, used for differential calc on servo arms
 */


function 5314MergeOverlap() = 2;

 // -- model calc -- //
module 5314HubWithOffset(offset=[0,0,0], hubBlanks=true) {
  translate([offset[0],offset[1],offset[2] + barrelOffsetZ]) {
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
barrelH = 40.1;
barrelD = 20;
barrelOffsetZ = 0.5;

//hub bolts
hubBoltD = 2.7;
hubBoltH = 10;
hubBoltOffset = 3.5;
hubBoltNutH = 5;
hubBoltNutD = 7.044 + 2;
hubBoltRadialCenter = (barrelD / 2) - (2.36 + (1.39/2));

//the mount screw extrusion
mountScrewExD = 9;
mountScrewExH = 10 + hubBoltOffset + hubBoltNutH;

//general stuff

module 5314MakeHubCenter() {
  5314MakeHubBarrel();
  5314MakeHubBarrelMountScrews();
}

module 5314MakeHubBarrel() {
  cylinder(d = barrelD, h=barrelH, center = true);

}

module 5314MakeHubBarrelMountScrews() {
  cylinder(d = mountScrewExD, h=barrelH + mountScrewExH, center = true);
  cylinder(d = mountScrewExD + 2, h= 2 + barrelH, center = true);

}

module 5134MakeHubBlanks() {
  translate([0,0,((barrelH / 2) + hubBoltOffset)]) {
    cylinder(r = hubBoltRadialCenter + (hubBoltNutD/2), h = hubBoltNutH);
  }
}

module 5314MakeHubBolts() {
  5314MakeHubBolt([ 0, hubBoltRadialCenter, (barrelH / 2) - 5314MergeOverlap()]);
  5314MakeHubBolt([ 0, -hubBoltRadialCenter, (barrelH / 2) - 5314MergeOverlap()]);
  5314MakeHubBolt([ hubBoltRadialCenter, 0, (barrelH / 2) - 5314MergeOverlap()]);
  5314MakeHubBolt([ -hubBoltRadialCenter, 0, (barrelH / 2) - 5314MergeOverlap()]);
}

module 5314MakeHubBolt(translateVector=[0,0,0]) {
  translate(translateVector) {
    cylinder(d=hubBoltD, h = hubBoltH + 5314MergeOverlap());
  }
}

horneX = 35;
horneY = 60;
horneZ = 5;
horneZFlush = 8;

function horneBackOffset() = 20;
// function horneBackCubeOffsetFromSpindle() = horneBackOffset() + (horneZ/2) + (horneZFlush/2);
function horneBackCubeOffsetFromSpindle() = horneX + (horneX /2) + horneBackOffset() + (hornJoinExtensionY/2) -0.1;


//hor?neBackOffset = 20;
horneBackXLength = 20;
horneBackYLength = 20;
horneBackZHeight = 17.5;

hornJoinExtensionX = 0;
hornJoinExtensionY = 5;

function 5314HornJoinXToCenter() = horneX - (horneX /2) + horneBackOffset() + (hornJoinExtensionY/2) +0.1;
function 5314HornMountBlockYoffset() = -horneX + (horneX /2) - horneBackOffset();

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
        cylinder(h = horneBoltCutoutHeight + 2, d = 3.2, center = true);

      translate([0,5314HornMountBlockYoffset() - hexBlankDiameter()/1.5,(horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        cylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter, center = true);

      translate([0,5314HornMountBlockYoffset() - hexBlankDiameter()/1.5, - (horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        cylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter, center = true);

      translate([0,5314HornMountBlockYoffset() + hexBlankDiameter()/1.5,0])
        cylinder(h = horneBoltCutoutHeight + 2, d = 3.2, center = true);

      translate([0,5314HornMountBlockYoffset() + hexBlankDiameter()/1.5,(horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        cylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter, center = true);

      translate([0,5314HornMountBlockYoffset() + hexBlankDiameter()/1.5, - (horneBoltCutoutHeight + horneBoltHeadBlankHeight) /2])
        cylinder(h = horneBoltHeadBlankHeight, d = horneBoltHeadDiameter, center = true);
    }
  }
}


module 5314HornJoin() {
  translate([0,-horneX + (horneX /2) - horneBackOffset() - (hornJoinExtensionY/2) -0.1, 0] ) {
    cube([horneBackXLength + hornJoinExtensionX, horneBackYLength + hornJoinExtensionY, horneBackOffset()], center = true);
  }
}

function 5314horneCalculateChopAngle(arcRadius) = (arcRadius == 0) ? 0 : calc_arc_slice_from_length(length = horneBackYLength/2, radius = arcRadius) * 2;

module 5314horneTop(arcRadius=0, arcDetail=100) {
  //calculate the chop angle
  arcChopAngle = 5314horneCalculateChopAngle(arcRadius=arcRadius);
  translate([0,0, (5314ServoHorneHeight() / 2) + (horneZ / 2) + 1.5 ]) {
    union() {
      hull() {
        cylinder(d = horneX, h = horneZFlush, center = true);
        translate([0,-horneX + (horneX /2),(horneZ/2) - (horneZFlush/2)]) {
          cylinder(d = horneX, h = horneZ, center = true);
          rotate([0,0,-(arcChopAngle * 2)])
            translate([0,-horneBackOffset(),0]) {
              cube([horneBackXLength, horneBackYLength, horneZ], center = true);
            }
        }
      }
      //if no arc angle, just make a cube
      if (arcRadius == 0) {
        translate([0,-horneX + (horneX /2) - horneBackOffset(), - (horneBackZHeight/2)]) { 
          cube([horneBackXLength, horneBackYLength, horneBackZHeight], center = true);
        }
      }
      else {
        //make the arc and move it into place
        union() {
          translate([-arcRadius + (horneBackYLength/2), 0, -(horneBackZHeight/2)]) {
            rotate([0,0,-(arcChopAngle * 2)])
              arc(thickness = horneBackXLength, depth = horneBackZHeight, radius = arcRadius, degrees = arcChopAngle, detail = arcDetail);
          }
        }
      }
    }
  }
}

module 5314horneBottom(arcRadius=0, arcDetail=100) {
  //calculate the chop angle
  arcChopAngle = 5314horneCalculateChopAngle(arcRadius=arcRadius);
  translate([0,0,(-(5314ServoHorneHeight() / 2)) - (horneZ / 2) - 1.5]) {
    union() {
      hull() {
        cylinder(d = horneX, h = horneZFlush, center = true);
        translate([0,-horneX + (horneX /2),-((horneZ/2) - (horneZFlush/2))]) {
          cylinder(d = horneX, h = horneZ, center = true);
          rotate([0,0,-(arcChopAngle * 2)])
            translate([0,-horneBackOffset(),0]) {
              cube([horneBackXLength, horneBackYLength, horneZ], center = true);
            }
        }
      }
      //if no arc angle, just make a cube
      if (arcRadius == 0) {
        translate([0,-horneX + (horneX /2) - horneBackOffset(), + (horneBackZHeight/2)]) {
          cube([horneBackXLength, horneBackYLength, horneBackZHeight], center = true);
        }
      }
      else {
        //make the arc and move it into place
        union() {
          translate([-arcRadius + (horneBackYLength/2),0, + (horneBackZHeight/2)]) {
            rotate([0,0,-(arcChopAngle * 2)])
              arc(thickness = horneBackXLength, depth = horneBackZHeight, radius = arcRadius, degrees = arcChopAngle, detail = arcDetail);
          }
        }
      }
    }
  }
}

module 5314horneSingle() {
  hull() {
    cylinder(d = horneX, h = horneZFlush, center = true);
    translate([0,-horneX + (horneX /2),(horneZ/2) - (horneZFlush/2)]) {
      cylinder(d = horneX, h = horneZ, center = true);
    }
  } 
}



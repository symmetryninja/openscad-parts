/** includes **/
include <5314.scad>
include <../sn_tools.scad>

/** general members **/

//the horne hub
hubTopH = 2.3;
hubBotH = 1.95;

hubScrewSpaceH = 3;
hubScrewSpaceD = 11;

hubD = 20.5;
hubOffsetZ = (58.56 -57.4) / 2;

function s902SHorneDiameter() = hubD;

hubHorneScrewHoleD = 2.6;
hubHorneScrewHoleOffsetRadius = 7.34;
hubHorneScrewPurchaseH= 3.8;
hubTopToBottom = 47.7;

hubBoltNutD = 7.044 + 4;
hubHorneBoltSpaceD = (2*hubHorneScrewHoleOffsetRadius) + (hubBoltNutD/2);

baseBoxOverhang = 15;
s5314BaseBackOversizeY = 60;
s5314BaseBackOversizeZ = 20;
s5314BaseBucketOffsetY = 75.5;

s5314RetainerBackSizeY = 25;
s5314RetainerOverSizeZ = 15;
s5314RetainerY = 26;

horneDimensionX = 32;
horneDimensionY = 60;
horneDimensionZ = 7;

horneBackPlateX = horneDimensionX + 3;
horneBackPlateY = 10;
horneBackPlateZ = s5314BaseBackOversizeY;

horneBackPlateJoinX = horneDimensionX;
horneBackPlateJoinY = horneBackPlateY + 10;
horneBackPlateJoinZ = horneDimensionZ;

roundedBoxD = 8;

function get902SHorneDimensionX() = horneDimensionX;
function get902SHorneDimensionY() = horneDimensionY;
function get902SHorneDimensionZ() = horneDimensionZ;



/** functions **/
/** output modules **/
module s902S_horne() {
  difference () {
    union() {
      s902S_horne_base();
      s902S_horne_backplate_joint();
    }
    union() {
      s902S_spline_and_hub();
      makes5314bucketFor902S();
      translate([0, -s5314BaseBucketOffsetY, 0]) {
        union() {
          rotate([0,90,0])
            makes5314bucketBackstop(overSize=0.1);
          rotate([0,90,0])
            s5314CubeBaseWithHub();
        }
      }
      s5314_retainer_screws();
      translate([0,0,-100])
        cube([200,200,200], center=true);
    }
  }
}
module s902S_spline_and_hub() {
  //build the drum
  cylinder(h=hubTopToBottom, d=hubD, center = true);
  //build the screw purchase cutout
  screwPurchaseBlockoutHeight = (hubTopToBottom+(horneDimensionZ * 4)) - (hubTopToBottom + 2*hubHorneScrewPurchaseH);
  screwPurchaseZ = hubTopToBottom/2 + hubHorneScrewPurchaseH + screwPurchaseBlockoutHeight/2;
  translate([0,0,-screwPurchaseZ]) {
    cylinder(d = hubHorneBoltSpaceD + (hubBoltNutD/2), h=screwPurchaseBlockoutHeight, center = true);
  }
  translate([0,0,screwPurchaseZ]) {
    cylinder(d = hubHorneBoltSpaceD + (hubBoltNutD/2), h=screwPurchaseBlockoutHeight, center = true);
  }
  //put the screws in place
  translate([hubHorneScrewHoleOffsetRadius,0,0])
    cylinder(h=hubTopToBottom+(horneDimensionZ * 4), d=hubHorneScrewHoleD, center=true);
  translate([-hubHorneScrewHoleOffsetRadius,0,0])
    cylinder(h=hubTopToBottom+(horneDimensionZ * 4), d=hubHorneScrewHoleD, center=true);
  rotate([0,0,90]) {
    translate([hubHorneScrewHoleOffsetRadius,0,0])
      cylinder(h=hubTopToBottom+(horneDimensionZ * 4), d=hubHorneScrewHoleD, center=true);
    translate([-hubHorneScrewHoleOffsetRadius,0,0])
      cylinder(h=hubTopToBottom+(horneDimensionZ * 4), d=hubHorneScrewHoleD, center=true);
  }

  //give some room for the hub mount screws
  cylinder(h=hubTopToBottom+(horneDimensionZ * 4), d=hubScrewSpaceD, center=true);

}

s902s_horne_offset = 25.6;
s902s_horne_join_H = 4;

module S902S_horne_hub_1(square=false) {
  translate([0, 0, s902s_horne_offset]) {
    if (square) {
      make_rounded_box([30,30, s902s_horne_join_H]);
    }
    else {
      cylinder(d = 30, h = s902s_horne_join_H, center = true);
    }
  }
}
module S902S_horne_hub_2(square=false) {
  translate([0, 0, -s902s_horne_offset]) {
    if (square) {
      make_rounded_box([30,30,s902s_horne_join_H]);
    }
    else {
      cylinder(d = 30, h = s902s_horne_join_H, center = true);
    }
  }
}

module makes5314bucketFor902S(with_bolts = true) {
  difference() {
    translate([0, -s5314BaseBucketOffsetY, 0]) {
      rotate([0,90,0]) {
        difference() {
          union() {
            s5314BaseScale(newSize = [s5314BaseBackOversizeX, s5314BaseBackOversizeY + 12.5, s5314BaseBackOversizeZ], positionOffset = [0,1.2,0], blunt_offset = -45);
          }
          union() {
            s5314CubeBaseWithHub();
          }
        }
      }
    }
    if (with_bolts) {
      s5314_retainer_screws();
    }
  }
}

module make_s5314_bucket_front_retainer_clips() {
  difference() {
    rotate([0,90,0]) {
      translate([0,-s5314BaseBucketOffsetY,0]) {
        s5314BaseScale(newSize = [s5314BaseBackOversizeX -0.01, s5314BaseBackOversizeY + 12.5-0.01, s5314BaseBackOversizeZ + s5314RetainerOverSizeZ + 2], positionOffset = [0,1.2,0], blunt_offset = -45);
      }
    }
    union() {
      translate([0,-s5314BaseBucketOffsetY,0]) {
        rotate([0,90,0]) {
          s5314CubeBaseWithHub();
            s5314BaseScale(newSize = [s5314BaseBackOversizeX, s5314BaseBackOversizeY + 12.5, s5314BaseBackOversizeZ], positionOffset = [0,1.2,0], blunt_offset = -45);
        }
      }
      s5314_retainer_screws();
      union() {
        translate([0,-s5314BaseBucketOffsetY ,0]) {
          rotate([0,90,0]) {
            cylinder(d=22, h=60, center=true);
          }
        }
        translate([0,-s5314BaseBucketOffsetY + 25,0]) {
          cube([60,60,60], center=true);
        }
      }
    }
  }
}

// makes5314Retainers();
module makes5314Retainers() {
  positionX = ((s5314BaseBackOversizeX + 5) / 2) - roundedBoxD/2;
  positionY = (s5314RetainerBackSizeY) - roundedBoxD;
  retainerH = s5314BaseBackOversizeZ + (s5314RetainerOverSizeZ);

  centerOffsetX = 6;

  translate([0, (-s5314BaseBackOversizeY/2) -9, 0])
    makeRoundedRhombus(positionX, positionY, roundedBoxD, centerOffsetX, retainerH);
}

module makes5314bucketBackstop(fullHeight=false, overSize=0) {
  translate([0, s5314BaseBackOversizeY/2, 0]) {
    if (fullHeight) {
      cube([s5314BaseBackOversizeX + overSize, s5314BaseBackOversizeY/2, s5314BaseBackOversizeZ + overSize], center=true);
    }
    else{
      cube([s5314BaseBackOversizeX + overSize, s5314BaseBackOversizeY/2, s5314BaseBackOversizeZ + overSize], center=true);
    }
  }
}

/** tooling modules **/
module s902S_horne_base() {
  translate([0,0,(hubTopToBottom/2 + horneDimensionZ/2)]) {
    union() {
      hull() {
        cylinder(h=horneDimensionZ, d=horneDimensionX, center=true);
        s902S_horne_backplate_join();
      }
      hull() {
        translate([0,0,-8])
          s902S_horne_backplate_join_to_retainer();
        s902S_horne_backplate_join();
      }
    }
  }
}

module s902S_horne_backplate_joint() {
  difference() {
    union() {
      translate([0,0,(hubTopToBottom/2 + horneDimensionZ/2)])
        s902S_horne_backplate_join();
      makes5314Retainers();
    }
    makes5314bucketFor902S();

  }
}
module s902S_horne_backplate_join(rhombus = false) {
  positionX = ((s5314BaseBackOversizeX + 5) / 2) - roundedBoxD/2;
  positionY = (s5314RetainerBackSizeY) - roundedBoxD - 6;
  retainerH = horneBackPlateJoinZ;

  centerOffsetX = 6;

  translate([0, (-s5314BaseBackOversizeY/2) -9, ]) {
    if (rhombus) 
      makeRoundedRhombus(positionX, positionY, roundedBoxD, centerOffsetX, retainerH);
    else
      make_rounded_box([horneBackPlateJoinX, horneBackPlateJoinY, horneBackPlateJoinZ], d=roundedBoxD);
  }
}

module s902S_horne_backplate_join_to_retainer() {
    positionX = ((s5314BaseBackOversizeX + 5) / 2) - roundedBoxD/2;
  positionY = (s5314RetainerBackSizeY) - roundedBoxD;
  retainerH = horneBackPlateJoinZ + 2;

  centerOffsetX = 6;

  translate([0, (-s5314BaseBackOversizeY/2) -9, 0]) {
    // make_rounded_box([horneBackPlateJoinX, horneBackPlateJoinY, horneBackPlateJoinZ], d=roundedBoxD);
    makeRoundedRhombus(positionX, positionY, roundedBoxD, centerOffsetX, retainerH);
  }
}

module s5314_retainer_screws() {
  screwHeight = 16;
  screwPurchase = 3;
  screwD = 3.2;
  screwHeadH = 30;
  screwHeadD = 7;

  hexBlankHeight = 11;

  screwVerticalOffset = (hexBlankHeight/2 + screwHeight/2) - screwPurchase;
  screwHeadVerticalOffset = screwVerticalOffset + (screwHeight/2 - screwPurchase) + screwHeadH/2;

  offsetY = -(s5314RetainerY + s5314RetainerBackSizeY - screwHeadD) - 3.4;
  offsetX = horneBackPlateJoinX/2 + screwHeadD/2 + 1.6;

  bucketRetainerOffsetY2 = offsetY + 12;
  bucketRetainerOffsetZ2 = 12;

  //vertical screws
  translate([offsetX,offsetY,0]) {
    screwM3DoubleWithHex_m3_16_button_10mhex(headBuffer=10);
  }
  translate([-offsetX,offsetY,0]) {
    screwM3DoubleWithHex_m3_16_button_10mhex(headBuffer=10);
  }

  //sideway screws
  //top
  translate([0,bucketRetainerOffsetY2,bucketRetainerOffsetZ2]) {
    makes5314RetainerBucketScrew(
      screwHeight=screwHeight,
      screwD=screwD,
      screwHeadH=screwHeadH,
      screwHeadD=screwHeadD,
      hexBlankH=s5314BaseBackOversizeZ + 1,
      screwVerticalOffset=screwVerticalOffset);
  }
  //bottom
  translate([0,bucketRetainerOffsetY2,-bucketRetainerOffsetZ2]) {
    makes5314RetainerBucketScrew(
      screwHeight=screwHeight,
      screwD=screwD,
      screwHeadH=screwHeadH,
      screwHeadD=screwHeadD,
      hexBlankH=s5314BaseBackOversizeZ + 1,
      screwVerticalOffset=screwVerticalOffset);
  }

  //front screws
  translate([0, -93, 0]) {
    rotate([90,0,0])
    makes5314RetainerBucketScrew(
      screwHeight=screwHeight,
      screwD=screwD,
      screwHeadH=screwHeadH,
      screwHeadD=screwHeadD,
      hexBlankH=s5314BaseBackOversizeZ + 1,
      screwVerticalOffset=screwVerticalOffset);
  }
}


module makes5314RetainerBucketScrew(screwHeight, screwD, screwHeadH, screwHeadD, hexBlankH, screwVerticalOffset) {
  rotate([0,90,0])
    rotate([0,0,90])
      screwM3DoubleWithHex_m3_16_button_10mhex(headBuffer=6, hexBlankBuffer=11, screwHeadD=screwHeadD);
}

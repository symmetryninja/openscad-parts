
bbb_small = 0.1;
bbb_inch = 25.4; 
bbb_boardLength = 3.400 * bbb_inch;
bbb_boardWidth  = 2.150 * bbb_inch;
bbb_boardHeight  = 1.5;
bbb_boardSize = [bbb_boardLength, bbb_boardWidth, bbb_boardHeight];
bbb_boardColor = [0.3,0.3,0.3];

bbb_ethSize     = [21.0,17.0,13.5];
bbb_ethOffset   = [-2.5,21.25,bbb_boardHeight+0.8];

bbb_usbHostSize     = [14.0,15.5,7.0];
bbb_usbHostOffset   = [bbb_boardLength-bbb_usbHostSize[0],9,bbb_boardHeight+0.7];

bbb_usbSize         = [7.0,7.8,4.5];
bbb_usbOffset       = [-.2,40,-bbb_usbSize[2]+0.5];

bbb_hdmiSize        = [8.0,8.0,3.5];
bbb_hdmiOffset      = [bbb_boardLength-bbb_hdmiSize[0]+0.5,20.8,-bbb_hdmiSize[2]+0.5];

bbb_sdSize   = [15.0,14.0,1.6];
bbb_sdOffset = [bbb_boardLength-bbb_sdSize[0],30,-bbb_sdSize[2]];

bbb_powerSize = [14.0,9.5,11.0];
bbb_powerOffset = [-2.5,4.75,bbb_boardHeight];

bbb_headerSize = [58.6,5.0,8.8];
bbb_headerOffset1 = [18.3,0.3,bbb_boardHeight];
bbb_headerOffset2 = [18.3,bbb_boardWidth-0.3-bbb_headerSize[1],bbb_boardHeight];

bbb_clearanceLength = 10;
bbb_clearanceColor = [0.5,0.5,0.8,0.4];

bbb_holeR = 0.125/2 * bbb_inch;
bbb_hole1Pos = [0.575 * bbb_inch, 0.125 * bbb_inch, 0];
bbb_hole2Pos = [0.575 * bbb_inch, 2.025 * bbb_inch, 0];
bbb_hole3Pos = [3.175 * bbb_inch, 0.250 * bbb_inch, 0];
bbb_hole4Pos = [3.175 * bbb_inch, 1.900 * bbb_inch, 0];

module bbb_board() {
  cube([bbb_boardLength, bbb_boardWidth, bbb_boardHeight]);
  translate(bbb_headerOffset1) cube(bbb_headerSize);
  translate(bbb_headerOffset2) cube(bbb_headerSize);
}

module bbb_cornerNegative(centre, radius, rotation) {
  translate(centre) {
    rotate([0,0,rotation]) {
      difference() {
        translate([-bbb_small,-bbb_small,-bbb_small/2]) {
          cube([radius+bbb_small,radius+bbb_small,bbb_boardHeight+bbb_small]);
        }
        translate([radius,radius,-bbb_small]) {
          cylinder(h=bbb_boardHeight+bbb_small*2,r=radius, center=false);
        }
      }
    }
  }
}

module bbb_mountingHole(centre) {
   translate(centre) {
     translate([0,0,bbb_boardHeight/2]) {
       cylinder(r=bbb_holeR,h=bbb_boardHeight+bbb_small,center=true);
     }
   }
}

module bbb_ethernetBlock() {
  translate(bbb_ethOffset) {
    cube(bbb_ethSize);
    translate([-bbb_clearanceLength,0,0]) {
      color(bbb_clearanceColor) cube([bbb_clearanceLength+bbb_small,bbb_ethSize[1],bbb_ethSize[2]]);
    }
  }
}

module bbb_usbHostBlock() {
  translate(bbb_usbHostOffset) {
    cube(bbb_usbHostSize);
    translate([bbb_usbHostSize[0]-bbb_small,0,0]) {
      color(bbb_clearanceColor) cube([bbb_clearanceLength+bbb_small,bbb_usbHostSize[1],bbb_usbHostSize[2]]);
    }
  }
}

module bbb_usbBlock() {
  translate(bbb_usbOffset) {
    cube(bbb_usbSize);
    translate([-bbb_clearanceLength,0,0]) {
      color(bbb_clearanceColor) cube([bbb_clearanceLength+bbb_small,bbb_usbSize[1],bbb_usbSize[2]]);
    }
  }
}

module bbb_sdBlock() {
  translate(bbb_sdOffset)  {
    cube(bbb_sdSize);
    translate([bbb_sdSize[0]-bbb_small,0,0]) {
      color(bbb_clearanceColor) cube([bbb_clearanceLength+bbb_small,bbb_sdSize[1],bbb_sdSize[2]]);
    }
  }        
}

module bbb_hdmiBlock() {
  translate(bbb_hdmiOffset) {
    cube(bbb_hdmiSize);
    translate([bbb_hdmiSize[0]-bbb_small,0,0]) {
      color(bbb_clearanceColor) cube([bbb_clearanceLength+bbb_small,bbb_hdmiSize[1],bbb_hdmiSize[2]]);
    }

  }
}

module bbb_powerBlock() {
  translate(bbb_powerOffset) {
    cube(bbb_powerSize);
    translate([-bbb_clearanceLength,0,0]) {
      color(bbb_clearanceColor) cube([bbb_clearanceLength+bbb_small,bbb_powerSize[1],bbb_powerSize[2]]);
    }
  }
}

module bbb_boardNegative() {
   bbb_cornerNegative([0,0,0], 0.250 * bbb_inch, 0);
   bbb_cornerNegative([0,bbb_boardWidth,0], 0.250 * bbb_inch, 270);
   bbb_cornerNegative([bbb_boardLength,0,0], 0.500 * bbb_inch, 90);
   bbb_cornerNegative([bbb_boardLength,bbb_boardWidth,0], 0.500 * bbb_inch, 180);
   bbb_mountingHole(bbb_hole1Pos);
   bbb_mountingHole(bbb_hole2Pos);
   bbb_mountingHole(bbb_hole3Pos);
   bbb_mountingHole(bbb_hole4Pos);
}

module beagleboneblack() {
  translate([-bbb_boardLength/2, -bbb_boardWidth/2, 0]) {
    color(bbb_boardColor) {
      difference() {
        bbb_board();
        bbb_boardNegative();
      }
    }
    bbb_ethernetBlock();
    bbb_usbHostBlock();
    bbb_usbBlock();
    bbb_hdmiBlock();
    bbb_sdBlock();
    bbb_powerBlock();
  }
}




module screw(height = 10, threadD = 3, headtype = "button", headD = 5, headH = 2.5) {
  union() {
    cylinder(d=threadD, h=height, center=true);
    translate([0,0,(height/2) + (headH/2) - 0.01]) {
      cylinder(d=headD, h=headH+0.01, center=true);
    }
  }
}

module screw10M3Button(withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3, screwheadHeight = 10) {
  screwM3Button(height=10, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase, screwheadHeight=screwheadHeight);
}

module screw16M3Button(withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3) {
  screwM3Button(withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase);
}

module screw16M3ButtonOversize(screwthreadwidth = 3.2, withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3) {
  screwM3Button(withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase);
}

module screw29M3Button(withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwheadDiameter=6.5, screwPurchase = 3, screwheadHeight = 10) {
  screwM3Button(height=29, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwheadDiameter=screwheadDiameter, screwPurchase=screwPurchase, screwheadHeight=screwheadHeight);
}

module screw39M3Button(withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwheadDiameter=6.5, screwPurchase = 3, screwheadHeight = 10) {
  screwM3Button(height=39, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwheadDiameter=screwheadDiameter, screwPurchase=screwPurchase, screwheadHeight=screwheadHeight);
}

module screw59M3Button(withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwheadDiameter=6.5, screwPurchase = 3, screwheadHeight = 10) {
  screwM3Button(height=59, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwheadDiameter=screwheadDiameter, screwPurchase=screwPurchase, screwheadHeight=screwheadHeight);
}

module screwM3Button(height=16, withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwheadDiameter=6.5, screwPurchase = 3, screwheadHeight = 10) {
  screwButton(height = height, withHexBlank = withHexBlank, hexBlankH = hexBlankH, hexBlankD = hexBlankD, screwheadDiameter=screwheadDiameter, screwPurchase = screwPurchase, screwheadHeight = screwheadHeight);
}

module screwButton(screwthreadwidth = 3.2, height=16, withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3, screwheadDiameter = 6.5, screwheadHeight = 10) {
  screwheight = height;
  screwheadtype = "button";
  screw(height = screwheight, threadD = screwthreadwidth, headtype = screwheadtype, headD = screwheadDiameter, headH = screwheadHeight);

  if (withHexBlank) {
    newPosition=[0,0,-hexBlankH/2 + screwPurchase - height/2];
    hexBlank(newPosition=newPosition, blankHeight=hexBlankH, centerObject=true, hexBlankD=hexBlankD);
  }
}

module screwM3DoubleWithHex_m3_29_button_10mhex(headBuffer=0, hexBlankBuffer=0, screwPurchase=3.5, screwHeadD=6.5) {
  screwHeight=29;
  screwD=3.2;
  screwHeadH=4 + headBuffer;
  screwHeadD=screwHeadD;
  hexBlankBaseH = 10;
  hexBlankH= hexBlankBaseH + hexBlankBuffer;
  screwVerticalOffset=hexBlankBaseH/2 - screwPurchase;

  screwM3DoubleWithHex(
    screwHeight=screwHeight,
    screwD=screwD,
    screwHeadH=screwHeadH,
    screwHeadD=screwHeadD,
    hexBlankH=hexBlankH,
    screwVerticalOffset=screwVerticalOffset);
}

module screwM3DoubleWithHex_m3_16_button_10mhex(headBuffer=0, hexBlankBuffer=0, hexBlankD=6.22, screwPurchase=3.5, screwHeadD=6.5) {
  screwHeight=16;
  screwD=3.2;
  screwHeadH=4 + headBuffer;
  screwHeadD=screwHeadD;
  hexBlankBaseH = 10;
  hexBlankH= hexBlankBaseH + hexBlankBuffer;
  screwVerticalOffset=hexBlankBaseH/2 - screwPurchase;

  screwM3DoubleWithHex(
    screwHeight=screwHeight,
    screwD=screwD,
    screwHeadH=screwHeadH,
    screwHeadD=screwHeadD,
    hexBlankH=hexBlankH,
    screwVerticalOffset=screwVerticalOffset,
    hexBlankD=hexBlankD);
}

module screwM3DoubleWithHex_m3_20_button_10mhex(headBuffer=0, hexBlankBuffer=0, hexBlankD=6.22, screwPurchase=3.5, screwHeadD=6.5) {
  screwHeight=20;
  screwD=3.2;
  screwHeadH=4 + headBuffer;
  screwHeadD=screwHeadD;
  hexBlankBaseH = 10;
  hexBlankH= hexBlankBaseH + hexBlankBuffer;
  screwVerticalOffset=hexBlankBaseH/2 - screwPurchase;

  screwM3DoubleWithHex(
    screwHeight=screwHeight,
    screwD=screwD,
    screwHeadH=screwHeadH,
    screwHeadD=screwHeadD,
    hexBlankH=hexBlankH,
    screwVerticalOffset=screwVerticalOffset,
    hexBlankD=hexBlankD);
}

module screwM3DoubleWithHex(screwHeight, screwD, screwHeadH, screwHeadD, hexBlankH, screwVerticalOffset, hexBlankD=6.22) {
  union() {
    //head1
    translate([0,0,(screwVerticalOffset + screwHeadH/2 + screwHeight - 0.01)])
      cylinder(h=screwHeadH, d=screwHeadD, center=true);
    //shaft1
    translate([0,0,(screwVerticalOffset + screwHeight/2)])
      cylinder(d=screwD, h=screwHeight, center=true);
    //hexblank1
    hexBlank(blankHeight = hexBlankH, hexBlankD = hexBlankD);
    //shaft2
      translate([0,0,-(screwVerticalOffset + screwHeight/2)])
      cylinder(d=screwD, h=screwHeight, center=true);
    //head2
    translate([0,0,-(screwVerticalOffset + screwHeadH/2 + screwHeight - 0.01)])
      cylinder(h=screwHeadH, d=screwHeadD, center=true);
  }
}

module screw8M25Button(withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3, screwheadDiameter = 6.5) {
  screwM25Button(height=8, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase, screwheadDiameter = screwheadDiameter);
}

module screw6M25Button(withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3, screwheadDiameter = 6.5) {
  screwM25Button(height=6, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase, screwheadDiameter = screwheadDiameter);
}

module screw10M25Button(withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3, screwheadDiameter = 6.5) {
  screwM25Button(height=10, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase, screwheadDiameter = screwheadDiameter);
}

module screw20M25Button(withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3, screwheadDiameter = 6.5) {
  screwM25Button(height=20, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase, screwheadDiameter = screwheadDiameter);
}

module screwM25Button(height=16, screwheadDiameter=6.5, screwheadHeight = 8, withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3, screwheadDiameter = 6.5) {
  screwButton(screwthreadwidth = 2.7, height = height, withHexBlank = withHexBlank, hexBlankH = hexBlankH, hexBlankD = hexBlankD, screwPurchase = screwPurchase, screwheadDiameter=screwheadDiameter);
}


module screw40M4Button(withHexBlank=false, hexBlankH = 10, hexBlankD=8.2, screwPurchase = 3, screwheadDiameter = 7.5) {
  screwM4Button(height=40, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase, screwheadDiameter = screwheadDiameter);
}

module screw20M4Button(withHexBlank=false, hexBlankH = 10, hexBlankD=8.2, screwPurchase = 3, screwheadDiameter = 7.5, screwheadHeight = 8) {
  screwM4Button(height=20, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase, screwheadDiameter = screwheadDiameter, screwheadHeight = screwheadHeight);
}

module screw60M4Button(withHexBlank=false, hexBlankH = 10, hexBlankD=8.2, screwPurchase = 3, screwheadDiameter = 7.5, screwheadHeight = 8) {
  screwM4Button(height=60, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase, screwheadDiameter = screwheadDiameter, screwheadHeight = screwheadHeight);
}

module screw30M4Button(withHexBlank=false, hexBlankH = 10, hexBlankD=8.2, screwPurchase = 3, screwheadDiameter = 7.5, screwheadHeight = 8) {
  screwM4Button(height=30, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase, screwheadDiameter = screwheadDiameter, screwheadHeight = screwheadHeight);
}

module screwM4Button(height=16, screwheadDiameter=6.5, screwheadHeight = 8, withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3, screwheadDiameter = 6.5) {
  screwButton(screwthreadwidth = 4.2, height = height, withHexBlank = withHexBlank, hexBlankH = hexBlankH, hexBlankD = hexBlankD, screwPurchase = screwPurchase, screwheadDiameter=screwheadDiameter, screwheadHeight = screwheadHeight);
}

module screwM2Button(height=16, screwheadDiameter=6.5, screwheadHeight = 8, withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3, screwheadDiameter = 6.5) {
  screwButton(screwthreadwidth = 2.2, height = height, withHexBlank = withHexBlank, hexBlankH = hexBlankH, hexBlankD = hexBlankD, screwPurchase = screwPurchase, screwheadDiameter=screwheadDiameter, screwheadHeight = screwheadHeight);
}

module screw8M2Button(withHexBlank=false, hexBlankH = 10, hexBlankD=6.22, screwPurchase = 3, screwheadDiameter = 6.5) {
  screwM2Button(height=8, withHexBlank=withHexBlank, hexBlankH = hexBlankH, hexBlankD=hexBlankD, screwPurchase=screwPurchase, screwheadDiameter = screwheadDiameter);
}
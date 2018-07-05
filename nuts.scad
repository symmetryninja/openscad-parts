function hexBlankDiameter() = 6.22;
function hex_blank_largeM3StainlessD() = 7.1;

module hexBlank(newPosition=[0,0,0], blankHeight=10, centerObject=true, hexBlankD = 6.22) {
  translate(newPosition)
    cylinder(d = hexBlankD, h = blankHeight, center = centerObject, $fn = 6);
}

module rivnut(bore_D, bore_H, flange_D, flange_H) {
  union() {
    ccylinder(d = bore_D, h = bore_H);
    translate([0, 0, -(bore_H/2 - flange_H/2)])
    ccylinder(d = flange_D, h = flange_H);
  }
}

module rivnut_m3_48_9mm(oversize=0){
  rivnut(bore_D = 4.8 + oversize, bore_H = 10, flange_D = 7, flange_H = 0.8);
}
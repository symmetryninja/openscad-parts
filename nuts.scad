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
  rivnut(bore_D = 4.7 + oversize, bore_H = 10, flange_D = 7, flange_H = 0.8);
}

module rivnut_m5_68_9mm(oversize=0){
  rivnut(bore_D = 6.7 + oversize, bore_H = 13, flange_D = 10, flange_H = 1);
}

module rivnut_m6_59_16mm(oversize=0){
  rivnut(bore_D = 8.8 + oversize, bore_H = 16, flange_D = 10, flange_H = 1.5);
}
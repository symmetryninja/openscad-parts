function hexBlankDiameter() = 6.22;
function hex_blank_largeM3StainlessD() = 7.1;

module hexBlank(newPosition=[0,0,0], blankHeight=10, centerObject=true, hexBlankD = 6.22) {
  translate(newPosition)
    cylinder(d = hexBlankD, h = blankHeight, center = centerObject, $fn = 6);
}
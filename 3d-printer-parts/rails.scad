

  linear_rail_20mm_rail_X = 17.68;
  linear_rail_20mm_rail_Y = 20.01;

module linear_rail_20mm(length=600, for_cutout = false, cutout_height = 30) {

  bolt_space = 60;

  difference() {
    union(){
      if (!for_cutout) ccube([linear_rail_20mm_rail_X, linear_rail_20mm_rail_Y, length]);
    }
    #union(){
      steps = (length / bolt_space); 
      translateZ(-length/2) for (i = [0:steps]) {
        translateZ(i*bolt_space + bolt_space/2){
          rotateX(90)
          ccylinder(d=6, h=cutout_height + 0.1);
        }
      }
    }
  }
}

linear_rail_20mm_bearing_X = 44.5;
linear_rail_20mm_bearing_Y = 25.5;
linear_rail_20mm_bearing_offset_Y = 4.88 + linear_rail_20mm_bearing_Y/2 - linear_rail_20mm_rail_Y/2;

module linear_rail_20mm_bearing(for_cutout = false, cutout_height = 30) {
  translateY(linear_rail_20mm_bearing_offset_Y) difference() {
    union() {
      if (!for_cutout) ccube([linear_rail_20mm_bearing_X, linear_rail_20mm_bearing_Y, 76.2]);
    }
    #union() {
      rotateX(90)
      makeBoxobjects(x= 32, y=35, inset=0) {
        ccylinder(h=cutout_height, d=5);
      }
    }
  }
}
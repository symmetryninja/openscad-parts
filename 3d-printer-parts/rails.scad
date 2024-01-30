

  linear_rail_20mm_rail_X = 17.68;
  linear_rail_20mm_rail_Y = 20.01;

module linear_rail_20mm(length=600, for_cutout = false, cutout_height = 30, bolt_offset_Z = 0) {

  bolt_space = 60;

  D() {
    U(){
      if (!for_cutout) ccube([linear_rail_20mm_rail_X, linear_rail_20mm_rail_Y, length]);
    }
    U(){
      steps = (length / bolt_space); 
      Tz(-length/2 + bolt_offset_Z) for (i = [0:steps + 1]) {
        Tz((i - 1)*bolt_space + bolt_space/2){
          Rx(90)
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
  Ty(linear_rail_20mm_bearing_offset_Y) D() {
    U() {
      ccube([linear_rail_20mm_bearing_X, linear_rail_20mm_bearing_Y, 76.2]);
      if (for_cutout) {
        Rx(90) makeBoxobjects(x= 32, y=35, inset=0) 
        ccylinder(h=60, d=5);
      }
    }
    U() {
      if (!for_cutout) 
      Rx(90) makeBoxobjects(x= 32, y=35, inset=0) {
        ccylinder(h=cutout_height, d=5);
      }
    }
  }
}


  module eyelit_shaft(eye_gap=50, eye_D = 3.5, eye_outer_D = 8.5, eye_width = 3, cylinder_joiner=10, cylinder_joiner_D=5, shaft_D = 3) {
    //eyelits
    translateX(eye_gap/2)
    difference() {
      ccylinder(d=eye_outer_D, h = eye_width);
      ccylinder(d = eye_D, h = eye_width + 1);
    }

    translateX(-eye_gap/2)
    difference() {
      ccylinder(d=eye_outer_D, h = eye_width);
      ccylinder(d = eye_D, h = eye_width + 1);
    }

    // eyelets have a cylinder on them    
    joiner_offset = eye_gap/2 - eye_outer_D/2 - cylinder_joiner/2;
    translateX(joiner_offset)
    rotateY(90)
    ccylinder(d=cylinder_joiner_D, h = cylinder_joiner);

    translateX(-joiner_offset)
    rotateY(90)
    ccylinder(d=cylinder_joiner_D, h = cylinder_joiner);

    //cyl shaft
    rotateY(90)
    ccylinder(d = shaft_D, h = eye_gap - (eye_D+1));
  }
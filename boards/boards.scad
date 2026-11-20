include <beagleboneblack.scad>

module computer_boards_xu4_drill_holes() {
}
module computer_boards_xu4() {
  // we have to import it!
  import("odroid_xu4.stl", convexity=10);
}

module computer_boards_jetson_nano_drill_holes(height=10, screw_D = 3) {
  translate([7.6, 2.5, 0])
  make_drill_holes([86,58, height], d = screw_D);
}
module computer_boards_jetson_nano() {
  // we have to import it!
  translate([17.5, 7.5, -28.5])
  rotate([90, 0, 90])
  import("Jetson_Nano_DK_v1.2.stl", convexity=10);
}

module computer_boards_pi3b_drill_holes(height=10, screw_D=3.5) {
  pi_shape = [85, 56, 0];
  screw_shape = [58, 49, height];

  make_drill_holes(screw_shape, d = screw_D);

}
module computer_boards_pi3b() {
  // we have to import it!
  T([15.9, -5.4, 4])
  import("pi3BModel.stl", convexity=10);
}

module computer_boards_opencr1_drill_holes(height=10, screw_D = 3.5) {
  translate([7.6, 2.5, 0])
  make_drill_holes([96,66, height], d = screw_D);
}
module computer_boards_opencr1() {
  // we have to import it!
  import("OpenCR_REVF.stl", convexity=10);
}



  /** bucky **/
  module ten_a_bucky() {
    // green()
    D() {
        %T([0, 0, 9]) ccube([37, 47, 15]);
        green() Tz(1) ccube([37, 47, 2]);
      #U() {
        ten_a_bucky_screws();
      };
    }
  }

  module ten_a_bucky_standoffs() {
    Tz(-4)
      ten_a_bucky_place_screws() {
        H() {
          ccylinder(d=6, h=6);
          Tz(-2) ccylinder(d=8, h=2);
        }
      }
  }

  module ten_a_bucky_screws(d=3, h=20) {
    ten_a_bucky_place_screws() {
      ccylinder(d = d, h = h);
    }
  }
  module ten_a_bucky_place_screws(d=3, h=20) {
    T([-15, 21, 0]) children();
    T([14.7, 19, 0]) children();
    T([15, -21, 0]) children();
    T([-15, -21, 0]) children();
  }
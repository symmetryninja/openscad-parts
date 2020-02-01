include <beagleboneblack.scad>

module computer_boards_xu4_drill_holes() {
}
module computer_boards_xu4() {
  // we have to import it!
  import("../openscad-parts/boards/odroid_xu4.stl", convexity=10);
}

module computer_boards_jetson_nano_drill_holes(height=10, screw_D = 3) {
  translate([7.6, 2.5, 0])
  make_drill_holes([86,58, height], shaftD = screw_D);
}
module computer_boards_jetson_nano() {
  // we have to import it!
  translate([17.5, 7.5, -28.5])
  rotate([90, 0, 90])
  import("../openscad-parts/boards/Jetson_Nano_DK_v1.2.stl", convexity=10);
}

module computer_boards_pi3b_drill_holes() {
}
module computer_boards_pi3b() {
  // we have to import it!
  import("../openscad-parts/boards/pi3BModel.stl", convexity=10);
}

module computer_boards_opencr1_drill_holes(height=10, screw_D = 3.5) {
  translate([7.6, 2.5, 0])
  make_drill_holes([96,66, height], shaftD = screw_D);
}
module computer_boards_opencr1() {
  // we have to import it!
  import("../openscad-parts/boards/OpenCR_REVF.stl", convexity=10);
}

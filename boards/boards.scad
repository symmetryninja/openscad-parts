include <beagleboneblack.scad>

module computer_boards_xu4() {
  // we have to import it!
  import("../openscad-parts/boards/odroid_xu4.stl", convexity=10);
}

module computer_boards_jetson_nano() {
  // we have to import it!
  import("../openscad-parts/boards/Jetson_Nano_DK_v1.2.stl", convexity=10);
}

module computer_boards_pi3b() {
  // we have to import it!
  import("../openscad-parts/boards/pi3BModel.stl", convexity=10);
}

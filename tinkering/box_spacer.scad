include <sn_tools.scad>

box_size = [13, 60, 13];

drill_D = 5;
drill_space = 41;

$fn = 40;

D() {
  U() {
    makeRoundedBox(box_size);
  }
  #U() {
    My() Ty(drill_space/2)
    ccylinder(d = drill_D, h = box_size[Z] + 1);
  }
}
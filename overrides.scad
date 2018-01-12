module ccube(size=[10,10,10], center=true){
  cube(size, center);
}

module ccylinder(d=10, r=-1, h=10) {
  if (r != -1) {
    cylinder(d = 2 * r, h = h, center=true);
  }
  else {
    cylinder(d = d, h = h, center=true);
  }
}
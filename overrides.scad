module ccube(size=[10,10,10], center=true){
  cube(size, center);
}

module ccylinder(d=10, r=-1, h=10, $fa=$fa, $fs=$fs, $fn=$fn) {
  if (r != -1) {
    cylinder(d = 2 * r, h = h, $fa=$fa, $fs=$fs, $fn=$fn, center=true);
  }
  else {
    cylinder(d = d, h = h, $fa=$fa, $fs=$fs, $fn=$fn, center=true);
  }
}

module csphere(d=10, r=-1, $fa=$fa, $fs=$fs, $fn=$fn) {
  if (r != -1) {
    sphere(d = 2 * r, $fa=$fa, $fs=$fs, $fn=$fn, center=true);
  }
  else {
    sphere(d = d, $fa=$fa, $fs=$fs, $fn=$fn, center=true);
  }
}

module cfunnel(d=10, r=-1, h = 20) {
  if (r != -1) {
    cylinder(r1= r, r2 = 0, h = h, $fa=$fa, $fs=$fs, $fn=$fn, center=true);
  }
  else {
    cylinder(r1 = d/2, r2 = 0, h = h, $fa=$fa, $fs=$fs, $fn=$fn, center=true);
  }
}

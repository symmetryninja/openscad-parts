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

module cfunnel(d=10, r=-1, h = 20, $fa=$fa, $fs=$fs, $fn=$fn) {
  if (r != -1) {
    cylinder(r1= r, r2 = 0, h = h, $fa=$fa, $fs=$fs, $fn=$fn, center=true);
  }
  else {
    cylinder(r1 = d/2, r2 = 0, h = h, $fa=$fa, $fs=$fs, $fn=$fn, center=true);
  }
}

module translateX(x_offset) {
  translate([x_offset, 0, 0]) {
    children();
  }
}

module translateY(y_offset) {
  translate([0, y_offset, 0]) {
    children();
  }
}

module translateZ(z_offset) {
  translate([0, 0, z_offset]) {
    children();
  }
}

module rotateX(x) {
  rotate([x, 0, 0]) {
    children();
  }
}

module rotateY(y) {
  rotate([0, y, 0]) {
    children();
  }
}

module rotateZ(z) {
  rotate([0, 0, z]) {
    children();
  }
}

module place_at_positions(positions = [[0,0,0], [1,1,1]]) {
  for (position = positions) {
    translate(position) {
      children();
    }
  }
}
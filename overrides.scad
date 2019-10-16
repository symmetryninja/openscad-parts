module ccube(size=[10,10,10], center=true){
  cube(size, center);
}

module ccube_bezel(size=[10,10,10], bezel=2, center=true){
  hull() {
    cube([size[0], size[1] - (bezel * 2), size[2] - (bezel * 2)], center);
    cube([size[0] - (bezel * 2), size[1], size[2] - (bezel * 2)], center);
    cube([size[0] - (bezel * 2), size[1] - (bezel * 2), size[2]], center);
  }
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

module mirrorX() {
  mirror([1, 0, 0]) {
    children();
  }
}

module mirrorY() {
  mirror([0, 1, 0]) {
    children();
  }
}

module mirrorZ() {
  mirror([0, 0, 1]) {
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

module slide_hull_X(amount = 10) {
  if ($children > 0) {
    union() {
      for ( child = [0:1:$children-1]) {
        hull() {
          translateX(amount/2)
            children(child);
          translateX(-amount/2)
            children(child);
        }
      }
    }
  }
  else {
    children();
  }
}
module slide_hull_Y(amount = 10) {  
  if ($children > 0) {
    union() {
      for ( child = [0:1:$children-1]) {
        hull() {
          translateY(amount/2)
            children(child);
          translateY(-amount/2)
            children(child);
        }
      }
    }
  }
  else {
    children();
  }
}

module slide_hull_Z(amount = 10) { 
  if ($children > 0) {
    union() {
      for ( child = [0:1:$children-1]) {
        hull() {
          translateZ(amount/2)
            children(child);
          translateZ(-amount/2)
            children(child);
        }
      }
    }
  }
  else {
    children();
  }
}

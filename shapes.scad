module makeRoundedBox_rotate_90_X(size=[50,50,50], d=6) {
  newsize_X = size[0];
  newsize_Y = size[2];
  newsize_Z = size[1];

  rotate([90, 0, 0])
    makeRoundedBox(size=[newsize_X,newsize_Y,newsize_Z], d=d);
}

module makeRoundedBox_rotate_90_Y(size=[50,50,50], d=6) {
  newsize_X = size[2];
  newsize_Y = size[1];
  newsize_Z = size[0];

  rotate([0, 90, 0])
    makeRoundedBox(size=[newsize_X,newsize_Y,newsize_Z], d=d);
}

module makeRoundedBox(size=[50,50,50], d=6) {
  //make 4 cylinders
  render() {
    hull() {
      makeRoundedBoxShafts(size=size, d=d, shaftD=d);
    }
  }
}

module makeRoundedBoxShafts(size=[50,50,50], d=6, shaftD=6, fn=$fn) {
  makeBoxobjects(x=size[0], y=size[1], inset=d) {
      cylinder(d=shaftD, h=size[2], center=true, $fn=fn);
  }
}

module make_drill_holes(size=[50,50,50], shaftD=6, fn=$fn) {
  makeRoundedBoxShafts(size=size, d=0, shaftD=shaftD);
}

module makeBoxobjects(x= 50, y=50, inset=0) {
  //make 4 cylinders
  positionOffsetX = (x-inset) /2;
  positionOffsetY = (y-inset) /2;
  render() {
    translate([-positionOffsetX, -positionOffsetY, 0 ])
      children();
    translate([-positionOffsetX, positionOffsetY, 0 ])
      children();
    translate([positionOffsetX, -positionOffsetY, 0 ])
      children();
    translate([positionOffsetX, positionOffsetY, 0 ])
      children();
  }
}

module make_bevelled_box(size=[50,50,50], bevel=3) {
  hull() {
    //x
    ccube([size[0], size[1] - (2 * bevel), size[2] - (2 * bevel)]);

    //y
    ccube([size[0] - (2 * bevel), size[1], size[2] - (2 * bevel)]);

    //z
    ccube([size[0] - (2 * bevel), size[1] - (2 * bevel), size[2]]);
  }
}

// not geometrically accurate but matches the above 
module make_bevelled_cylinder(d = 20, h = 30, bevel=3) {
  hull() {
    ccylinder(d = d - (2 * bevel), h = h);
    ccylinder(d = d, h = h - (2 * bevel));
  }
}

module make_sphered_box(size=[50,50,50], d=6) {
  x = size[0]/2 - d/2;
  y = size[1]/2 - d/2;
  z = size[2]/2 - d/2;
  hull() {
    translate([-x, y, z]) sphere(d=d);
    translate([-x,-y, z]) sphere(d=d);
    translate([ x,-y, z]) sphere(d=d);
    translate([ x, y, z]) sphere(d=d);

    translate([-x, y,-z]) sphere(d=d);
    translate([-x,-y,-z]) sphere(d=d);
    translate([ x,-y,-z]) sphere(d=d);
    translate([ x, y,-z]) sphere(d=d);
  }
}

module makeRoundedRhombus(positionX, positionY, roundedBoxD, centerOffsetX, retainerH) {
  hull() {
    //back1
    translate([positionX - centerOffsetX, positionY/2, 0]) {
      cylinder(h = retainerH, d = roundedBoxD, center=true);
    }
    //back2
    translate([-positionX, -positionY/2, 0]) {
      cylinder(h = retainerH, d = roundedBoxD, center=true);
    }
    //front1
    translate([positionX, -positionY/2, 0]) {
      cylinder(h = retainerH, d = roundedBoxD, center=true);
    }
    //front2
    translate([-(positionX - centerOffsetX), positionY/2, 0]) {
      cylinder(h = retainerH, d = roundedBoxD, center=true);
    }
  }
}

module make_triangle(size=[20,20,5]) {
  tri_X = size[0];
  tri_Y = size[1];
  tri_Z = size[2];
  polyhedron( 
    points = [
      [tri_X/2, -tri_Y/2, tri_Z/2],
      [-tri_X/2, -tri_Y/2, tri_Z/2],
      [0, tri_Y/2, tri_Z/2],
      [tri_X/2, -tri_Y/2, -tri_Z/2],
      [-tri_X/2, -tri_Y/2, -tri_Z/2],
      [0, tri_Y/2, -tri_Z/2],
    ], 
    faces = [
      [0, 1, 2],
      [5, 4, 3],
      [3, 4, 1, 0],
      [0, 2, 5, 3],
      [2, 1, 4, 5],
    ]
  );
}

module make_round_triangle_90(size = [30, 30, 5], d = 6) {
  make_round_triangle(size = size, d = d, offset_rotation_Z = 90);
}

module make_round_triangle_180(size = [30, 30, 5], d = 6) {
  make_round_triangle(size = size, d = d, offset_rotation_Z = 180);
}

module make_round_triangle_270(size = [30, 30, 5], d = 6) {
  make_round_triangle(size = size, d = d, offset_rotation_Z = 270);
}

module make_round_triangle(size = [30, 30, 5], d = 6, offset_rotation_Z = 0) {
  rotate([0,0,offset_rotation_Z]) {
    hull() {
      translate([size[0]/2, size[1]/2, 0]) {
        cylinder(d=d, h=size[2], center = true);
      }
      translate([-size[0]/2, size[1]/2, 0]) {
        cylinder(d=d, h=size[2], center = true);
      }
      translate([0, -size[1]/2, 0]) {
        cylinder(d=d, h=size[2], center = true);
      }
    }
  }
}

module make_rhombus(size=[20,20,20], long_side=5, rotate_z=0) {
  tri_X = long_side*2;
  tri_Y = size[1];
  tri_Z = size[2];
  rotate([0,0,rotate_z]) {
    hull() {
      translate([-size[0]/2,0,0])
        make_triangle(size = [tri_X, tri_Y, tri_Z]);
      translate([size[0]/2,0,0])
        make_triangle(size = [tri_X, tri_Y, tri_Z]);
    }
  }
}

module make_drilled_cylinder(d=5, i_d=3, h=4, detail = $fn) {
  //main 
  difference() {
    cylinder(h=h, d=d, center=true, $fn=detail);
    cylinder(h=h + 4, d=i_d, center=true, $fn=detail);
  }
}

module make_pie_slice(d=50, h = 50, angle=45) {
  cube_X = d + 10;
  cube_Y = d + 10;
  cube_Z = h + 10;
  difference() {
    cylinder(d = d, h = h, center = true);
    union() {
      rotate([0,0,angle/2]) {
        translate([cube_X/2,0,0]) {
          cube([cube_X, cube_Y, cube_Z], center = true);
        }
      }
      rotate([0,0,-angle/2]) {
        translate([-cube_X/2,0,0]) {
          cube([cube_X, cube_Y, cube_Z], center = true);
        }
      }
    }
  }
}

module torus(part_D=2, D = 4) {
  rotate_extrude(convexity = 10) {
    translate([D/2, 0, 0]) {
      circle(r = part_D/2, $fn = 100);
    }
  }
}

module torus_square(inner_D=2, outer_D = 4, h = 2) {
  difference() {
    ccylinder(d=outer_D, h = h);
    ccylinder(d=inner_D, h = h + 1);
  }
}

module make_bearing(d1 = 40, d2 = 100, height = 40) {
  difference() {
    ccylinder(d=d2, h=height);
    ccylinder(d=d1, h=height + 1);
  }
}

module make_rounded_slot(d = 3, h = 10, l = 10) {
  hull() {
    translateY((l - d) / 2)
    ccylinder(d=d, h = h);
    translateY(- (l - d) / 2)
    ccylinder(d=d, h = h);
  }
}
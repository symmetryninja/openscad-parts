//smart defaults
  // axis variables
  X=0;
  Y=1;
  Z=2;

// Some math functions
  function sq(value_to_square) = value_to_square * value_to_square;

// Vector manipulation shortcuts.
  // vector getters
  function X(input) = input[0];
  function Y(input) = input[1];
  function Z(input) = input[2];

  // add a value in a vector
  function addX(input, X=0) =             [input[0] + X,  input[1],     input[2]];
  function addXY(input, X=0, Y=0) =       [input[0] + X,  input[1] + Y,     input[2]];
  function addXZ(input, X=0, Z=0) =       [input[0] + X,  input[1],     input[2] + Z];
  function addY(input, Y=0) =             [input[0],      input[1] + Y, input[2]];
  function addYZ(input, Y=0, Z=0) =       [input[0],      input[1] + Y, input[2] + Z];
  function addZ(input, Z=0) =             [input[0],      input[1],     input[2] + Z];
  function addXYZ(input, X=0, Y=0, Z=0) = [input[0] + X,  input[1] + Y, input[2] + Z];

  // override a value in a vector
  function setX(input, X=0) =             [X,         input[1],   input[2]];
  function setXY(input, X=0, Y=0) =       [X,         Y,   input[2]];
  function setXZ(input, X=0, Z=0) =       [X,         input[1],   Z];
  function setY(input, Y=0) =             [input[0],  Y,          input[2]];
  function setYZ(input, Y=0, Z=0) =       [input[0],  Y,          Z];
  function setZ(input, Z=0) =             [input[0],  input[1],   Z];
  function setXYZ(input, X=0, Y=0, Z=0) = [X,Y,Z];


// Transform overrides, move/rotate/mirror on one axis
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
  
  module resizeX(x) {
    resize([x, 0, 0]) {
      children();
    }
  }

  module resizeY(y) {
    resize([0, y, 0]) {
      children();
    }
  }

  module resizeZ(z) {
    resize([0, 0, z]) {
      children();
    }
  }

  // note the mirror by default retains the origonal object
  module mirrorX(retain=true) {
    mirror([1, 0, 0]) children();
    if (retain) children();
  }

  module mirrorY(retain=true) {
    mirror([0, 1, 0]) children();
    if (retain) children();
  }

  module mirrorZ(retain=true) {
    mirror([0, 0, 1]) children();
    if (retain) children();
  }

// Autoplacement at corners
  module place_at_corners_xy(x, y) {
    mirrorY()
    mirrorX()
    translate([x/2, y/2, 0]) children();
  }

  module place_at_corners_xz(x, z) {
    mirrorZ()
    mirrorX()
    translate([x/2, 0, z/2]) children();
  }

  module place_at_corners_yz(y, z) {
    mirrorZ()
    mirrorY()
    translate([0, y/2, z/2]) children();
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

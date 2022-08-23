//smart defaults
  // axis variables
  X=0;
  Y=1;
  Z=2;

// Some math functions
  function sqr(value_to_square) = value_to_square * value_to_square;

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

// translate/rotate/scale/resize etc
  // Translate shorthand
  module T(t=[0,0,0]){translate(t)children(); }
  module Tx(x) { translate([x, 0, 0])children(); }
  module Ty(y) { translate([0, y, 0])children(); }
  module Tz(z) { translate([0, 0, z])children(); }

  // Rotate shorthand
  module R(t=[0,0,0]){ rotate(t) children(); }
  module Rx(x=90) { rotate([x, 0, 0]) children(); }
  module Ry(y=90) { rotate([0, y, 0]) children(); }
  module Rz(z=90) { rotate([0, 0, z]) children(); }

  // Scale shorthand
  module S(t=[0,0,0]) { scale(t) children();}
  module Sx(x=1) { scale([x, 1, 1]) children(); }
  module Sy(y=1) { scale([1, y, 1]) children(); }
  module Sz(z=1) { scale([1, 1, z]) children(); }

  // Resize shorthand
  module RS(t=[0,0,0]){resize(t) children();}
  module RSx(x=90) { resize([x, 0, 0]) children(); }
  module RSy(y=90) { resize([0, y, 0]) children(); }
  module RSz(z=90) { resize([0, 0, z]) children(); }

  // Diff/Union shorthand
  module D() { difference() { children(0); if($children>1) children([1:$children-1]); } }
  module U() { union() { children(); } }
  module H() { hull() { children();  } }
  module I() { intersection() {children(); } }

  // note the mirror by default retains the origonal object
  module Mx(retain=true) {mirror([1, 0, 0]) children(); if (retain) children();}
  module My(retain=true) {mirror([0, 1, 0]) children(); if (retain) children();}
  module Mz(retain=true) {mirror([0, 0, 1]) children(); if (retain) children();}


// Autoplacement at corners
  module place_at_corners_xy(x, y) {
    My()
    Mx()
    translate([x/2, y/2, 0]) children();
  }

  module place_at_corners_xz(x, z) {
    Mz()
    Mx()
    translate([x/2, 0, z/2]) children();
  }

  module place_at_corners_yz(y, z) {
    Mz()
    My()
    translate([0, y/2, z/2]) children();
  }

  module place_at_positions(positions = [[0,0,0], [1,1,1]]) {
    for (position = positions) {
      translate(position) {
        children();
      }
    }
  }

// Weird hulling stuff i ended up making
  module slide_hull_X(amount = 10) {
    if ($children > 0) {
      union() {
        for ( child = [0:1:$children-1]) {
          hull() {
            Tx(amount/2)
              children(child);
            Tx(-amount/2)
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
            Ty(amount/2)
              children(child);
            Ty(-amount/2)
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
            Tz(amount/2)
              children(child);
            Tz(-amount/2)
              children(child);
          }
        }
      }
    }
    else {
      children();
    }
  }


  module progressive_resize_rotate(scales=[0.01,0.1,0.3,1,2,3,5,8,13,8,3,2,1], resize_axis=[true,true,true], radius = 300, angle=90, detail=100) {
    // work out the resize amount and angle per step
    resize_offset = detail/(len(scales) - 1);
    movement=angle/detail;
    parts_offset = detail/$children;

    render() {
      union() {
        //loop with the end chopped off - this is because the second to last item merges with the last item
        for(i = [0 : 1 : detail - 1]) {
          hull() {
            rotate([0, 0, movement * i]) {
              translate([radius, 0, 0]) {
                scale([
                  resize_axis[0]? resize_ration_from_scale(scales, i, resize_offset) : 1,
                  resize_axis[1]? resize_ration_from_scale(scales, i, resize_offset) : 1,
                  resize_axis[2]? resize_ration_from_scale(scales, i, resize_offset) : 1]) {
                  if (($children > 0 &&$children < 2) || i == 0) {
                    children(0);
                  }
                  else if (i == detail -1) {
                    children($children -1);
                  }
                  else {
                    children(i / parts_offset);
                  }
                }
              }
            }
            rotate([0, 0, movement * (i + 1)]) {
              translate([radius, 0, 0]) {
                scale([
                  resize_axis[0]? resize_ration_from_scale(scales, (i + 1), resize_offset) : 1,
                  resize_axis[1]? resize_ration_from_scale(scales, (i + 1), resize_offset) : 1,
                  resize_axis[2]? resize_ration_from_scale(scales, (i + 1), resize_offset) : 1]) {
                    if (($children > 0 &&$children < 2) || (i + 1) == 0) {
                      children(0);
                    }
                    else if ((i + 1) == detail) {
                      children($children -1);
                    }
                    else {
                      children((i + 1) / parts_offset);
                    }
                }
              }
            }
          }
        }
      }
    }
  }


  module progressive_rotate(scales=[1,2,3.8,14,5,6,4,3,2,1], radius = 300, angle=90, detail=100) {
    // work out the rotation amount per step
    movement=angle/detail;
    union() {
      //loop with the end chopped off - this is because the second to last item merges with the last item
      for(i = [0 : 1 : detail - 1]) {
        hull() {
          rotate([0, 0, movement * i]) {
            translate([radius, 0, 0]) {
            children(0);
            }
          }
          rotate([0, 0, movement * (i + 1)]) {
            translate([radius, 0, 0]) {
            children(0);
            }
          }
        }
      }
    }
  }

  module progressive_resize_linear(scales=[1,2,3.8,14,5,6,4,3,2,1], resize_axis=[true,true,true], distance = 300, detail=100) {
    // work out the resize amount per step
    movement=distance/detail;
    resize_offset = detail/(len(scales));

    union() {
      //loop with the end chopped off - this is because the second to last item merges with the last item
      for(i = [0 : 1 : detail - 1]) {
        hull() {
          translate([i * movement,0,0]) { // move it
            scale([ //scale it
                resize_axis[0]? resize_ration_from_scale(scales, i, resize_offset) : 1,
                resize_axis[1]? resize_ration_from_scale(scales, i, resize_offset) : 1,
                resize_axis[2]? resize_ration_from_scale(scales, i, resize_offset) : 1]) {
            children(0);
            }
          }
          translate([(i + 1) * movement,0,0]) {
            scale([
                resize_axis[0]? resize_ration_from_scale(scales, (i + 1), resize_offset) : 1,
                resize_axis[1]? resize_ration_from_scale(scales, (i + 1), resize_offset) : 1,
                resize_axis[2]? resize_ration_from_scale(scales, (i + 1), resize_offset) : 1]) {
            children(0);
            }
          }
          echo (i);
          echo (resize_ration_from_scale(scales, i, resize_offset));
        }
      }
    }
  }


  function resize_ration_from_scale(scales, i, resize_offset) = 
    find_scale_ratio(
      scales[floor((i)/resize_offset)],
      scales[floor((i)/resize_offset) + 1],
      resize_offset,
      i % resize_offset);

  function resize_ration_from_scale(scales, i, resize_offset) = 
    find_scale_ratio(
      scales[floor((i)/resize_offset)],
      scales[floor((i)/resize_offset) + 1],
      resize_offset,
      i % resize_offset);

  function find_scale_ratio(valueA, valueB, steps, step) = valueA+((valueB-valueA)/steps*(step));

  module progressive_hull(){
    if ($children > 1) {
      number_of_children = $children;
      union() {
        for ( child = [0:1:$children-1]) {
          if (child + 1 < number_of_children) {
          hull(){
              children(child);
              children(child + 1);
            }
          }
        }
      }
    }
    else {
      children();
    }
  }

  module progressive_hull_at_locations(locations = [[20,20,20], [20,-20,20], [20,-20,-20],[20,20,-20]], close_end=true) {
    location_count = len(locations);
    
    for (i = [0:location_count -1]) {
      if (i + 1 == location_count) {
          hull() {
            translate(locations[i]) children();
            if (close_end) translate(locations[0]) children();
          }
      }
      else {
        hull() {
          translate(locations[i]) children();
          translate(locations[i + 1]) children();
        }
      }
    }
  }


/* legacy for compatability */
  module translateX(x) { Tx(x) children(); }
  module translateY(y) { Ty(y) children(); }
  module translateZ(z) { Tz(z) children(); }

  // Rotate shorthand
  module rotateX(x=90) { Rx(x) children(); }
  module rotateY(y=90) { Ry(y) children(); }
  module rotateZ(z=90) { Rz(z) children(); }

  // Scale shorthand
  module scaleX(x=1) { Sx(x) children(); }
  module scaleY(y=1) { Sy(y) children(); }
  module scaleZ(z=1) { Sz(z) children(); }

  // Resize shorthand
  module resizeX(x=90){  RSx(x) children(); }
  module resizeY(y=90){ RSy(y) children(); }
  module resizeZ(z=90){ RSz(z) children(); }

  // note the mirror by default retains the origonal object
  module mirrorX(retain=true) { Mx(retain=retain) children(); }
  module mirrorY(retain=true) { My(retain=retain) children(); }
  module mirrorZ(retain=true) { Mz(retain=retain) children(); }

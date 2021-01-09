include <curves_math.scad>

module arc_base( height, depth, radius, detail = 100, degrees , rounded = false) {
  // This dies a horible death if it's not rendered here 
  // -- sucks up all memory and spins out of control 
  render() {
    // Outer ring
    #rotate_extrude(angle = degrees, $fn = detail) {
      translate([radius - height, 0, 0]) {
        if (rounded) {
          translate([height/2, 0, 0])
          resize(newsize=[height, depth, 0])
          circle(height);
        }
        else {
          translate([0, -depth/2, 0])
          square([height,depth]);
        }
      }
    }
  }
}

module arc(thickness, depth, radius, degrees, detail=100, center = true, rounded = false) {
  rotate([0,0,-degrees/2]) {
    arc_base(height=thickness, depth=depth, radius=radius, detail=detail, degrees=degrees, rounded = rounded);
  }
}

module straight(thickness, depth, length, center = true, rounded = false) {
  if (rounded) {
    rotate([90, 0, 90]) {
      resize(newsize=[thickness, depth, length]) {
        cylinder(d = depth, height = length, center = center);
      }
    }
  }
  else {
    cube([length, thickness, depth], center=center);
  }
}

module arc_from_sag_length(sag, length) {
  radius = calc_arc_radius_from_sag_length(sag, length);
  angle = calc_arc_slice_from_length(radius, length);

  translateX(-radius)
  rotateZ(-angle/2)
    rotate_extrude(angle = angle, $fn = $fn * 2) {
      translateX(radius) 
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
    echo (i)
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

function fn_arcs() = $fn * 5;

module shape_balanced_arc( thickness, depth, radius, detail, degrees , rounded = false) {
  rotate([0,0,-degrees/2])
  render() {
    rotate_extrude(angle = degrees, $fn = fn_arcs()) {
      translate([radius, 0, 0]) {
        if (rounded) {
          resize(newsize=[thickness, depth, 0])
          circle(thickness, center = true);
        }
        else {
          square([thickness,depth], center = true);
        }
      }
    }
  }
}

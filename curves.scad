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

  Tx(-radius)
  Rz(-angle/2)
    rotate_extrude(angle = angle, $fn = $fn * 2) {
      Tx(radius) 
        children();
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

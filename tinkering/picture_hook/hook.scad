  include <../../openscad-parts/tools.scad>

$fn = 80;
/* 
  basic part sizes
*/

banister_thickness = 118;
hook_width = 40;
hook_overhang_balast = 20;
hook_overhang_hook = 40;
hook_thickness = 6;

module hook_cutout() {
  cube([banister_thickness,banister_thickness,banister_thickness], center = true);

}
difference() {
  make_hook();
  union() {
    translate([0, -(hook_width + 5), 40])
      ccube([banister_thickness + 10, hook_width, hook_overhang_hook + 20]);
    translate([0, (hook_width + 5), 40])
      ccube([banister_thickness + 10, hook_width, hook_overhang_hook + 20]);
    hook_cutout();
    translate([banister_thickness / 2 + 15,5,29]) {
      rotate([0,90,0]) {
        cylinder(d=8, h=15, center = true);
      }
    }
    translate([banister_thickness / 2 + 15,-5,29]) {
      rotate([0,90,0]) {
        cylinder(d=8, h=15, center = true);
      }
    }
  }
}

// the hook
module make_hook() {
  //top side
  top_offset_X = banister_thickness / 2;
  top_offset_Y = hook_width/2;
  top_offset_Z = banister_thickness/2;

  hull() {
    translate([top_offset_X, top_offset_Y, top_offset_Z]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([top_offset_X, -top_offset_Y, top_offset_Z]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([-top_offset_X, -top_offset_Y, top_offset_Z]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([-top_offset_X, top_offset_Y, top_offset_Z]) {
      sphere(r=hook_thickness, center = true);
    }
  }

  //rear balast
  hull() {
    translate([-top_offset_X, -top_offset_Y, top_offset_Z]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([-top_offset_X, top_offset_Y, top_offset_Z]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([-top_offset_X, -top_offset_Y, top_offset_Z - hook_overhang_balast]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([-top_offset_X, top_offset_Y, top_offset_Z - hook_overhang_balast]) {
      sphere(r=hook_thickness, center = true);
    }
  }

  //hook side outcrop
  hull() {
    translate([top_offset_X, -top_offset_Y, top_offset_Z]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([top_offset_X, top_offset_Y, top_offset_Z]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([top_offset_X, -top_offset_Y, top_offset_Z - hook_overhang_hook]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([top_offset_X, top_offset_Y, top_offset_Z - hook_overhang_hook]) {
      sphere(r=hook_thickness, center = true);
    }
  }

  //the hook part
  hull() {
    translate([top_offset_X, -top_offset_Y, top_offset_Z - hook_overhang_hook]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([top_offset_X, top_offset_Y, top_offset_Z - hook_overhang_hook]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([top_offset_X + hook_thickness * 2.5, -(top_offset_Y - hook_thickness * 1.5), top_offset_Z - hook_overhang_hook]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([top_offset_X + hook_thickness * 2.5, (top_offset_Y - hook_thickness * 1.5), top_offset_Z - hook_overhang_hook]) {
      sphere(r=hook_thickness, center = true);
    }
  }

  hull() {
    translate([top_offset_X + hook_thickness * 2.5, -(top_offset_Y - hook_thickness * 2), top_offset_Z - hook_overhang_hook]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([top_offset_X + hook_thickness * 2.5, (top_offset_Y - hook_thickness * 2), top_offset_Z - hook_overhang_hook]) {
      sphere(r=hook_thickness, center = true);
    }
    translate([top_offset_X + hook_thickness * 2.5, -(top_offset_Y - hook_thickness * 2), top_offset_Z - (3* hook_thickness)]) {
      sphere(r=hook_thickness/2, center = true);
    }
    translate([top_offset_X + hook_thickness * 2.5, (top_offset_Y - hook_thickness * 2), top_offset_Z - (3* hook_thickness)]) {
      sphere(r=hook_thickness/2, center = true);
    }
  }
}
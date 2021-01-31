space = 150;
rail_D = 8;
size_x = space + rail_D * 2 + 2;
depth = 7;
thickness = 30;
spacer_height = 60;

$fn = 100;

make_rail_spacer();
module make_rail_spacer() {
  difference() {
    make_plates();
    make_rails();
  }
}

module make_rails() {
  hull() {
    translate([space/2 - 1, 0, 0]) {
      rotate([90, 0, 0]) {
        cylinder(d = rail_D, h=thickness + 10, center=true);
      }
    }
    translate([space/2 + 1, 0, 0]) {
      rotate([90, 0, 0]) {
        cylinder(d = rail_D, h=thickness + 10, center=true);
      }
    }
  }
  hull() {
    translate([-space/2 + 1, 0, 0]) {
      rotate([90, 0, 0]) {
        cylinder(d = rail_D, h=thickness + 10, center=true);
      }
    }
    translate([-space/2 - 1, 0, 0]) {
      rotate([90, 0, 0]) {
        cylinder(d = rail_D, h=thickness + 10, center=true);
      }
    }
  }

  translate([0, 0, spacer_height]) {
    rotate([0, 90, 0]) {
//      cylinder(d = rail_D, h=size_x + 10, center=true);
    }
  }
}

module make_plates() {
  //bottom_plate
  translate([0, 0, depth/2]) {
    cube(size=[size_x, thickness, depth], center=true);
  }
  //top_plate
  translate([0, 0, spacer_height - depth/2]) {
    cube(size=[space, thickness, depth], center=true);
  }

  //side_plates
  translate([-space/2, 0, spacer_height/2]) {
    cube(size=[depth, thickness, spacer_height], center=true);
  }

  translate([space/2, 0, spacer_height/2]) {
    cube(size=[depth, thickness, spacer_height], center=true);
  }
}
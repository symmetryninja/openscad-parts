/*
  circuitboards file
  generates code for different sizes of circuit boards
 */

// members
protoboard_Z = 1.6;

// functions
function protoboard_get_Z() = protoboard_Z;

// outputs

module make_protoboard(size_X=30, size_Y=40, corner_screws=2.5, corner_screw_edge=1.3, drill_holes=true) {
  color("green")
  difference() {
    cube([size_X, size_Y, protoboard_get_Z()], center = true);
    if(drill_holes)
      make_protoboard_screws(size_X = size_X, size_Y = size_Y, corner_screws = corner_screws, corner_screw_edge = corner_screw_edge);
  }
}

module make_protoboard_screws(size_X=30, size_Y=40, corner_screws=2.5, corner_screw_edge=1.3, screw_length=20, hex_size=[5,5], screw_purchase=2) {
  offset_X = (size_X - (2*corner_screw_edge + corner_screws/2)) / 2;
  offset_Y = (size_Y - (2*corner_screw_edge + corner_screws/2)) / 2;
  offset_Z = -screw_length/2 + protoboard_get_Z()/2;
  translate([ offset_X,  offset_Y, 0]) {
    screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = 5.2, screwheadHeight=3, withHexBlank = true, hexBlankH = hex_size[0], hexBlankD = hex_size[1], screwPurchase = screw_purchase);
  }
  translate([ offset_X, -offset_Y, 0]) {
    screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = 5.2, screwheadHeight=3, withHexBlank = true, hexBlankH = hex_size[0], hexBlankD = hex_size[1], screwPurchase = screw_purchase);
  }
  translate([-offset_X,  offset_Y, 0]) {
    screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = 5.2, screwheadHeight=3, withHexBlank = true, hexBlankH = hex_size[0], hexBlankD = hex_size[1], screwPurchase = screw_purchase);
  }
  translate([-offset_X, -offset_Y, 0]) {
    screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = 5.2, screwheadHeight=3, withHexBlank = true, hexBlankH = hex_size[0], hexBlankD = hex_size[1], screwPurchase = screw_purchase);
  }
}

module make_protoboard_screws_precice(size_X=30, size_Y=40, corner_screws=3.3, screw_length=20) {
  offset_X = size_X / 2;
  offset_Y = size_Y / 2;
  offset_Z = -screw_length/2;
  translate([ offset_X,  offset_Y, offset_Z]) {
    screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = corner_screws, screwheadHeight=3, withHexBlank = false);
  }
  translate([ offset_X, -offset_Y, offset_Z]) {
    screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = corner_screws, screwheadHeight=3, withHexBlank = false);
  }
  translate([-offset_X,  offset_Y, offset_Z]) {
    screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = corner_screws, screwheadHeight=3, withHexBlank = false);
  }
  translate([-offset_X, -offset_Y, offset_Z]) {
    screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = corner_screws, screwheadHeight=3, withHexBlank = false);
  }
}

/// Node the sizes denote the centres!
module make_protoboard_x_frame(size_X=30, size_Y=40, corner_screws=2.5, corner_screw_edge=1.3, screw_length=20, hex_size=[5,5], screw_purchase=2, spacer_H=3, spacer_D=5, thickness=2, diff_screws=true, diff_triangles=true, additional_spacers=[]) {
  useable_size_X = size_X - corner_screw_edge * 2;
  useable_size_Y = size_Y - corner_screw_edge * 2;
  centre_X = useable_size_X/2;
  centre_Y = useable_size_Y/2;
  translate([0,0,-(protoboard_get_Z()/2 + spacer_H)]) {
    difference() {
      union() {
        difference() {
          union() {
            union() {
              translate([0,0,spacer_H/2 - thickness/4]) {
                union () {
                  translate([-centre_X, centre_Y, 0]) {
                    cylinder(h=thickness/2 + spacer_H, d=spacer_D, center=true);
                  }
                   translate([centre_X, -centre_Y, 0]) {
                    cylinder(h=thickness/2 + spacer_H, d=spacer_D, center=true);
                  }
                   translate([-centre_X, -centre_Y, 0]) {
                    cylinder(h=thickness/2 + spacer_H, d=spacer_D, center=true);
                  }
                   translate([centre_X, centre_Y, 0]) {
                    cylinder(h=thickness/2 + spacer_H, d=spacer_D, center=true);
                  }
                }
              }
              difference() {
                hull() {
                  union () {
                    translate([-centre_X, centre_Y, 0]) {
                      cylinder(h=thickness, d=spacer_D, center=true);
                    }
                     translate([centre_X, -centre_Y, 0]) {
                      cylinder(h=thickness, d=spacer_D, center=true);
                    }
                     translate([-centre_X, -centre_Y, 0]) {
                      cylinder(h=thickness, d=spacer_D, center=true);
                    }
                     translate([centre_X, centre_Y, 0]) {
                      cylinder(h=thickness, d=spacer_D, center=true);
                    }
                  }
                }
                if (diff_triangles) {
                  union() {
                    triangle_pad = spacer_D * 4;

                    triangle_1_X = useable_size_X - triangle_pad;
                    triangle_1_Y = useable_size_Y/2 - triangle_pad / 2;
                    triangle_1_offset_X = 0;
                    triangle_1_offset_Y = -useable_size_Y/2/2;

                    triangle_2_X = useable_size_Y - triangle_pad;
                    triangle_2_Y = useable_size_X/2 - triangle_pad / 2;
                    triangle_2_offset_X = 0;
                    triangle_2_offset_Y = -useable_size_X/2/2;

                    translate([triangle_1_offset_X,triangle_1_offset_Y,0]) {
                      make_triangle(size=[triangle_1_X,triangle_1_Y,5]);
                    }
                    rotate([0,0,180]) {
                      translate([triangle_1_offset_X,triangle_1_offset_Y,0]) {
                        make_triangle(size=[triangle_1_X,triangle_1_Y,5]);
                      }
                    }
                    rotate([0,0,90]) {
                      translate([triangle_2_offset_X,triangle_2_offset_Y,0]) {
                        make_triangle(size=[triangle_2_X,triangle_2_Y,5]);
                      }
                    }
                    rotate([0,0,-90]) {
                      translate([triangle_2_offset_X,triangle_2_offset_Y,0]) {
                        make_triangle(size=[triangle_2_X,triangle_2_Y,5]);
                      }
                    }
                  }
                }
              }
              if (!diff_screws) {
                make_protoboard_screws(useable_size_X, useable_size_Y, corner_screws, corner_screw_edge, screw_length, hex_size, screw_purchase);
              }
            }
            
            if (additional_spacers) {
              difference() {
                union() {
                  for(i = additional_spacers){
                    translate(i) {
                      translate([0,0,spacer_H/2 - thickness/4]) {
                        cylinder(h=thickness/2 + spacer_H, d=spacer_D, center=true);
                      }
                    }
                  }
                }
              }
            }
          }
        }

        for(i = additional_spacers){
          hull() {
            translate([i[0], centre_Y -1, 0]) {
              cylinder(h=thickness, d=spacer_D+2, center=true);
            }
            translate([i[0], -centre_Y +1, 0]) {
              cylinder(h=thickness, d=spacer_D+2, center=true);
            }
          }
        }
      }
      union() {
        if (diff_screws) {
          translate([ centre_X,  centre_Y, 0]) {
            screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = 5.2, screwheadHeight=3, withHexBlank = true, hexBlankH = hex_size[0], hexBlankD = hex_size[1], screwPurchase = screw_purchase);
          }
          translate([ centre_X, -centre_Y, 0]) {
            screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = 5.2, screwheadHeight=3, withHexBlank = true, hexBlankH = hex_size[0], hexBlankD = hex_size[1], screwPurchase = screw_purchase);
          }
          translate([-centre_X,  centre_Y, 0]) {
            screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = 5.2, screwheadHeight=3, withHexBlank = true, hexBlankH = hex_size[0], hexBlankD = hex_size[1], screwPurchase = screw_purchase);
          }
          translate([-centre_X, -centre_Y, 0]) {
            screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = 5.2, screwheadHeight=3, withHexBlank = true, hexBlankH = hex_size[0], hexBlankD = hex_size[1], screwPurchase = screw_purchase);
          }
          for(i = additional_spacers){
            translate(i) {
              screwButton(screwthreadwidth=corner_screws, height=screw_length, screwheadDiameter = 5.2, screwheadHeight=3, withHexBlank = true, hexBlankH = hex_size[0], hexBlankD = hex_size[1], screwPurchase = screw_purchase);
            }
          }
        }
      }
    }
  }
}

/**
 * clips.scad
 * --- tension clips for joining components
 */

module tools_clip_internal_box() {
  difference() {
    translate([20,0,0]) {
        ccube([30, 29, 9]);
    }
    tools_clip_internal();
  }
}

module tools_clip_external_box() {
  difference() {
    translate([25,0,0]) {
        ccube([30, 45, 9]);
    }
    union() {
      tools_clip_external();
      ccube([50, 30 - 7, 10]);
    }
  }
}


module tools_clip_internal(box_size=[50, 30, 10], arm_thickness = 2, box_thickness = 4, long_side = 5, short_side = 5) {
  tools_clip(box_size=box_size, arm_thickness = arm_thickness, box_thickness = box_thickness, long_side = long_side, short_side = short_side, inverted = true);
}

module tools_clip_external(box_size=[50, 30, 10], arm_thickness = 2, box_thickness = 10, long_side = 5, short_side = 5) {
  tools_clip(box_size=box_size, arm_thickness = arm_thickness, box_thickness = box_thickness, long_side = long_side, short_side = short_side, inverted = false);
}

module tools_clip(box_size=[50, 30, 10], arm_thickness = 2, box_thickness = 10, long_side = 5, short_side = 5, inverted = true) {
  union() {
    box_X = box_size[0];
    box_Y = box_size[1];
    box_Z = box_size[2];
    // tail box
    translate([-box_X/2 + box_thickness/2, 0]) {
      ccube([box_thickness, box_Y, box_Z]);
    }

    // clip arms
    tools_clip_arms(box_size=box_size, arm_thickness = arm_thickness, short_side = short_side, inverted = inverted);

    // clip tips
    translate([box_X/2 - long_side/2, 0, 0]) {
      tools_clip_triangle(long_side=long_side, short_side=short_side, depth = box_Z, space=box_Y - 2 * short_side, inverted = inverted);
    }
  }
}

module tools_clip_arms(box_size=[50, 30, 10], arm_thickness = 2, short_side = 5, inverted = true) {
  tools_clip_arm(box_size=box_size, arm_thickness = arm_thickness, short_side = short_side, inverted = inverted);
  mirror([0,1,0])
  tools_clip_arm(box_size=box_size, arm_thickness = arm_thickness, short_side = short_side, inverted = inverted);
}

module tools_clip_arm(box_size=[50, 30, 10], arm_thickness = 2, short_side = 5, inverted=false) {
  box_X = box_size[0];
  box_Y = box_size[1];
  box_Z = box_size[2];
  if (!inverted) {
    hull() {
      translate([box_X/2 - short_side, box_Y/2 - arm_thickness/2 - short_side + arm_thickness, 0]) {
        ccube([0.1, arm_thickness, box_Z]);
      }
      translate([-box_X/2 + 0.1, box_Y/2 - arm_thickness - short_side + arm_thickness, 0]) {
        ccube([0.1, arm_thickness * 2, box_Z]);
      }
    }
  }
  else {
    hull() {
      translate([box_X/2 - short_side, box_Y/2 - arm_thickness/2 - short_side + short_side, 0]) {
        ccube([0.1, arm_thickness, box_Z]);
      }
      translate([-box_X/2 + 0.1, box_Y/2 - arm_thickness - short_side + short_side, 0]) {
        ccube([0.1, arm_thickness * 2, box_Z]);
      }
    }
  }
}

module tools_clip_triangle(long_side=5, short_side=5, depth = 10, space = 40, inverted=true) {
  if (inverted) {
    translate([-long_side/2,-(space/2 + short_side),0]) {
      tools_clip_triangle_normal(long_side=long_side, short_side=short_side, depth = depth, space = space);
    }
    translate([-long_side/2,(space/2 + short_side),0]) {
      tools_clip_triangle_inverted(long_side=long_side, short_side=short_side, depth = depth, space = space);
    }
  }
  else {
    translate([-long_side/2,space/2,0]) {
      tools_clip_triangle_normal(long_side=long_side, short_side=short_side, depth = depth, space = space);
    }
    translate([-long_side/2,-space/2,0]) {
      tools_clip_triangle_inverted(long_side=long_side, short_side=short_side, depth = depth, space = space);
    }
  }

}

module tools_clip_triangle_normal(long_side=20, short_side=10, depth = 5, space = 40) {
  tools_clip_triangle_base(long_side = long_side, short_side = short_side, depth = depth);
}

module tools_clip_triangle_inverted(long_side=20, short_side=10, depth = 5, space = 40) {
  mirror([0,1,0])
    tools_clip_triangle_base(long_side = long_side, short_side = short_side, depth = depth);
}

module tools_clip_triangle_base(long_side=20, short_side=10, depth = 5) {
  pt_1 = long_side;
  pt_2 = short_side;
  pt_H = depth/2;
  pt_L = -depth/2;
  
  polyhedron( 
    points = [
      [pt_1, 0, pt_H],
      [0, pt_2, pt_H],
      [0, 0, pt_H],
      [pt_1, 0, pt_L],
      [0, pt_2, pt_L],
      [0, 0, pt_L],
    ], 
    faces = [
      [2, 1, 0],
      [3, 4, 5],
      [0, 1, 4, 3],
      [3, 5, 2, 0],
      [5, 4, 1, 2],
    ]
  );
}

module tools_clip_circular(inner_D=30, thickness=3, height=15, block_long_side = 7.5, block_ends=true) {
  cube_size = inner_D + 1 + (2 * thickness);
  clip_ss = thickness * 2;
  clip_ls = block_long_side;
  union() {
    difference() {
      ccylinder(d = inner_D + 2 * thickness, h = height);
      union() {
        ccylinder(d = inner_D, h = height + 1);
        translate([cube_size/2 + 0.1, 0, 0]) {
          ccube([cube_size, cube_size, height + 1]);
        }
      }
    }
    if (block_ends) {
      translate([clip_ls/2,  inner_D/2, 0]) {
        ccube([clip_ls, clip_ss, height]);
      }
      translate([clip_ls/2, -inner_D/2, 0]) {
        ccube([clip_ls, clip_ss, height]);
      }
    }
    else {
      translate([clip_ls/2, 0, 0]) {
        tools_clip_triangle(long_side=clip_ls, short_side=clip_ss, depth = height, space = inner_D - clip_ss, inverted=true);
      }
    }
  }
}
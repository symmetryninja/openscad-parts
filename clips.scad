/**
 * clips.scad
 * --- tension clips for joining components
 */

module tools_clips_base_clip(overall_size = [40,15,10], endblock = 5, hard_edge = true, edge_thickness = 3, arm_thickness = 1) {
  tools_clips_base(overall_size, endblock, hard_edge, edge_thickness, arm_thickness);
  tools_clips_base_block(overall_size, endblock, hard_edge, edge_thickness, arm_thickness);
}

module tools_clips_base(overall_size = [40,15,10], endblock = 5, hard_edge = true, edge_thickness = 3, arm_thickness = 1, invert = false) {
  size_X = overall_size[0];
  size_Y = overall_size[1];
  size_Z = overall_size[2];

  //end block
  translate([size_X/2 -endblock/2, 0, 0]) {
    cube([endblock, size_Y, size_Z], center = true);
  }

  //arm
  arm_X = size_X * 2/3 - edge_thickness;
  arm_Y = arm_thickness;
  arm_Z = size_Z;

  arm_offset_X = (size_X)/6;
  arm_offset_Y = (size_Y - arm_thickness) / 2 - arm_Y/2 - edge_thickness;
  arm_offset_Z = 0;

  translate([arm_offset_X, arm_offset_Y, arm_offset_Z]) {
    cube([arm_X, arm_Y, arm_Z], center = true);
  }

  translate([arm_offset_X, -arm_offset_Y, arm_offset_Z]) {
    cube([arm_X, arm_Y, arm_Z], center = true);
  }

  // arm triangle
  arm_t_X = 2 * edge_thickness;
  arm_t_Y = edge_thickness;

  arm_t_offset_X = -arm_t_X/4;
  arm_t_offset_Y = arm_offset_Y + arm_t_Y/2;
  arm_t_offset_Z = 0;

  translate([arm_t_offset_X, arm_t_offset_Y, arm_t_offset_Z]) {
    make_triangle([arm_t_X, arm_t_Y, size_Z]);
  }
  translate([arm_t_offset_X, -arm_t_offset_Y, arm_t_offset_Z]) {
    rotate([0,0,180]) {
      make_triangle([arm_t_X, arm_t_Y, size_Z]);
    }
  }



}
module tools_clips_base_block(overall_size = [40,15,10], endblock = 5, hard_edge = true, edge_thickness = 3, arm_thickness = 1) {

}
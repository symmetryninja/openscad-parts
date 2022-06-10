include <sn_tools.scad>

/* camera frame for 3030 extrusion
clip_part - connects to the printer
arm_join - linkages
*/

module spline_cutter() {
  inner_D = 10;
  outer_D = 40;
  segments = 20;
  teeth_depth = 5;

  c_inner = pi * inner_D;
  c_outer = pi * outer_D;

  segment_angle = 360/segments;
  // segment_xy_short = 

}

ccube_multi();
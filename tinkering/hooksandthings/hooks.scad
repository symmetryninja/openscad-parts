include <sn_tools.scad>

// bannister hook

// headphone hook
hh_bar_thickness = 11;
hh_bar_height = 45;
hh_hook_depth = 15;
hh_hook_thickness = 4;
hh_hook_wide_side = 20;

hh_cube_size_X = hh_hook_thickness + hh_bar_thickness + hh_hook_wide_side;
hh_cube_size_Y = hh_bar_height + hh_hook_thickness;

hh_cube_offset_X = hh_cube_size_X/2 - hh_bar_thickness/2 - hh_hook_thickness;
hh_cube_offset_Y = hh_hook_thickness/2 + 0.01;

hh_cutout_1 = [hh_bar_thickness, hh_bar_height,hh_hook_depth + 1];
hh_cutout_2 = [8, 41, hh_hook_depth + 1];
hh_cutout_2_offset = [15.5, hh_cube_offset_Y, 0];

headphone_hook();
module headphone_hook() {
  $fn = 100;
  D() {
    hh_hook();
    #hh_cutout();
  }
}

module hh_hook() {
  union() {
    T([hh_cube_offset_X, hh_cube_offset_Y, 0]) {
      ccube ([hh_cube_size_X, hh_cube_size_Y,hh_hook_depth]);
    }
    T([40, 40, 0]) {
      R([0, 0, 180]) {
        
        D() {
          rotate_extrude(angle = 180, convexity = 10) {
            T([22/2, 0, 0]) {
              square(size=[20, hh_hook_depth], center=true);
            }
          }
          T([0,-0.01,0])
          rotate_extrude(angle = 180, convexity = 10) {
            T([15/2, 0, 0]) {
              square(size=[15, hh_hook_depth + 1], center=true);
            }
          }
        }
      }
      T([18, 2, 0]) ccube([6, 5, hh_hook_depth]);
      T([-18, -10, 0]) {
        ccube([6, 29, hh_hook_depth]);
      }
    }
  }
}

module hh_cutout() {
  ccube (hh_cutout_1);
  T(hh_cutout_2_offset)
  ccube (hh_cutout_2);
}
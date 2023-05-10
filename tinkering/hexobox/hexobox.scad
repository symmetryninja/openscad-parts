include <sn_tools.scad>

/**
 2023-05-10
 HexoBox
 -----------
 A 6 sided box that is meant to be laser cut.

 Has a sliding lid
**/

if (is_undef(batch_rendering)) {
  $fn=60;

  // hexo_box_display();
  // projection() hexo_box_for_cut_3();
  // projection() hexo_box_for_cut_4();
  projection() hexo_box_for_cut_10();

}

/** globals **/
// 70x120x20 222
hb_space_X = 70;
hb_space_Y = 120;
hb_space_Z = 20;

hb_yoversize = 0.66;

hb_wall = 12;
hb_gap = 8;

hb_outer_end_Y = hb_space_Y/2 + hb_wall + hb_gap;
hb_outer_mid_X = hb_space_X/2 + hb_wall + hb_gap;
hb_outer_mid_Y = hb_outer_end_Y * hb_yoversize;

hb_outer_positions = [
  [0, hb_outer_end_Y, 0],
  [hb_outer_mid_X,hb_outer_mid_Y,0],
  [hb_outer_mid_X,-hb_outer_mid_Y,0],
  [0, -hb_outer_end_Y, 0],
  [-hb_outer_mid_X,-hb_outer_mid_Y,0],
  [-hb_outer_mid_X,hb_outer_mid_Y,0],
];

hb_outer_positions_cut = [
  addY(hb_outer_positions[0], 10),
  addY(hb_outer_positions[1], 10),
  hb_outer_positions[2],
  hb_outer_positions[3],
  hb_outer_positions[4],
  addY(hb_outer_positions[5], 10),
];

hb_retainer_positions = [
  hb_outer_positions[1],
  hb_outer_positions[2],
  hb_outer_positions[3],
  hb_outer_positions[4],
  hb_outer_positions[5],
];

hb_screw_positions = [
  addX(hb_outer_positions[1], 2.5),
  addX(hb_outer_positions[2], 2.5),
  addX(hb_outer_positions[4], -2.5),
  addX(hb_outer_positions[5], -2.5),
];

hb_handle_positions = [
  hb_outer_positions[2],
  hb_outer_positions[1],
  hb_outer_positions[4],
];



/** helpers **/

module framebox_base(d = hb_wall, h=5) {
  progressive_hull_at_locations(hb_outer_positions) {
    ccylinder(d = d, h = h);
  };
}

module hexo_box_for_cut_3() {
  // door pane
  T([75, -50, 0]) hexo_box_door(h=3);
}

module hexo_box_for_cut_4() {
  // top ring
  Tx(230) hexo_box_retainer(h=4, top = true);
  // door handle for slide
  Tx(75) hexo_box_door_handle(h=4);
  // door retainer
  Tx(-75) hexo_box_retainer(h=4);
  // bottom pane
  Tx(-230) hexo_box_bottom(h=4);
}

module hexo_box_for_cut_10() {
  // spacers
  T([75, 180]) Tz(5) hexo_box_space(h=10, magnet=true);
  T([-75, 180]) Tz(-5) hexo_box_space(h=10, hole_D=4);
}

module hexo_box_display() {
  // top ring
  blue() Tz(16) hexo_box_retainer(h=4, top = true);
  // door handle for slide
  Tz(15) hexo_box_door_handle(h=4);
  // door pane
  red() Tz(11.5) hexo_box_door(h=3);
  // door retainer
  blue() Tz(12) hexo_box_retainer(h=4);
  // spacers
  red() Tz(5) hexo_box_space(h=10, magnet=true);
  blue() Tz(-5) hexo_box_space(h=10, hole_D=4);
  // bottom pane
  red() Tz(-13) hexo_box_bottom(h=4);
}

module hexo_box_retainer(h=4, oversize = 0.0, top=false, holes=true) {
  D() {
    U() {
      progressive_hull_at_locations(hb_retainer_positions, close_end=false) {
        ccylinder(d = hb_wall + oversize, h = h + oversize);
      };
    }
    U() {
      if(!top) H() progressive_hull_at_locations(hb_outer_positions_cut) ccylinder(d = 0.01, h = h+oversize + 1);
      if(holes) hexo_screws();
    }
  }
}

module hexo_box_door_handle(h=4) {
  D() {
    framebox_base(d = hb_wall, h=h);
    U() {
      hexo_box_retainer(h=h+1, oversize=0.1, top = true, holes=false);
      T(hb_outer_positions[0]) ccylinder(d=10, h=20);
    }
  }

}

module hexo_box_door(h=3, positions = hb_outer_positions) {
  D() {
    H()framebox_base(d = hb_wall, h=h);
    hexo_box_retainer(h=4, oversize=0.1, holes=false);
  }
}

module hexo_box_space(h=10, hole_D = 3.5, magnet=false) {
  D() {
    framebox_base(h=h);
    U() {
      hexo_screws(d=hole_D);
      if (magnet) T(hb_outer_positions[0]) ccylinder(d=10, h=20);
    }
  }
}

module hexo_box_bottom(h=6){
  D() {
    H() framebox_base(h=h);
    hexo_screws(d=4);
  }
} 

module hexo_screws(d=3.1, h = 11) {
  place_at_positions(hb_screw_positions) {
    ccylinder(d=d, h = h);
  }
}

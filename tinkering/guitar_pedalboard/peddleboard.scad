

bar_rod_D = 8;
bar_rod_L  = 600;

bar_rod_offset_Y = 20;

bolt_D = 15;
bolt_H = 6.8;
bolt_space_X = 10;
bolt_space_Y = 20;
bolt_space_Z = 20;

box_X = bar_rod_L;
box_Y = 210;
box_Z = 15;
end_offset = (box_X/2 - 30/2 - 0.01);

box_positions = [
  end_offset,
  0,
  -end_offset,
];

box_spacer_positions = [
  end_offset / 2,
  -end_offset / 2,
];

bar_block_X = (bar_rod_L/2 - bolt_space_X/2);
bar_offset = (box_Y/2 - bar_rod_offset_Y);
bars = [
  bar_offset,
  (bar_offset/3),
  -(bar_offset/3),
  -bar_offset,
];

cable_tunnels = [
  65, 
  45, 
  10, 
  -10, 
  -45, 
  -65, 
];

$fn = 80;

// make the 2 bars

module thread_shaft() {
  rotate([0, 90, 0])
  cylinder(d = bar_rod_D, h = bar_rod_L, center = true);
}

module end_cutout() {
  cube([bolt_space_X, bolt_space_Y, bolt_space_Z], center = true);
}

module thread_cutouts() {
  for (bar = bars) {
    translate([0,bar, 0]) {
      thread_shaft();
      translate([bar_block_X, 0, 0]) {
        end_cutout();
      }
      translate([-bar_block_X, 0, 0]) {
        end_cutout();
      }
    }
  }
  for (x = box_positions) {
    for (y = cable_tunnels) {
      translate([x,y,0]) {
        cylinder(d = 8, h = 50, center = true);
      }
      translate([x,y,-15]) {
        rotate([0,90,0]) {
          cylinder(d = 8, h = 50, center = true);
        }
      }
    }
  }
}

module bevelled_box(size=[100,100,30], bevel=3) {
  tall_size = [size[0] - (bevel * 2), size[1] - (bevel * 2), size[2]]; 
  stout_size = [size[0], size[1], size[2] - (bevel * 2)]; 

  hull() {
    cube(tall_size, center=true);
    cube(stout_size, center=true);
  }
}

difference() {
  union() {
    for (x = box_positions) {
      translate([x,0,0]) {
        union() {
          // bevelled_box([30, box_Y, box_Z]);
          translate([0,0,5])
          bevelled_box([10, box_Y, box_Z + 15]);
          translate([0,0,-2.51])
          bevelled_box([30, box_Y, box_Z + 10]);
        }
      }
    }
  }
  #thread_cutouts();
}

difference() {
  union() {
    for (x = box_spacer_positions) {
      translate([x,0,0]) {
        union() {
          bevelled_box([40, box_Y, box_Z]);
        }
      }
    }
  }
  #thread_cutouts();
}



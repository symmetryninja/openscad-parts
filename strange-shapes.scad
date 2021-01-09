/** includes **/
include <sn_tools.scad>

$fn = 50;

sts_radius=20;
// sphericon2(sts_radius); 
sphericon_4(radius = sts_radius);

module sphericon_ground(size=1000) {
   translate([0,0,-size]) cube(2*size,center=true);
}

module sphericon2_half(r) {
  difference() {
    union() {
      cylinder(r1=r,r2=0,h=r);
      rotate([180,0,0]) cylinder(r1=r,r2=0,h=r);
    }
    rotate([0,-90,0]) sphericon_ground();
  }
}

module sphericon2(r) {
  render() {
  sphericon2_half(r);
  rotate([90,0,0]) rotate([0,0,180]) sphericon2_half(r);
  }
};

module sphericon2_half_shell(r, ratio) {
   difference() {
      sphericon2(r);   
      sphericon2(ratio*r);
      sphericon_ground();
   }
}

module sphericon_4(radius=20) {
  sts_split_and_rotate(){
    sphericon_4_base(radius);
  }
}
// sphericon_4_base();
module sphericon_4_base(radius=20) {
  cyl_H = radius/1.735;
  offset = radius - (radius * .136);
  offset_donut_ends = offset + (radius * 0.065);
  offset_donut_d = radius*2 + 3;
  offset_donut_ends_d  = cyl_H*1.867;
  offset_donut_ends_part_d  = cyl_H*1.5;
  echo (offset);
  difference() {
    hull() {
      translate([0,0,offset]) {
        cylinder(r1=radius,r2=0,h=cyl_H, center=true);
      }
      
      translate([0,0,-offset]) {
        cylinder(r2=radius,r1=0,h=cyl_H, center=true);
      }
    }
    union() {
      translate([0,0,-offset_donut_ends]) {
        torus(part_D=offset_donut_ends_part_d, D = offset_donut_ends_d);
      }
      torus(part_D=offset_donut_ends_part_d, D = offset_donut_d);
      translate([0,0,offset_donut_ends]) {
        torus(part_D=offset_donut_ends_part_d, D = offset_donut_ends_d);
      }
    }
  }
}

module sts_split_and_rotate(angle = 120, cubesize = 100){
  union() {
    difference(){
      union() {
        children();
      }
      translate([cubesize/2 - 0.0001, 0, 0]) {
        ccube([cubesize,cubesize,cubesize]);
      }
    }
    rotate([angle,0,0])
    difference(){
      union() {
        children();
      }
      translate([-cubesize/2 + 0.0001, 0, 0]) {
        ccube([cubesize,cubesize,cubesize]);
      }
    }
  }
}
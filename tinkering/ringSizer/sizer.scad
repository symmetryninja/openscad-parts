include <../../openscad-parts/tools.scad>
$fn=100;

sizes = [ 
  [ 0, "I", 15.2 ], [ 1, "I 1/2", 15.4 ], [ 2, "J", 15.6 ], 
  [ 3, "J 1/2", 15.8 ], [ 4, "K", 16.0 ], [ 5, "K 1/2", 16.1 ], 
  [ 6, "L", 16.4 ], [ 7, "L 1/2", 16.6 ], [ 8, "M", 16.8 ], 
  [ 9, "M 1/2", 17.0 ], [ 10,"N", 17.2 ], [ 11,"N 1/2", 17.4 ], 
  [ 12,"O", 17.6 ], [ 13,"O 1/2", 17.8 ], [ 14,"P", 18.0 ], 
  [ 15,"P 1/2", 18.2 ], [ 16,"Q", 18.4 ], [ 17,"Q 1/2", 18.6 ], 
  [ 18,"R", 18.8 ], [ 19,"R 1/2", 19.0 ], [ 20,"S", 19.2 ], 
  [ 21,"S 1/2", 19.4 ], [ 22,"T", 19.5 ], [ 23,"T 1/2", 19.7 ], 
  [ 24,"U", 19.9 ],
];
section_H = 8;

for(size = sizes) {
  offset_Y = section_H * size[0];
  translate([0,-(25*section_H)/2, 0]) {
    difference() {
      intersection() {
        translate([0,offset_Y,0]) {
          rotate([90,0,0]) {
            ccylinder(d=size[2], h = section_H+0.001);
          }
        }
        translate([0,offset_Y,0]) {
          ccube([40,section_H + 1,6]);
        }
      }
      translate([0,offset_Y-1.5,2]) {
        linear_extrude(3) {
          text(text=size[1], halign="center", size=4);
        }
      }
    }
  }
}

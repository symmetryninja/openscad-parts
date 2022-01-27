include <../../openscad-parts/tools.scad>


module gizmo_corners(x = 40, y = 40, z = 40, depth = 5) {
  oversize=0.01;
  difference(){
    union() {
      ccube([x + depth, y + depth, z + depth]);
    }
    #union() {
      translate([(depth + oversize)/2, (depth + oversize)/2,  (depth/2 + oversize)]) {
        ccube([x, y, z]);
      }
      Tx(10) Rx(90) ccylinder(d = 7, h = y + depth + 2);
      Tx(-10) Rx(90) ccylinder(d = 7, h = y + depth + 2);
      Ty(10) Ry(90) ccylinder(d = 7, h = y + depth + 2);
      Ty(-10) Ry(90) ccylinder(d = 7, h = y + depth + 2);
      Ty(10) ccylinder(d = 7, h = y + depth + 2);
      Ty(-10) ccylinder(d = 7, h = y + depth + 2);
    }
  }
}


module gizmo_edges(x = 40, y = 40, z = 40, depth = 5) {
  oversize=0.01;
  difference(){
    union() {
      ccube([x + depth, y + depth, z]);
    }
    #union() {
      translate([(depth + oversize)/2, (depth + oversize)/2, 0]) {
        ccube([x, y, z + depth*2]);
      }
      Tx(10) Rx(90) ccylinder(d = 7, h = y + depth + 2);
      Tx(-10) Rx(90) ccylinder(d = 7, h = y + depth + 2);
      Ty(10) Ry(90) ccylinder(d = 7, h = y + depth + 2);
      Ty(-10) Ry(90) ccylinder(d = 7, h = y + depth + 2);
      Ty(10) ccylinder(d = 7, h = y + depth + 2);
      Ty(-10) ccylinder(d = 7, h = y + depth + 2);
    }
  }
}


Tx(30) gizmo_corners();
Tx(-30) gizmo_edges();
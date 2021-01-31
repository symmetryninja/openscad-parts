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
      translateX(10) rotateX(90) ccylinder(d = 7, h = y + depth + 2);
      translateX(-10) rotateX(90) ccylinder(d = 7, h = y + depth + 2);
      translateY(10) rotateY(90) ccylinder(d = 7, h = y + depth + 2);
      translateY(-10) rotateY(90) ccylinder(d = 7, h = y + depth + 2);
      translateY(10) ccylinder(d = 7, h = y + depth + 2);
      translateY(-10) ccylinder(d = 7, h = y + depth + 2);
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
      translateX(10) rotateX(90) ccylinder(d = 7, h = y + depth + 2);
      translateX(-10) rotateX(90) ccylinder(d = 7, h = y + depth + 2);
      translateY(10) rotateY(90) ccylinder(d = 7, h = y + depth + 2);
      translateY(-10) rotateY(90) ccylinder(d = 7, h = y + depth + 2);
      translateY(10) ccylinder(d = 7, h = y + depth + 2);
      translateY(-10) ccylinder(d = 7, h = y + depth + 2);
    }
  }
}


translateX(30) gizmo_corners();
translateX(-30) gizmo_edges();
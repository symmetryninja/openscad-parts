include <../../openscad-parts/tools.scad>

hole_fit = 20;

module placeCyls() {
  translate([18,0,0]) {
    Ry(90) {
      children(); 
    }
  }

  translate([0,18,0]) {
    Rx(90) {
      children();
    }
  }

  translate([3, 3, 18]) {
    Rz(45)
      Ry(20) {
        children();
      }
  }
}

module cutouts() {
  placeCyls() {
    ccylinder(d=12, h=hole_fit + 0.5);
  }
}

module shape1() {
  hull() {
    placeCyls() {
      ccylinder(d=18, h=hole_fit);
    }
    sphere(d=18);
  }
}

module shape2() {
  union() {
    placeCyls() {
      ccylinder(d=18, h=hole_fit);
    }
    hull() {
      translate([0.75,0.75,10])
      sphere(d=18);
      Tx(10)
      sphere(d=18);
      Ty(10)
      sphere(d=18);
      sphere(d=18);
    }
  }
}

module shape3() {
  hull() {
    placeCyls() {
      ccylinder(d=16, h=hole_fit);
    }
    sphere(d=16);
  }
}

module shape4() {
  union() {
    placeCyls() {
      ccylinder(d=16, h=hole_fit);
    }
    hull() {
      translate([0.75,0.75,10])
      sphere(d=16);
      Tx(10)
      sphere(d=16);
      Ty(10)
      sphere(d=16);
      sphere(d=16);
    }
  }
}

$fn = 80;

// shape 1 = 3mm walls - no cutouts
// translate([20, 20, 0])
// difference() {
//   shape1();
//   cutouts();
// }

// // shape 1 = 3mm walls - no cutouts
// translate([-20, 20, 0])
difference() {
  shape2();
  cutouts();
}

// shape 3 = 2mm walls - no cutouts
// translate([20, -20, 0])
// difference() {
//   shape3();
//   cutouts();
// }

// // shape 4 = 2mm walls - no cutouts
// translate([-20, -20, 0])
// difference() {
//   shape4();
//   cutouts();
// }
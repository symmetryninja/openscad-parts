e3d_volcano_height = 24;
  module e3d_volcano() {
    rotateZ(-90)
    red()
    translateY(4.5) make_bevelled_box([15, 27, 22 ], bevel = 1);

    translateZ(-11) {
      ccylinder(d = 7.2, h = 3, $fn = 6);
      translateZ(-2)
      cylinder(r1 = 1, r2 = 2, h = 2, center = true);
    }

    silver()
    translateZ(8)
    ccylinder(d = 5, h = 20);

  }
  e3d_v6_heatsync_height = 43;

  module e3d_v6_heatsync(lowpoly=false) {
    height = e3d_v6_heatsync_height;
    fin_height = 26;
    fin_d = 22.3;
    fin_z = 1.1;
    fin_gap_z = (fin_height - fin_z) / 10 - 1.1;
    
    //centre metal
    red()
    ccylinder(h=height, d = 9);

    // top rings
    difference() {
      translateZ(height/2 - 8) {
        ccylinder(d = 16, h = 16);
      }
      union() {
        translateZ(height/2 - 7)
          make_bearing(d1 = 12, d2 = 20, height = 6);
        translateZ(height/2 - 13.7)
          make_bearing(d1 = 9, d2 = 20, height = 1.4);
      }
    }

    // 11 fins
    fin_offset_Z = -(height - fin_height) / 2;
    if (lowpoly) {
      translateZ(fin_offset_Z)
      ccylinder(d=fin_d, h = fin_height);
    }
    else {
      translateZ(fin_offset_Z + 0.55)
      for (i=[0:10]) {
        translateZ((i * (fin_z + fin_gap_z)) - fin_height/2)
        ccylinder(d = fin_d, h = fin_z);
      }
    }
  }

  
  module e3d_volcano_on_6() {
    translateZ(- e3d_v6_heatsync_height/2 + 7)
      silver()
        e3d_v6_heatsync();
    translateZ(- e3d_v6_heatsync_height - 6)
      e3d_volcano();
  }


  module e3d_volcano_on_6_bracket(cutouts=true) {
    difference() {
      union() {
        hull() {
          translateX(-15)
          ccube([5, 40, 10]);
          translate([18, 16, 0]) {
            ccylinder(d = 8, h = 10);
          }
          translate([18, -16, 0]) {
            ccylinder(d = 8, h = 10);
          }
        }

      }
      if (cutouts) {
        e3d_volcano_on_6_bracket_cutouts();
      }
    }
  }

  module e3d_volcano_on_6_bracket_cutouts() {
    union() {
      // volcano
      e3d_volcano_on_6();

      //splitters
      ccube([0.01, 50, 11]);
      // translateX(-12)
      // ccube([0.01, 50, 11]);

      // screws front/back
      translate([-2, 15, 0]) {
        rotateY(90) {
          ccylinder(d = 3.5, h = 45);
          translateZ(-16.5)
          ccylinder(d = 4.8, h = 10);
        }
      }
      translate([-2, -15, 0]) {
        rotateY(90) {
          ccylinder(d = 3.5, h = 45);
          translateZ(-16.5)
          ccylinder(d = 4.8, h = 10);
        }
      }
      // screws rear

    }

  }

  // Hermera
  
  e3d_h_X = 44;
  e3d_h_Y = 80;
  e3d_h_Z = 44;

  e3d_h_offset_Y = 11;
  e3d_h_offset_Z = - 9;
  
  module e3d_volcano_on_hermera() {
    black()
      e3d_hermera();
    translateZ(e3d_h_offset_Z - 35)
      e3d_volcano();
  }

  module e3d_hermera_cutouts(screw_size = 3.2, height = 30) {
    // 34sq, 3mm in from end
    e3d_hermera_place()
    translate([-52.5, 20.75, 0])
    rotateY(90)
    make_drill_holes([34, 34, height], shaftD = screw_size);
  }

  module e3d_hermera() {
    e3d_hermera_place()
    ccube([44, 80, 44]);
  }

  module e3d_hermera_place() {
    translate([7.5, 11, e3d_h_offset_Z]) {
      children();
    }
  }
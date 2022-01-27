// This makes a clip that clamps onto t-slot with friction, useful for quick removal of things!

ffm3030_space = [29.6, 10.75, 1];
ffm3030_tab = 6.2;


module friction_fit_mount_3030_clip(depth=10) {
  difference() {
    hull() {
      makeRoundedBox(setZ(addXY(ffm3030_space, ffm3030_tab*2 -0.01, ffm3030_tab*2 -0.01), depth));
      children();
    }

    #union() {
      // rail box
      ccube(setZ(ffm3030_space, depth +1));


      // access cutout
      translate([ffm3030_tab, ffm3030_tab, 0])
      ccube(setZ(ffm3030_space, depth+1));
    }
  }

}

module friction_fit_mount_3030_camera_arms() {
  depth_arm = 9;

  // cam bolt 6mm
  // through bolt 5 x 10

  // clip
  Tx(50)
  difference() {
    union() {
      friction_fit_mount_3030_clip(depth=depth_arm) {
        Ty(-30) ccylinder(d = 30, h = depth_arm);
      }
    }
    union() {
      // bolt
      Ty(-30) ccylinder(d = 5, h = depth_arm + 1);
      // hinge spacer
      translate([0,-30, 4.9]) ccube([40, 31, depth_arm + 0.1]);
    }
  }

  // join arm
  Tx(-50)
  difference() {
    hull() {
      My() Ty(-75) ccylinder(d = 30, h = depth_arm);
    }
    union() {
      My() Ty(-75) {
          ccylinder(d = 5, h = depth_arm + 1);
          Tz(depth_arm/2) ccube([31, 31, depth_arm]);
      }
    }
  }

  // camera arm
  difference() {
    union() {
      progressive_hull() {
        Ty(-75) ccylinder(d = 30, h = depth_arm);
        Ty(75) ccylinder(d = 30, h = depth_arm);
        translate([40, 75, 0]) ccylinder(d = 30, h = depth_arm);
      }
      translate([40, 75, 1]) ccylinder(d = 20, h = 11);
    }

    union() {
      Ty(-75) {
          ccylinder(d = 5, h = depth_arm + 1);
          Tz(depth_arm/2) ccube([31, 31, depth_arm]);
      }
      translate([40, 75, 0]) ccylinder(d = 6, h = depth_arm + 1);
    }
  }
  
}
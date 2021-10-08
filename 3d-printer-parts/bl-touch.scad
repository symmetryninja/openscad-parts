
bl_screw_gap = 18;

module bl_touch_screws(h = 22, d = 3.3, z_offset = 5) {
  translate([bl_screw_gap/2, 0, z_offset]) {
    ccylinder(d = d, h = h);
  }
  translate([-bl_screw_gap/2, 0, z_offset]) {
    ccylinder(d = d, h = h);
  }
}
// mods 
  module bl_touch_out() {
    bl_touch(pin_h = 11);
  }
  module bl_touch_in() {
    bl_touch(pin_h = 6);
  }

bl_touch_full_height = 36.2;


module bl_touch(pin_h = 11) {
  full_height = bl_touch_full_height;
  difference() {
    translateZ(-full_height/2)
    union() {
      // space plate
      %translateZ(full_height/2 + 8)
      hull() {
        translateX(bl_screw_gap/2)
          ccylinder(h = 1, d = 8);
        translateX(-bl_screw_gap/2)
          ccylinder(h = 1, d = 8);
      }
      // screw plate
      plate_h = 2.3;
      white()
      translateZ(full_height/2 - plate_h/2)
        hull() {
          translateX(bl_screw_gap/2)
            ccylinder(h = plate_h, d = 8);
          ccylinder(h = plate_h, d = 12);
          translateX(-bl_screw_gap/2)
            ccylinder(h = plate_h, d = 8);
        }

      // sticker barrel
      translateZ(full_height/2 - plate_h - 4)
        ccylinder(h = 9, d = 11);

      // main barrel
      white()
      translateZ(-full_height/2 + 4 + 11)
      hull() {
        ccube([8, 10.5, 22.7]);
        translateY(-2)
        ccube([13, 6.5, 22.7]);
      }

      // funneldown
      white()
      translateZ(-full_height/2 + 2)
      hull() {
        translateZ(2.1)
        ccube([8, 10.5, .7]);
        translateZ(2.1)
        translateY(-2)
        ccube([13, 6.5, .7]);
        ccylinder(d = 7, h = 4);
      }

      // pin
      silver()
      translateZ(-pin_h/2)
      ccylinder(h = pin_h + full_height, d = 2);
    }
    #union() {
      bl_touch_screws();
    }
  }
}
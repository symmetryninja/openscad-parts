// dynamixel_mx_28.scad

dm28_horne_hub_D = 23.4899 * 2;
dm28_horne_hub_outer_D = 70;
dm28_horne_hub_space_H = 41;
dm28_horne_screw_space = 6;
dm28_horne_hub_H = dm28_horne_hub_space_H + (2 * dm28_horne_screw_space);
dm28_horne_hub_outer_angle = 55;
dm28_horne_hub_arc_R = 30;


module dm_mx_28_load_stl() {
  import("../parts/servos/MX-28T_R.stl");
}


module dm_mx_28_horne_hub_join() {
  rotate([0,0,180])
  difference() {
    hull() {
      translate([0,-5,0]) {
        cylinder(d = 42, h = dm28_horne_hub_H, center=true);
      }
      translate([0,-20,0]) {
        cube([42, 42, dm28_horne_hub_H], center=true);
      }
    }
    cylinder(h=41, d=100, center=true);
  }
}

module dm_mx_28_horne_cutouts(with_cutout=true) {
  for (i = [0:7]) {
    rotate([0,0,135 - (i * 45)]) {
      dm_mx_28_horne_bolt();
    }
  }
  cylinder(d=9, h=70, center = true);
}

module dm_mx_28_horne_bolt() {
  translate([0,8,0]) {
    cylinder(d=2, h=70, center=true);
  }
}

module dm_mx_28_chassis() {
  difference() {
    dm_mx_28_chassis_box();
    // cutout for rotorbits
    translate([0,-72,0]) {
      cylinder(d = 30, h=50, center=true);
    }
  }
}

module dm_mx_28_chassis_box() {
  hull() {
    hull() {
      cylinder(h=35.6, d=50.6, center=true);
      translate([0,-59, 0]) {
        cube([50.6, 10, 35.6], center = true);
      }
    }
    hull() {
      cylinder(h=25.6, d=53.6, center=true);
      translate([0,-62, 0]) {
        cube([53.6, 10, 25.6], center = true);
      }
    }
  }
}
module dm_mx_28_chassis_cutout(include_web=true) {
  union () {
    if (include_web) {
      //horne size slice
      
      bolt_offset = 15;
      bolt_offset_2 = 8.5;

      bolt_offset_1_Y = 4.5;
      bolt_offset_2_Y = -12.5;
      bolt_offset_4_Y = -35.8;


      //bolts - front
      translate([bolt_offset,bolt_offset_1_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }
      translate([bolt_offset, bolt_offset_2_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }
      // bolts - rear
      translate([bolt_offset_2, bolt_offset_4_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }
      //bolts - front
      translate([-bolt_offset, bolt_offset_1_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }
      translate([-bolt_offset, bolt_offset_2_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }
      // bolts - rear
      translate([-bolt_offset_2, bolt_offset_4_Y,0]) {
        cylinder(d=2.7, h=60, center = true);
      }


      translate([9,18,-1.5]) {
        screw39M3Button(withHexBlank=true, hexBlankH=12, hexBlankD=7);
      }
      translate([-9,18,-1.5]) {
        screw39M3Button(withHexBlank=true, hexBlankH=12, hexBlankD=7);
      }

      //front cable cutout
      translate([0,20,0]) {
        makeRoundedBox_rotate_90_X([35,50,10]);
      }

      translate([0,-10.4,0]) {
        cube([24.6,45.1,35.9], center=true);
      }

      //side-cutout
      translate([0,-5,1.6]) {
        makeRoundedBox_rotate_90_Y([65,20,17]);
      }
      translate([0,-15,1.6]) {
        cube([65,10,17], center = true);
      }
    }

    translate([22,-30,-4]) rotate([0,0,90]) screwM3DoubleWithHex_m3_20_button_10mhex(hexBlankBuffer = 3, hexBlankD=7, screwPurchase=3);
    translate([22,-60,-4]) rotate([0,0,90]) screwM3DoubleWithHex_m3_20_button_10mhex(hexBlankBuffer = 3, hexBlankD=7, screwPurchase=3);
    translate([-22,-60,-4]) rotate([0,0,90]) screwM3DoubleWithHex_m3_20_button_10mhex(hexBlankBuffer = 3, hexBlankD=7, screwPurchase=3);
    translate([-22,-30,-4]) rotate([0,0,90]) screwM3DoubleWithHex_m3_20_button_10mhex(hexBlankBuffer = 3, hexBlankD=7, screwPurchase=3);

    translate([0,-13.35,0]) {
      cube([36.5,51.5,30.3], center=true);
    }


    // cable tunnel
    translate([-12,-40,4.01]) {
      cube([12,30,12], center=true);
    }
    translate([-12,-55,13.01]) {
      cylinder(d = 12, h=30, center=true);
    }


  }
}

module yorick_mx28_horne_for_print(with_cutout=true) {
  difference() {
    dm_mx_28_horne_hub_join();
    dm_mx_28_horne_cutouts(with_cutout);
  }
}



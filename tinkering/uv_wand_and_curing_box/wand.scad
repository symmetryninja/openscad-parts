include <../tools/tools.scad>

/* 
  tube
    200x50x43 internal
    external +5
  head
    join on 40mm fan
      45.5mm corner to corner screws
      43*43mm shape with ~8mm curve
    join to bucky
      43*35*75
  middle
    bucky to battery & swidch box
      sw box = 40,50, 85
    tail end with removeable 
*/

uvw_box_i_X = 200;
uvw_box_i_Y = 45;
uvw_box_i_Z = 50;

uvw_box_oversize = 5;
uvw_box_oversize_D = 8;

uvw_box_X = uvw_box_i_X + uvw_box_oversize;
uvw_box_Y = uvw_box_i_Y + uvw_box_oversize;
uvw_box_Z = uvw_box_i_Z + uvw_box_oversize;

uvw_bucky_X = 75;
uvw_bucky_Y = 35;
uvw_bucky_Z = 43;

uvw_battery_X = 85;
uvw_battery_Y = 40;
uvw_battery_Z = 50;

//component_make_square_fan_40()
//component_make_square_fan_40_bolts()
//component_make_square_fan_40_tunnel()
wand_box_cutouts();

module wand_layout_components() {
  //fan
  translate([110,0,10])
  rotate([0,45,0])
  component_make_square_fan_40();

  //bucky
  translate([50,0,0])
  cube([uvw_bucky_X, uvw_bucky_Y, uvw_bucky_Z], center = true);
  
  //battery and power
  translate([-50,0,0])
  cube([uvw_battery_X, uvw_battery_Y, uvw_battery_Z], center = true);
}

module wand_box_cutouts() {
  //fan
  translate([110,0,0])
  rotate([0,90,0])
  union() {
    component_make_square_fan_40_bolts();
    component_make_square_fan_40();
    scale([1,1,2])
    component_make_square_fan_40_tunnel();
  }

  //bucky
  translate([50,0,0]) {
    translate([(uvw_bucky_X/2 - 4), 0, 0])
    cylinder(h=70, d=4, center=true);
    translate([-(uvw_bucky_X/2 - 4), 0, 0])
    cylinder(h=70, d=4, center=true);
    cube([uvw_bucky_X, uvw_bucky_Y, uvw_bucky_Z], center = true);
  }
  translate([10,0,0])
    cube([20, uvw_bucky_Y, uvw_bucky_Z], center = true);
  
  //battery and power
  translate([-40,0,0]) {
    translate([25.4, 1.27, 0]) {
      cylinder(d=5.54, h=20, $fn=6, center = true);
    }
    translate([0, -1.27, 0]) {
      cylinder(d=5.54, h=20, $fn=6, center = true);
    }
    translate([-25.4, 1.27, 0]) {
      cylinder(d=5.54, h=20, $fn=6, center = true);
    }
    difference() {
      cube([uvw_battery_X, uvw_battery_Y, uvw_battery_Z], center = true);
      cube([uvw_battery_X + 1, uvw_battery_Y + 1, 10], center = true);
    }
  }
  translate([50, 0, 0]) {
    rotate([0, 0, 0]) {
      cylinder( d=40, h = 80, center = true);
    }
  }
  translate([80, 0, 0]) {
    rotate([90, 0, 0]) {
      cylinder( d=40, h = 80, center = true);
    }
  }
  translate([45, 0, 0]) {
    rotate([90, 0, 0]) {
      cylinder( d=20, h = 80, center = true);
    }
  }
  translate([20, 0, 0]) {
    rotate([90, 0, 0]) {
      cylinder( d=20, h = 80, center = true);
    }
  }


  //cable spacers
  translate([85,20,0]) {
    cube([30,20,15], center = true);
  }

}

module wand_fan_to_bucky() {

}

  translate([-40,0,0]) {
    translate([25.4, 1.27, 0]) {
      cylinder(d=10, h=20, center = true);
    }
    translate([0, -1.27, 0]) {
      cylinder(d=10, h=20, center = true);
    }
    translate([-25.4, 1.27, 0]) {
      cylinder(d=10, h=20, center = true);
    }
  }
module wand_case_front() {

 translate([uvw_box_X/4 + 7.5, 0, 0])
 makeRoundedBox_rotate_90_Y([uvw_box_X/2 - 25, uvw_box_Y, uvw_box_Z], uvw_box_oversize_D);

}
translate([10,0,0])
  %wand_case_front();
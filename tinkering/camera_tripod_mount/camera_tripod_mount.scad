
camera_base_X = 50;
camera_base_Y = 60;
camera_base_Z = 10;

camera_base_offset_X = -10;

tube_size_D = 23.75;
tube_outer_D = tube_size_D + 12;
tube_outer_X = 22.5;
tube_outer_H = 16;

tube_base_offset_X = 0;
tube_base_offset_Y = 0;
tube_base_offset_Z = 55;

camera_bolt_L = 17.5;
camera_bolt_C = 12;
camera_bolt_space = 4.5;
camera_bolt_thread_H = camera_bolt_L - camera_bolt_space;
camera_bolt_thread_D = 6.1;
camera_bolt_head_D = 10;
camera_bolt_head_H = 4;


mount_bolt_throat = 45;
mount_bolt_D = 6.2;
rivnut_D = 9.5;
rivnut_H = 15;

overlap = 3.6;

$fn = 100;

tube_outer_join_Z = tube_base_offset_Z - tube_size_D/2;

tripod_join();

module tripod_cutout() {
  translate([0, camera_base_Y/2 - tube_outer_H/2, -tube_size_D/2]) {
    rotate([0,90,0]) {
      cylinder(d = mount_bolt_D, h = 100, center = true);
    }
    translate([-18.1,0,0])
    rotate([0,90,0]) {
      cylinder(d = rivnut_D, h = rivnut_H, center = true);
    }
  }

  translate([0, camera_base_Y/2 - tube_outer_H/2, -15]) {
    cube([1.5, tube_size_D + 1, tube_size_D], center = true);
  }

  rotate([90,0,0]) {
    cylinder(d = tube_size_D, h = 100, center = true);
  }

  translate([28,0,20]) {
    rotate([90,0,0]) {
      cylinder(d = 30, h = 100, center = true);
    }
  }

  translate([-28,0,20]) {
    rotate([90,0,0]) {
      cylinder(d = 30, h = 100, center = true);
    }
  }

  translate([0,0,tube_outer_join_Z - camera_base_Z/2]) {
    make_camera_bolt();
  }
}

module tripod_camera_join() {
  // couple base
  translate([0, camera_base_Y/2 - tube_outer_H/2, 0]) {
    hull() {
      rotate([90,0,0]) {
        cylinder(d = tube_outer_D, h = tube_outer_H, center = true);
      }
      translate([0,0,tube_outer_join_Z]) {
        cube([camera_base_X - 6, tube_outer_H, camera_base_Z], center = true);
      }
    }
    translate([-3,0,-tube_size_D/2]) {
      makeRoundedBox_rotate_90_X([mount_bolt_throat, tube_outer_H, 15], center = true);
    }
  }
}

module tripod_camera_base() {
  // platform
  translate([0,0,tube_outer_join_Z]) {
    makeRoundedBox([camera_base_X,camera_base_Y,camera_base_Z]);
  }
}

module tripod_join() {
  difference() {
    union() {
      tripod_camera_base();
      tripod_camera_join();
    }
    tripod_cutout();
  }
}

module make_camera_bolt() {
  translate([0,-10, - camera_bolt_head_H/2]) {
    cylinder(d = camera_bolt_head_D, h = camera_bolt_head_H, center = true);
  }
  translate([0,-10, camera_bolt_thread_H/2 + camera_bolt_space]) {
    cylinder(d = camera_bolt_thread_D + 2, h = camera_bolt_thread_H, center = true);
  }
  translate([0,-10, camera_bolt_thread_H/2 - 1]) {
    cylinder(d = camera_bolt_thread_D, h = camera_bolt_thread_H, center = true);
  }

}


module makeRoundedBox_rotate_90_X(size=[50,50,50], d=6) {
  newsize_X = size[0];
  newsize_Y = size[2];
  newsize_Z = size[1];

  rotate([90, 0, 0])
    makeRoundedBox(size=[newsize_X,newsize_Y,newsize_Z], d=d);
}

module makeRoundedBox_rotate_90_Y(size=[50,50,50], d=6) {
  newsize_X = size[2];
  newsize_Y = size[1];
  newsize_Z = size[0];

  rotate([0, 90, 0])
    makeRoundedBox(size=[newsize_X,newsize_Y,newsize_Z], d=d);
}

module makeRoundedBox(size=[50,50,50], d=6) {
  //make 4 cylinders
  render() {
    hull() {
      makeRoundedBoxShafts(size=size, d=d, shaftD=d);
    }
  }
}

module makeRoundedBoxShafts(size=[50,50,50], d=6, shaftD=6, fn=$fn) {
  //make 4 cylinders
  positionOffsetX = (size[0]-d) /2;
  positionOffsetY = (size[1]-d) /2;
  render() {
    translate([-positionOffsetX, -positionOffsetY, 0 ])
      cylinder(d=shaftD, h=size[2], center=true, $fn=fn);
    translate([-positionOffsetX, positionOffsetY, 0 ])
      cylinder(d=shaftD, h=size[2], center=true, $fn=fn);
    translate([positionOffsetX, -positionOffsetY, 0 ])
      cylinder(d=shaftD, h=size[2], center=true, $fn=fn);
    translate([positionOffsetX, positionOffsetY, 0 ])
      cylinder(d=shaftD, h=size[2], center=true, $fn=fn);
  }
}
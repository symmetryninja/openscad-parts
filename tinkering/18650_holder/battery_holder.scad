batteries = [7, 7];

battery_D = 19;
battery_H = 67;

spacer = 1.5;

overall_size_X = (battery_D + spacer) * batteries[0];
overall_size_Y = (battery_D + spacer) * batteries[1];

case_size_Z = 20;

$fn = 100;


module battery_cutouts(oversize_d = 0) {
    for (row = [1 : batteries[0]]) {
      for (col = [1 : batteries[1]]) {
        offset_X = overall_size_X/2 - (row * (spacer + battery_D)) + (battery_D + spacer)/2;
        offset_Y = overall_size_Y/2 - (col * (spacer + battery_D)) + (battery_D + spacer)/2;
        translate([offset_X, offset_Y, 0]) {
          cylinder(h=battery_H, d=battery_D + oversize_d, center=true);
        }
      }
    }
}

case_part();
    // battery_cutouts();

module case_part() {
  difference() {
    hull() {
      translate([case_size_X/2, case_size_Y/2, case_offset_Z]) {
        cylinder(h=case_size_Z, d=battery_D + 5, center=true);
      }
      translate([case_size_X/2, -case_size_Y/2, case_offset_Z]) {
        cylinder(h=case_size_Z, d=battery_D + 5, center=true);
      }
      translate([-case_size_X/2, -case_size_Y/2, case_offset_Z]) {
        cylinder(h=case_size_Z, d=battery_D + 5, center=true);
      }
      translate([-case_size_X/2, case_size_Y/2, case_offset_Z]) {
        cylinder(h=case_size_Z, d=battery_D + 5, center=true);
      }
    }
    battery_cutouts();
  }
}
case_size_X = overall_size_X - (spacer + battery_D);
case_size_Y = overall_size_Y - (spacer + battery_D);
case_offset_Z = -(battery_H/2 - (case_size_Z/2 - 2));

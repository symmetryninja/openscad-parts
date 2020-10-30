include <sn_tools.scad>

/********************************************
*********** Kelvin cell
********************************************/

// Kelvin cell unit cell

  // kelvin_pod(detail = 10, bar_L = 5, bar_D = 1);

  // detail = 15;
  // bar_D = 2;
  // bar_L = 8;
  // kelvin_pod_unit(detail, bar_D, bar_L);

  module kelvin_pod_unit(detail, bar_D, bar_L) {
    offset = sqrt(sq(bar_L) - sq(bar_L/2));

    progressive_hull() {
      kelvin_point(sequence = 0, detail = detail, bar_D = bar_D, offset = offset);
      kelvin_point(sequence = 1, detail = detail, bar_D = bar_D, offset = offset);
      kelvin_point(sequence = 2, detail = detail, bar_D = bar_D, offset = offset);
      kelvin_point(sequence = 3, detail = detail, bar_D = bar_D, offset = offset);
      kelvin_point(sequence = 4, detail = detail, bar_D = bar_D, offset = offset);
      kelvin_point(sequence = 5, detail = detail, bar_D = bar_D, offset = offset);
      kelvin_point(sequence = 0, detail = detail, bar_D = bar_D, offset = offset);
    }
  }

  module kelvin_point(sequence, detail, bar_D, offset) {
    rotate([0,0,sequence * 60]) {
      translate([0, offset, 0]) {
        csphere($fn = detail, d = bar_D);
      }
    }
  }

  module kelvin_pod_4(detail, bar_D, bar_L) {
    rotate([0,0,0]) {
      kelvin_pod_unit_in_place(detail = detail, bar_D = bar_D, bar_L = bar_L);
    }
    rotate([0,0,90]) {
      kelvin_pod_unit_in_place(detail = detail, bar_D = bar_D, bar_L = bar_L);
    }
    rotate([0,0,180]) {
      kelvin_pod_unit_in_place(detail = detail, bar_D = bar_D, bar_L = bar_L);
    }
    rotate([0,0,270]) {
      kelvin_pod_unit_in_place(detail = detail, bar_D = bar_D, bar_L = bar_L);
    }
  }

  module kelvin_pod_unit_in_place(detail, bar_D, bar_L) {
    offset = sqrt(sq(bar_L) - sq(bar_L/2));
    translate([-offset, 0, 0]) {
      rotate([0,55,0]) {
        kelvin_pod_unit(detail = detail, bar_D = bar_D, bar_L = bar_L);
      }
    }
  }

  module kelvin_pod(detail = 15, bar_D = 2, bar_L = 8) {
    offset = sin(55) * sin(60) * sqrt(sq(bar_L) - sq(bar_L/2));
    translate([0,0,-(offset)]) {
      kelvin_pod_4(detail = detail, bar_D = bar_D, bar_L = bar_L);
    }
    translate([0,0,(offset)]) {
      mirror([0,0,1]) {
        kelvin_pod_4(detail = detail, bar_D = bar_D, bar_L = bar_L);
      }
    }
  }

  module build_net(net_X, net_Y, net_Z, detail = 30, bar_D = 2, bar_L = 8) {
    // TODO: make this go
  }

/********************************************
*********** Hex Cutout grid
********************************************/
  //todo: create by width

  module pattern_hex_plate(rows, columns, cell_interior, walls, height) {
    for (i = [0 : rows - 1]) {
      linear_extrude(height=height) {
        for (j = [0 : (columns - 1 - i%2)]) {
          translate([(j + (i % 2) /2) * (cell_interior + walls),
                    (cell_interior + walls) * i * sqrt(3) / 2])
          rotate([0,0,30])
          difference() {
            circle(r=(cell_interior + 2 * walls)/sqrt(3),$fn=6); // comment out to get inverse
            circle(r=cell_interior/sqrt(3),$fn=6);
          }
        }
      }
    }
  }




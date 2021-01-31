/*
 * Resizeable cube
 * ----------------
 * Set x and y size and number of devisions to tweak it
 */


/******* modifiers *******/

  step_size_X = 10;
  step_size_Y = 5;
  divisions_X = 19;
  divisions_Y = 6;

/***** stop editting *****/
  make_test_cube();

  module make_test_cube() {
    rotate([180,0,0]) {
      translate([0,-25,0]) {
        make_test_cube_actual(divisions_Y < divisions_X?divisions_Y:divisions_X);
      }
    }
  }

  module make_test_cube_actual(z_steps) {
    zstep = 1;
    union()
    // for (zstep = [1: z_steps], ystep = [1: divisions_Y], xstep = [1: divisions_X]) {
    for (xstep = [1: 1 :divisions_X]) {
      translate([0, xstep * step_size_Y, 0]) {
        make_shape(xstep);
      }
    }

  }
  module make_shape(multiplier) {
    difference() {
      cube([multiplier * step_size_X, step_size_Y, step_size_Y], center = true);
      translate([-(multiplier * step_size_X)/2, 0, 0]) {
        for (offset = [1:multiplier * 2]) {
          translate([(offset - 0.5)  * (step_size_X/2), 0, 0]) {
            cube([step_size_X/2 - 1.5, step_size_Y - 1, step_size_Y + 2], center = true);
          }
        }
      }
    }

  }



/** 
  3d printer parameter test
  @param min (10) - the minimum length (mm)
  @param max (100) - the maximum length (mm)
  @param steps (9) - number of steps to break up between min/max
  @param depth (3) - the height of the printable object (mm)
*/
module test_3d_print_graded_xy(min = 10, max = 100, steps=9, depth=3) {
  
  width = (max - min) / steps;

  for (step = [0 : steps - 1]) {
    space = (width * step) + min;
    T([-step*width/2,step*width, 0])
    ccube([space, width + 0.001, depth]);

  }
}
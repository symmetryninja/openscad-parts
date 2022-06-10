include <sn_tools.scad>

/* camera frame for 3030 extrusion
clip_part - connects to the printer
arm_join - linkages
*/

module roboplinth() {
  total_H = 100;
  
  // top
  // 55 wide
  // 5 either side
  // 70 long
  difference() {
    union() {
      translateZ(total_H/2 -10)
      hull() {
        Tz(8)
        ccube([50, 70, 10]);
        Tz(-20)
        union() {
          ccube([6,40, 10]);
          // ccube([30,8, 10]);
        }
      }
      
      // mid
      ccube([6,40, total_H - 10]);
      ccube([30,6, total_H - 10]);

      // bottom
      base_size=[70, 70, 5];
      translateZ(-total_H/2 + 6.5)
      Rz(45)
      hull() {
        ccube(base_size);
        Tz(2.5)
        ccube(addXYZ(base_size, -5, -5, 3));
      }
    }
    union() {
      translateZ(total_H/2 -10) {
        Tz(10) ccube([40, 80, 10]);
        hull() {
          Tz(5) ccube([28, 80, 10]);
          Tz(-2) ccube([10, 80, 20]);
        }
      }
    }
  }

}

roboplinth();
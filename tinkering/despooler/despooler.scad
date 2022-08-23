include <sn_tools.scad>

if (is_undef(batch_rendering)) {
  $fn=60;
  despooler();

}

/** globals **/
offset = 10;

outer_D = 20;
outer_Z = 70 + offset;
inner_D = 9;
inner_Z = outer_Z + 1;
bracket_X = 43;

module despooler() {
  %ccylinder(d = 65, h = outer_Z - offset);
  Tz(offset/2)
  D() {
    U() {

      // outer
      ccylinder(d = outer_D, h = outer_Z);

      // bracket
      T([bracket_X/2, 0, (outer_Z - offset)/2]) {
        ccube([bracket_X, 15, 10]);
      }
      T([bracket_X, 0, (40 - offset)/2]) {
        ccube([15, 15, 50]);
      }
    }
    #U() {
      // inner
      ccylinder(d = inner_D, h = inner_Z);

      // drill holes
      H() {
        Tx(bracket_X) Rx(90) ccylinder(d=4, h = 16);
        translateZ(30) Tx(bracket_X) Rx(90) ccylinder(d=4, h = 16);
      }
    }
  }
}

include <sn_tools.scad>

if (is_undef(batch_rendering)) {
  $fn=60;
  lightbracket();

}

/** globals **/

inner_D = 34;
inner_Z = 50;
outer_D = 38;
outer_Z = 90;
bracket_X = 280;
bracket_Y= 25;
bracket_Z = 20;

inner_H = inner_Z + outer_Z + bracket_Z;
outer_H = outer_Z + bracket_Z;

blockCutout_X = 5;
blockCutout_Y = outer_D + 2;
blockCutout_Z = inner_Z + 10;


module lightbracket() {
  D() {
    U() {
      // inner
      Tz(-inner_H/2)
      ccylinder(d = inner_D, h = inner_H);

      // outer
      Tz(-outer_H/2)
      ccylinder(d = outer_D, h = outer_H);

      // bracket
      Tz(-bracket_Z/2) H() Mx() Tx(bracket_X/2 - bracket_Y/2) ccylinder(d = bracket_Y, h = bracket_Z);
    }
    #U() {
      // drill holes
      Tz(-bracket_Z/2)
      Mx() Tx(bracket_X/2 - bracket_Y/2) {
        ccylinder(d=3, h=bracket_Z + 2);
      }
      Tz(-inner_H - 0.1 + blockCutout_Z/2) ccube([blockCutout_X, blockCutout_Y, blockCutout_Z]);
    }
  }
}
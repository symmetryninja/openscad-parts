/** Includes **/
include <sn_tools.scad>

/** Scripting stuff **/
  batch_rendering = false;
  if (!batch_rendering) render_workspace();

  module render_workspace() {
    $fn = 60;
    /* hacking */
    /* for print */
    /* visuals */
    ptfe_cutter_disc();
    ptfe_cutter_box();
  }

/** globals **/
/** visual-only modules **/
/** actual modules **/
  module ptfe_cutter_disc() {
    difference() {
      union() {
        ccylinder(d=20, h = 40);
        Tx(5)
        ccube([20,10,40]);
      }
      #union() {
        ccylinder(d=4, h = 41);
        Tx(7.5)
        ccube([15.1,3,41]);
        Mz() {
          translate([12,0,15])
          Rx(90)
          ccylinder(d = 3, h=30);
        }
      }
    }
    
  }

  module ptfe_cutter_box() {
    
  }



/** Includes **/
include <sn_tools.scad>

/** Scripting stuff **/
  batch_rendering = false;
  if (!batch_rendering) render_workspace();

  module render_workspace() {
  $fn = 60;
  /* hacking */
  tb_castor_spacer();
  /* for print */
  /* visuals */
  }

/** globals **/
/** visual-only modules **/
/** actual modules **/

module tb_castor_spacer() {
  difference() {
    union() {
      translateZ(-3.7)
      makeRoundedBox([50,32,3]);
      makeRoundedBox([34, 40, 10.4]);
    }
    union() {

      // waffle panel
      make_drill_holes(size=[40,22,15], shaftD=3);
      // castor
      make_drill_holes(size=[24,30,15], shaftD=3.8);

      // cutouts
      makeRoundedBox([15,33,15]);
      makeRoundedBox([27,20,15]);

      
    }
  }

}
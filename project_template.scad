/** Includes **/
// this example has the decorators for the python-threaded-openscad project:
// https://github.com/symmetryninja/python-threaded-openscad

include <sn_tools.scad>

//render.quality [85]
//render.number_of_threads [36]

/** Scripting stuff **/
  if (is_undef(batch_rendering)) {
    $fn = 60;
    /* hacking */
    /* for print */
    /* visuals */
  }

/** globals **/
/** visual-only modules **/
/** actual modules **/
module mycool_model_for_stl() { //render.model.stl
}
module mycool_model_for_svg() { //render.model.svg
}
module mycool_model_for_dxf() { //render.model.dxf
}
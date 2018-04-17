include <overrides.scad>
include <curves.scad>
include <bezier.scad>
include <graph.scad>
include <shapes.scad>

include <screws.scad>
include <threads.scad>
include <nuts.scad>

include <batteries.scad>
include <rotorbits.scad>
include <graphics.scad>

include <Springs.scad>
include <clips.scad>
include <quick_colours.scad>

/* components */
include <components/components.scad>
include <components/protoboards.scad>
include <components/tft.scad>
include <components/power_plugs.scad>

function sq(value_to_square) = value_to_square * value_to_square;

module make_screw_spacer(height = 10, outer_D = 6, inner_D = 3) {
  difference() {
    ccylinder(d = outer_D, h = height);
    ccylinder(d = inner_D, h = height + 1);
  }
}
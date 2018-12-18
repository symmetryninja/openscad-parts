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
include <shafts.scad>
include <quick_colours.scad>
include <publicDomainGearV1.1.scad>

/* components */
include <components/components.scad>
include <components/protoboards.scad>
include <components/tft98.scad>
include <components/tft280.scad>
include <components/power_plugs.scad>

function sq(value_to_square) = value_to_square * value_to_square;

module make_screw_spacer(height = 10, outer_D = 6, inner_D = 3) {
  difference() {
    ccylinder(d = outer_D, h = height);
    ccylinder(d = inner_D, h = height + 1);
  }
}

function math_constant_E() = 2.7182818284590452353602875;
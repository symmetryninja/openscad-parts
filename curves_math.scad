
/**
 * Calculating the Sagitta of an Arc
 * refs: http://liutaiomottola.com/formulae/sag.htm
 * this is modified to calculate the sag from a radius and angle of slice, aka how big is the sag in a pie of this size
 */

//get the Sagitta size from a slice angle and radius
function calc_arc_sag_from_slice(radius, slice) = calc_arc_sag(radius=radius, length = (sin(slice/2) * radius));

//get the Sagitta size from a slice length (halved) and radius
function calc_arc_sag(radius, length) = radius - sqrt((radius * radius) - (length * length));

//get the arc slice angle from a length and radius **REM use 1/2 the overall length!
function calc_arc_slice_from_length(radius, length) = asin(length/radius);
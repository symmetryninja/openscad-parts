//=====================================
// This is public Domain Code
// Contributed by: William A Adams
//=====================================
joinfactor = 0.125;

gSteps = 100;
gHeight = 4;

//======================================
// Demos
//======================================
//BezCubicFilletColored( [[0, 15],[5,5],[10,5],[15,15]], [7.5,12], gSteps, gHeight, 
//	[[1,0,0],[1,1,0],[0,1,1],[0,0,1]]);
//BezCubicFilletColored( [[0, 15],[5,5],[10,5],[15,15]], [7.5,18], gSteps, gHeight, 
//	[[1,0,0],[0,1,0],[0,1,0],[0,0,1]]);
//DrawCubicControlPoints([[0, 15],[5,5],[10,5],[15,15]], [7.5,18], gHeight, $fn=12);

//BezCubicFillet( [[0, 5],[5,15],[10,3],[15,10]], [7.5,0], gSteps, gHeight);
//DrawCubicControlPoints( [[0, 5],[5,15],[10,3],[15,10]], [7.5,0], gHeight, $fn=12);

// BezCubicRibbon([[0,15],[6,13],[3,5],[15,0]], [[0,13],[6,11],[3,2],[13,0]]);

//=======================================
// Functions
// These are the 4 blending functions for a cubic bezier curve
//=======================================
// Bernstein Polynomials
function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

// Calculate a singe point along a cubic bezier curve
function PointOnBezCubic2D(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]];

function PointOnBezCubic3D(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1],
	BEZ03(u)*p0[2]+BEZ13(u)*p1[2]+BEZ23(u)*p2[2]+BEZ33(u)*p3[2]];

//=======================================
// Modules
//=======================================
// This function will extrude a bezier solid from a bezier curve
// It is a straight up prism
// c - ControlPoints
//
module BezCubicFillet(c, focalPoint, steps=gSteps, height=gHeight)
{
	for(step = [steps:1])
	{
		linear_extrude(height = height, convexity = 10) 
		polygon(
			points=[
				focalPoint,
				PointOnBezCubic2D(c[0], c[1], c[2],c[3], step/steps),
				PointOnBezCubic2D(c[0], c[1], c[2],c[3], (step-1)/steps)],
			paths=[[0,1,2,0]]
		);
	}
}

module BezCubicFilletColored(c, focalPoint, steps=gSteps, height=gHeight, colors)
{
	for(step = [steps:1])
	{
		color(PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], step/steps))
		linear_extrude(height = height, convexity = 10) 
		polygon(
			points=[
				focalPoint,
				PointOnBezCubic2D(c[0], c[1], c[2],c[3], step/steps),
				PointOnBezCubic2D(c[0], c[1], c[2],c[3], (step-1)/steps)],
			paths=[[0,1,2,0]]
		);
	}
}


module BezCubicRibbon(c1, c2, steps=gSteps, height=gHeight, colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]])
{
  translate([0,0,-height/2])
	for (step=[0:steps-1])
	{
		color(PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], step/steps))
		linear_extrude(height = height, convexity = 10) 
		polygon(
			points=[
				PointOnBezCubic2D(c1[0], c1[1], c1[2],c1[3], step/steps),
				PointOnBezCubic2D(c2[0], c2[1], c2[2],c2[3], (step)/steps),
				PointOnBezCubic2D(c2[0], c2[1], c2[2],c2[3], (step+1)/steps),
				PointOnBezCubic2D(c1[0], c1[1], c1[2],c1[3], (step+1)/steps)],
			paths=[[0,1,2,3]]
		);

	}
}

//==============================================
// Test functions
//
// These test functions help demonstrate that the core blending
// functions actually work correctly.
//==============================================
//PlotBEZ0(100);
//PlotBEZ1(100);
//PlotBEZ2(100);
//PlotBEZ3(100);
//PlotBez4Blending();

module DrawCubicControlPoints(c, focalPoint, height)
{
	// Draw control points
	// Start point
	translate(c[0])
	color([1,0,0])
	cylinder(r=0.5, h=height+joinfactor);

	// Controll point 1
	translate(c[1])
	color([0,0,0])
	cylinder(r=0.5, h=height+joinfactor);

	// Control point 2
	translate(c[2])
	color([0,0,0])
	cylinder(r=0.5, h=height+joinfactor);

	// End Point
	translate(c[3])
	color([0,0,1])
	cylinder(r=0.5, h=height+joinfactor);


	// Draw the focal point
	translate(focalPoint)
	color([0,1,0])
	cylinder(r=0.5, h=height+joinfactor);
}

module PlotBEZ0(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ03(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ1(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ13(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ2(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ23(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ3(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ33(step/steps)*cubeHeight]);
	}	
}

module PlotBez4Blending()
{
	sizing = 100;

	translate([0, 0, sizing + 10])
	PlotBEZ0(100);

	translate([sizing+10, 0, sizing + 10])
	PlotBEZ1(100);

	translate([0, 0, 0])
	PlotBEZ2(100);

	translate([sizing+10, 0, 0])
	PlotBEZ3(100);
}

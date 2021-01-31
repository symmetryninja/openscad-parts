// Set some render quality 
// * drop this to 20 while you're designing so its quick to render changes
$fn = 50;

overallHeight = 50;
innerD = 8.15;
padding = 3;

bladeLength = 28;
bladeThickness = 10;

outerD = innerD + padding;
outerBoxX = outerD + 1.5;
outerBoxY = 5;

separatorThickness = 3;
separatorH = overallHeight - bladeLength - padding;

//flip and move the model for printing
translate([0, 0, overallHeight])
rotate([0, 180, 0])
difference() {
  //outer shape
  union() {
    //handle grip
    cylinder(h=separatorH, d=outerD);

    //outer box
    translate([0, 0, overallHeight/2])
      cube([outerBoxX, outerBoxY, overallHeight], center=true);

    //sphere for niceness + blade grip
    translate([0, 0, separatorH])
      sphere(d=outerD);
  }
  //inner shape cutout
  union() {
    //blade space
    translate([0, 0, (overallHeight - padding)/2]) 
      cube([bladeThickness, padding, overallHeight - padding], center=true);

    //bottom box
    translate([0, 0, separatorH/2 - 0.1]) 
      cube([outerBoxX + 0.1, padding, separatorH + 0.1], center=true);
    //bottom box cutout curve cylinder
    translate([0, 0, separatorH ]) 
      rotate([0, 90, 0])
        cylinder(h=separatorH, d=separatorThickness, center=true);

    //internal cylinder for scalpel shaft
    translate([0, 0, separatorH/2 - 0.1], center=true) 
      cylinder(h=separatorH + 0.1, d=innerD, center=true);
    //middle sphere for niceness + blade grip
    translate([0, 0, separatorH], center=true) 
      sphere(d=innerD);
  }
}

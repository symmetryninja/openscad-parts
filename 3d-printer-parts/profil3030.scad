
module tslot_extrude(layer, height) {
  union(){
    linear_extrude(height = height, center = true, convexity = 10) {
      import(file = "30mmslottake2.dxf", layer = layer);
    }
  }
}

module tslot(h=10){
  translate([-15,-15,0]) tslot_extrude(layer = "tslotrounded", height = h);
}
// tslot();

module tslotmodel2(h=10){
  translate([-15,-15,0]) tslot_extrude(layer = "tslotrounded2", height = h);
}
// tslotmodel2();

module nutholder2(m=6,h=4.5){
for(i=[0:2]){
rotate([0,0,i* 360/6])cube([m+4,5.7,h],true);
}
cylinder(h=h*2,r=m/2,center=true);
}
// nutholder2();

module nutholder(m=6,h=4.5){
for(i=[0:2]){
rotate([0,0,i* 360/6])cube([m+4.3,6,h],true);
}
cylinder(h=h*2,r=m/2,center=true);
}
// nutholder();

module nutplace(h=10){
  translate([0,0,h/2]) tslot_extrude(layer = "nutplace", height = h);
}
//nutplace();

module nut1(h=10){
  translate([-15,0,0]) tslot_extrude(layer = "nut1", height = h);
}
//nut1();

module nut2(h=10){
  translate([0,0,h/2]) tslot_extrude(layer = "nut2", height = h);
}
// nut2();

module nut3(h=10){
  translate([0,0,h/2]) tslot_extrude(layer = "nut3", height = h);
}
// nut3();

module nut4(h=10){
  translate([0,0,0]) tslot_extrude(layer = "nut4", height = h);
}
// nut4();

module crossnut(x,y){
translate([0,0,0])nut4(h=y);
translate([0,0,0])rotate([0,90,180])nut4(h=x);
}

module hollytslot(h=10){
union(){
difference(){
 tslotmodel2(h);
union(){
//holes
cylinder(h=h+4,r1=3.5,r2=3.5,center=true,$fn=120); //center
for(i=[0:3]){
rotate([0,0,i*90])translate([15-3.35,15-3.35,0])cylinder(h=h+4,r1=2.2,r2=2.2,center=true,$fn=120);
}
////bars
rotate([0,0,45])cube([11,1.3,h+4],true);
rotate([0,0,-45])cube([11,1.3,h+4],true);
}
}
}
}
// hollytslot();

module stopper(h=20,stop=10){
difference(){
cube([36,36,h],true);
translate([0,0,h-stop])scale([1.01,1.01,1])tslot(h);
}
}
// stopper();


module telescope(h=5){
translate([0,-15,-h/2])union(){
translate([-15,0,0])nut2(h);
translate([0,30,0])rotate([0,0,180])translate([-15,0,0])nut2(h);
translate([15,15,0])rotate([0,0,90])translate([-15,0,0])nut2(h);
translate([-15,15,0])rotate([0,0,-90])translate([-15,0,0])nut2(h);
translate([0,30/2,h/2])difference(){
cube([35,35,h],true);
cube([30.3,30.3,h+2],true);
}
}
}
//telescope();


module corner90(){
translate([0,0,10])rotate([180,0,0])union(){
difference(){
rotate([45,0,0])translate([0,15,-15])union(){
translate([-15,0,0])nut2(35);
translate([0,5,30])rotate([90,0,0])translate([-15,0,0])nut2(35);
translate([0,-15,15])rotate([0,0,-90])cube([30,5,30],true);
}
union(){
translate([0,0,35])cube([60,60,30],true);
translate([0,0,-15])cube([60,60,30],true);
}
}
}
}
// corner90();

	
module tap(){
translate([0,0,1.5])union(){
intersection(){
cube([30,30,30],true);
union(){
difference(){
minkowski(){
cube([26,26,3],true);
cylinder(h=3,r=2);
}
translate([0,0,3.5])cube([28,28,4],true);
}
difference(){
cylinder(h=11,r=3.2);
cylinder(h=12,r=2.5);
}
translate([0,0,1.5])cube([9,4.1,3],true);
translate([0,0,1.5])cube([4.1,9,3],true);

translate([0,-15,4])cube([8.2,4,8],true);
translate([0,15,4])cube([8.2,4,8],true);
//translate([15,0,0])rotate([0,0,90])translate([-15,0,0])nut2(8);
//translate([-15,0,0])rotate([0,0,-90])translate([-15,0,0])nut2(8);
}
}
}
}
// tap();

module elbow(){
  intersection(){
    translate([-15,-15,0])cylinder(h=32,r=32,center=true);
    cube([30,30,30],true);
  }
  translate([-15,0,0])fourslots();
  translate([0,-15,0])rotate([0,0,-90])fourslots();
}
// elbow();

module fourslots(){
translate([0,-15,-15])union(){
translate([0,0,15])rotate([90,90,90])nut1();
translate([0,30,15])rotate([-90,90,90])nut1();
translate([0,15,30])rotate([-90,0,90])nut1();
translate([0,15,0])rotate([-90,180,90])nut1();
}
}
module nutinsert(){
  rotate([-90,0,0]){
    difference(){
      nutplace(20);
      translate([0,-0.57,7])rotate([90,0,0])nutholder();
    }
  }
}
// nutinsert();

module boltm8(mm=16){
cylinder(h=mm,r=4);
translate([0,0,-6])cylinder(h=6,r=6.5);
}
// boltm8(mm=16);

module elbow8m3030(){
difference(){
union(){
	
	difference(){
		elbow();
		union(){
			translate([-2,0,0])rotate([0,-90,0])boltm8(mm=16);
			translate([0,-2,0])rotate([90,0,0])boltm8(mm=16);
			translate([37,0,0])rotate([0,-90,0])cylinder(h=35,r=8.2);
			translate([0,37,0])rotate([90,0,0])cylinder(h=35,r=8.2);
		}
	}
}
//translate([0,0,-10])cube([90,90,10],true);
}
}
//elbow8m3030();

module demo(){
translate([0,0,5])tslot(10); //1 cm tall
translate([40,0,5])hollytslot(10); //1 cm tall
translate([0,40,0])tap(); 
translate([35,35,2])nutinsert();
translate([-40,0,5])hollytslot(10);
translate([-40,30,5])hollytslot(10);
}
//demo();
module xyztslot(){
difference(){
union(){
cube(30,true);
translate([15,0,0])fourslots();
translate([0,0,15])rotate([0,90,0])fourslots();
translate([0,-15,0])rotate([0,0,90])fourslots();
}
union(){
cylinder(h=40,r=3.1,center=true);
translate([0,0,-2])cylinder(h=30,r=8,center=true);
rotate([0,90,0])cylinder(h=40,r=3.1,center=true);
translate([-2,0,0])rotate([0,90,0])cylinder(h=30,r=8,center=true);
rotate([90,0,0])cylinder(h=40,r=3.1,center=true);
translate([0,2,0])rotate([90,0,0])cylinder(h=30,r=8,center=true);
}
}
}
//xyztslot();


module support908(){
translate([0,-11,1])union(){
scale([1,.2,.2])translate([14,50,-1])rotate([90,0,-90])tria(28);
scale([1,.4,.4])translate([0,25,-1])rotate([90,0,-90])tria();
translate([-12,10,-1])rotate([90,0,-90])tria();
translate([14,10,-1])rotate([90,0,-90])tria();
translate([0,-7,0])difference(){cube([28,35,2],true);union(){
	translate([0,4,0])cylinder(h=6,r=3,center=true);
		translate([0,-10,0])cylinder(h=6,r=3,center=true);
	}
}

translate([0,10,11.5])rotate([90,0,0])difference(){cube([28,25,2],true);union(){
translate([7,2.5,0])cylinder(h=6,r=3,center=true);
translate([-7,2.5,0])cylinder(h=6,r=3,center=true);}
}
}
}
//support908();

module tria(h=2){
  linear_extrude(height=h)polygon(points=[[0,0],[0,20],[20,0]], paths=[[0,1,2]]);
}




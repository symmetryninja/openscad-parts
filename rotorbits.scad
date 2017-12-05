module rotor_shaft(length=100, includeScrews =true) {
  //make the shaft
  difference() {
    cube([10,length,10], center=true);
    if (includeScrews) {
      rotor_screws(length=length);
    }
  }
}

module rotor_screws(length=100, height=20) {
  union() {
    translate([0, -length/2]) {
      for (a =[5 : 10 : length - 5]) {
        translate([0, a, 0])
          cylinder(d=2.7, h=height, center=true);
      }
      rotate([0, 90, 0]) {
        for (b =[5 : 10 : length - 5]) {
          translate([0, b, 0])
            cylinder(d=2.7, h=height, center=true);
        }
      }
    }
  }
}

module makeRotorScrewsFor100() {
  union() {
    translate([0, -100/2]) {
      for (a =[5 : 20 : 50]) {
        translate([0, a, 0])
          cylinder(d=2.7, h=45, center=true);
      }
      for (b =[55 : 20 : 100]) {
        translate([0, b, 0])
          cylinder(d=2.7, h=45, center=true);
      }
    }
  }
}

module makeRotorScrewsFor150() {
  union() {
    translate([0, -150/2]) {
      for (a =[5 : 10 : 145]) {
        translate([0, a, 0])
          cylinder(d=2.7, h=45, center=true);
      }
    }
  }
}
module makeRotorScrewsFor200() {
  union() {
    translate([0, -200/2]) {
      for (a =[5 : 10 : 195]) {
        translate([0, a, 0])
          cylinder(d=2.7, h=45, center=true);
      }
    }
  }
}
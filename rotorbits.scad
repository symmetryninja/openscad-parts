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
  make_rotor_screws_for(size=100);
}

module makeRotorScrewsFor150() {
  make_rotor_screws_for(size=150);
}

module makeRotorScrewsFor200() {
  make_rotor_screws_for(size=200);
}

module make_rotor_screws_for(size=250) {
  union() {
    translate([0, -size/2]) {
      for (a =[5 : 10 : size-5]) {
        translate([0, a, 0]) {
          cylinder(d=2.7, h=45, center=true);
          // rotate([0,90,0]) {
          //   cylinder(d=2.7, h=45, center=true);
          // }
        }
      }
    }
  }
}
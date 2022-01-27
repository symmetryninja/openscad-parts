module scraper_single() {
  difference() {
    union() {
      hull() {
        translate([-100, 100, 0]) makeRoundedBox([100, 100, 3]);
        ccylinder(h=3, d = 200);
      }
    }
    #union() {
      translate([100, 100, 0]) ccylinder(h=4, d = 300);
    }
  }
}
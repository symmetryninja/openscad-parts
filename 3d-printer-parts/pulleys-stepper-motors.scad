
module stepper_nema_17(with_10mm=false) {
  if (with_10mm) {
    translateZ(35)
    silver() pulley_gt2_wheel();
  }
  translateZ(10)
  silver()
  translateZ(1.5)
  ccylinder(d = 5, h = 63);
  black() {
    translateZ(15) makeRoundedBox([40, 40, 10]);
    makeRoundedBox([37, 37, 20]);
    translateZ(-15) makeRoundedBox([40, 40, 10]);
  }
}

module stepper_nema_23(with_sprocket=false) {
  shaft_H = 19.5;
  balast_H = 1.6;
  body_H = 82;
  total_H = shaft_H + body_H + balast_H;
  if (with_sprocket) {
    translateZ(total_H/2 - 23.2/2 + 4) silver() pulley_gt2_10mm_sprocket_26();
  }
  


  // body height 82

  // shaft d8 - 19.5
  silver() ccylinder(d = 8, h = total_H - 0.01);

  // plate balast 38.1 1.6
  silver() translateZ(total_H/2 - shaft_H - 0.9 ) ccylinder(d = 38.1, h = 1.7);
  black() difference() {
    union() {
      // plate 56.3 56.3 5.6 R edge=3
       translateZ(total_H/2 - shaft_H -1.6 - body_H /2 ) makeRoundedBox([56.3, 56.3, body_H], d=6);
    }
    union() {
      // bolts 9.9d 47 square
      translateZ(total_H/2 - shaft_H -1.6 - body_H /2 )
      makeRoundedBoxShafts(size=[47,47,body_H + 3], d=0, shaftD=4.9);

      // base cutout 8.6
      translateZ(total_H/2 - shaft_H -1.6 - body_H /2 -1.51)
      makeRoundedBoxShafts(size=[47,47,body_H - 3], d=-7, shaftD=17.2);
    }
  }
}


module pulley_gt2_wheel_cutout(cutout_depth = 5, offset_X = 20, offset_Y = 20) {
  ccylinder( h = gt2_wheel_height + 1.6, d = gt2_wheel_outer_d + 2);
}

module pulley_gt2_wheel() {
  silver()
  union() {
    difference() {
      ccylinder( h = gt2_wheel_height, d = gt2_wheel_outer_d );
      ccylinder( h = gt2_wheel_space_height, d = gt2_wheel_outer_d + 1 );
    }
    ccylinder( h = gt2_wheel_height, d = gt2_wheel_inner_d );
  }
}

module pulley_gt2_10mm_sprocket_26() {
  total_H = 23.2;
  silver()
  difference() {
    union(){
      
      offset_Z = total_H/2;

      // bump 12.9 0.4
      ccylinder(d = 12.9, h=total_H);

      // hat 20 1
      translateZ(offset_Z - 0.4 - 0.5)
      ccylinder(d = 20, h = 1);

      // gear 15.85 11.1
      translateZ(offset_Z - 0.4 - 1 - 5.55)
      ccylinder(d = 15.85, h = 12.1);

      // plate 20 1
      translateZ(offset_Z - 1.4 - 11.1 - 0.5)
      ccylinder(d = 20, h = 1);

      // lower_shaft 12.9 9.7

    }
    union(){
      ccylinder(d = 8, h = total_H +1);
    }
  }


}


module stepper_nema_17(with_10mm=false) {
  if (with_10mm) {
    Tz(35)
    silver() pulley_gt2_wheel();
  }
  Tz(10)
  silver()
  Tz(1.5)
  ccylinder(d = 5, h = 63);
  black() {
    Tz(15) makeRoundedBox([40, 40, 10]);
    makeRoundedBox([37, 37, 20]);
    Tz(-15) makeRoundedBox([40, 40, 10]);
  }
}

module stepper_nema_23(with_sprocket=false, for_cutout=false) {
  shaft_H = 19.5;
  balast_H = 1.6;
  body_H = 82;
  total_H = shaft_H + body_H + balast_H;
  if (with_sprocket) {
    Tz(total_H/2 - 23.2/2 + 3) silver() pulley_gt2_10mm_sprocket_32();
  }

  // body height 82

  // shaft d8 - 19.5
  silver() ccylinder(d = 8, h = total_H - 0.01);

  // plate balast 38.1 1.6
  silver() Tz(total_H/2 - shaft_H - 0.9 ) ccylinder(d = 38.1, h = 1.7);
  black() D() {
    U() {
      // plate 56.3 56.3 5.6 R edge=3
       Tz(total_H/2 - shaft_H -1.6 - body_H /2 ) makeRoundedBox([56.3, 56.3, body_H], d=6);
       if (for_cutout) {
          // bolts 9.9d 47 square
          Tz(total_H/2 - shaft_H -1.6 - body_H /2 )
          makeRoundedBoxShafts(size=[47,47,body_H + 30], d=0, shaftD=5.5);
       }
    }
    U() {
       if (!for_cutout) {
        // bolts 9.9d 47 square
        Tz(total_H/2 - shaft_H -1.6 - body_H /2 ) makeRoundedBoxShafts(size=[47,47,body_H + 3], d=0, shaftD=4.9);

        // base cutout 8.6
        Tz(total_H/2 - shaft_H -1.6 - body_H /2 -1.51) makeRoundedBoxShafts(size=[47,47,body_H - 3], d=-7, shaftD=17.2);
       }
    }
  }
}

module stepper_nema_23_shafts(h=20) {
  makeRoundedBoxShafts(size=[47,47,h + 3], d=0, shaftD=4.9);
}
module pulley_gt2_wheel_cutout(cutout_depth = 5, offset_X = 20, offset_Y = 20) {
  ccylinder( h = gt2_wheel_height + 1.6, d = gt2_wheel_outer_d + 2);
}

gt2_wheel_inner_d = 12.2;
gt2_wheel_height = 13;
gt2_wheel_outer_d = gt2_wheel_inner_d + 6;

module pulley_gt2_wheel() {
  silver()
  U() {
    D() {
      ccylinder( h = gt2_wheel_height, d = gt2_wheel_outer_d );
      ccylinder( h = gt2_wheel_space_height, d = gt2_wheel_outer_d + 1 );
    }
    ccylinder( h = gt2_wheel_height, d = gt2_wheel_inner_d );
  }
}

nema23_stepper_sprocket_26T_total_H = 23.2;
nema23_stepper_sprocket_26T_D = 15.85;

module pulley_gt2_10mm_sprocket_26() {
  nema23_stepper_sprocket_26T_total_H = 23.2;
  silver()
  D() {
    U(){
      
      offset_Z = nema23_stepper_sprocket_26T_total_H/2;

      // bump 12.9 0.4
      ccylinder(d = 12.9, h=nema23_stepper_sprocket_26T_total_H);

      // hat 20 1
      Tz(offset_Z - 0.4 - 0.5)
      ccylinder(d = 20, h = 1);

      // gear 15.85 11.1
      Tz(offset_Z - 0.4 - 1 - 5.55)
      ccylinder(d = nema23_stepper_sprocket_26T_D, h = 12.1);

      // plate 20 1
      Tz(offset_Z - 1.4 - 11.1 - 0.5)
      ccylinder(d = 20, h = 1);

      // lower_shaft 12.9 9.7

    }
    U(){
      ccylinder(d = 8, h = nema23_stepper_sprocket_26T_total_H +1);
    }
  }
}

nema23_stepper_sprocket_32T_total_H = 21.1;
nema23_stepper_sprocket_32T_D = 22.35;

module pulley_gt2_10mm_sprocket_32() {
  nema23_stepper_sprocket_32T_total_H = 23.2;
  silver()
  D() {
    U(){
      
      offset_Z = nema23_stepper_sprocket_32T_total_H/2;

      // bump 12.9 0.4
      ccylinder(d = 12.9, h=nema23_stepper_sprocket_32T_total_H);

      // hat 20 1
      Tz(offset_Z - 0.4 - 0.5)
      ccylinder(d = 25.6, h = 1);

      // gear 15.85 11.1
      Tz(offset_Z - 0.4 - 1 - 5.55)
      ccylinder(d = nema23_stepper_sprocket_32T_D, h = 12.1);

      // plate 20 1
      Tz(offset_Z - 1.4 - 11.1 - 0.5)
      ccylinder(d = 25.6, h = 1);

      // lower_shaft 12.9 9.7

    }
    U(){
      ccylinder(d = 8, h = nema23_stepper_sprocket_32T_total_H +1);
    }
  }
}

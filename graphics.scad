function get_a_from_dia(d) = (7/17) * d / 21;

module drawbiohazard(d = 51, cheat_ring=0) {

  A=get_a_from_dia(d);
  B=A*3.5;
  C=A*4;
  D=A*6;
  E=A*11;
  F=A*15;
  G=A*21;
  H=A*30;

  difference()
  {
    bigcircles(A,B,C,D,E,F,G,H);
    subcircles(A,B,C,D,E,F,G,H);
    circle(r=D/2);
    for(i=[0,120,240])
      rotate([0,0,i]) translate([-A/2,0,0]) square(size=[A,E/2]);
  }
  centerring(A,B,C,D,E,F,G,H,cheat_ring);
}

// three biggest circles
module bigcircles(A,B,C,D,E,F,G,H)
{
  union()
  {
    for(i=[90,210,330])
      rotate([0,0,i]) translate([E,0,0]) circle(r=H/2);
  }
}


// the three subtractive circles
module subcircles(A,B,C,D,E,F,G,H)
{
  union()
  {
    for(i=[90,210,330])
      rotate([0,0,i]) translate([F,0,0]) circle(r=G/2);
  }
}


// center ring
module centerring(A,B,C,D,E,F,G,H,cheat_ring=0)
{
  intersection()
  {
    difference()
    {
      circle(r=E+B);
      circle(r=E-A);
    }

    if(cheat_ring == 0)
    {
      union()
      {
        for(i=[90,210,330])
          rotate([0,0,i]) translate([F,0,0]) circle(r=(G/2)-A);
      }
    }
    else
    {
      // HACK
      square([G*5,G*5],center=true);
    }
  }
}
include <ShortCuts.scad>  // http://www.thingiverse.com/thing:644830
// help(); 
//examples();  // slow!! F6 takes hours!
module examples()
{ 
place_in_rect(60, 60)
{
// examples spring:
	spring(Windings = 7, R = 10, r = 1, h = 20);  // clockwise
	R(90) spring(Windings = 3, R = 12, r = 2, h = -60); // ccw

// examples helicoils:
	helicoil(Windings = 10);  // square wire
	helicoil(clockwise = false, square = true);  // ccw + round wire

// examples elliptic rings:
	elliptic_ring(10, 5, 1);  
	elliptic_ring(10, 10, 1);  // non elliptic
	elliptic_ring(h = 10);  // element of a spring
	elliptic_ring(h = 10, w = 240);  // partial ring

// example chain:
	U()
	{
	 Rx(90) T(15) elliptic_ring(); 
	 elliptic_ring(); 
	 Rx(90) T(-15) elliptic_ring(); 
	}
}
}

module help()
{
	echo("===== springs.scad - signatures [by Rudolf Huttary, Berlin] ===="); 
	echo("elliptic_ring(r1 = 10, r2 = 5, r = 2, slices = 100, h = 0, w = 360)
"); 
	echo("helicoil(Windings = 5, R = 20, r = 1, slices = 50, clockwise = true, square = true)"); 
	echo("spring(Windings = 5, R = 20, r=2, h = 20, slices = 50)"); 
	echo("elliptic_spring(Windings = 5, R1 = 20, R2 = 0, r=1, h = 20, slices = 50)"); 
	echo("===== springs.scad - end ===="); 
}


module elliptic_ring(r1 = 10, r2 = 5, r = 2, slices = 100, h = 0, w = 360)
{
	dz = h/slices; 
   dwx = atan(h/(r1+r2)/PI); 
	for (i = [0:slices-1])
	hull()
	{
		T(r1*cos((i+1)*w/slices), r2*sin((i+1)*w/slices), (i+1)*dz)
	   R(90+dwx, 0, (i+1)*w/slices)
		Cy(r = r, h = .01); 
	
		T(r1*cos((i)*w/slices), r2*sin((i)*w/slices), i*dz)
	   R(90+dwx, 0, i*w/slices)
		Cy(r = r, h = .01); 
	}
}

module helicoil(Windings = 5, R = 20, r = 1, slices = 50, clockwise = true, square = true)
{
  $fn = square? 4 :$fn; 
  h = clockwise?Windings*2*r:-Windings*2*r; 
  spring(Windings, R, r, h, slices); 
  T((.5*R)/2, r)
  Ry(90 )
  Cy(r, 1.5*R); 
}

module spring(Windings = 5, R = 20, r=2, h = 20, slices = 50)
	elliptic_spring(Windings, R, 0, r, h, slices); 

module elliptic_spring(Windings = 5, R1 = 20, R2 = 0, r=1, h = 20, slices = 50)
{
   dh = h/Windings;   
   r2 = (R2==0)?R1:R2; 
	for(j = [0:Windings-1])
		Tz(j*dh)
		elliptic_ring(R1, r2, r, slices, dh); 
}


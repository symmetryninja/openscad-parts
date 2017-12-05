/*************************
* borrowed from here
* http://spolearninglab.com/curriculum/lessonPlans/hacking/resources/software/3d/openscad/openscad_math.html
*************************/

pi = 3.1415926536;
e = 2.718281828;

/*************************
* Cartesian equations 
*************************/
/* Sine wave */

module sineWave(){
    linear_extrude(height=5)
    2dgraph([-50, 50], 3, steps=50);
}

module  parabola (){
    linear_extrude(height=5)
    2dgraph([-50, 50], 6, steps=40);
}

/* Ellipsoid - use a cartesion equation for a half ellipse, 
then rotate extrude it */

module ellipsoid(){
    rotate_extrude(convexity=10, $fn=100) 
    rotate([0, 0, -90]) 
    2dgraph([-50, 50], 3, steps=100);
}

/*************************
* Polar equations 
*************************/
/* Rose curve */

module rose(){
    scale([20, 20, 20]) linear_extrude(height=0.15)
    2dgraph([0, 720], 0.1, steps=160, polar=true);
}

/* Archimedes spiral */
module archimedesSpiral(){
    scale([0.02, 0.02, 0.02]) linear_extrude(height=150)
    2dgraph([0, 360*3], 50, steps=100, polar=true);
}

/* Golden spiral */
module goldenSpiral(){
    linear_extrude(height=50)
    2dgraph([0, 7*180], 1, steps=300, polar=true);
}

/**************************
* Parametric equations 
*************************/
/* 9-pointed star */
module ninePointedStar(s,h){
    scale(s) linear_extrude(height=h)
    2dgraph([10, 1450], 0.1, steps=9, parametric=true);
}

/*************************/
// function to convert degrees to radians
function d2r(theta) = theta*360/(2*pi);

// These functions are here to help get the slope of each segment, and use that to find points for a correctly oriented polygon
function diffx(x1, y1, x2, y2, th) = cos(atan((y2-y1)/(x2-x1)) + 90)*(th/2);
function diffy(x1, y1, x2, y2, th) = sin(atan((y2-y1)/(x2-x1)) + 90)*(th/2);
function point1(x1, y1, x2, y2, th) = [x1-diffx(x1, y1, x2, y2, th), y1-diffy(x1, y1, x2, y2, th)];
function point2(x1, y1, x2, y2, th) = [x2-diffx(x1, y1, x2, y2, th), y2-diffy(x1, y1, x2, y2, th)];
function point3(x1, y1, x2, y2, th) = [x2+diffx(x1, y1, x2, y2, th), y2+diffy(x1, y1, x2, y2, th)];
function point4(x1, y1, x2, y2, th) = [x1+diffx(x1, y1, x2, y2, th), y1+diffy(x1, y1, x2, y2, th)];
function polarX(theta) = cos(theta)*r(theta);
function polarY(theta) = sin(theta)*r(theta);

module nextPolygon(x1, y1, x2, y2, x3, y3, th) {
    if((x2 > x1 && x2-diffx(x2, y2, x3, y3, th) < x2-diffx(x1, y1, x2, y2, th) || (x2 <= x1 && x2-diffx(x2, y2, x3, y3, th) > x2-diffx(x1, y1, x2, y2, th)))) {
        polygon(
            points = [
                point1(x1, y1, x2, y2, th),
                point2(x1, y1, x2, y2, th),
                // This point connects this segment to the next
                point4(x2, y2, x3, y3, th),
                point3(x1, y1, x2, y2, th),
                point4(x1, y1, x2, y2, th)
            ],
            paths = [[0,1,2,3,4]]
        );
    }
    else if((x2 > x1 && x2-diffx(x2, y2, x3, y3, th) > x2-diffx(x1, y1, x2, y2, th) || (x2 <= x1 && x2-diffx(x2, y2, x3, y3, th) < x2-diffx(x1, y1, x2, y2, th)))) {
        polygon(
            points = [
                point1(x1, y1, x2, y2, th),
                point2(x1, y1, x2, y2, th),
                // This point connects this segment to the next
                point1(x2, y2, x3, y3, th),
                point3(x1, y1, x2, y2, th),
                point4(x1, y1, x2, y2, th)
            ],
            paths = [[0,1,2,3,4]]
        );
    }
    else {
        polygon(
            points = [
                point1(x1, y1, x2, y2, th),
                point2(x1, y1, x2, y2, th),
                point3(x1, y1, x2, y2, th),
                point4(x1, y1, x2, y2, th)
            ],
            paths = [[0,1,2,3]]
        );
    }
}

module 2dgraph(bounds=[-10,10], th=2, steps=10, polar=false, parametric=false) {

    step = (bounds[1]-bounds[0])/steps;
    union() {
        for(i = [bounds[0]:step:bounds[1]-step]) {
            if(polar) {
                nextPolygon(polarX(i), polarY(i), polarX(i+step), polarY(i+step), polarX(i+2*step), polarY(i+2*step), th);
            }
            else if(parametric) {
                nextPolygon(x(i), y(i), x(i+step), y(i+step), x(i+2*step), y(i+2*step), th);
            }
            else {
                nextPolygon(i, f(i), i+step, f(i+step), i+2*step, f(i+2*step), th);
            }
        }
    }
}
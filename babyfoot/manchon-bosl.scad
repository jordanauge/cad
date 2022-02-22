use <threadlib/threadlib.scad>
use <BOSL/threading.scad>
use <BOSL/constants.scad> // V_*

$fn = 100; // 360;
epsilon = 0.001;

// Internal diameter (13 is too tight, 13.5 too wide)
int_diam = 13.25;

// original outer diameter = 20, measured hole = 21.2/21.3, better fit...
// too tight... 20.7 good but could be tighter
out_diam = 21;

ext_diam = 28;

// Thread: for metric trapezoidal threads, use thread_angle=15 and 
// thread_depth=pitch/2.

thread_diam = 16;

// inner thread is a tad smaller for better screwing... 0.2 is perfect
thread_tol = 0.2;

module rcylinder(h, d) {
  cylinder(h=h, d=d-h);
  rotate_extrude() translate([(d-h)/2, h/2, 0]) circle(d = h);
}

module outer() {
    // base + margin (0.5mm) + 11.5 turns = base (1.5mm) + 12.5mm = 14mm
    // = 1mm more than the original
    //
    // original outer diameter = 20, measured hole = 21.2/21.3, better fit... too tight... 20.7 better maybe
    //translate([0,0,1.5]) translate([0,0,0.5]) nut("M16x1", turns=11.5, Douter=20.7);
    translate([0,0, 1.5])  difference() {
        cylinder(h=12.5, d=out_diam);
        translate([0,0,-epsilon]) cylinder(h=12.5+2*epsilon, d=19);
    };
    
    translate([0,0,12.5/2 + 1.5]) trapezoidal_threaded_nut(od=out_diam-3, id=thread_diam, h=12.5, pitch=1, slop=0.2, edges=$fn, thread_angle=15);
    difference() {
        rcylinder(h=1.5, d=ext_diam);
        translate([0,0,-epsilon]) cylinder(h=1.5+2*epsilon, d=int_diam);
    };
};
 
 
module inner() {
    difference() {
        rcylinder(h=1.5, d=ext_diam);
        translate([0,0,-epsilon]) cylinder(h=1.5+2*epsilon, d=int_diam);
    }       
    translate([0,0,1.5]) difference() {
        // h= (10.5 turns + 1) x 1mm = 11.5mm (incl translate)
        //translate([0,0,0.5]) bolt("M16x1", turns=10.5);
        translate([0,0, 11.5/2]) trapezoidal_threaded_rod(d=thread_diam - thread_tol, l=11.5, pitch=1, thread_angle=15);
 
        translate([0,0,-epsilon]) cylinder(h=11.5+2*epsilon, d=int_diam);
    };
};

//outer();
//translate([30, 0,0]) inner();
inner();
//translate([0,0,20]) rotate([0,180,0])  inner();

 
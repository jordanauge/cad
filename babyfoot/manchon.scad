use <threadlib/threadlib.scad>

$fn = 100;
 
module rcylinder(h, d) {
  cylinder(h=h, d=d-h);
  rotate_extrude() translate([(d-h)/2, h/2, 0]) circle(d = h);
}

module outer() {
    // base + margin (0.5mm) + 11.5 turns = base (1.5mm) + 12.5mm = 14mm
    // = 1mm more than the original
    //
    // original outer diameter = 20, measured hole = 21.2/21.3, better fit... too tight... 20.7 better maybe
    translate([0,0,1.5]) translate([0,0,0.5]) nut("M16x1", turns=11.5, Douter=20.7);
    difference() {
        rcylinder(h=1.5, d=28);
        cylinder(h=1.5, d=13.5); // 13 is too tight
    };
};
 
 
module inner() {
    difference() {
        rcylinder(h=1.5, d=28);
        cylinder(h=1.5, d=13);
    }       
    translate([0,0,1.5]) difference() {
        // h= (10.5 turns + 1) x 1mm = 11.5mm (incl translate)
        translate([0,0,0.5]) bolt("M16x1", turns=10.5); 
        cylinder(h=11.5, d=13.5);
    };
};

outer();
translate([30, 0,0]) inner();

 
 
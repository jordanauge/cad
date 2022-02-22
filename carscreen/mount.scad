$fn=100;

//import("./roundedcube.scad");
M5=5;
M4=4;
M3=3;

module edge(side, height, hole_diameter) {
    difference() {
        cube([side, side, height], center=true); //, 1, "all");

        cylinder(h=height, d=hole_diameter, center=true);
    }
}
module edger(side, height, hole_diameter) {
    
        
    difference() {
        union() {
            cube([side, side, height], center=true); //, 1, "all");
            translate([0,-7.5,0]) cylinder(d=side, h=height, center=true); //, 1, "all");
        }
        translate([0,-7.5,0]) cylinder(h=height, d=hole_diameter, center=true);
    }
}
module base(length, width, height, hole_diameter, hole_sep, edge_side, edge_sep) {
    square_hole_length = (length-height-edge_sep) / 2;
    union() {
        difference() {
            cube([length, width- EDGE_SIDE, height], center=true); //, 1, "all");
            translate([-hole_sep/2,-(width-2*BASE_SIDE-hole_diameter)/2,0]) cylinder(h=height, d=hole_diameter, center=true);
            translate([+hole_sep/2,-(width-2*BASE_SIDE-hole_diameter)/2,0]) cylinder(h=height, d=hole_diameter, center=true);

            
        }
        rotate(a=90, v=[0,1,0]) translate([height, width/2 , -edge_sep/2 - height/2 ]) edge(edge_side, height, M4);
        rotate(a=90, v=[0,1,0]) translate([height, width/2 , edge_sep/2 + height/2]) edge(edge_side, height, M4);
    }
}

module mount() {
    off=75/2;
    difference() {
        union() {
   // cube([59, 3, 15], center=true);
        translate([0,-3,0])        cube([19, 3, 12], center=true);        
    translate([0,-6,0])        cube([50, 3, 12], center=true);
     //rotate(a=90, v=[0,1,0])  translate([0, -6, -27]) edger(15, 5, M5);
     //rotate(a=90, v=[0,1,0])  translate([0, -6, +27]) edger(15, 5, M5);
     rotate(a=45, v=[0,1,0]) cube([20, 3, 150], center=true)   ;
     rotate(a=-45, v=[0,1,0]) cube([20, 3, 150], center=true)   ;
        }
    translate([-off, 5, -off]) rotate(a=90, v=[1,0,0]) cylinder(h=10,d=M4);
    translate([-off, 5, off]) rotate(a=90, v=[1,0,0]) cylinder(h=10,d=M4);
    translate([off, 5, -off]) rotate(a=90, v=[1,0,0]) cylinder(h=10,d=M4);
    translate([off, 5, off]) rotate(a=90, v=[1,0,0]) cylinder(h=10,d=M4);
        //cylinder(h=3,d=3)
    }
//        rotate(a=90, v=[0,1,0]) translate([height, width/2 , edge_sep/2 + height/2]) edge(edge_side, height, M5);
}

module mount2() {
    cube([59, 3, 15], center=true);
      translate([0,4,-6]) cube([59, 9, 3], center=true);

        //cube([20, 3, 18], center=true);
        //cube([20, 3, 18], center=true);
    translate([20,7,1.5]) cube([19, 3, 12], center=true);
    translate([-20,7,1.5]) cube([19, 3, 12], center=true);
    translate([27,4,1.5]) cube([5, 5, 12], center=true);
    translate([-27,4,1.5]) cube([5, 5, 12], center=true);
    
    rotate(a=90, v=[0,1,0])  translate([0, -6, -27]) edger(15, 5, M4);
    rotate(a=90, v=[0,1,0])  translate([0, -6, +27]) edger(15, 5, M4);
}

EDGE_SIDE = 15;
BASE_SIDE = 15;
BASE_HOLE_SEP = 110;

BASE_HOLE_DIAMETER = 15;
BASE_LENGTH = BASE_HOLE_SEP + BASE_HOLE_DIAMETER + 2*BASE_SIDE;
BASE_WIDTH = 27.5+BASE_HOLE_DIAMETER+BASE_SIDE;
BASE_HEIGHT = 5;
BASE_EDGE_SEP = 60;

//base(BASE_LENGTH, BASE_WIDTH, BASE_HEIGHT, BASE_HOLE_DIAMETER, BASE_HOLE_SEP, EDGE_SIDE, BASE_EDGE_SEP);
//translate([0,50,0]) mount2();
translate([0,80,0]) mount();
$fn=100;

//import("./roundedcube.scad");
M5=5;

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
        rotate(a=90, v=[0,1,0]) translate([height, width/2 , -edge_sep/2 - height/2 ]) edge(edge_side, height, M5);
        rotate(a=90, v=[0,1,0]) translate([height, width/2 , edge_sep/2 + height/2]) edge(edge_side, height, M5);
    }
}

module mount() {
    off=75/2;
    difference() {
        union() {
    cube([59, 3, 15], center=true);
     rotate(a=45, v=[0,1,0]) cube([20, 3, 150], center=true)   ;
     rotate(a=-45, v=[0,1,0]) cube([20, 3, 150], center=true)   ;
      rotate(a=90, v=[0,1,0])  translate([0, -6, -27]) edger(15, 5, M5);
          rotate(a=90, v=[0,1,0])  translate([0, -6, +27]) edger(15, 5, M5);
        }
    translate([-off, 5, -off]) rotate(a=90, v=[1,0,0]) cylinder(h=10,d=3);
    translate([-off, 5, off]) rotate(a=90, v=[1,0,0]) cylinder(h=10,d=3);
    translate([off, 5, -off]) rotate(a=90, v=[1,0,0]) cylinder(h=10,d=3);
    translate([off, 5, off]) rotate(a=90, v=[1,0,0]) cylinder(h=10,d=3);
        //cylinder(h=3,d=3)
    }
//        rotate(a=90, v=[0,1,0]) translate([height, width/2 , edge_sep/2 + height/2]) edge(edge_side, height, M5);
}

EDGE_SIDE = 15;
BASE_SIDE = 15;
BASE_HOLE_SEP = 110;

BASE_HOLE_DIAMETER = 14;
BASE_LENGTH = BASE_HOLE_SEP + BASE_HOLE_DIAMETER + 2*BASE_SIDE;
BASE_WIDTH = 27.5+BASE_HOLE_DIAMETER+BASE_SIDE;
BASE_HEIGHT = 5;
BASE_EDGE_SEP = 60;

base(BASE_LENGTH, BASE_WIDTH, BASE_HEIGHT, BASE_HOLE_DIAMETER, BASE_HOLE_SEP, EDGE_SIDE, BASE_EDGE_SEP);
translate([0,50,0]) mount();
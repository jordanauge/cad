L = 37.5;
l = 12;
h = 10;

font = "Liberation Sans";

letter_size = 7.5;
letter_height = 3.8;

$fn=120;

module base() {
    intersection() {
        cylinder(h=15, d=50);
        translate([30,0,0]) cylinder(h=15, d=50);
        translate([15,0,0]) cylinder(h=15, d=37.5);
        rotate([0,90,0]) translate([37,5,0]) cylinder(h=40, d=95);
    }
}

module letter(l) {
	linear_extrude(height = letter_height) {
		text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
	}
}

module piece(n) {
    difference() {
        base();
        translate([15,-25,14]) rotate([-75.5,0,0]) cylinder(h=45, d=22);
        translate([25,-2,3]) rotate([0,-90,0]) cube([5.5,10,20]);
    }
    translate([15,-7,5]) rotate([15,0,0]) letter(n);

}

for ( i = [1 : 10] ){
translate([i*25,0,0]) piece(str(i));
}


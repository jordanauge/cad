//$fn=100;

HEIGHT=4.8;
WIDTH=35;
DEPTH=22;

module base() {
linear_extrude(center=true,height=HEIGHT) 
    import(file="wolfcraft.dxf",scale=WIDTH/100);
}

module roundedRect(size, radius)
{
  x = size[0];
  y = size[1];
  z = size[2];

  linear_extrude(height=z)
  hull()
  {
    // place 4 circles in the corners, with the given radius
    translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius);

    translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius);

    translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius);

    translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius);
  }
}


difference() {
  base();
  translate([WIDTH/4,DEPTH/2,0]) linear_extrude(height=HEIGHT/2) circle(d=8.5);
  translate([WIDTH/4,DEPTH/2,-HEIGHT/2]) linear_extrude(height=HEIGHT/2) circle(d=2.5);
  translate([3*WIDTH/4,DEPTH/2,0]) linear_extrude(height=HEIGHT/2) circle(d=8.5);
  translate([3*WIDTH/4,DEPTH/2,-HEIGHT/2]) linear_extrude(height=HEIGHT/2) circle(d=2.5);
  translate([WIDTH/2, 3,0]) roundedRect([WIDTH - 4,4,HEIGHT/2],0.5);
}

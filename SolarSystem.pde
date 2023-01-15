public static final double PI = (float) Math.PI;
public static final double G = 1.062928 * (float) Math.pow(10, 17);
private static final double AU = 1.495978707 * (float) Math.pow(10, 11);
public static final double EARTHMASS = 5.97 * (float) Math.pow(10, 24);
public static final double EARTHRAD = 6.3781 * (float) Math.pow(10, 6);

private static final int WIDTH = 1200;
private static final int HEIGHT = 1000;

private static final double SCALE_DISTANCE = 100;        // pixels / AU
private static final double SCALE_SIZE = 20;             // pixels / EARTHRADIUS
private static final double DT = 1E5;               // seconds / update

private static final int ORIGX = WIDTH / 2;
private static final int ORIGY = HEIGHT / 2;

private ArrayList<Object> planets;

Object sun = new Object(0, 0, 0, 0, 332946, 109.2, color(255, 255, 0));
Object mercury = new Object(0, 0.387, 47400, 0, 0.0553, 0.383, color(200, 40, 40));
Object venus = new Object(0, 0.723, 35000, 0, 0.815, 0.949, color(170, 60, 0));
Object earth = new Object(0, 1, 29780, 0, 1, 1, color(0, 20, 220));
Object mars = new Object(0, 1.5224, 24100, 0, 0.107, 0.532, color(250, 30, 30));
Object jupiter = new Object(0, 5.203, 13100, 0, 317.83, 11.21, color(100, 70, 30));
Object saturn = new Object(0, 9.537, 9700, 0, 95.159, 9.45, color(80, 100, 100));
Object uranus = new Object(0, 19.191, 6800, 0, 14.536, 4.01, color(0, 150, 180));
Object neptune = new Object(0, 30.069, 5400, 0, 17.147, 3.88, color(0, 10, 50));
Object pluto = new Object(0, 39.482, 4700, 0, 0.0021, 0.186, color(20, 40, 60));

Object moon = new Object(earth.x.i, earth.x.j + 0.002569, earth.v.i + 1000, earth.v.j, 0.0123);

public void setup() {
  size(1200, 1000);
  
  planets = new ArrayList<Object>();
  
  planets.add(sun);
  planets.add(mercury);
  planets.add(venus);
  planets.add(earth);
  planets.add(mars);
  planets.add(jupiter);
  planets.add(saturn);
  planets.add(uranus);
  planets.add(neptune);
  planets.add(pluto);

}

public void draw() {
  background(0, 0, 0);
  
  for (Object p : planets) {
    p.clearForces();
    
    for (Object p2 : planets) 
      if (p2 != p) {
        p.addForce(gravity(p, p2));
        
        if (distance(p.x, p2.x) * AU / EARTHRAD <= p.r + p2.r) {
          p.addForce(Vector.scale(Vector.radial(p2.x, p.x), Vector.dotProduct(p.sumForces(), Vector.radial(p.x, p2.x))));
        }
      }
      
    p.time(DT);
  }
}

private Vector gravity(Object o1, Object o2) {
  double r = distance(o1.x, o2.x);
  double magnitude = -G * (o1.m * o2.m) / (r * r);
  Vector direction = Vector.radial(o2.x, o1.x);
  
  return Vector.scale(direction, magnitude);
}

private double distance(Vector x1, Vector x2) {
  return (double) Math.sqrt((x1.i - x2.i) * (x1.i - x2.i) + (x1.j - x2.j) * (x1.j - x2.j));
}

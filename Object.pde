public class Object {
  private double m;
  private double r;
  
  private Vector x;
  private Vector v;
  
  private color col;
  
  private ArrayList<Vector> forces;
  
  public Object() {
    this.m = 0;
    this.r = 1;
    this.col = color(255);
    
    this.x = new Vector();
    this.v = new Vector();
    
    this.forces = new ArrayList<Vector>();
  }
  
  public Object(double x, double y, double velocityx, double velocityy, double mass, double radius, color c) {
    this.m = mass;
    this.r = radius;
    
    this.x = new Vector(x, y);
    this.v = new Vector(velocityx, velocityy);
    
    this.forces = new ArrayList<Vector>();
    
    this.col = c;
  }
  
  public Object(double x, double y, double velocityx, double velocityy, double mass) {
    this.m = mass;
    
    this.x = new Vector(x, y);
    this.v = new Vector(velocityx, velocityy);
    
    this.forces = new ArrayList<Vector>();
    this.r = 1;
    this.col = color(255);
  }
  
  public Object(int x, int y, int mass) {
    this.m = mass;
    
    this.x = new Vector(x, y);
    this.v = new Vector();
    
    this.forces = new ArrayList<Vector>();
    this.r = 1;
    this.col = color(255);
  }
  
  public void time(double dt) {
    accelerate(dt);
    move(dt);
    display();
  }
  
  private void accelerate(double dt) {
    this.v = Vector.add(v, Vector.scale(acceleration(), dt));
  }
  
  private void move(double dt) {
    this.x = Vector.add(x, Vector.scale(Vector.scale(v, dt), 1 / AU));
  }
  
  private Vector acceleration() {
    return Vector.scale(sumForces(), 1 / (m * EARTHMASS));
  }
  
  private Vector sumForces() {
    if (forces.size() == 0)
      return new Vector();
    
    Vector sum = forces.get(0);
    for(int i = 1; i < forces.size(); i++) {
      sum = Vector.add(sum, forces.get(i));
    }
    
    return sum;
  }
  
  public Vector x() {
    return this.x;
  }
  
  public Vector v() {
    return this.v;
  }
  
  public double mass() {
    return this.m;
  }
  
  public void addForce(Vector f) {
    this.forces.add(f);
  }
  
  public void clearForces() {
    this.forces = new ArrayList<Vector>();
  }
  
  public void display() {
    stroke(col);
    fill(col);
    ellipse((float) (ORIGX + this.x.i * SCALE_DISTANCE), (float) ( ORIGY - this.x.j * SCALE_DISTANCE), (float) Math.ceil(r * SCALE_SIZE / r), (float) Math.ceil(r * SCALE_SIZE / r));
  }
}

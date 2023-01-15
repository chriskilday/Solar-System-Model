public static class Vector {
  static Vector add(Vector a, Vector b) {
    return new Vector(a.i + b.i, a.j + b.j);
  }
  
  static Vector sub(Vector a, Vector b) {
    return add(a, scale(b, -1));
  }
  
  static Vector scale(Vector a, double k) {
    return new Vector(a.i * k, a.j * k);
  }
  
  static Vector radial(Vector source, Vector p) {
    Vector r = sub(p, source);
    return  scale(r, 1 / mag(r));
  }
  
  static double dotProduct(Vector a, Vector b) {
    return a.i * b.i + a.j * b.j;
  }
  
  static double mag(Vector a) {
    return (double) Math.sqrt(a.i * a.i + a.j * a.j);
  }
  
  public double i;
  public double j;
  
  public Vector() { i = j = 0; }
  
  public Vector(double i, double j) {
    this.i = i;
    this.j = j;
  }
  
  public Vector(double mag, Vector dir) {
    Vector v = scale(dir, mag);
    this.i = v.i;
    this.j = v.j;
  }
}

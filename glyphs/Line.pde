class Line extends Curve{

  Line(Node s, Node e){
    this.s = new PVector(s.x, s.y);
    this.e = new PVector(e.x, e.y);

    this.len = this.getLength();
  }

  Line(float sx,float sy,float ex,float ey){
    this.s = new PVector(sx, sy);
    this.e = new PVector(ex, ey);

    this.len = this.getLength();
  }

  // lines don't care of parameter t
  @Override
  PVector directionAt(float t) {
    return this.direction();
  }

  @Override
  float angleAt(float t){
    PVector direction = this.direction();
    return atan2(direction.y, direction.x);
  }

  PVector direction(){
    // important to use static method
    return PVector.sub(
        this.e,
        this.s
        ).normalize();
  }

  void updateLength() {
    this.len = this.getLength();
  }

  void shift(PVector dir){
    float angle = this.angleAt(0.5);
    dir.rotate(angle + PI * 0.5);
    this.s.add(dir);
    this.e.add(dir);
  }

  @Override
  void draw() {
    line(this.s.x, this.s.y, this.e.x, this.e.y);
    ellipse(this.s.x, this.s.y, 3, 3);
    ellipse(this.e.x, this.e.y, 3, 3);
  }

  @Override
  PVector pointAt(float t) {
    PVector sub = PVector.sub(this.e, this.s);
    return PVector.add(this.s, PVector.mult(sub, t));
  }

  ArrayList<PVector> divide(int num) {
    ArrayList<PVector> points = new ArrayList<PVector>();
    for(int i = 0; i < num ; i++){
      float t = (1.0 / num) * i;
      points.add(this.pointAt(t));
    }
    points.add(this.e);
    return points;
  }

  @Override
  float getLength() {
    return PVector.dist(this.s, this.e);
  }

  PVector intersectWith(Line other){
    float ksi, eta, delta, ramda, mu;
  
    ksi = (other.e.y - other.s.y) * (other.e.x - this.s.x)
         -(other.e.x - other.s.x) * (other.e.y - this.s.y);

    eta = (this.e.x - this.s.x) * (other.e.y - this.s.y)
         -(this.e.y - this.s.y) * (other.e.x - this.s.x);

    delta = (this.e.x - this.s.x) * (other.e.y - other.s.y)
           -(this.e.y - this.s.y) * (other.e.x - other.s.x);

    ramda = ksi / delta;
    mu = eta / delta;

    if ((ramda >= 0 && ramda <=1) && (mu >= 0 && mu <= 1)) {
      return new PVector(
          this.s.x + ramda * (this.e.x - this.s.x),
          this.s.y + ramda * (this.e.y - this.s.y)
          );
    } 
 
    return null;
  }

  String toString() {
    return "Line:{length: "+this.len +",sx: " + this.s.x + ", sy: " + this.s.y + ", ex: " + this.e.x + ", ey: " + this.e.y + "}";
  }

}

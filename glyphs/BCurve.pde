int RESOLUTION = 100;

class BCurve extends Curve {

  PVector sControl;
  PVector eControl;

  BCurve(PVector sA, PVector sC, PVector eC, PVector eA) {
    this.s = sA;
    this.sControl = sC;
    this.eControl = eC;
    this.e = eA;

    this.len = this.getLength();
  }

  @Override
  PVector directionAt(float t){
    float angle = this.angleAt(t);
    return new PVector(-cos(angle), -sin(angle));
  }

  @Override
  float angleAt(float t){
    float tx = bezierTangent(this.s.x, this.sControl.x, this.eControl.x, this.e.x, t); 
    float ty = bezierTangent(this.s.y, this.sControl.y, this.eControl.y, this.e.y, t); 

    return atan2(ty, tx);
  }

  @Override
  float getLength(){
    PVector prev = this.sControl;
    float tempLen = 0;

    for(int i =0; i < RESOLUTION; i++){
      float t = i / float(RESOLUTION);
      PVector current = this.pointAt(t); // TODO: examine speed compared to caching this value (lookup)
      tempLen += PVector.dist(prev, current);
      prev = current;
    }

    tempLen += PVector.dist(prev, this.e);

    return tempLen;
  }

  @Override
  void draw() {
    bezier(
        this.s.x,
        this.s.y,
        this.sControl.x,
        this.sControl.y, 
        this.eControl.x,
        this.eControl.y,
        this.e.x,
        this.e.y);

    ellipse(this.s.x,this.s.y, 3, 3);
    ellipse(this.e.x,this.e.y, 3, 3);
  }

  @Override
  PVector pointAt(float t) {
    float x = bezierPoint(this.s.x, this.sControl.x, this.eControl.x, this.e.x, t); 
    float y = bezierPoint(this.s.y, this.sControl.y, this.eControl.y, this.e.y, t); 

    return new PVector(x, y);
  }

  String toString(){
    return "BCurve:{length: "+this.len +",sx: " + this.s.x + ", sy: " + this.s.y + ", ex: " + this.e.x + ", ey: " + this.e.y + "}";
  }

}

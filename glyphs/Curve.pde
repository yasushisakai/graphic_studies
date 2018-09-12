public abstract class Curve {

  public float len;
  public PVector s;
  public PVector e;
  
  public abstract void draw();

  public abstract PVector pointAt(float t);
  
  public abstract float getLength();

  public abstract PVector directionAt(float t);
  public abstract float angleAt(float t);
  
  public PVector pointAtDist(float d){
    if(d > this.len) {
      throw new IllegalArgumentException("distance larger than Line length");
    }
    float t = d / this.len;
    return this.pointAt(t);
  }

  public ArrayList<PVector> divide(int n){
    
    ArrayList<PVector> points = new ArrayList<PVector>();
    
    for(int i = 0; i < n; i++){
      points.add(this.pointAt(i/float(n)));
    }

    points.add(this.e);
    
    return points;
  }

  public ArrayList<PVector> divideByDist(float d, float remainder){
    float tempD;
    ArrayList<PVector> points = new ArrayList<PVector>();

    if(d > this.len - remainder) { // d is larger than the whole length
      return points;
    }

    tempD = remainder;

    while(tempD < this.len){
      points.add(this.pointAtDist(tempD));
      tempD += d; 
    }
    
    remainder = tempD - d; // will this change the arg??
    
    return points;
  }

}

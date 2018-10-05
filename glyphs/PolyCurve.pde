import java.util.Collections;

class PolyCurve {
  ArrayList<Curve> curves; // this can be Line or BCurves
  float len;

  // PolyCurve(ArrayList<Curve> curves){
  //   this.curves = curves; 
  //   this.len = this.getLength();
  // }

  PolyCurve(ArrayList<Node> nodes){

    this.curves = new ArrayList<Curve>();
    for(int i = 1; i < nodes.size() ;i++){
      this.curves.add(new Line(
            nodes.get(i),
            nodes.get(i-1)
            ));
    }

    Collections.reverse(this.curves);

    this.len = this.getLength();
  }

  void smooth(float filletDist) {
    for(int i = 1; i < this.curves.size(); i++) {
      if(this.areLines(i-1, i)){
        this.smooth(i-1, i, filletDist);
        i++;
      }
    }
  }

  // FIXME
  // void simplify() {
  //   IntList deleteList = new IntList();
  //   for(int i = 1; i < this.curves.size(); i++){
  //     if(this.areLines(i-1, i)){
  //       Line l = (Line)this.curves.get(i - 1);
  //       Line m = (Line)this.curves.get(i);
  //       float angle = PVector.angleBetween(l.direction(), m.direction());
  //       if(angle == 0.0){ 
  //         deleteList.append(i-1);
  //         m.s = l.s;
  //       }
  //     }
  //   } 
  //   for(int i:deleteList){
  //     this.curves.remove(i);
  //   }
  // }

  void rightShift(float shift){
    for(int i = 0; i < this.curves.size(); i ++){
      Line l;

      try{
        l = (Line) this.curves.get(i);
      } catch (Exception e) {
        return;
      }

      l.shift(new PVector(shift, 0));
    }

    for(int i=1; i < this.curves.size(); i++){
      Line l,m; 
      try{
        l = (Line) this.curves.get(i-1);
        m = (Line) this.curves.get(i);
      } catch (Exception e) {
        return;
      }

      PVector inter = l.intersectWith(m);
      if(inter != null){
        l.e = inter;
        m.s = inter;
        l.len = l.getLength();
        m.len = m.getLength();
      }
    }

    this.len = this.getLength(); // FIXME: too many loops
  }

  private boolean areLines(int i, int j){
    Curve I = this.curves.get(i);
    Curve J= this.curves.get(j);

    return I instanceof Line && J instanceof Line;
  }


  void smooth(int i, int j, float filletDist) {
    Line l,m;
    try{
      l = (Line) this.curves.get(i);
      m = (Line) this.curves.get(j);
    } catch (Exception e) {
      // println("Warning: error parsing to Line from Curve, " + e);
      return; // does nothing
    }

    if(PVector.angleBetween(l.direction(), m.direction()) == 0.0) return;

    this.len -= filletDist * 2;

    PVector tempEnd = l.pointAtDist(l.len - filletDist);
    PVector tempStart = m.pointAtDist(filletDist);
    
    BCurve newBCurve = new BCurve(tempEnd, l.e, m.s, tempStart);

    l.e = tempEnd;
    m.s = tempStart;

    l.updateLength();
    m.updateLength();

    this.len += newBCurve.len;
    this.curves.add(j, newBCurve);
  }

  float getLength(){
    float tempLen = 0;
    for(int i = 0; i < this.curves.size(); i++){
      Curve c = this.curves.get(i);
      tempLen += c.len;
    }

    return tempLen;
  }

  PVector getStart(){
    return this.curves.get(0).s;
  }

  float[] evalAt(float t) {
    float dist = this.len * t;
    float tempDist = 0;

    Curve c;
    for (int i = 0; i < this.curves.size(); i++ ){
      c = this.curves.get(i);
      
      if(dist <= tempDist + c.len){
        break;
      }
      
      tempDist += len;
    }

    float tCurve= (dist - tempDist) / c.len;
    PVector r = c.pointAt(tCurve);
    float a = c.angleAt(tCurve);
    return new float[]{r.x, r.y, a};
  }

  void draw(){
    for(Curve c : this.curves){
      c.draw();
    }
  }
}

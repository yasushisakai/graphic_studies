// this should be an abstract agent ?
// at this point agent behavior is the same
class MobilityAgent {
  
  public String type;
  private PGraphics[] g;
  private float speed; // in pix
  private float turnRadius = 20;
  private float laneWidth = 5;
  
  // these we dont't need to change
  private PolyCurve path;
  private boolean isVisible;
  private PVector pos;
  private float velocity;
  private float tSpeed;
  private float angle;
  private float t;
  private int state; // TODO: enum

  MobilityAgent (
      String type,
      Glyph[] gs, 
      float speed, 
      float turnRadius, 
      float laneWidth
    ) {

    this.type = type;
    this.g = new PGraphics[gs.length]; 
    for(int i=0; i<gs.length; i++){
      this.g[i] = gs[i].renderGraphics();
    }

    this.speed = speed;
    this.turnRadius = turnRadius;
    this.laneWidth = laneWidth;
    this.isVisible = false;
  }

  void setPath(PolyCurve path) {
    // customises path to fit mode of mobility
    this.path = path;
    this.path.rightShift(this.laneWidth);
    this.path.smooth(this.turnRadius);

    this.isVisible = true;
    this.state = 1;
    this.t = 0.0;
    this.pos = this.path.getStart();
    this.tSpeed = this.speed / this.path.len;
    this.velocity = 0.0;
  }

  void update() {
    if (this.t > 1) {
      this.isVisible = false;
      return; // stop;
    }

    switch (this.state) {
      case 0:
        break;
      case 1:
        if(this.velocity < 0.98){
          this.velocity += 0.02;
        }
      break;
      case 2:
        if(this.velocity > 0.05){
          this.velocity -= 0.05;
        }
      break;
    }

    float[] posDir = this.path.evalAt(t);
    this.pos = new PVector(int(posDir[0]), int(posDir[1]));
    this.angle = posDir[2]; 

    this.t += sigmoid(this.velocity) * this.tSpeed;
  }

  void switchState(int s) {
    this.state = s;
  }

  void drawPath() {
    this.path.draw();
  }

  void draw() {
    this.drawPath(); 
    PGraphics whichG = this.g[(frameCount/3) % this.g.length];
    if(this.isVisible){
      pushMatrix();
      translate(this.pos.x, this.pos.y);
      rotate(this.angle + PI * 0.5);
      image(whichG, -whichG.width / 2, -whichG.height / 2);
      popMatrix();
    }
  }
}

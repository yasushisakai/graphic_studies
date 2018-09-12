// this should be an abstract agent
class MobilityAgent {
  PGraphics[] g;
  PolyCurve path;
  PVector pos;
  float angle;
  float t = 0;
  int state = 0; // TODO: enum
  float velocity = 0;
  boolean isVisible;
  float turnRadius = 50;
  float laneWidth = 5;
  float speed; // pix

  MobilityAgent (PolyCurve path, float maxSpeed) {
    // g = human.renderGraphics(255);
    
    g = new PGraphics[]{
      human[0].renderGraphics(255),
      human[1].renderGraphics(255),
      human[2].renderGraphics(255),
    };

    this.path = path;
    // this.path.simplify();
    this.path.rightShift(this.laneWidth);
    this.path.smooth(this.turnRadius);
    this.state = 1;
    this.isVisible = true;
    this.pos = this.path.getStart();
    this.speed = maxSpeed / this.path.len;
  }

  void update() {
    if (t > 1) {
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
        if(this.velocity > 0.5){
          this.velocity -= 0.5;
        }
      break;
    }

    float[] posDir = this.path.evalAt(t);
    this.pos = new PVector(posDir[0], posDir[1]);
    this.angle = posDir[2]; 

    t += sigmoid(this.velocity) * this.speed;
  }

  void switchState(int s) {
    this.state = s;
  }

  void draw() {
    
    PGraphics whichG = this.g[(frameCount/5) % this.g.length];
    if(this.isVisible){
      // this.path.draw();
      pushMatrix();
      translate(this.pos.x, this.pos.y);
      rotate(this.angle + PI * 0.5);
      image(whichG, -whichG.width/2, -whichG.height/2);
      popMatrix();
    }
  }
}

class Blocks{

  PGraphics g;
  int row;

  float pitch;
  float boxWidthDepth;
  float boxHeight;

  Blocks(int row){
    this.g = createGraphics(width, height, P3D);

    this.row = row;
    this.pitch = width / this.row;
    this.boxWidthDepth = 145;
    this.boxHeight = 40;
  }

  PGraphics draw(){
    this.g.beginDraw();
    this.g.stroke(255);
    this.g.fill(0);
    for(int i=0; i < this.row; i++){
      for (int j=0; j< this.row; j++){
        this.g.pushMatrix();
        this.g.translate(this.pitch * (i + 0.5), this.pitch * (j + 0.5), this.boxHeight * 0.5 + 1);
        this.g.box(this.boxWidthDepth, this.boxWidthDepth, this.boxHeight);
        this.g.popMatrix();
      }
    }
    this.g.endDraw();
    return this.g;
  }


}

MobilityAgentManager mobs;
Glyphs title;
int networkSize = 25;
int major = 6;
RoadNetwork rn;

int unit; // TODO: clean
int boxSize;

void  settings(){
  size(800, 800, P3D);
  // fullScreen();
  noSmooth();
}

void setup() {
  frameRate(60);
  background(0);

  stroke(255);
  noFill();
  title = new Glyphs("city scope  mobility ver");
  rn = new RoadNetwork(networkSize, major);
  mobs = new MobilityAgentManager(100, rn);

  unit = width / 4;
  boxSize = 140;
}

void draw(){
  background(0);

  pushMatrix();
  translate(width/(networkSize * 2), height/(networkSize * 2));
  // rn.drawNodes();
  // rn.drawConnections();
  mobs.update();
  mobs.draw();
  popMatrix();

  pushStyle();
  fill(0);
  stroke(255);
  for(int i = 0;i < 4; i++){
    for(int j = 0; j < 4; j++){          
      float x = unit * 0.5 + i * unit;
      float y = unit * 0.5 + j * unit;
      pushMatrix();
      translate(x, y, 21);
      box(boxSize, boxSize, 40);
      popMatrix();
    }
  }
  popStyle();

  title.render(10, 10);

}

void mouseReleased() {
  save("frame.png");
}

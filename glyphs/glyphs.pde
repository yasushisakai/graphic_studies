MobilityAgentManager mobs;
GlyphCollection title;
int networkSize = 25;
int major = 6;
RoadNetwork rn;
SidewalkNetwork sn;

int unit; // TODO: clean
int boxSize;

void  settings(){
  size(800, 800, P3D);
  // fullScreen();
  noSmooth();
}

void setup() {
  // frameRate(60);
  frameRate(30);
  background(0);

  stroke(255);
  noFill();
  title = new GlyphCollection("city scope  mobility ver");
  rn = new RoadNetwork(networkSize, major);
  sn = new SidewalkNetwork(networkSize, major);
  mobs = new MobilityAgentManager(0, rn, sn);

    
  mobs.addPedestrians(3);
  mobs.addPEVs(3);
  mobs.addCars(3);
  
  mobs.addPedestrians(1000);
  mobs.addPEVs(400);
  mobs.addCars(100);


  unit = width / 4;
  boxSize = 140;
}

void draw(){
  background(0);

  pushMatrix();
  translate(width/(networkSize * 2), height/(networkSize * 2));
  // sn.drawConnections();
  // sn.drawNodes();
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

MobilityAgentManager mobs;
GlyphCollection title;
int networkSize = 25;
int major = 6;
RoadNetwork rn;
SidewalkNetwork sn;
Blocks blocks;

void  settings(){
  // you need to specify P2D if using createGraphics(w,h, P3D);
  size(800, 800, P2D);
  noSmooth();
}

void setup() {
  frameRate(30);
  background(0);
  stroke(255);
  noFill();
  title = new GlyphCollection("city scope  mobility ver");
  rn = new RoadNetwork(networkSize, major);
  sn = new SidewalkNetwork(networkSize, major);
  blocks = new Blocks(4);
  mobs = new MobilityAgentManager(0, rn, sn);

  mobs.addPedestrians(500);
  mobs.addPEVs(200);
  mobs.addCars(100);
}

void draw(){
  background(0);
  
  image(title.draw(), 10, 10);

  pushMatrix();
  translate(width/(networkSize * 2), height/(networkSize * 2));
  mobs.update();
  mobs.draw();
  popMatrix();

  image(blocks.draw(), 0, 0);
}

void mouseReleased() {
  save("frame.png");
}

MobilityAgentManager mobs;
Glyphs title;
int networkSize = 4;
RoadNetwork rn;

void  settings(){
  size(1080, 1080);
  noSmooth();
}

void setup() {
  frameRate(30);
  background(0);

  stroke(255);
  noFill();
  title = new Glyphs("city scope  mobility ver");
  rn = new RoadNetwork(networkSize);
  mobs = new MobilityAgentManager(100, rn);
}

void draw(){
  background(0);

  title.render(10, 10);
  translate(width/(networkSize * 2), height/(networkSize * 2));
  // rn.drawNodes();
  mobs.update();
  mobs.draw();
}

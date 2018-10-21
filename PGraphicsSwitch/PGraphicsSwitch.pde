float midpoint;
int method  = 1;

PFont font;
PGraphics left;
PGraphics right;
PImage img;
PShader maskShader;

void setup(){
  size(640, 480, P2D);
  
  midpoint = 0.5;
  left = createGraphics(width, height, P2D);
  right = createGraphics(width, height, P2D);
  
  font = createFont("Arial", 10);
  textFont(font);

  maskShader = loadShader("mask.glsl");
  maskShader.set("width", float(width));
  maskShader.set("height", float(height));
  maskShader.set("left", left);
  maskShader.set("right", right);
  maskShader.set("divPoint", midpoint);
}

void draw(){

  println(frameRate);

  shader(maskShader);

  makeGraphics(left, color(255, 0, 0), color(255));
  makeGraphics(right, color(0, 0, 255), color(0));

  // image();
  rect(0, 0, width, height);
}


void  makeGraphics(PGraphics g, color background, color strokeColor){

  // PGraphics g =createGraphics(width, height);


  g.beginDraw();
    g.background(background);

  
  g.stroke(strokeColor);
  for(int i = 0; i < 5000; i++){
    float x1 = random(width);
    float y1 = random(height);
    float x2 = random(width);
    float y2 = random(height); 
    g.line(x1, y1, x2, y2);
  }

  g.endDraw();

  // return g;
}

void keyPressed() {
  switch(key) {
    case 'z':
      midpoint = 0.0;
      maskShader.set("divPoint", midpoint);
    break;
    case 'x':
      midpoint = max(0, midpoint - 0.05);
      maskShader.set("divPoint", midpoint);
    break;
    case 'c':
      midpoint = 0.5;
      maskShader.set("divPoint", midpoint);
    break;
    case 'v':
      midpoint = min(1.0, midpoint + 0.05);
      maskShader.set("divPoint", midpoint);
    break;
    case 'b':
      midpoint = 1.0;
      maskShader.set("divPoint", midpoint);
    break;
    case '1':
      method = 1;
      resetShader();
    break;
    case '2':
      method = 2;
      resetShader();
    break;
    case '3':
      method = 3;
  }
}

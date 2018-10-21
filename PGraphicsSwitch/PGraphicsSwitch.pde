float midpoint;
int method  = 1;

PFont font;
PGraphics g;
PImage img;
PShader maskShader;

void setup(){
  size(640, 480, P2D);
  
  midpoint = 0.5;
  g = createGraphics(width, height, P2D);
  
  font = createFont("Arial", 10);
  textFont(font);

  maskShader = loadShader("mask.glsl");
  maskShader.set("tex", g);
  maskShader.set("divPoint", midpoint);
}

void draw(){

  println(frameRate);

  background(255, 0, 0);
  
  for(int i = 0; i < 5000; i++){
    float x1 = random(width);
    float y1 = random(height);
    float x2 = random(width);
    float y2 = random(width); 
    line(x1, y1, x2, y2);
  }

  int divideUntil = (int)(width * midpoint);
  
  g.beginDraw();
    g.background(0, 0, 255);
  
  g.stroke(255);
  for(int i = 0; i < 5000; i++){
    float x1 = random(width);
    float y1 = random(height);
    float x2 = random(width);
    float y2 = random(height); 
    g.line(x1, y1, x2, y2);
  }

  // method 1
  if(method == 1){
    img = g.get(divideUntil, 0, width, height);
  }

  // method 1
  if(method == 2){
    g.loadPixels();
      for(int y = 0; y < height; y++){
        for(int x = 0; x < divideUntil ;x++){
          g.pixels[y * width + x] = color(0, 0, 0, 0);
        }
      }
  
    g.updatePixels();
  }
  
  if(method == 3){
      g.filter(maskShader);
  }
  
  g.endDraw();

  if(method == 1){
    image(img, divideUntil, 0);
  } else if(method == 2){
    image(g, 0, 0);
  } else {
    // filter(maskShader);
    image(g, 0, 0);
  }
  /*
  memo: no mask 60fps
  */
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

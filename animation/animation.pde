float start;
final float DURATION = 3000;

AnimationUtil util;

void setup() {

  noFill();
  // drawing a bezier curve
  curve(-10, 800, 0, 100, 100, 0, 100, 50);

  // want to know the y
  // int div = 4;
  // for(int i = 0; i < div; i++){
  //   float t = map(i, 0, div, 0.0, 1.0);
  //   float y = bezierPoint(0, 50, 100, 100, t);
  //   ellipse(50, y, 5, 5);
  // }
  //
  util = new AnimationUtil();

  start = millis();
}

void draw(){
  background(100);
   float t = (millis() - start) / DURATION;
   float y = map(util.cubicEase(t), 0, 1, 100, 0);
   ellipse(50, y, 3, 3);
}


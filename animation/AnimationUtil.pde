


class AnimationUtil {
  float cubicEase(float t) {
    float y = curvePoint(800, 100, 0, 5, t);
    return map(y, 100.0, 0.0, 0, 1.0);
  }
}

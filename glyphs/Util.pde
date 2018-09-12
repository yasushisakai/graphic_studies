public final float E = 2.7182818284;

public float sigmoid(float t){
  float x = map(t, 0.0, 1.0, -10, 10);
  return 1.0 / (1.0 + pow(E, -x));
}

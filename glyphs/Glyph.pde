class Glyph {
  
  public int w;
  public int h;
  
  public String n;   
  
  private boolean[] bin;

  Glyph(String _n, int _w, boolean[] _bin){
    this.n = _n;
    this.w = _w;
    this.bin = _bin;
    this.h = _bin.length / w;
  }

  void render(int x, int y) {
    for(int i = 0; i < this.w; i++) {
      for(int j = 0; j < this.h; j++) {
        if (this.bin[i + j * this.w]) point(x + i, y + j);
      }
    }
  }

  PGraphics renderGraphics() {
    PGraphics g = createGraphics(this.w, this.h);
    g.beginDraw(); 
    g.stroke(255);
    for(int i = 0; i < this.w; i++) {
      for(int j = 0; j < this.h; j++) {
        if (this.bin[i + j * this.w]) g.point(i, j);
      }
    }
    g.endDraw();
    return g;
  }

}


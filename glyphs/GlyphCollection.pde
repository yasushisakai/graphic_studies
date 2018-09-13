class GlyphCollection {
  
  private PGraphics g;
  private Glyph[] word;
  private int h = 5;

  GlyphCollection(String _word){
    String uc = _word.toUpperCase();
    this.word = new Glyph[uc.length()];
    int w = 0;
    for(int i = 0; i < uc.length(); i++){
      char c = uc.charAt(i);
      Glyph gl = mapFromAscii(c);
      w += gl.w + 1;  
      this.word[i] = gl;
    } 
    w--;
    this.g = createGraphics(w, this.h, P2D);
    int cursor = 0;
    this.g.beginDraw();
    this.g.stroke(255);
    this.g.noFill();
    for(int i=0; i < uc.length(); i++){
      this.g.image(this.word[i].renderGraphics(), cursor, 0);
      cursor += this.word[i].w + 1;
    }
    this.g.endDraw();
  }

  PGraphics draw() {
    return this.g;
  }
}

Glyph PEV = new Glyph("PEV", 3, new boolean[]{
        true, false, true,
        true, false, true,
        true, false, true,
        false, false, false,
        true, true, true,
        true, false, true,
        true, false, true,
        true, false, true,
        true, false, true,
        true, true, true,
        false, false, false,
        false, true, false,
        false, true, false,
        false, true, false,
});

Glyph bike = new Glyph("Bike", 3, new boolean[]{
        false, true, false,
        false, true, false,
        false, true, false,
        false, false, false,
        true, true, true,
        true, false, true,
        true, false, true,
        true, false, true,
        true, false, true,
        true, true, true,
        false, false, false,
        false, true, false,
        false, true, false,
        false, true, false,
});

Glyph[] human = new Glyph[] {
  new Glyph("human0", 3, new boolean[]{
        false, false, true,
        true, true, false,
  }),
  new Glyph("human1", 3, new boolean[]{
        false, true, false,
        true, true, true,
   
  }),
  new Glyph("human0", 3, new boolean[]{
        true, false, false,
        false, true, true,
  })
};

Glyph car = new Glyph("car", 7, new boolean[]{
  true, false, true, true, true, false, true,    
  true, false, true, false, true, false, true,    
  true, false, true, false, true, false, true,    
  false, false, true, false, true, false, false,
  true, true, true, false, true, true, true, 
  true, false, false, false, false, false, true, 
  true, false, false, false, false, false, true, 
  true, false, false, false, false, false, true, 
  true, false, false, false, false, false, true, 
  true, false, false, false, false, false, true, 
  true, true, true, false, true, true, true, 
  false, false, true, true, true, false, false,
  true, false, true, false, true, false, true,    
  true, false, true, false, true, false, true,    
  true, false, true, false, true, false, true,    
});


Glyph mapFromAscii(char c) {
    byte b = byte(c);

    if(b >= 65 && b < 91) {
      return G[int(b) - 65 + 10];
    } else if (b >= 48 && b < 58) {
      return G[int(b) - 48];
    } else if (b == 32) {
      return G[36];
    } else {
      return G[36];
    }
}




Glyph[] G = new Glyph[]{
    
    new Glyph("0", 4, new boolean[]{
      false, true, true, false,
      true, false, false, true,
      true, false, false, true,
      true, false, false, true,
      false, true, true, false
      }), 

    new Glyph("1", 1, new boolean[]{ true, true, true, true, true }),
    
    new Glyph("2", 3, new boolean[]{
      true, true, true,
      false, false, true,
      true, true, true,
      true, false, false,
      true, true, true}),
    
    new Glyph("3", 3, new boolean[]{
      true, true, false,
      false, false, true,
      true, true, true,
      false, false, true,
      true, true, false}),

    new Glyph("4", 4, new boolean[]{
      true, false, true, false,
      true, false, true, false,
      true, true, true, true,
      false, false, true, false,
      false, false, true, false}),
  
  new Glyph("5", 3, new boolean[]{
      true, true, true,
      true, false, false,
      true, true, false,
      false, false, true,
      true, true, false}),

  new Glyph("6", 4, new boolean[]{
      false, true, true, false,
      true, false, false, false,
      true, true, true, false,
      true, false, false, true,
      false, true, true, false}),
  
  new Glyph("7", 3, new boolean[]{
      true, true, true,
      false, false, true,
      false, true, false,
      true, false, false,
      true, false, false}),
  
  new Glyph("8", 4, new boolean[]{
      false, true, true, false,
      true, false, false, true,
      false, true, true, false,
      true, false, false, true,
      false, true, true, false}),
  
  new Glyph("9", 4, new boolean[]{
      false, true, true, false,
      true, false, false, true,
      false, true, true, true,
      false, false, false, true,
      true, true, true, false}),

  new Glyph("a", 4, new boolean[]{
      false, true, true, false, 
      true, false, false, true,
      true, true, true, true,
      true, false, false, true,
      true, false, false, true}),
  
  new Glyph("b", 4, new boolean[]{
      true, true, true, false, 
      true, false, false, true,
      true, true, true, false,
      true, false, false, true,
      true, true, true, false}),
  
  new Glyph("c", 4, new boolean[]{
      false, true, true, false, 
      true, false, false, true,
      true, false, false, false,
      true, false, false, true,
      false, true, true, false}),
  
  new Glyph("d", 4, new boolean[]{
      true, true, true, false, 
      true, false, false, true,
      true, false, false, true,
      true, false, false, true,
      true, true, true, false}),

  new Glyph("e", 4, new boolean[]{
      true, true, true, true, 
      true, false, false, false,
      true, true, true, true, 
      true, false, false, false,
      true, true, true, true}),
  
  new Glyph("f", 4, new boolean[]{
      true, true, true, true, 
      true, false, false, false,
      true, true, true, false,
      true, false, false, false,
      true, false, false, false}),
  
  new Glyph("g", 4, new boolean[]{
      false, true, true, false, 
      true, false, false, false,
      true, false, true, true,
      true, false, false, true,
      false, true, true, false}),
  
  new Glyph("h", 4, new boolean[]{
      true, false, false, true,
      true, false, false, true,
      true, true, true, true,
      true, false, false, true,
      true, false, false, true}),

  new Glyph("i", 1, new boolean[]{true, true, true, true, true}),

  new Glyph("j", 4, new boolean[]{
      false, false, false, true, 
      false, false, false, true, 
      false, false, false, true, 
      true, false, false, true,
      false, true, true, false}),
 
  new Glyph("k", 4, new boolean[]{
      true, false, false, true, 
      true, false, true, false,
      true, true, false, false,
      true, false, true, false,
      true, false, false, true}),

  new Glyph("l", 3, new boolean[]{
      true, false, false,  
      true, false, false,  
      true, false, false,  
      true, false, false,  
      true, true, true}),

  new Glyph("m", 5, new boolean[]{
      true, false, false, false, true,
      true, true, false, true, true,
      true, false, true, false, true,
      true, false, false, false, true,
      true, false, false, false, true}),
  
  new Glyph("n", 4, new boolean[]{
      true, false, false, true, 
      true, true, false, true,
      true, false, true, true,
      true, false, false, true,
      true, false, false, true}),

  new Glyph("o", 4, new boolean[]{
      false, true, true, false, 
      true, false, false, true,
      true, false, false, true,
      true, false, false, true,
      false, true, true, false}),
  
  new Glyph("p", 4, new boolean[]{
      true, true, true, false, 
      true, false, false, true,
      true, true, true, false, 
      true, false, false, false,
      true, false, false, false}),
  
  new Glyph("q", 4, new boolean[]{
      false, true, true, false, 
      true, false, false, true,
      true, false, false, true,
      true, false, true, false,
      false, true, false, true}),
  
  new Glyph("r", 4, new boolean[]{
      true, true, true, false, 
      true, false, false, true,
      true, true, true, false, 
      true, false, false, true,
      true, false, false, true}),

  new Glyph("s", 4, new boolean[]{
      false, true, true, true, 
      true, false, false, false,
      true, true, true, false,
      false, false, false, true,
      true, true, true, false}),
  
  new Glyph("t", 3, new boolean[]{
      true, true, true, 
      false, true, false,
      false, true, false,
      false, true, false,
      false, true, false}),
  
  new Glyph("u", 4, new boolean[]{
      true, false, false, true, 
      true, false, false, true, 
      true, false, false, true, 
      true, false, false, true, 
      false, true, true, false}),
  
  new Glyph("v", 4, new boolean[]{
      true, false, false, true, 
      true, false, false, true, 
      true, false, true, false, 
      true, true, false, false, 
      true, false, false, false, false}),

  new Glyph("w", 5, new boolean[]{
      true, false, false, false, true,
      true, false, false, false, true,
      true, false, true, false, true,
      true, false, true, false, true,
      false, true, false, true, false}),

  new Glyph("x", 5, new boolean[]{
      true, false, false, false, true,
      false, true, false, true, false,
      false, false, true, false, false,
      false, true, false, true, false,
      true, false, false, false, true}),

  new Glyph("y", 3, new boolean[]{
      true, false, true,
      true, false, true,
      false, true, false,
      false, true, false,
      false, true, false}),

  new Glyph("z", 4, new boolean[]{
      true, true, true, true, 
      false, false, false, true,
      false, true, true, false,
      true, false, false, false,
      true, true, true, true}),

  new Glyph(" ", 3, new boolean[]{
      false, false, false, 
      false, false, false, 
      false, false, false, 
      false, false, false, 
      false, false, false, 
      })
};


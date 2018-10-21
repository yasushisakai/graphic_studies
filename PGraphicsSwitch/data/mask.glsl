#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_COLOR_SHADER

uniform sampler2D right;
uniform sampler2D left;
uniform float divPoint;

varying vec4 vertTexCoord;

void main() {
  if(vertTexCoord.s < divPoint){
    gl_FragColor = vec4(1.0, 0.0, 0.0, 0.0);
  } else {
    gl_FragColor = texture2D(tex, vertTexCoord.st).rgba;
  }
}
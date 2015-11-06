import processing.video.*;
Capture camera;
int Cwidth=640;
int Cheight=480;
int ColorCode, AverageRED;
int DiffRED, DiffGREEN, DiffBLUE, targetColor, tolerance=20,targetX,targetY;
void setup() {
  size(1000, 480);

  camera = new Capture(this, Cwidth, Cheight, 30);
  //  smooth();
  camera.start();
}
int RED(int Color) {  
  return Color >>16 &0xff;
}
int GREEN(int Color) {
  return Color >> 8 & 0xff;
}
int BLUE(int Color) {
  return Color & 0xff;
}


void mousePressed() {
  targetColor=camera.pixels[mouseX+mouseY*Cwidth];
}


void draw() {

  background(0);

  for (int i=1; i<Cwidth*Cheight; i++) {
    DiffRED = abs( RED(camera.pixels[i])-RED(targetColor) );
        DiffGREEN = abs( GREEN(camera.pixels[i])-GREEN(targetColor) );
            DiffBLUE = abs( BLUE(camera.pixels[i])-BLUE(targetColor) );
    if (DiffRED<tolerance && DiffGREEN<tolerance && DiffBLUE<tolerance) {
      targetX = i%Cwidth;
      targetY = i/Cwidth;
      break;
    }
  }

  int d = 10;

  for (int y = d / 2; y < Cheight; y += d) {
    for (int x = d / 2; x < Cwidth; x += d) {
      fill(camera.pixels[y*Cwidth+x]);
      ellipse(x, y, d, d);
    }
  }
fill(#ff0000);
  ellipse(targetX, targetY, 30, 30);

  //  image(camera, 0, 0);
  //  for (int y = d / 2; y < Cheight; y += d) {
  //    for (int x = d / 2; x < Cwidth; x += d) {
  //      ColorCode=(camera.pixels[Cwidth*Cheight/2]&0xff0000)/0x10000;
  //      if (ColorCode>0x10) {
  //        //fill(camera.pixels[y * Cwidth + x]);
  //        fill(camera.pixels[y*Cwidth+x]&0xff00ff00);
  //        ellipse(x, y, d, d);
  //        //        rect(x-d/2, y-d/2, x+d/2, y+d/2);
  //      } else {
  //        fill(camera.pixels[y * Cwidth + x]&0xffff0000);
  //        ellipse(x, y, d, d);
  //      }
  //    }
  //  }
  fill(#ff0000);

  text("RED", Cwidth, 20);
  //  ColorCode=camera.pixels[Cwidth*Cheight/2]&0xff0000;
  //  ColorCode = ColorCode/0x10000;
  ColorCode = RED(camera.pixels[Cwidth*Cheight/2]);
  text(hex(ColorCode, 2), Cwidth, 50);
  text(hex(camera.pixels[Cwidth*Cheight/2]), Cwidth, 70);

  AverageRED = (camera.pixels[Cwidth*Cheight/2]&0xff0000)/0x10000 + (camera.pixels[1+Cwidth*Cheight/2]&0xff0000)/0x10000;
  text(hex(AverageRED, 2), Cwidth, 90);

  text(targetX, Cwidth, 150);
  text(targetY, Cwidth, 170);
  text(hex(targetColor), Cwidth, 190);
} 

void captureEvent(Capture camera) {
  camera.read();
}


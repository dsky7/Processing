import processing.video.*;
int Color1,ColorR,ColorG,ColorB;
Capture camera;
import processing.serial.*;
Serial myPort;
void setup()
{
  size(640, 480);
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  String[] cams = Capture.list();
  //   camera = new Capture(this, cams[0]);
  camera = new Capture(this, width, height);
  smooth();
  noStroke();
  camera.start();
}

void draw() {
  background(0);
  camera.loadPixels(); 
  int d = 10; 
  for (int y = d / 2; y < height; y += d) {
    for (int x = d / 2; x < width; x += d) {
      fill(camera.pixels[y * width + x]&0xff0000ff);
      ellipse(x, y, d, d);
    }
  }
  fill(camera.pixels[height/2 * width + width/2]&0xff0000ff);
  textSize(30);
  text("dsky",100,100,100,100);
Color1 = camera.pixels[height/2 * width + width/2];
ColorR = (0x00ff0000 & Color1)/0x10000;
ColorG = (0x0000ff00 & Color1)/0x100;
ColorB = 0x000000ff & Color1;
print("R:");
print(ColorR);
print(" G:");
print(ColorG);
print(" B:");
  println(ColorB);
  myPort.write("A");
} 

void captureEvent(Capture camera) {
  camera.read();
}
void serialEvent(Serial myPort) { 
  String myString = myPort.readStringUntil('\n');
 // myString = trim(myString);
print(myString);

}

import processing.serial.*;
Serial myPort;

int x; 
void setup(){
  size(256, 512);
myPort = new Serial(this, "COM5", 9600);
}

void draw(){
  background(255);
//  ellipse(x,100,50,50);
line(0,0,100,x);
}

void serialEvent(Serial p){
  x = p.read();
  println(x);
}

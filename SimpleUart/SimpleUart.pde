import processing.serial.*;
Serial myPort;
public static final Start = 1;
public static final Id = 2;
public static final Data = 3;
int x; 
int Status;
void setup(){
  size(256, 512);
myPort = new Serial(this, "COM7", 9600);
colorMode(RGB,256);
}

void draw(){
  background(0,0,0);
fill(0,0,255);
textSize(20);
text(x,10,35);
//  ellipse(x,100,50,50);
//line(0,0,100,x);

}

void serialEvent(Serial p){
  x = p.read();
  switch(Status){
    case Start:
  }
  if(x=='S'){
  
  }
  println(x);
}
